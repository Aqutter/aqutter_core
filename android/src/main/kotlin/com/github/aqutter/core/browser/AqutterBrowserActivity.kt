package com.github.aqutter.core.browser

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.KeyEvent
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.webkit.WebView
import android.widget.ProgressBar
import android.widget.RelativeLayout
import android.widget.SearchView

import androidx.appcompat.app.ActionBar
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.view.menu.MenuBuilder
import androidx.appcompat.widget.Toolbar
import androidx.core.view.ViewCompat
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat

import com.github.aqutter.core.R
import com.github.aqutter.core.Util
import com.github.aqutter.core.find_interaction.FindInteractionController
import com.github.aqutter.core.pull_to_refresh.PullToRefreshChannelDelegate
import com.github.aqutter.core.pull_to_refresh.PullToRefreshLayout
import com.github.aqutter.core.pull_to_refresh.PullToRefreshSettings
import com.github.aqutter.core.types.AndroidResource
import com.github.aqutter.core.types.Disposable
import com.github.aqutter.core.types.AqutterBrowserMenuItem
import com.github.aqutter.core.types.URLRequest
import com.github.aqutter.core.types.UserScript
import com.github.aqutter.core.webview.WebViewChannelDelegate
import com.github.aqutter.core.webview.webview.AqutterWebView
import com.github.aqutter.core.webview.webview.AqutterWebViewSettings

import java.io.IOException

import io.flutter.plugin.common.MethodChannel

class AqutterBrowserActivity : AppCompatActivity(), AqutterBrowserDelegate, Disposable {

  @JvmField
  var windowId: Int? = null
  @JvmField
  var id: String? = null
  @JvmField
  var webView: AqutterWebView? = null
  @JvmField
  var pullToRefreshLayout: PullToRefreshLayout? = null
  @JvmField
  var actionBar: ActionBar? = null
  @JvmField
  var toolbar: Toolbar? = null
  @JvmField
  var menu: Menu? = null
  @JvmField
  var searchView: SearchView? = null
  @JvmField
  var customSettings: AqutterBrowserSettings = AqutterBrowserSettings()
  @JvmField
  var progressBar: ProgressBar? = null
  @JvmField
  var isHidden: Boolean = false
  @JvmField
  var fromActivity: String? = null
  private val activityResultListeners: MutableList<ActivityResultListener> = ArrayList()
  @JvmField
  var manager: AqutterBrowserManager? = null
  @JvmField
  var channelDelegate: AqutterBrowserChannelDelegate? = null
  @JvmField
  var menuItems: MutableList<AqutterBrowserMenuItem> = ArrayList()

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    val b = intent.extras
    if (b == null) {
      if (savedInstanceState != null) {
        finish()
      }
      return
    }

    id = b.getString("id")

    val managerId = b.getString("managerId")
    val manager = AqutterBrowserManager.shared[managerId]
    this.manager = manager
    if (manager == null || manager.plugin == null || manager.plugin!!.messenger == null) {
      if (savedInstanceState != null) {
        finish()
      }
      return
    }
    val plugin = manager.plugin!!

    val settingsMap = b.getSerializable("settings") as MutableMap<String, Any?>
    customSettings.parse(settingsMap)

    windowId = b.getInt("windowId")

    setContentView(R.layout.activity_web_view)

    WindowCompat.setDecorFitsSystemWindows(window, false)
    val toolbar = findViewById<Toolbar>(R.id.toolbar)
    this.toolbar = toolbar
    setSupportActionBar(toolbar)
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      window.statusBarColor = Color.TRANSPARENT
    }

    ViewCompat.setOnApplyWindowInsetsListener(toolbar) { v, insets ->
      val systemBars = insets.getInsets(WindowInsetsCompat.Type.statusBars())
      v.setPadding(v.paddingLeft, systemBars.top, v.paddingRight, v.paddingBottom)
      insets
    }

    val pullToRefreshInitialSettings = b.getSerializable("pullToRefreshInitialSettings") as MutableMap<String, Any?>
    val pullToRefreshLayoutChannel = MethodChannel(plugin.messenger, PullToRefreshLayout.METHOD_CHANNEL_NAME_PREFIX + id)
    val pullToRefreshSettings = PullToRefreshSettings()
    pullToRefreshSettings.parse(pullToRefreshInitialSettings)
    val pullToRefreshLayout = findViewById<PullToRefreshLayout>(R.id.pullToRefresh)
    this.pullToRefreshLayout = pullToRefreshLayout
    pullToRefreshLayout.channelDelegate = PullToRefreshChannelDelegate(pullToRefreshLayout, pullToRefreshLayoutChannel)
    pullToRefreshLayout.settings = pullToRefreshSettings
    pullToRefreshLayout.prepare()

    val webView = findViewById<AqutterWebView>(R.id.webView)
    this.webView = webView
    webView.id = id
    if (windowId != -1) {
      webView.windowId = windowId
    }
    webView.aqutterBrowserDelegate = this
    webView.plugin = plugin

    // NOTE: Java passed a possibly-null id to a @NonNull Object parameter; Kotlin needs `!!` here
    val findInteractionController = FindInteractionController(webView, plugin, id!!, null)
    webView.findInteractionController = findInteractionController
    findInteractionController.prepare()

    val channel = MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME_PREFIX + id)
    channelDelegate = AqutterBrowserChannelDelegate(channel)
    webView.channelDelegate = WebViewChannelDelegate(webView, channel)

    fromActivity = b.getString("fromActivity")

    val contextMenu = b.getSerializable("contextMenu") as MutableMap<String, Any?>?
    val initialUserScripts = b.getSerializable("initialUserScripts") as List<MutableMap<String, Any?>>?
    val menuItemList = b.getSerializable("menuItems") as List<MutableMap<String, Any?>>
    for (menuItem in menuItemList) {
      menuItems.add(AqutterBrowserMenuItem.fromMap(menuItem)!!)
    }

    val webViewSettings = AqutterWebViewSettings()
    webViewSettings.parse(settingsMap)
    webView.customSettings = webViewSettings
    webView.contextMenu = contextMenu

    val userScripts: MutableList<UserScript> = ArrayList()
    if (initialUserScripts != null) {
      for (initialUserScript in initialUserScripts) {
        userScripts.add(UserScript.fromMap(initialUserScript)!!)
      }
    }
    webView.userContentController.addUserOnlyScripts(userScripts)

    actionBar = supportActionBar

    prepareView()

    if (windowId != -1) {
      val webViewPlugin = webView.plugin
      val aqutterWebViewManager = webViewPlugin?.aqutterWebViewManager
      if (webViewPlugin != null && aqutterWebViewManager != null) {
        val resultMsg = aqutterWebViewManager.windowWebViewMessages.get(windowId!!)
        if (resultMsg != null) {
          (resultMsg.obj as WebView.WebViewTransport).webView = webView
          resultMsg.sendToTarget()
        }
      }
    } else {
      val initialFile = b.getString("initialFile")
      val initialUrlRequest = b.getSerializable("initialUrlRequest") as MutableMap<String, Any?>?
      val initialData = b.getString("initialData")
      if (initialFile != null) {
        try {
          webView.loadFile(initialFile)
        } catch (e: IOException) {
          Log.e(LOG_TAG, initialFile + " asset file cannot be found!", e)
          return
        }
      } else if (initialData != null) {
        val mimeType = b.getString("initialMimeType")
        val encoding = b.getString("initialEncoding")
        val baseUrl = b.getString("initialBaseUrl")
        val historyUrl = b.getString("initialHistoryUrl")
        webView.loadDataWithBaseURL(baseUrl, initialData, mimeType, encoding, historyUrl)
      } else if (initialUrlRequest != null) {
        val urlRequest = URLRequest.fromMap(initialUrlRequest)
        if (urlRequest != null) {
          webView.loadUrl(urlRequest)
        }
      }
    }

    channelDelegate?.onBrowserCreated()
  }

  private fun prepareView() {

    webView?.prepare()

    if (customSettings.hidden)
      hide()
    else
      show()

    progressBar = findViewById(R.id.progressBar)

    val progressBar = this.progressBar
    if (progressBar != null) {
      if (customSettings.hideProgressBar)
        progressBar.max = 0
      else
        progressBar.max = 100
    }

    val actionBar = this.actionBar
    if (actionBar != null) {
      actionBar.setDisplayShowTitleEnabled(!customSettings.hideTitleBar)

      if (customSettings.hideToolbarTop)
        actionBar.hide()

      val toolbarTopBackgroundColor = customSettings.toolbarTopBackgroundColor
      if (toolbarTopBackgroundColor != null && !toolbarTopBackgroundColor.isEmpty())
        actionBar.setBackgroundDrawable(ColorDrawable(Color.parseColor(toolbarTopBackgroundColor)))

      val toolbarTopFixedTitle = customSettings.toolbarTopFixedTitle
      if (toolbarTopFixedTitle != null && !toolbarTopFixedTitle.isEmpty())
        actionBar.title = toolbarTopFixedTitle
    }
  }

  @SuppressLint("RestrictedApi")
  override fun onCreateOptionsMenu(m: Menu?): Boolean {
    menu = m

    val toolbarTopFixedTitle = customSettings.toolbarTopFixedTitle
    val webView = this.webView
    if (actionBar != null && (toolbarTopFixedTitle == null || toolbarTopFixedTitle.isEmpty()))
      actionBar!!.title = if (webView != null) webView.title else ""

    if (m == null)
      return super.onCreateOptionsMenu(m)

    if (m is MenuBuilder) {
      m.setOptionalIconsVisible(true)
    }

    val inflater = menuInflater
    try {
      // Inflate menu to add items to action bar if it is present.
      inflater.inflate(R.menu.menu_main, m)
    } catch (e: Exception) {
      e.printStackTrace()
      Log.e(LOG_TAG, "Cannot inflate com.github.aqutter.core.R.menu.menu_main." +
              "To make it work, you need to set minifyEnabled false and shrinkResources false in your build.gradle file.")
      return super.onCreateOptionsMenu(m)
    }

    val menuSearchItem = m.findItem(R.id.menu_search)
    if (menuSearchItem != null) {
      if (customSettings.hideUrlBar)
        menuSearchItem.isVisible = false

      searchView = menuSearchItem.actionView as SearchView?
      val searchView = this.searchView
      if (searchView != null) {
        searchView.isFocusable = true

        val currentWebView = this.webView
        searchView.setQuery(if (currentWebView != null) currentWebView.url else "", false)

        searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
          override fun onQueryTextSubmit(query: String): Boolean {
            if (!query.isEmpty()) {
              this@AqutterBrowserActivity.webView?.loadUrl(query)
              val sv = this@AqutterBrowserActivity.searchView
              if (sv != null) {
                sv.setQuery("", false)
                sv.isIconified = true
              }
              return true
            }
            return false
          }

          override fun onQueryTextChange(newText: String): Boolean {
            return false
          }

        })

        searchView.setOnCloseListener {
          val sv = this.searchView
          if (sv != null && sv.query.toString().isEmpty()) {
            val wv = this.webView
            sv.setQuery(if (wv != null) wv.url else "", false)
          }
          false
        }

        searchView.setOnQueryTextFocusChangeListener { _, b ->
          val sv = this.searchView
          if (!b && sv != null) {
            sv.setQuery("", false)
            sv.isIconified = true
          }
        }
      }
    }

    if (customSettings.hideDefaultMenuItems) {
      val actionClose = m.findItem(R.id.action_close)
      if (actionClose != null) {
        actionClose.isVisible = false
      }
      val actionGoBack = m.findItem(R.id.action_go_back)
      if (actionGoBack != null) {
        actionGoBack.isVisible = false
      }
      val actionReload = m.findItem(R.id.action_reload)
      if (actionReload != null) {
        actionReload.isVisible = false
      }
      val actionGoForward = m.findItem(R.id.action_go_forward)
      if (actionGoForward != null) {
        actionGoForward.isVisible = false
      }
      val actionShare = m.findItem(R.id.action_share)
      if (actionShare != null) {
        actionShare.isVisible = false
      }
    }

    for (menuItem in menuItems) {
      val order = menuItem.order ?: Menu.NONE
      val item = m.add(Menu.NONE, menuItem.id, order, menuItem.title)
      if (menuItem.isShowAsAction) {
        item.setShowAsAction(MenuItem.SHOW_AS_ACTION_ALWAYS)
      }
      val icon = menuItem.icon
      if (icon != null) {
        if (icon is AndroidResource) {
          item.setIcon(icon.getIdentifier(this))
        } else {
          item.setIcon(Util.drawableFromBytes(this, icon as ByteArray))
        }
        val iconColor = menuItem.iconColor
        if (iconColor != null && !iconColor.isEmpty() && Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          item.icon!!.setTint(Color.parseColor(iconColor))
        }
      }
      item.setOnMenuItemClickListener {
        channelDelegate?.onMenuItemClicked(menuItem)
        true
      }
    }

    return true
  }

  override fun onKeyDown(keyCode: Int, event: KeyEvent): Boolean {
    if (keyCode == KeyEvent.KEYCODE_BACK) {
      if (customSettings.shouldCloseOnBackButtonPressed) {
        close(null)
        return true
      }
      if (customSettings.allowGoBackWithBackButton) {
        if (canGoBack())
          goBack()
        else if (customSettings.closeOnCannotGoBack)
          close(null)
        return true
      }
      if (!customSettings.shouldCloseOnBackButtonPressed) {
        return true
      }
    }
    return super.onKeyDown(keyCode, event)
  }

  fun close(result: MethodChannel.Result?) {
    channelDelegate?.onExit()

    dispose()

    if (result != null) {
      result.success(true)
    }
  }

  fun reload() {
    webView?.reload()
  }

  fun goBack() {
    val webView = this.webView
    if (webView != null && canGoBack())
      webView.goBack()
  }

  fun canGoBack(): Boolean {
    val webView = this.webView
    if (webView != null)
      return webView.canGoBack()
    return false
  }

  fun goForward() {
    val webView = this.webView
    if (webView != null && canGoForward())
      webView.goForward()
  }

  fun canGoForward(): Boolean {
    val webView = this.webView
    if (webView != null)
      return webView.canGoForward()
    return false
  }

  fun hide() {
    val fromActivity = this.fromActivity
    if (fromActivity != null) {
      try {
        isHidden = true
        val openActivity = Intent(this, Class.forName(fromActivity))
        openActivity.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT)
        startActivityIfNeeded(openActivity, 0)
      } catch (e: ClassNotFoundException) {
        Log.d(LOG_TAG, "", e)
      }
    }
  }

  fun show() {
    isHidden = false
    val openActivity = Intent(this, AqutterBrowserActivity::class.java)
    openActivity.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT)
    startActivityIfNeeded(openActivity, 0)
  }

  fun goBackButtonClicked(item: MenuItem) {
    goBack()
  }

  fun goForwardButtonClicked(item: MenuItem) {
    goForward()
  }

  fun shareButtonClicked(item: MenuItem) {
    val share = Intent(Intent.ACTION_SEND)
    share.setType("text/plain")
    val webView = this.webView
    share.putExtra(Intent.EXTRA_TEXT, if (webView != null) webView.url else "")
    startActivity(Intent.createChooser(share, "Share"))
  }

  fun reloadButtonClicked(item: MenuItem) {
    reload()
  }

  fun closeButtonClicked(item: MenuItem) {
    close(null)
  }

  fun setSettings(newSettings: AqutterBrowserSettings, newSettingsMap: HashMap<String, Any?>) {

    val newAqutterWebViewSettings = AqutterWebViewSettings()
    newAqutterWebViewSettings.parse(newSettingsMap)
    webView?.setSettings(newAqutterWebViewSettings, newSettingsMap)

    if (newSettingsMap["hidden"] != null && customSettings.hidden != newSettings.hidden) {
      if (newSettings.hidden)
        hide()
      else
        show()
    }

    val progressBar = this.progressBar
    if (newSettingsMap["hideProgressBar"] != null && customSettings.hideProgressBar != newSettings.hideProgressBar && progressBar != null) {
      if (newSettings.hideProgressBar)
        progressBar.max = 0
      else
        progressBar.max = 100
    }

    val actionBar = this.actionBar
    if (actionBar != null && newSettingsMap["hideTitleBar"] != null && customSettings.hideTitleBar != newSettings.hideTitleBar)
      actionBar.setDisplayShowTitleEnabled(!newSettings.hideTitleBar)

    if (actionBar != null && newSettingsMap["hideToolbarTop"] != null && customSettings.hideToolbarTop != newSettings.hideToolbarTop) {
      if (newSettings.hideToolbarTop)
        actionBar.hide()
      else
        actionBar.show()
    }

    val newToolbarTopBackgroundColor = newSettings.toolbarTopBackgroundColor
    if (actionBar != null && newSettingsMap["toolbarTopBackgroundColor"] != null &&
            !Util.objEquals(customSettings.toolbarTopBackgroundColor, newToolbarTopBackgroundColor) &&
            newToolbarTopBackgroundColor != null && !newToolbarTopBackgroundColor.isEmpty())
      actionBar.setBackgroundDrawable(ColorDrawable(Color.parseColor(newToolbarTopBackgroundColor)))

    val newToolbarTopFixedTitle = newSettings.toolbarTopFixedTitle
    if (actionBar != null && newSettingsMap["toolbarTopFixedTitle"] != null &&
            !Util.objEquals(customSettings.toolbarTopFixedTitle, newToolbarTopFixedTitle) &&
            newToolbarTopFixedTitle != null && !newToolbarTopFixedTitle.isEmpty())
      actionBar.title = newToolbarTopFixedTitle

    val menu = this.menu
    if (menu != null && newSettingsMap["hideUrlBar"] != null && customSettings.hideUrlBar != newSettings.hideUrlBar) {
      val menuSearchItem = menu.findItem(R.id.menu_search)
      if (menuSearchItem != null) {
        menuSearchItem.isVisible = !newSettings.hideUrlBar
      }
    }

    if (menu != null && newSettingsMap["hideDefaultMenuItems"] != null && customSettings.hideDefaultMenuItems != newSettings.hideDefaultMenuItems) {
      val actionClose = menu.findItem(R.id.action_close)
      if (actionClose != null) {
        actionClose.isVisible = !newSettings.hideDefaultMenuItems
      }
      val actionGoBack = menu.findItem(R.id.action_go_back)
      if (actionGoBack != null) {
        actionGoBack.isVisible = !newSettings.hideDefaultMenuItems
      }
      val actionReload = menu.findItem(R.id.action_reload)
      if (actionReload != null) {
        actionReload.isVisible = !newSettings.hideDefaultMenuItems
      }
      val actionGoForward = menu.findItem(R.id.action_go_forward)
      if (actionGoForward != null) {
        actionGoForward.isVisible = !newSettings.hideDefaultMenuItems
      }
      val actionShare = menu.findItem(R.id.action_share)
      if (actionShare != null) {
        actionShare.isVisible = !newSettings.hideDefaultMenuItems
      }
    }

    customSettings = newSettings
  }

  fun getCustomSettingsMap(): MutableMap<String, Any?>? {
    val webView = this.webView
    val webViewSettingsMap: Map<String, Any?>? = if (webView != null) webView.getCustomSettingsMap() else null
    if (webViewSettingsMap == null)
      return null

    val settingsMap = customSettings.getRealSettings(this)
    settingsMap.putAll(webViewSettingsMap)
    return settingsMap
  }

  override fun getActivity(): Activity {
    return this
  }

  override fun didChangeTitle(title: String?) {
    val toolbarTopFixedTitle = customSettings.toolbarTopFixedTitle
    if (actionBar != null && (toolbarTopFixedTitle == null || toolbarTopFixedTitle.isEmpty())) {
      actionBar!!.title = title
    }
  }

  override fun didStartNavigation(url: String?) {
    progressBar?.progress = 0
    searchView?.setQuery(url, false)
  }

  override fun didUpdateVisitedHistory(url: String?) {
    searchView?.setQuery(url, false)
  }

  override fun didFinishNavigation(url: String?) {
    searchView?.setQuery(url, false)
    progressBar?.progress = 0
  }

  override fun didFailNavigation(url: String?, errorCode: Int, description: String?) {
    progressBar?.progress = 0
  }

  override fun didChangeProgress(progress: Int) {
    val progressBar = this.progressBar
    if (progressBar != null) {
      progressBar.visibility = View.VISIBLE
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
        progressBar.setProgress(progress, true)
      } else {
        progressBar.progress = progress
      }
      if (progress == 100) {
        progressBar.visibility = View.GONE
      }
    }
  }

  override fun getActivityResultListeners(): MutableList<ActivityResultListener> {
    return activityResultListeners
  }

  override fun onActivityResult(requestCode: Int,
                                resultCode: Int,
                                data: Intent?) {
    for (listener in activityResultListeners) {
      if (listener.onActivityResult(requestCode, resultCode, data)) {
        return
      }
    }
    super.onActivityResult(requestCode, resultCode, data)
  }

  override fun dispose() {
    channelDelegate?.let {
      it.dispose()
      channelDelegate = null
    }
    activityResultListeners.clear()
    val webView = this.webView
    if (webView != null) {
      val manager = this.manager
      val managerPlugin = manager?.plugin
      val activityPluginBinding = managerPlugin?.activityPluginBinding
      val aqutterWebViewChromeClient = webView.aqutterWebViewChromeClient
      if (manager != null && managerPlugin != null &&
              activityPluginBinding != null && aqutterWebViewChromeClient != null) {
        activityPluginBinding.removeActivityResultListener(aqutterWebViewChromeClient)
      }
      val containerView = findViewById<RelativeLayout>(R.id.container)
      if (containerView != null) {
        containerView.removeAllViews()
      }
      webView.dispose()
      this.webView = null
      finish()
    }
  }

  public override fun onDestroy() {
    dispose()
    super.onDestroy()
  }

  companion object {
    // protected static in Java
    const val LOG_TAG = "AqutterBrowserActivity"
    const val METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/browser_"
  }
}
