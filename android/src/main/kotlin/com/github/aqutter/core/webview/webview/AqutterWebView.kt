package com.github.aqutter.core.webview.webview

import android.animation.ObjectAnimator
import android.animation.PropertyValuesHolder
import android.annotation.SuppressLint
import android.annotation.TargetApi
import android.content.Context
import android.content.Context.INPUT_METHOD_SERVICE
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Point
import android.graphics.drawable.ColorDrawable
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.os.Message
import android.os.Parcel
import android.print.AqutterWebViewPrintDocumentAdapter
import android.print.PrintAttributes
import android.print.PrintDocumentAdapter
import android.print.PrintManager
import android.text.TextUtils
import android.util.AttributeSet
import android.util.Log
import android.view.ActionMode
import android.view.ContextMenu
import android.view.GestureDetector
import android.view.LayoutInflater
import android.view.MenuItem
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup
import android.view.ViewParent
import android.view.ViewTreeObserver
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputConnection
import android.view.inputmethod.InputMethodManager
import android.webkit.CookieManager
import android.webkit.DownloadListener
import android.webkit.URLUtil
import android.webkit.ValueCallback
import android.webkit.WebChromeClient
import android.webkit.WebSettings
import android.webkit.WebStorage
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.AbsoluteLayout
import android.widget.HorizontalScrollView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.annotation.RequiresApi
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.webkit.WebSettingsCompat
import androidx.webkit.WebViewCompat
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.R
import com.github.aqutter.core.Util
import com.github.aqutter.core.content_blocker.ContentBlocker
import com.github.aqutter.core.content_blocker.ContentBlockerAction
import com.github.aqutter.core.content_blocker.ContentBlockerHandler
import com.github.aqutter.core.content_blocker.ContentBlockerTrigger
import com.github.aqutter.core.find_interaction.FindInteractionController
import com.github.aqutter.core.browser.AqutterBrowserDelegate
import com.github.aqutter.core.plugin_scripts_js.InterceptAjaxRequestJS
import com.github.aqutter.core.plugin_scripts_js.InterceptFetchRequestJS
import com.github.aqutter.core.plugin_scripts_js.JavaScriptBridgeJS
import com.github.aqutter.core.plugin_scripts_js.KeyboardAvoidanceJS
import com.github.aqutter.core.plugin_scripts_js.OnLoadResourceJS
import com.github.aqutter.core.plugin_scripts_js.OnWindowBlurEventJS
import com.github.aqutter.core.plugin_scripts_js.OnWindowFocusEventJS
import com.github.aqutter.core.plugin_scripts_js.PluginScriptsUtil
import com.github.aqutter.core.plugin_scripts_js.PrintJS
import com.github.aqutter.core.plugin_scripts_js.PromisePolyfillJS
import com.github.aqutter.core.print_job.PrintJobController
import com.github.aqutter.core.print_job.PrintJobSettings
import com.github.aqutter.core.pull_to_refresh.PullToRefreshLayout
import com.github.aqutter.core.types.ContentWorld
import com.github.aqutter.core.types.DownloadStartRequest
import com.github.aqutter.core.types.PluginScript
import com.github.aqutter.core.types.PreferredContentModeOptionType
import com.github.aqutter.core.types.URLRequest
import com.github.aqutter.core.types.UserContentController
import com.github.aqutter.core.types.UserScript
import com.github.aqutter.core.types.WebViewAssetLoaderExt
import com.github.aqutter.core.webview.ContextMenuSettings
import com.github.aqutter.core.webview.AqutterWebViewInterface
import com.github.aqutter.core.webview.JavaScriptBridgeInterface
import com.github.aqutter.core.webview.WebViewChannelDelegate
import com.github.aqutter.core.webview.web_message.WebMessageChannel
import com.github.aqutter.core.webview.web_message.WebMessageListener
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import java.io.ByteArrayOutputStream
import java.io.IOException
import java.util.ArrayList
import java.util.HashMap
import java.util.UUID

class AqutterWebView : InputAwareWebView, AqutterWebViewInterface {
  companion object {
    private const val LOG_TAG = "AqutterWebView"

    /**
     * Single-event displacement, in dp, above which a move inside an edge-started gesture is taken
     * to be the system's injected cancel artefact rather than the finger. See
     * [shouldDropSystemGestureArtefact].
     */
    private const val GESTURE_ARTEFACT_THRESHOLD_DP = 48f

    const val METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/webview_"

    // package-private in Java
    @JvmField
    var mHandler: Handler = Handler()
  }

  private var gestureStartedInSystemGestureArea = false
  private var lastGestureX = 0f
  private var lastGestureY = 0f

  @JvmField
  var plugin: AqutterCorePlugin? = null
  @JvmField
  var aqutterBrowserDelegate: AqutterBrowserDelegate? = null
  @JvmField
  var id: Any? = null
  @JvmField
  var windowId: Int? = null
  @JvmField
  var aqutterWebViewClient: AqutterWebViewClient? = null
  @JvmField
  var aqutterWebViewClientCompat: AqutterWebViewClientCompat? = null
  @JvmField
  var aqutterWebViewChromeClient: AqutterWebViewChromeClient? = null
  @JvmField
  var aqutterWebViewRenderProcessClient: AqutterWebViewRenderProcessClient? = null
  @JvmField
  var channelDelegate: WebViewChannelDelegate? = null
  @JvmField
  var javaScriptBridgeInterface: JavaScriptBridgeInterface? = null
  @JvmField
  var customSettings: AqutterWebViewSettings = AqutterWebViewSettings()
  @JvmField
  var isLoading: Boolean = false
  private var inFullscreen = false
  @JvmField
  var zoomScale: Float = 1.0f
  @JvmField
  var contentBlockerHandler: ContentBlockerHandler = ContentBlockerHandler()
  @JvmField
  var gestureDetector: GestureDetector? = null
  @JvmField
  var floatingContextMenu: LinearLayout? = null
  @JvmField
  var contextMenu: MutableMap<String, Any?>? = null
  @JvmField
  var mainLooperHandler: Handler = Handler(getWebViewLooper())

  @JvmField
  var checkScrollStoppedTask: Runnable? = null
  @JvmField
  var initialPositionScrollStoppedTask: Int = 0
  @JvmField
  var newCheckScrollStoppedTask: Int = 100 // ms

  @JvmField
  var checkContextMenuShouldBeClosedTask: Runnable? = null
  @JvmField
  var newCheckContextMenuShouldBeClosedTaskTask: Int = 100 // ms

  @JvmField
  var userContentController: UserContentController = UserContentController(this)

  @JvmField
  var callAsyncJavaScriptCallbacks: MutableMap<String, ValueCallback<String>> = HashMap()
  @JvmField
  var evaluateJavaScriptContentWorldCallbacks: MutableMap<String, ValueCallback<String>> = HashMap()

  @JvmField
  var webMessageChannels: MutableMap<String, WebMessageChannel> = HashMap()
  @JvmField
  var webMessageListeners: MutableList<WebMessageListener> = ArrayList()

  private var initialUserOnlyScripts: List<UserScript> = ArrayList()

  @JvmField
  var findInteractionController: FindInteractionController? = null

  @JvmField
  var webViewAssetLoaderExt: WebViewAssetLoaderExt? = null

  private var interceptOnlyAsyncAjaxRequestsPluginScript: PluginScript? = null

  private val expectedBridgeSecret: String = UUID.randomUUID().toString()
  private var javaScriptBridgeEnabled = true

  constructor(context: Context) : super(context)

  constructor(context: Context, attrs: AttributeSet?) : super(context, attrs)

  constructor(context: Context, attrs: AttributeSet?, defaultStyle: Int) : super(context, attrs, defaultStyle)

  constructor(context: Context, plugin: AqutterCorePlugin,
              id: Any, windowId: Int?, customSettings: AqutterWebViewSettings,
              contextMenu: MutableMap<String, Any?>?, containerView: View?,
              userScripts: List<UserScript>) : super(context, containerView, customSettings.useHybridComposition) {
    this.plugin = plugin
    this.id = id
    val channel = MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME_PREFIX + id)
    this.channelDelegate = WebViewChannelDelegate(this, channel)
    this.windowId = windowId
    this.customSettings = customSettings
    this.contextMenu = contextMenu
    this.initialUserOnlyScripts = userScripts
    if (plugin.activity != null) {
      plugin.activity!!.registerForContextMenu(this)
    }
  }

  fun createWebViewClient(aqutterBrowserDelegate: AqutterBrowserDelegate?): WebViewClient {
    // bug https://bugs.chromium.org/p/chromium/issues/detail?id=925887
    val packageInfo = WebViewCompat.getCurrentWebViewPackage(getContext())
    if (packageInfo == null) {
      Log.d(LOG_TAG, "Using AqutterWebViewClient implementation")
      return AqutterWebViewClient(aqutterBrowserDelegate)
    }

    val isChromiumWebView = "com.android.webview" == packageInfo.packageName ||
      "com.google.android.webview" == packageInfo.packageName ||
      "com.android.chrome" == packageInfo.packageName
    var isChromiumWebViewBugFixed = false
    if (isChromiumWebView) {
      val versionName = if (packageInfo.versionName != null) packageInfo.versionName!! else ""
      try {
        val majorVersion = if (versionName.contains(".")) Integer.parseInt(java.util.regex.Pattern.compile("\\.").split(versionName)[0]) else 0
        isChromiumWebViewBugFixed = majorVersion >= 73
      } catch (ignored: NumberFormatException) {
      }
    }

    if (isChromiumWebViewBugFixed || !isChromiumWebView) {
      Log.d(LOG_TAG, "Using AqutterWebViewClientCompat implementation")
      return AqutterWebViewClientCompat(aqutterBrowserDelegate)
    } else {
      Log.d(LOG_TAG, "Using AqutterWebViewClient implementation")
      return AqutterWebViewClient(aqutterBrowserDelegate)
    }
  }

  override fun setAlpha(alpha: Float) {
    val parent = getParent()
    if (parent is PullToRefreshLayout) {
      parent.setAlpha(alpha)
    } else {
      super.setAlpha(alpha)
    }
  }

  @SuppressLint("RestrictedApi")
  fun prepare() {
    if (customSettings.alpha != null) {
      setAlpha(customSettings.alpha!!.toFloat())
    }

    javaScriptBridgeEnabled = customSettings.javaScriptBridgeEnabled
    if (customSettings.javaScriptBridgeOriginAllowList != null && customSettings.javaScriptBridgeOriginAllowList!!.isEmpty()) {
      // an empty list means that the JavaScript Bridge is not allowed for any origin.
      javaScriptBridgeEnabled = false
    }

    if (plugin != null) {
      webViewAssetLoaderExt = WebViewAssetLoaderExt.fromMap(customSettings.webViewAssetLoader, plugin!!, getContext())
    }

    if (javaScriptBridgeEnabled) {
      javaScriptBridgeInterface = JavaScriptBridgeInterface(this, expectedBridgeSecret)
      addJavascriptInterface(javaScriptBridgeInterface!!, JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME())
    }

    aqutterWebViewChromeClient = AqutterWebViewChromeClient(plugin!!, this, aqutterBrowserDelegate)
    setWebChromeClient(aqutterWebViewChromeClient)

    val webViewClient = createWebViewClient(aqutterBrowserDelegate)
    if (webViewClient is AqutterWebViewClientCompat) {
      aqutterWebViewClientCompat = webViewClient
      setWebViewClient(webViewClient)
    } else if (webViewClient is AqutterWebViewClient) {
      aqutterWebViewClient = webViewClient
      setWebViewClient(webViewClient)
    }

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q && WebViewFeature.isFeatureSupported(WebViewFeature.WEB_VIEW_RENDERER_CLIENT_BASIC_USAGE)) {
      aqutterWebViewRenderProcessClient = AqutterWebViewRenderProcessClient()
      WebViewCompat.setWebViewRenderProcessClient(this, aqutterWebViewRenderProcessClient)
    }

    if (windowId == null || !WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT)) {
      // for some reason, if a WebView is created using a window id,
      // the initial plugin and user scripts injected
      // with WebViewCompat.addDocumentStartJavaScript will not be added!
      // https://github.com/pichillilorenzo/flutter_inappwebview/issues/1455
      prepareAndAddUserScripts()
    }

    if (customSettings.useOnDownloadStart)
      setDownloadListener(DownloadStartListener())

    val settings = getSettings()

    settings.setJavaScriptEnabled(customSettings.javaScriptEnabled)
    settings.setJavaScriptCanOpenWindowsAutomatically(customSettings.javaScriptCanOpenWindowsAutomatically)
    settings.setBuiltInZoomControls(customSettings.builtInZoomControls)
    settings.setDisplayZoomControls(customSettings.displayZoomControls)
    settings.setSupportMultipleWindows(customSettings.supportMultipleWindows)

    if (WebViewFeature.isFeatureSupported(WebViewFeature.SAFE_BROWSING_ENABLE))
      WebSettingsCompat.setSafeBrowsingEnabled(settings, customSettings.safeBrowsingEnabled)
    else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
      settings.setSafeBrowsingEnabled(customSettings.safeBrowsingEnabled)

    settings.setMediaPlaybackRequiresUserGesture(customSettings.mediaPlaybackRequiresUserGesture)

    settings.setDatabaseEnabled(customSettings.databaseEnabled)
    settings.setDomStorageEnabled(customSettings.domStorageEnabled)

    if (customSettings.userAgent != null && !customSettings.userAgent.isEmpty())
      settings.setUserAgentString(customSettings.userAgent)
    else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1)
      settings.setUserAgentString(WebSettings.getDefaultUserAgent(getContext()))

    if (customSettings.applicationNameForUserAgent != null && !customSettings.applicationNameForUserAgent.isEmpty()) {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
        val userAgent = if (customSettings.userAgent != null && !customSettings.userAgent.isEmpty()) customSettings.userAgent else WebSettings.getDefaultUserAgent(getContext())
        val userAgentWithApplicationName = userAgent + " " + customSettings.applicationNameForUserAgent
        settings.setUserAgentString(userAgentWithApplicationName)
      }
    }

    if (customSettings.clearCache)
      clearAllCache()
    else if (customSettings.clearSessionCache)
      CookieManager.getInstance().removeSessionCookie()

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
      CookieManager.getInstance().setAcceptThirdPartyCookies(this, customSettings.thirdPartyCookiesEnabled)

    settings.setLoadWithOverviewMode(customSettings.loadWithOverviewMode)
    settings.setUseWideViewPort(customSettings.useWideViewPort)
    settings.setSupportZoom(customSettings.supportZoom)
    if (customSettings.textZoom != null)
      settings.setTextZoom(customSettings.textZoom!!)

    setVerticalScrollBarEnabled(!customSettings.disableVerticalScroll && customSettings.verticalScrollBarEnabled)
    setHorizontalScrollBarEnabled(!customSettings.disableHorizontalScroll && customSettings.horizontalScrollBarEnabled)

    setKeyboardAvoidanceEnabled(customSettings.keyboardAvoidance)

    if (customSettings.transparentBackground)
      setBackgroundColor(Color.TRANSPARENT)

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP && customSettings.mixedContentMode != null)
      settings.setMixedContentMode(customSettings.mixedContentMode!!)

    settings.setAllowContentAccess(customSettings.allowContentAccess)
    settings.setAllowFileAccess(customSettings.allowFileAccess)
    settings.setAllowFileAccessFromFileURLs(customSettings.allowFileAccessFromFileURLs)
    settings.setAllowUniversalAccessFromFileURLs(customSettings.allowUniversalAccessFromFileURLs)
    setCacheEnabled(customSettings.cacheEnabled)
    if (customSettings.appCachePath != null && !customSettings.appCachePath!!.isEmpty() && customSettings.cacheEnabled) {
      // removed from Android API 33+ (https://developer.android.com/sdk/api_diff/33/changes)
      // settings.setAppCachePath(customSettings.appCachePath);
      Util.invokeMethodIfExists(settings, "setAppCachePath", customSettings.appCachePath)
    }
    settings.setBlockNetworkImage(customSettings.blockNetworkImage)
    settings.setBlockNetworkLoads(customSettings.blockNetworkLoads)
    if (customSettings.cacheMode != null)
      settings.setCacheMode(customSettings.cacheMode!!)
    settings.setCursiveFontFamily(customSettings.cursiveFontFamily)
    settings.setDefaultFixedFontSize(customSettings.defaultFixedFontSize!!)
    settings.setDefaultFontSize(customSettings.defaultFontSize!!)
    settings.setDefaultTextEncodingName(customSettings.defaultTextEncodingName)
    if (customSettings.disabledActionModeMenuItems != null) {
      if (WebViewFeature.isFeatureSupported(WebViewFeature.DISABLED_ACTION_MODE_MENU_ITEMS))
        WebSettingsCompat.setDisabledActionModeMenuItems(settings, customSettings.disabledActionModeMenuItems!!)
      else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N)
        settings.setDisabledActionModeMenuItems(customSettings.disabledActionModeMenuItems!!)
    }
    settings.setFantasyFontFamily(customSettings.fantasyFontFamily)
    settings.setFixedFontFamily(customSettings.fixedFontFamily)
    if (customSettings.forceDark != null) {
      if (WebViewFeature.isFeatureSupported(WebViewFeature.FORCE_DARK))
        WebSettingsCompat.setForceDark(settings, customSettings.forceDark!!)
      else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q)
        settings.setForceDark(customSettings.forceDark!!)
    }
    if (customSettings.forceDarkStrategy != null && WebViewFeature.isFeatureSupported(WebViewFeature.FORCE_DARK_STRATEGY)) {
      try {
        // for some reason the setForceDarkStrategy method could throw a ClassCastException
        // from the Android WebView Chromium library.
        WebSettingsCompat.setForceDarkStrategy(settings, customSettings.forceDarkStrategy!!)
      } catch (e: Exception) {
        e.printStackTrace()
      }
    }
    settings.setGeolocationEnabled(customSettings.geolocationEnabled)
    if (customSettings.layoutAlgorithm != null) {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT && customSettings.layoutAlgorithm!!.equals(WebSettings.LayoutAlgorithm.TEXT_AUTOSIZING)) {
        settings.setLayoutAlgorithm(customSettings.layoutAlgorithm)
      } else {
        settings.setLayoutAlgorithm(customSettings.layoutAlgorithm)
      }
    }
    settings.setLoadsImagesAutomatically(customSettings.loadsImagesAutomatically)
    settings.setMinimumFontSize(customSettings.minimumFontSize!!)
    settings.setMinimumLogicalFontSize(customSettings.minimumLogicalFontSize!!)
    setInitialScale(customSettings.initialScale!!)
    settings.setNeedInitialFocus(customSettings.needInitialFocus)
    if (WebViewFeature.isFeatureSupported(WebViewFeature.OFF_SCREEN_PRERASTER))
      WebSettingsCompat.setOffscreenPreRaster(settings, customSettings.offscreenPreRaster)
    else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
      settings.setOffscreenPreRaster(customSettings.offscreenPreRaster)
    settings.setSansSerifFontFamily(customSettings.sansSerifFontFamily)
    settings.setSerifFontFamily(customSettings.serifFontFamily)
    settings.setStandardFontFamily(customSettings.standardFontFamily)
    if (customSettings.preferredContentMode != null &&
      customSettings.preferredContentMode == PreferredContentModeOptionType.DESKTOP.toValue()) {
      setDesktopMode(true)
    }
    settings.setSaveFormData(customSettings.saveFormData)
    if (customSettings.incognito)
      setIncognito(true)
    if (customSettings.useHybridComposition) {
      if (customSettings.hardwareAcceleration)
        setLayerType(View.LAYER_TYPE_HARDWARE, null)
      else
        setLayerType(View.LAYER_TYPE_NONE, null)
    }
    setScrollBarStyle(customSettings.scrollBarStyle!!)
    if (customSettings.scrollBarDefaultDelayBeforeFade != null) {
      setScrollBarDefaultDelayBeforeFade(customSettings.scrollBarDefaultDelayBeforeFade!!)
    } else {
      customSettings.scrollBarDefaultDelayBeforeFade = getScrollBarDefaultDelayBeforeFade()
    }
    setScrollbarFadingEnabled(customSettings.scrollbarFadingEnabled!!)
    if (customSettings.scrollBarFadeDuration != null) {
      setScrollBarFadeDuration(customSettings.scrollBarFadeDuration!!)
    } else {
      customSettings.scrollBarFadeDuration = getScrollBarFadeDuration()
    }
    setVerticalScrollbarPosition(customSettings.verticalScrollbarPosition!!)

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
      if (customSettings.verticalScrollbarThumbColor != null)
        setVerticalScrollbarThumbDrawable(ColorDrawable(Color.parseColor(customSettings.verticalScrollbarThumbColor)))
      if (customSettings.verticalScrollbarTrackColor != null)
        setVerticalScrollbarTrackDrawable(ColorDrawable(Color.parseColor(customSettings.verticalScrollbarTrackColor)))
      if (customSettings.horizontalScrollbarThumbColor != null)
        setHorizontalScrollbarThumbDrawable(ColorDrawable(Color.parseColor(customSettings.horizontalScrollbarThumbColor)))
      if (customSettings.horizontalScrollbarTrackColor != null)
        setHorizontalScrollbarTrackDrawable(ColorDrawable(Color.parseColor(customSettings.horizontalScrollbarTrackColor)))
    }

    setOverScrollMode(customSettings.overScrollMode!!)
    if (customSettings.networkAvailable != null) {
      setNetworkAvailable(customSettings.networkAvailable!!)
    }
    if (customSettings.rendererPriorityPolicy != null && !customSettings.rendererPriorityPolicy!!.isEmpty() && Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      setRendererPriorityPolicy(
        customSettings.rendererPriorityPolicy!!["rendererRequestedPriority"] as Int,
        customSettings.rendererPriorityPolicy!!["waivedWhenNotVisible"] as Boolean)
    }

    if (WebViewFeature.isFeatureSupported(WebViewFeature.ALGORITHMIC_DARKENING) && Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
      WebSettingsCompat.setAlgorithmicDarkeningAllowed(settings, customSettings.algorithmicDarkeningAllowed)
    }
    if (WebViewFeature.isFeatureSupported(WebViewFeature.ENTERPRISE_AUTHENTICATION_APP_LINK_POLICY)) {
      WebSettingsCompat.setEnterpriseAuthenticationAppLinkPolicyEnabled(settings, customSettings.enterpriseAuthenticationAppLinkPolicyEnabled)
    }
    if (customSettings.requestedWithHeaderOriginAllowList != null &&
      WebViewFeature.isFeatureSupported(WebViewFeature.REQUESTED_WITH_HEADER_ALLOW_LIST)) {
      WebSettingsCompat.setRequestedWithHeaderOriginAllowList(settings, customSettings.requestedWithHeaderOriginAllowList!!)
    }

    contentBlockerHandler.getRuleList().clear()
    for (contentBlocker in customSettings.contentBlockers) {
      // compile ContentBlockerTrigger urlFilter
      val trigger = ContentBlockerTrigger.fromMap(contentBlocker["trigger"]!!)
      val action = ContentBlockerAction.fromMap(contentBlocker["action"]!!)
      contentBlockerHandler.getRuleList().add(ContentBlocker(trigger, action))
    }

    setFindListener(object : WebView.FindListener {
      override fun onFindResultReceived(activeMatchOrdinal: Int, numberOfMatches: Int, isDoneCounting: Boolean) {
        if (findInteractionController != null && findInteractionController!!.channelDelegate != null)
          findInteractionController!!.channelDelegate!!.onFindResultReceived(activeMatchOrdinal, numberOfMatches, isDoneCounting)
        if (channelDelegate != null)
          channelDelegate!!.onFindResultReceived(activeMatchOrdinal, numberOfMatches, isDoneCounting)
      }
    })

    gestureDetector = GestureDetector(this.getContext(), object : GestureDetector.SimpleOnGestureListener() {
      override fun onSingleTapUp(ev: MotionEvent): Boolean {
        if (floatingContextMenu != null) {
          hideContextMenu()
        }
        return super.onSingleTapUp(ev)
      }
    })

    checkScrollStoppedTask = object : Runnable {
      override fun run() {
        val newPosition = getScrollY()
        if (initialPositionScrollStoppedTask - newPosition == 0) {
          // has stopped
          onScrollStopped()
        } else {
          initialPositionScrollStoppedTask = getScrollY()
          mainLooperHandler.postDelayed(checkScrollStoppedTask!!, newCheckScrollStoppedTask.toLong())
        }
      }
    }

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT && !customSettings.useHybridComposition) {
      checkContextMenuShouldBeClosedTask = object : Runnable {
        override fun run() {
          if (floatingContextMenu != null) {
            evaluateJavascript(PluginScriptsUtil.CHECK_CONTEXT_MENU_SHOULD_BE_HIDDEN_JS_SOURCE, object : ValueCallback<String> {
              override fun onReceiveValue(value: String?) {
                if (value == null || value == "true") {
                  if (floatingContextMenu != null) {
                    hideContextMenu()
                  }
                } else {
                  mainLooperHandler.postDelayed(checkContextMenuShouldBeClosedTask!!, newCheckContextMenuShouldBeClosedTaskTask.toLong())
                }
              }
            })
          }
        }
      }
    }

    setOnTouchListener(object : View.OnTouchListener {
      var m_downX = 0f
      var m_downY = 0f

      override fun onTouch(v: View, event: MotionEvent): Boolean {
        gestureDetector!!.onTouchEvent(event)

        if (event.action == MotionEvent.ACTION_UP) {
          checkScrollStoppedTask!!.run()
        }

        if (customSettings.disableHorizontalScroll && customSettings.disableVerticalScroll) {
          return (event.action == MotionEvent.ACTION_MOVE)
        } else if (customSettings.disableHorizontalScroll || customSettings.disableVerticalScroll) {
          when (event.action) {
            MotionEvent.ACTION_DOWN -> {
              // save the x
              m_downX = event.x
              // save the y
              m_downY = event.y
            }
            MotionEvent.ACTION_MOVE,
            MotionEvent.ACTION_CANCEL,
            MotionEvent.ACTION_UP -> {
              if (customSettings.disableHorizontalScroll) {
                // set x so that it doesn't move
                event.setLocation(m_downX, event.y)
              } else {
                // set y so that it doesn't move
                event.setLocation(event.x, m_downY)
              }
            }
          }
        }
        return false
      }
    })

    setOnLongClickListener(object : View.OnLongClickListener {
      override fun onLongClick(v: View): Boolean {
        val hitTestResult =
          com.github.aqutter.core.types.HitTestResult.fromWebViewHitTestResult(getHitTestResult())
        if (channelDelegate != null) channelDelegate!!.onLongPressHitTestResult(hitTestResult)
        return false
      }
    })
  }

  fun prepareAndAddUserScripts() {
    if (javaScriptBridgeEnabled) {
      // all the plugin scripts are using the JavaScript Bridge to work
      userContentController.addPluginScript(PromisePolyfillJS.PROMISE_POLYFILL_JS_PLUGIN_SCRIPT(customSettings.pluginScriptsOriginAllowList,
        customSettings.pluginScriptsForMainFrameOnly))

      val javaScriptBridgeOriginAllowList: MutableSet<String>? = if (customSettings.javaScriptBridgeOriginAllowList != null)
        customSettings.javaScriptBridgeOriginAllowList else customSettings.pluginScriptsOriginAllowList
      val javaScriptBridgeForMainFrameOnly: Boolean = if (customSettings.javaScriptBridgeForMainFrameOnly != null)
        customSettings.javaScriptBridgeForMainFrameOnly!! else customSettings.pluginScriptsForMainFrameOnly
      userContentController.addPluginScript(JavaScriptBridgeJS.JAVASCRIPT_BRIDGE_JS_PLUGIN_SCRIPT(expectedBridgeSecret,
        javaScriptBridgeOriginAllowList,
        javaScriptBridgeForMainFrameOnly))

      userContentController.addPluginScript(PrintJS.PRINT_JS_PLUGIN_SCRIPT(customSettings.pluginScriptsOriginAllowList,
        customSettings.pluginScriptsForMainFrameOnly))
      userContentController.addPluginScript(OnWindowBlurEventJS.ON_WINDOW_BLUR_EVENT_JS_PLUGIN_SCRIPT(customSettings.pluginScriptsOriginAllowList))
      userContentController.addPluginScript(OnWindowFocusEventJS.ON_WINDOW_FOCUS_EVENT_JS_PLUGIN_SCRIPT(customSettings.pluginScriptsOriginAllowList))
      if (customSettings.keyboardAvoidance) {
        userContentController.addPluginScript(KeyboardAvoidanceJS.KEYBOARD_AVOIDANCE_JS_PLUGIN_SCRIPT(customSettings.pluginScriptsOriginAllowList))
      }
      interceptOnlyAsyncAjaxRequestsPluginScript = InterceptAjaxRequestJS.createInterceptOnlyAsyncAjaxRequestsPluginScript(customSettings.interceptOnlyAsyncAjaxRequests)
      if (customSettings.useShouldInterceptAjaxRequest) {
        userContentController.addPluginScript(interceptOnlyAsyncAjaxRequestsPluginScript!!)
        userContentController.addPluginScript(InterceptAjaxRequestJS.INTERCEPT_AJAX_REQUEST_JS_PLUGIN_SCRIPT(
          customSettings.pluginScriptsOriginAllowList,
          customSettings.pluginScriptsForMainFrameOnly,
          customSettings.useOnAjaxReadyStateChange,
          customSettings.useOnAjaxProgress))
      }
      if (customSettings.useShouldInterceptFetchRequest) {
        userContentController.addPluginScript(InterceptFetchRequestJS.INTERCEPT_FETCH_REQUEST_JS_PLUGIN_SCRIPT(customSettings.pluginScriptsOriginAllowList,
          customSettings.pluginScriptsForMainFrameOnly))
      }
      if (customSettings.useOnLoadResource) {
        userContentController.addPluginScript(OnLoadResourceJS.ON_LOAD_RESOURCE_JS_PLUGIN_SCRIPT(customSettings.pluginScriptsOriginAllowList,
          customSettings.pluginScriptsForMainFrameOnly))
      }
      if (!customSettings.useHybridComposition) {
        userContentController.addPluginScript(PluginScriptsUtil.CHECK_GLOBAL_KEY_DOWN_EVENT_TO_HIDE_CONTEXT_MENU_JS_PLUGIN_SCRIPT(customSettings.pluginScriptsOriginAllowList,
          customSettings.pluginScriptsForMainFrameOnly))
      }
    }
    this.userContentController.addUserOnlyScripts(this.initialUserOnlyScripts)
  }

  fun setIncognito(enabled: Boolean) {
    val settings = getSettings()
    if (enabled) {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        CookieManager.getInstance().removeAllCookies(null)
      } else {
        CookieManager.getInstance().removeAllCookie()
      }

      // Disable caching
      settings.setCacheMode(WebSettings.LOAD_NO_CACHE)

      // removed from Android API 33+ (https://developer.android.com/sdk/api_diff/33/changes)
      // settings.setAppCacheEnabled(false);
      Util.invokeMethodIfExists(settings, "setAppCacheEnabled", false)

      clearHistory()
      clearCache(true)

      // No form data or autofill enabled
      clearFormData()
      settings.setSavePassword(false)
      settings.setSaveFormData(false)
    } else {
      settings.setCacheMode(WebSettings.LOAD_DEFAULT)

      // removed from Android API 33+ (https://developer.android.com/sdk/api_diff/33/changes)
      // settings.setAppCacheEnabled(true);
      Util.invokeMethodIfExists(settings, "setAppCacheEnabled", true)

      settings.setSavePassword(true)
      settings.setSaveFormData(true)
    }
  }

  fun setCacheEnabled(enabled: Boolean) {
    val settings = getSettings()
    if (enabled) {
      val ctx = getContext()
      if (ctx != null) {
        // removed from Android API 33+ (https://developer.android.com/sdk/api_diff/33/changes)
        // settings.setAppCachePath(ctx.getCacheDir().getAbsolutePath());
        Util.invokeMethodIfExists(settings, "setAppCachePath", ctx.getCacheDir().getAbsolutePath())

        settings.setCacheMode(WebSettings.LOAD_DEFAULT)

        // removed from Android API 33+ (https://developer.android.com/sdk/api_diff/33/changes)
        // settings.setAppCacheEnabled(true);
        Util.invokeMethodIfExists(settings, "setAppCacheEnabled", true)
      }
    } else {
      settings.setCacheMode(WebSettings.LOAD_NO_CACHE)

      // removed from Android API 33+ (https://developer.android.com/sdk/api_diff/33/changes)
      // settings.setAppCacheEnabled(false);
      Util.invokeMethodIfExists(settings, "setAppCacheEnabled", false)
    }
  }

  override fun loadUrl(urlRequest: URLRequest) {
    val url = urlRequest.url
    val method = urlRequest.method
    if (method != null && method == "POST") {
      val postData = urlRequest.body
      postUrl(url!!, postData!!)
      return
    }
    val headers = urlRequest.headers
    if (headers != null) {
      loadUrl(url!!, headers)
      return
    }
    loadUrl(url!!)
  }

  @Throws(IOException::class)
  override fun loadFile(assetFilePath: String) {
    if (plugin == null) {
      return
    }

    loadUrl(Util.getUrlAsset(plugin!!, assetFilePath))
  }

  override fun isLoading(): Boolean {
    return isLoading
  }

  @Deprecated("Deprecated")
  private fun clearCookies() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      CookieManager.getInstance().removeAllCookies(object : ValueCallback<Boolean> {
        override fun onReceiveValue(aBoolean: Boolean?) {

        }
      })
    } else {
      CookieManager.getInstance().removeAllCookie()
    }
  }

  @Deprecated("Deprecated")
  override fun clearAllCache() {
    clearCache(true)
    clearCookies()
    clearFormData()
    WebStorage.getInstance().deleteAllData()
  }

  @Suppress("UNCHECKED_CAST")
  override fun takeScreenshot(screenshotConfiguration: MutableMap<String, Any?>?, result: MethodChannel.Result) {
    val pixelDensity = Util.getPixelDensity(getContext())

    mainLooperHandler.post(object : Runnable {
      override fun run() {
        try {
          var bitmapWidth = getMeasuredWidth()
          var bitmapHeight = getMeasuredHeight()
          var bitmapScrollX = getScrollX()
          var bitmapScrollY = getScrollY()

          var compressFormat = Bitmap.CompressFormat.PNG
          var quality = 100

          if (screenshotConfiguration != null) {
            val rect = screenshotConfiguration["rect"] as Map<String, Double>?
            if (rect != null) {
              bitmapScrollX = Math.floor(rect["x"]!! * pixelDensity + 0.5).toInt()
              bitmapScrollY = Math.floor(rect["y"]!! * pixelDensity + 0.5).toInt()
              bitmapWidth = Math.floor(rect["width"]!! * pixelDensity + 0.5).toInt()
              bitmapHeight = Math.floor(rect["height"]!! * pixelDensity + 0.5).toInt()
            }

            try {
              compressFormat = Bitmap.CompressFormat.valueOf(screenshotConfiguration["compressFormat"] as String)
            } catch (e: IllegalArgumentException) {
              Log.e(LOG_TAG, "", e)
            }

            quality = screenshotConfiguration["quality"] as Int
          }

          var screenshotBitmap = Bitmap.createBitmap(bitmapWidth, bitmapHeight, Bitmap.Config.ARGB_8888)
          val c = Canvas(screenshotBitmap)
          c.translate(-bitmapScrollX.toFloat(), -bitmapScrollY.toFloat())
          draw(c)

          val byteArrayOutputStream = ByteArrayOutputStream()

          if (screenshotConfiguration != null) {
            val snapshotWidth = screenshotConfiguration["snapshotWidth"] as Double?
            if (snapshotWidth != null) {
              val dstWidth = Math.floor(snapshotWidth * pixelDensity + 0.5).toInt()
              val ratioBitmap = screenshotBitmap.width.toFloat() / screenshotBitmap.height.toFloat()
              val dstHeight = (dstWidth.toFloat() / ratioBitmap).toInt()
              screenshotBitmap = Bitmap.createScaledBitmap(screenshotBitmap, dstWidth, dstHeight, true)
            }
          }

          val compressed = screenshotBitmap.compress(
            compressFormat,
            quality,
            byteArrayOutputStream)
          if (!compressed) {
            Log.e(LOG_TAG, "Screenshot cannot be compressed using compressFormat " +
              compressFormat.name + " with quality " + quality, null)
          }

          try {
            byteArrayOutputStream.close()
          } catch (e: IOException) {
            Log.e(LOG_TAG, "", e)
          }
          screenshotBitmap.recycle()
          result.success(byteArrayOutputStream.toByteArray())

        } catch (e: IllegalArgumentException) {
          Log.e(LOG_TAG, "", e)
          result.success(null)
        }
      }
    })
  }

  @SuppressLint("RestrictedApi")
  override fun setSettings(newCustomSettings: AqutterWebViewSettings, newSettingsMap: HashMap<String, Any?>) {

    val settings = getSettings()

    if (newSettingsMap["javaScriptEnabled"] != null && customSettings.javaScriptEnabled != newCustomSettings.javaScriptEnabled)
      settings.setJavaScriptEnabled(newCustomSettings.javaScriptEnabled)

    if (newSettingsMap["useShouldInterceptAjaxRequest"] != null && customSettings.useShouldInterceptAjaxRequest != newCustomSettings.useShouldInterceptAjaxRequest) {
      enablePluginScriptAtRuntime(
        InterceptAjaxRequestJS.FLAG_VARIABLE_FOR_SHOULD_INTERCEPT_AJAX_REQUEST_JS_SOURCE(),
        newCustomSettings.useShouldInterceptAjaxRequest,
        InterceptAjaxRequestJS.INTERCEPT_AJAX_REQUEST_JS_PLUGIN_SCRIPT(
          customSettings.pluginScriptsOriginAllowList,
          customSettings.pluginScriptsForMainFrameOnly,
          newCustomSettings.useOnAjaxReadyStateChange,
          newCustomSettings.useOnAjaxProgress)
      )
    }

    if (newSettingsMap["useOnAjaxReadyStateChange"] != null && customSettings.useOnAjaxReadyStateChange != newCustomSettings.useOnAjaxReadyStateChange) {
      evaluateJavascript("((window.top == null || window.top === window) ? window : window.top)." + InterceptAjaxRequestJS.FLAG_VARIABLE_FOR_ON_AJAX_READY_STATE_CHANGE() + " = " + newCustomSettings.useOnAjaxReadyStateChange + ";", null)
    }

    if (newSettingsMap["useOnAjaxProgress"] != null && customSettings.useOnAjaxProgress != newCustomSettings.useOnAjaxProgress) {
      evaluateJavascript("((window.top == null || window.top === window) ? window : window.top)." + InterceptAjaxRequestJS.FLAG_VARIABLE_FOR_ON_AJAX_PROGRESS() + " = " + newCustomSettings.useOnAjaxProgress + ";", null)
    }

    if (newSettingsMap["interceptOnlyAsyncAjaxRequests"] != null && customSettings.interceptOnlyAsyncAjaxRequests != newCustomSettings.interceptOnlyAsyncAjaxRequests) {
      enablePluginScriptAtRuntime(
        InterceptAjaxRequestJS.FLAG_VARIABLE_FOR_INTERCEPT_ONLY_ASYNC_AJAX_REQUESTS_JS_SOURCE(),
        newCustomSettings.interceptOnlyAsyncAjaxRequests,
        interceptOnlyAsyncAjaxRequestsPluginScript
      )
    }

    if (newSettingsMap["useShouldInterceptFetchRequest"] != null && customSettings.useShouldInterceptFetchRequest != newCustomSettings.useShouldInterceptFetchRequest) {
      enablePluginScriptAtRuntime(
        InterceptFetchRequestJS.FLAG_VARIABLE_FOR_SHOULD_INTERCEPT_FETCH_REQUEST_JS_SOURCE(),
        newCustomSettings.useShouldInterceptFetchRequest,
        InterceptFetchRequestJS.INTERCEPT_FETCH_REQUEST_JS_PLUGIN_SCRIPT(customSettings.pluginScriptsOriginAllowList,
          customSettings.pluginScriptsForMainFrameOnly)
      )
    }

    if (newSettingsMap["useOnLoadResource"] != null && customSettings.useOnLoadResource != newCustomSettings.useOnLoadResource) {
      enablePluginScriptAtRuntime(
        OnLoadResourceJS.FLAG_VARIABLE_FOR_ON_LOAD_RESOURCE_JS_SOURCE(),
        newCustomSettings.useOnLoadResource,
        OnLoadResourceJS.ON_LOAD_RESOURCE_JS_PLUGIN_SCRIPT(customSettings.pluginScriptsOriginAllowList,
          customSettings.pluginScriptsForMainFrameOnly)
      )
    }

    if (newSettingsMap["javaScriptCanOpenWindowsAutomatically"] != null && customSettings.javaScriptCanOpenWindowsAutomatically != newCustomSettings.javaScriptCanOpenWindowsAutomatically)
      settings.setJavaScriptCanOpenWindowsAutomatically(newCustomSettings.javaScriptCanOpenWindowsAutomatically)

    if (newSettingsMap["builtInZoomControls"] != null && customSettings.builtInZoomControls != newCustomSettings.builtInZoomControls)
      settings.setBuiltInZoomControls(newCustomSettings.builtInZoomControls)

    if (newSettingsMap["displayZoomControls"] != null && customSettings.displayZoomControls != newCustomSettings.displayZoomControls)
      settings.setDisplayZoomControls(newCustomSettings.displayZoomControls)

    if (newSettingsMap["safeBrowsingEnabled"] != null && customSettings.safeBrowsingEnabled != newCustomSettings.safeBrowsingEnabled) {
      if (WebViewFeature.isFeatureSupported(WebViewFeature.SAFE_BROWSING_ENABLE))
        WebSettingsCompat.setSafeBrowsingEnabled(settings, newCustomSettings.safeBrowsingEnabled)
      else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
        settings.setSafeBrowsingEnabled(newCustomSettings.safeBrowsingEnabled)
    }

    if (newSettingsMap["mediaPlaybackRequiresUserGesture"] != null && customSettings.mediaPlaybackRequiresUserGesture != newCustomSettings.mediaPlaybackRequiresUserGesture)
      settings.setMediaPlaybackRequiresUserGesture(newCustomSettings.mediaPlaybackRequiresUserGesture)

    if (newSettingsMap["databaseEnabled"] != null && customSettings.databaseEnabled != newCustomSettings.databaseEnabled)
      settings.setDatabaseEnabled(newCustomSettings.databaseEnabled)

    if (newSettingsMap["domStorageEnabled"] != null && customSettings.domStorageEnabled != newCustomSettings.domStorageEnabled)
      settings.setDomStorageEnabled(newCustomSettings.domStorageEnabled)

    if (newSettingsMap["userAgent"] != null && !customSettings.userAgent.equals(newCustomSettings.userAgent) && !newCustomSettings.userAgent.isEmpty())
      settings.setUserAgentString(newCustomSettings.userAgent)

    if (newSettingsMap["applicationNameForUserAgent"] != null && !customSettings.applicationNameForUserAgent.equals(newCustomSettings.applicationNameForUserAgent) && !newCustomSettings.applicationNameForUserAgent.isEmpty()) {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
        val userAgent = if (newCustomSettings.userAgent != null && !newCustomSettings.userAgent.isEmpty()) newCustomSettings.userAgent else WebSettings.getDefaultUserAgent(getContext())
        val userAgentWithApplicationName = userAgent + " " + customSettings.applicationNameForUserAgent
        settings.setUserAgentString(userAgentWithApplicationName)
      }
    }

    if (newSettingsMap["clearCache"] != null && newCustomSettings.clearCache)
      clearAllCache()
    else if (newSettingsMap["clearSessionCache"] != null && newCustomSettings.clearSessionCache)
      CookieManager.getInstance().removeSessionCookie()

    if (newSettingsMap["thirdPartyCookiesEnabled"] != null && customSettings.thirdPartyCookiesEnabled != newCustomSettings.thirdPartyCookiesEnabled && Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
      CookieManager.getInstance().setAcceptThirdPartyCookies(this, newCustomSettings.thirdPartyCookiesEnabled)

    if (newSettingsMap["useWideViewPort"] != null && customSettings.useWideViewPort != newCustomSettings.useWideViewPort)
      settings.setUseWideViewPort(newCustomSettings.useWideViewPort)

    if (newSettingsMap["supportZoom"] != null && customSettings.supportZoom != newCustomSettings.supportZoom)
      settings.setSupportZoom(newCustomSettings.supportZoom)

    if (newSettingsMap["textZoom"] != null && (customSettings.textZoom == null || !customSettings.textZoom!!.equals(newCustomSettings.textZoom)))
      settings.setTextZoom(newCustomSettings.textZoom!!)

    if (newSettingsMap["verticalScrollBarEnabled"] != null && customSettings.verticalScrollBarEnabled != newCustomSettings.verticalScrollBarEnabled)
      setVerticalScrollBarEnabled(newCustomSettings.verticalScrollBarEnabled)

    if (newSettingsMap["horizontalScrollBarEnabled"] != null && customSettings.horizontalScrollBarEnabled != newCustomSettings.horizontalScrollBarEnabled)
      setHorizontalScrollBarEnabled(newCustomSettings.horizontalScrollBarEnabled)

    if (newSettingsMap["transparentBackground"] != null && customSettings.transparentBackground != newCustomSettings.transparentBackground) {
      if (newCustomSettings.transparentBackground) {
        setBackgroundColor(Color.TRANSPARENT)
      } else {
        setBackgroundColor(Color.parseColor("#FFFFFF"))
      }
    }

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
      if (newSettingsMap["mixedContentMode"] != null && (customSettings.mixedContentMode == null || !customSettings.mixedContentMode!!.equals(newCustomSettings.mixedContentMode)))
        settings.setMixedContentMode(newCustomSettings.mixedContentMode!!)

    if (newSettingsMap["supportMultipleWindows"] != null && customSettings.supportMultipleWindows != newCustomSettings.supportMultipleWindows)
      settings.setSupportMultipleWindows(newCustomSettings.supportMultipleWindows)

    if (newSettingsMap["useOnDownloadStart"] != null && customSettings.useOnDownloadStart != newCustomSettings.useOnDownloadStart) {
      if (newCustomSettings.useOnDownloadStart) {
        setDownloadListener(DownloadStartListener())
      } else {
        setDownloadListener(null)
      }
    }

    if (newSettingsMap["allowContentAccess"] != null && customSettings.allowContentAccess != newCustomSettings.allowContentAccess)
      settings.setAllowContentAccess(newCustomSettings.allowContentAccess)

    if (newSettingsMap["allowFileAccess"] != null && customSettings.allowFileAccess != newCustomSettings.allowFileAccess)
      settings.setAllowFileAccess(newCustomSettings.allowFileAccess)

    if (newSettingsMap["allowFileAccessFromFileURLs"] != null && customSettings.allowFileAccessFromFileURLs != newCustomSettings.allowFileAccessFromFileURLs)
      settings.setAllowFileAccessFromFileURLs(newCustomSettings.allowFileAccessFromFileURLs)

    if (newSettingsMap["allowUniversalAccessFromFileURLs"] != null && customSettings.allowUniversalAccessFromFileURLs != newCustomSettings.allowUniversalAccessFromFileURLs)
      settings.setAllowUniversalAccessFromFileURLs(newCustomSettings.allowUniversalAccessFromFileURLs)

    if (newSettingsMap["cacheEnabled"] != null && customSettings.cacheEnabled != newCustomSettings.cacheEnabled)
      setCacheEnabled(newCustomSettings.cacheEnabled)

    if (newSettingsMap["appCachePath"] != null && (customSettings.appCachePath == null || !customSettings.appCachePath.equals(newCustomSettings.appCachePath))) {
      // removed from Android API 33+ (https://developer.android.com/sdk/api_diff/33/changes)
      // settings.setAppCachePath(newCustomSettings.appCachePath);
      Util.invokeMethodIfExists(settings, "setAppCachePath", newCustomSettings.appCachePath)
    }

    if (newSettingsMap["blockNetworkImage"] != null && customSettings.blockNetworkImage != newCustomSettings.blockNetworkImage)
      settings.setBlockNetworkImage(newCustomSettings.blockNetworkImage)

    if (newSettingsMap["blockNetworkLoads"] != null && customSettings.blockNetworkLoads != newCustomSettings.blockNetworkLoads)
      settings.setBlockNetworkLoads(newCustomSettings.blockNetworkLoads)

    if (newSettingsMap["cacheMode"] != null && !customSettings.cacheMode!!.equals(newCustomSettings.cacheMode))
      settings.setCacheMode(newCustomSettings.cacheMode!!)

    if (newSettingsMap["cursiveFontFamily"] != null && !customSettings.cursiveFontFamily.equals(newCustomSettings.cursiveFontFamily))
      settings.setCursiveFontFamily(newCustomSettings.cursiveFontFamily)

    if (newSettingsMap["defaultFixedFontSize"] != null && !customSettings.defaultFixedFontSize!!.equals(newCustomSettings.defaultFixedFontSize))
      settings.setDefaultFixedFontSize(newCustomSettings.defaultFixedFontSize!!)

    if (newSettingsMap["defaultFontSize"] != null && !customSettings.defaultFontSize!!.equals(newCustomSettings.defaultFontSize))
      settings.setDefaultFontSize(newCustomSettings.defaultFontSize!!)

    if (newSettingsMap["defaultTextEncodingName"] != null && !customSettings.defaultTextEncodingName.equals(newCustomSettings.defaultTextEncodingName))
      settings.setDefaultTextEncodingName(newCustomSettings.defaultTextEncodingName)

    if (newSettingsMap["disabledActionModeMenuItems"] != null &&
      (customSettings.disabledActionModeMenuItems == null ||
        !customSettings.disabledActionModeMenuItems!!.equals(newCustomSettings.disabledActionModeMenuItems))) {
      if (WebViewFeature.isFeatureSupported(WebViewFeature.DISABLED_ACTION_MODE_MENU_ITEMS))
        WebSettingsCompat.setDisabledActionModeMenuItems(settings, newCustomSettings.disabledActionModeMenuItems!!)
      else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N)
        settings.setDisabledActionModeMenuItems(newCustomSettings.disabledActionModeMenuItems!!)
    }

    if (newSettingsMap["fantasyFontFamily"] != null && !customSettings.fantasyFontFamily.equals(newCustomSettings.fantasyFontFamily))
      settings.setFantasyFontFamily(newCustomSettings.fantasyFontFamily)

    if (newSettingsMap["fixedFontFamily"] != null && !customSettings.fixedFontFamily.equals(newCustomSettings.fixedFontFamily))
      settings.setFixedFontFamily(newCustomSettings.fixedFontFamily)

    if (newSettingsMap["forceDark"] != null && !Util.objEquals(customSettings.forceDark, newCustomSettings.forceDark)) {
      if (WebViewFeature.isFeatureSupported(WebViewFeature.FORCE_DARK))
        WebSettingsCompat.setForceDark(settings, newCustomSettings.forceDark!!)
      else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q)
        settings.setForceDark(newCustomSettings.forceDark!!)
    }

    if (newSettingsMap["forceDarkStrategy"] != null &&
      !Util.objEquals(customSettings.forceDarkStrategy, newCustomSettings.forceDarkStrategy) &&
      WebViewFeature.isFeatureSupported(WebViewFeature.FORCE_DARK_STRATEGY)) {
      try {
        // for some reason the setForceDarkStrategy method could throw a ClassCastException
        // from the Android WebView Chromium library.
        WebSettingsCompat.setForceDarkStrategy(settings, newCustomSettings.forceDarkStrategy!!)
      } catch (e: Exception) {
        e.printStackTrace()
      }
    }

    if (newSettingsMap["geolocationEnabled"] != null && customSettings.geolocationEnabled != newCustomSettings.geolocationEnabled)
      settings.setGeolocationEnabled(newCustomSettings.geolocationEnabled)

    if (newSettingsMap["layoutAlgorithm"] != null && customSettings.layoutAlgorithm != newCustomSettings.layoutAlgorithm) {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT && newCustomSettings.layoutAlgorithm!!.equals(WebSettings.LayoutAlgorithm.TEXT_AUTOSIZING)) {
        settings.setLayoutAlgorithm(newCustomSettings.layoutAlgorithm)
      } else {
        settings.setLayoutAlgorithm(newCustomSettings.layoutAlgorithm)
      }
    }

    if (newSettingsMap["loadWithOverviewMode"] != null && customSettings.loadWithOverviewMode != newCustomSettings.loadWithOverviewMode)
      settings.setLoadWithOverviewMode(newCustomSettings.loadWithOverviewMode)

    if (newSettingsMap["loadsImagesAutomatically"] != null && customSettings.loadsImagesAutomatically != newCustomSettings.loadsImagesAutomatically)
      settings.setLoadsImagesAutomatically(newCustomSettings.loadsImagesAutomatically)

    if (newSettingsMap["minimumFontSize"] != null && !customSettings.minimumFontSize!!.equals(newCustomSettings.minimumFontSize))
      settings.setMinimumFontSize(newCustomSettings.minimumFontSize!!)

    if (newSettingsMap["minimumLogicalFontSize"] != null && !customSettings.minimumLogicalFontSize!!.equals(newCustomSettings.minimumLogicalFontSize))
      settings.setMinimumLogicalFontSize(newCustomSettings.minimumLogicalFontSize!!)

    if (newSettingsMap["initialScale"] != null && !customSettings.initialScale!!.equals(newCustomSettings.initialScale))
      setInitialScale(newCustomSettings.initialScale!!)

    if (newSettingsMap["needInitialFocus"] != null && customSettings.needInitialFocus != newCustomSettings.needInitialFocus)
      settings.setNeedInitialFocus(newCustomSettings.needInitialFocus)

    if (newSettingsMap["offscreenPreRaster"] != null && customSettings.offscreenPreRaster != newCustomSettings.offscreenPreRaster) {
      if (WebViewFeature.isFeatureSupported(WebViewFeature.OFF_SCREEN_PRERASTER))
        WebSettingsCompat.setOffscreenPreRaster(settings, newCustomSettings.offscreenPreRaster)
      else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
        settings.setOffscreenPreRaster(newCustomSettings.offscreenPreRaster)
    }

    if (newSettingsMap["sansSerifFontFamily"] != null && !customSettings.sansSerifFontFamily.equals(newCustomSettings.sansSerifFontFamily))
      settings.setSansSerifFontFamily(newCustomSettings.sansSerifFontFamily)

    if (newSettingsMap["serifFontFamily"] != null && !customSettings.serifFontFamily.equals(newCustomSettings.serifFontFamily))
      settings.setSerifFontFamily(newCustomSettings.serifFontFamily)

    if (newSettingsMap["standardFontFamily"] != null && !customSettings.standardFontFamily.equals(newCustomSettings.standardFontFamily))
      settings.setStandardFontFamily(newCustomSettings.standardFontFamily)

    if (newSettingsMap["preferredContentMode"] != null && !customSettings.preferredContentMode!!.equals(newCustomSettings.preferredContentMode)) {
      when (PreferredContentModeOptionType.fromValue(newCustomSettings.preferredContentMode!!)) {
        PreferredContentModeOptionType.DESKTOP ->
          setDesktopMode(true)
        PreferredContentModeOptionType.MOBILE,
        PreferredContentModeOptionType.RECOMMENDED ->
          setDesktopMode(false)
      }
    }

    if (newSettingsMap["saveFormData"] != null && customSettings.saveFormData != newCustomSettings.saveFormData)
      settings.setSaveFormData(newCustomSettings.saveFormData)

    if (newSettingsMap["incognito"] != null && customSettings.incognito != newCustomSettings.incognito)
      setIncognito(newCustomSettings.incognito)

    if (customSettings.useHybridComposition) {
      if (newSettingsMap["hardwareAcceleration"] != null && customSettings.hardwareAcceleration != newCustomSettings.hardwareAcceleration) {
        if (newCustomSettings.hardwareAcceleration)
          setLayerType(View.LAYER_TYPE_HARDWARE, null)
        else
          setLayerType(View.LAYER_TYPE_NONE, null)
      }
    }

    if (newCustomSettings.contentBlockers != null) {
      contentBlockerHandler.getRuleList().clear()
      for (contentBlocker in newCustomSettings.contentBlockers) {
        // compile ContentBlockerTrigger urlFilter
        val trigger = ContentBlockerTrigger.fromMap(contentBlocker["trigger"]!!)
        val action = ContentBlockerAction.fromMap(contentBlocker["action"]!!)
        contentBlockerHandler.getRuleList().add(ContentBlocker(trigger, action))
      }
    }

    if (newSettingsMap["scrollBarStyle"] != null && !customSettings.scrollBarStyle!!.equals(newCustomSettings.scrollBarStyle))
      setScrollBarStyle(newCustomSettings.scrollBarStyle!!)

    if (newSettingsMap["scrollBarDefaultDelayBeforeFade"] != null && (customSettings.scrollBarDefaultDelayBeforeFade == null ||
        !customSettings.scrollBarDefaultDelayBeforeFade!!.equals(newCustomSettings.scrollBarDefaultDelayBeforeFade)))
      setScrollBarDefaultDelayBeforeFade(newCustomSettings.scrollBarDefaultDelayBeforeFade!!)

    if (newSettingsMap["scrollbarFadingEnabled"] != null && !customSettings.scrollbarFadingEnabled!!.equals(newCustomSettings.scrollbarFadingEnabled))
      setScrollbarFadingEnabled(newCustomSettings.scrollbarFadingEnabled!!)

    if (newSettingsMap["scrollBarFadeDuration"] != null && (customSettings.scrollBarFadeDuration == null ||
        !customSettings.scrollBarFadeDuration!!.equals(newCustomSettings.scrollBarFadeDuration)))
      setScrollBarFadeDuration(newCustomSettings.scrollBarFadeDuration!!)

    if (newSettingsMap["verticalScrollbarPosition"] != null && !customSettings.verticalScrollbarPosition!!.equals(newCustomSettings.verticalScrollbarPosition))
      setVerticalScrollbarPosition(newCustomSettings.verticalScrollbarPosition!!)

    if (newSettingsMap["disableVerticalScroll"] != null && customSettings.disableVerticalScroll != newCustomSettings.disableVerticalScroll)
      setVerticalScrollBarEnabled(!newCustomSettings.disableVerticalScroll && newCustomSettings.verticalScrollBarEnabled)

    if (newSettingsMap["disableHorizontalScroll"] != null && customSettings.disableHorizontalScroll != newCustomSettings.disableHorizontalScroll)
      setHorizontalScrollBarEnabled(!newCustomSettings.disableHorizontalScroll && newCustomSettings.horizontalScrollBarEnabled)

    if (newSettingsMap["keyboardAvoidance"] != null && customSettings.keyboardAvoidance != newCustomSettings.keyboardAvoidance) {
      if (newCustomSettings.keyboardAvoidance) {
        // Refused rather than half-applied. The reporting script is registered during prepare(),
        // and reloading only re-injects what the user content controller already holds, so it
        // cannot recover a script that was never added. Applying just the inset interception
        // would silence Chromium with nothing left to move the field into view -- worse than
        // leaving the option off.
        Log.w(LOG_TAG, "keyboardAvoidance can only be enabled through initialSettings; ignoring this runtime change.")
      } else {
        // Disabling is safe at any time: the listener goes away, the shift is reset, and the
        // controller can no longer receive a keyboard height, so it computes a zero shift.
        setKeyboardAvoidanceEnabled(false)
      }
    }

    if (newSettingsMap["overScrollMode"] != null && !customSettings.overScrollMode!!.equals(newCustomSettings.overScrollMode))
      setOverScrollMode(newCustomSettings.overScrollMode!!)

    if (newSettingsMap["networkAvailable"] != null && customSettings.networkAvailable != newCustomSettings.networkAvailable)
      setNetworkAvailable(newCustomSettings.networkAvailable!!)

    if (newSettingsMap["rendererPriorityPolicy"] != null && (customSettings.rendererPriorityPolicy == null ||
        (customSettings.rendererPriorityPolicy!!["rendererRequestedPriority"] !== newCustomSettings.rendererPriorityPolicy!!["rendererRequestedPriority"] ||
          customSettings.rendererPriorityPolicy!!["waivedWhenNotVisible"] !== newCustomSettings.rendererPriorityPolicy!!["waivedWhenNotVisible"])) &&
      Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      setRendererPriorityPolicy(
        newCustomSettings.rendererPriorityPolicy!!["rendererRequestedPriority"] as Int,
        newCustomSettings.rendererPriorityPolicy!!["waivedWhenNotVisible"] as Boolean)
    }

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
      if (newSettingsMap["verticalScrollbarThumbColor"] != null && !Util.objEquals(customSettings.verticalScrollbarThumbColor, newCustomSettings.verticalScrollbarThumbColor))
        setVerticalScrollbarThumbDrawable(ColorDrawable(Color.parseColor(newCustomSettings.verticalScrollbarThumbColor)))

      if (newSettingsMap["verticalScrollbarTrackColor"] != null && !Util.objEquals(customSettings.verticalScrollbarTrackColor, newCustomSettings.verticalScrollbarTrackColor))
        setVerticalScrollbarTrackDrawable(ColorDrawable(Color.parseColor(newCustomSettings.verticalScrollbarTrackColor)))

      if (newSettingsMap["horizontalScrollbarThumbColor"] != null && !Util.objEquals(customSettings.horizontalScrollbarThumbColor, newCustomSettings.horizontalScrollbarThumbColor))
        setHorizontalScrollbarThumbDrawable(ColorDrawable(Color.parseColor(newCustomSettings.horizontalScrollbarThumbColor)))

      if (newSettingsMap["horizontalScrollbarTrackColor"] != null && !Util.objEquals(customSettings.horizontalScrollbarTrackColor, newCustomSettings.horizontalScrollbarTrackColor))
        setHorizontalScrollbarTrackDrawable(ColorDrawable(Color.parseColor(newCustomSettings.horizontalScrollbarTrackColor)))
    }

    if (newSettingsMap["algorithmicDarkeningAllowed"] != null &&
      !Util.objEquals(customSettings.algorithmicDarkeningAllowed, newCustomSettings.algorithmicDarkeningAllowed) &&
      WebViewFeature.isFeatureSupported(WebViewFeature.ALGORITHMIC_DARKENING) && Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
      WebSettingsCompat.setAlgorithmicDarkeningAllowed(settings, newCustomSettings.algorithmicDarkeningAllowed)
    }
    if (newSettingsMap["enterpriseAuthenticationAppLinkPolicyEnabled"] != null &&
      !Util.objEquals(customSettings.enterpriseAuthenticationAppLinkPolicyEnabled, newCustomSettings.enterpriseAuthenticationAppLinkPolicyEnabled) &&
      WebViewFeature.isFeatureSupported(WebViewFeature.ENTERPRISE_AUTHENTICATION_APP_LINK_POLICY)) {
      WebSettingsCompat.setEnterpriseAuthenticationAppLinkPolicyEnabled(settings, newCustomSettings.enterpriseAuthenticationAppLinkPolicyEnabled)
    }
    if (newSettingsMap["requestedWithHeaderOriginAllowList"] != null &&
      !Util.objEquals(customSettings.requestedWithHeaderOriginAllowList, newCustomSettings.requestedWithHeaderOriginAllowList) &&
      WebViewFeature.isFeatureSupported(WebViewFeature.REQUESTED_WITH_HEADER_ALLOW_LIST)) {
      WebSettingsCompat.setRequestedWithHeaderOriginAllowList(settings, newCustomSettings.requestedWithHeaderOriginAllowList!!)
    }

    if (plugin != null) {
      if (webViewAssetLoaderExt != null) {
        webViewAssetLoaderExt!!.dispose()
      }
      webViewAssetLoaderExt = WebViewAssetLoaderExt.fromMap(customSettings.webViewAssetLoader, plugin!!, getContext())
    }

    customSettings = newCustomSettings
  }

  override fun getCustomSettingsMap(): MutableMap<String, Any?>? {
    return if (customSettings != null) customSettings.getRealSettings(this) else null
  }

  fun enablePluginScriptAtRuntime(flagVariable: String,
                                  enable: Boolean,
                                  pluginScript: PluginScript?) {
    evaluateJavascript("((window.top == null || window.top === window) ? window : window.top)." + flagVariable, null, object : ValueCallback<String> {
      override fun onReceiveValue(value: String?) {
        val alreadyLoaded = value != null && !value.equals("null", ignoreCase = true)
        if (alreadyLoaded) {
          val enableSource = "((window.top == null || window.top === window) ? window : window.top)." + flagVariable + " = " + enable + ";"
          evaluateJavascript(enableSource, null, null)
          if (!enable) {
            userContentController.removePluginScript(pluginScript!!)
          }
        } else if (enable && javaScriptBridgeEnabled) {
          evaluateJavascript(pluginScript!!.source, null, null)
          userContentController.addPluginScript(pluginScript)
        }
      }
    })
  }

  fun injectDeferredObject(source: String, contentWorld: ContentWorld?, jsWrapper: String?, resultCallback: ValueCallback<String>?) {
    val resultUuid = if (contentWorld != null && contentWorld != ContentWorld.PAGE) UUID.randomUUID().toString() else null
    var scriptToInject = source
    if (jsWrapper != null) {
      val jsonEsc = org.json.JSONArray()
      jsonEsc.put(source)
      val jsonRepr = jsonEsc.toString()
      val jsonSourceString = jsonRepr.substring(1, jsonRepr.length - 1)
      scriptToInject = String.format(jsWrapper, jsonSourceString)
    }
    if (resultUuid != null && resultCallback != null) {
      evaluateJavaScriptContentWorldCallbacks[resultUuid] = resultCallback
      scriptToInject = Util.replaceAll(PluginScriptsUtil.EVALUATE_JAVASCRIPT_WITH_CONTENT_WORLD_WRAPPER_JS_SOURCE(),
        PluginScriptsUtil.VAR_RANDOM_NAME, "_" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "_" + Math.round(Math.random() * 1000000))
        .replace(PluginScriptsUtil.VAR_PLACEHOLDER_VALUE, UserContentController.escapeCode(source))
        .replace(PluginScriptsUtil.VAR_RESULT_UUID, resultUuid)
    }
    val finalScriptToInject = scriptToInject
    mainLooperHandler.post(object : Runnable {
      override fun run() {
        val scriptToInject = userContentController.generateCodeForScriptEvaluation(finalScriptToInject, contentWorld)
        evaluateJavascript(scriptToInject, object : ValueCallback<String> {
          override fun onReceiveValue(s: String?) {
            if (resultUuid != null || resultCallback == null)
              return
            resultCallback.onReceiveValue(s)
          }
        })
      }
    })
  }

  override fun evaluateJavascript(source: String, contentWorld: ContentWorld?, resultCallback: ValueCallback<String>?) {
    injectDeferredObject(source, contentWorld, null, resultCallback)
  }

  override fun injectJavascriptFileFromUrl(urlFile: String, scriptHtmlTagAttributes: MutableMap<String, Any?>?) {
    var scriptAttributes = ""
    if (scriptHtmlTagAttributes != null) {
      val typeAttr = scriptHtmlTagAttributes["type"] as String?
      if (typeAttr != null) {
        scriptAttributes += " script.type = '" + typeAttr.replace("'".toRegex(), "\\\\'") + "'; "
      }
      val idAttr = scriptHtmlTagAttributes["id"] as String?
      if (idAttr != null) {
        val scriptIdEscaped = idAttr.replace("'".toRegex(), "\\\\'")
        scriptAttributes += " script.id = '" + scriptIdEscaped + "'; "
        scriptAttributes += " script.onload = function() {" +
          "  if (window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + " != null) {" +
          "    window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + ".callHandler('onInjectedScriptLoaded', '" + scriptIdEscaped + "');" +
          "  }" +
          "};"
        scriptAttributes += " script.onerror = function() {" +
          "  if (window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + " != null) {" +
          "    window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + ".callHandler('onInjectedScriptError', '" + scriptIdEscaped + "');" +
          "  }" +
          "};"
      }
      val asyncAttr = scriptHtmlTagAttributes["async"] as Boolean?
      if (asyncAttr != null && asyncAttr) {
        scriptAttributes += " script.async = true; "
      }
      val deferAttr = scriptHtmlTagAttributes["defer"] as Boolean?
      if (deferAttr != null && deferAttr) {
        scriptAttributes += " script.defer = true; "
      }
      val crossOriginAttr = scriptHtmlTagAttributes["crossOrigin"] as String?
      if (crossOriginAttr != null) {
        scriptAttributes += " script.crossOrigin = '" + crossOriginAttr.replace("'".toRegex(), "\\\\'") + "'; "
      }
      val integrityAttr = scriptHtmlTagAttributes["integrity"] as String?
      if (integrityAttr != null) {
        scriptAttributes += " script.integrity = '" + integrityAttr.replace("'".toRegex(), "\\\\'") + "'; "
      }
      val noModuleAttr = scriptHtmlTagAttributes["noModule"] as Boolean?
      if (noModuleAttr != null && noModuleAttr) {
        scriptAttributes += " script.noModule = true; "
      }
      val nonceAttr = scriptHtmlTagAttributes["nonce"] as String?
      if (nonceAttr != null) {
        scriptAttributes += " script.nonce = '" + nonceAttr.replace("'".toRegex(), "\\\\'") + "'; "
      }
      val referrerPolicyAttr = scriptHtmlTagAttributes["referrerPolicy"] as String?
      if (referrerPolicyAttr != null) {
        scriptAttributes += " script.referrerPolicy = '" + referrerPolicyAttr.replace("'".toRegex(), "\\\\'") + "'; "
      }
    }
    val jsWrapper = "(function(d) { var script = d.createElement('script'); " + scriptAttributes +
      " script.src = %s; if (d.body != null) { d.body.appendChild(script); } })(document);"
    injectDeferredObject(urlFile, null, jsWrapper, null)
  }

  override fun injectCSSCode(source: String) {
    val jsWrapper = "(function(d) { var style = d.createElement('style'); style.innerHTML = %s;" +
      " if (d.head != null) { d.head.appendChild(style); } })(document);"
    injectDeferredObject(source, null, jsWrapper, null)
  }

  override fun injectCSSFileFromUrl(urlFile: String, cssLinkHtmlTagAttributes: MutableMap<String, Any?>?) {
    var cssLinkAttributes = ""
    var alternateStylesheet = ""
    if (cssLinkHtmlTagAttributes != null) {
      val idAttr = cssLinkHtmlTagAttributes["id"] as String?
      if (idAttr != null) {
        cssLinkAttributes += " link.id = '" + idAttr.replace("'".toRegex(), "\\\\'") + "'; "
      }
      val mediaAttr = cssLinkHtmlTagAttributes["media"] as String?
      if (mediaAttr != null) {
        cssLinkAttributes += " link.media = '" + mediaAttr.replace("'".toRegex(), "\\\\'") + "'; "
      }
      val crossOriginAttr = cssLinkHtmlTagAttributes["crossOrigin"] as String?
      if (crossOriginAttr != null) {
        cssLinkAttributes += " link.crossOrigin = '" + crossOriginAttr.replace("'".toRegex(), "\\\\'") + "'; "
      }
      val integrityAttr = cssLinkHtmlTagAttributes["integrity"] as String?
      if (integrityAttr != null) {
        cssLinkAttributes += " link.integrity = '" + integrityAttr.replace("'".toRegex(), "\\\\'") + "'; "
      }
      val referrerPolicyAttr = cssLinkHtmlTagAttributes["referrerPolicy"] as String?
      if (referrerPolicyAttr != null) {
        cssLinkAttributes += " link.referrerPolicy = '" + referrerPolicyAttr.replace("'".toRegex(), "\\\\'") + "'; "
      }
      val disabledAttr = cssLinkHtmlTagAttributes["disabled"] as Boolean?
      if (disabledAttr != null && disabledAttr) {
        cssLinkAttributes += " link.disabled = true; "
      }
      val alternateAttr = cssLinkHtmlTagAttributes["alternate"] as Boolean?
      if (alternateAttr != null && alternateAttr) {
        alternateStylesheet = "alternate "
      }
      val titleAttr = cssLinkHtmlTagAttributes["title"] as String?
      if (titleAttr != null) {
        cssLinkAttributes += " link.title = '" + titleAttr.replace("'".toRegex(), "\\\\'") + "'; "
      }
    }
    val jsWrapper = "(function(d) { var link = d.createElement('link'); link.rel='" + alternateStylesheet + "stylesheet'; link.type='text/css'; " +
      cssLinkAttributes + " link.href = %s; if (d.head != null) { d.head.appendChild(link); } })(document);"
    injectDeferredObject(urlFile, null, jsWrapper, null)
  }

  override fun getCopyBackForwardList(): HashMap<String, Any?> {
    val currentList = copyBackForwardList()
    val currentSize = currentList.getSize()
    val currentIndex = currentList.getCurrentIndex()

    val history: MutableList<HashMap<String, Any?>> = ArrayList<HashMap<String, Any?>>()

    for (i in 0 until currentSize) {
      val historyItem = currentList.getItemAtIndex(i)
      val historyItemMap = HashMap<String, Any?>()

      historyItemMap["originalUrl"] = historyItem.getOriginalUrl()
      historyItemMap["title"] = historyItem.getTitle()
      historyItemMap["url"] = historyItem.getUrl()
      historyItemMap["index"] = i
      historyItemMap["offset"] = i - currentIndex

      history.add(historyItemMap)
    }

    val result = HashMap<String, Any?>()

    result["list"] = history
    result["currentIndex"] = currentIndex

    return result
  }

  override fun onScrollChanged(x: Int,
                               y: Int,
                               oldX: Int,
                               oldY: Int) {
    super.onScrollChanged(x, y, oldX, oldY)

    if (floatingContextMenu != null) {
      floatingContextMenu!!.setAlpha(0f)
      floatingContextMenu!!.setVisibility(View.GONE)
    }

    if (channelDelegate != null) channelDelegate!!.onScrollChanged(x, y)
  }

  override fun scrollTo(x: Int?, y: Int?, animated: Boolean?) {
    if (animated!!) {
      val pvhX = PropertyValuesHolder.ofInt("scrollX", x!!)
      val pvhY = PropertyValuesHolder.ofInt("scrollY", y!!)
      val anim = ObjectAnimator.ofPropertyValuesHolder(this, pvhX, pvhY)
      anim.setDuration(300).start()
    } else {
      scrollTo(x!!, y!!)
    }
  }

  override fun scrollBy(x: Int?, y: Int?, animated: Boolean?) {
    if (animated!!) {
      val pvhX = PropertyValuesHolder.ofInt("scrollX", getScrollX() + x!!)
      val pvhY = PropertyValuesHolder.ofInt("scrollY", getScrollY() + y!!)
      val anim = ObjectAnimator.ofPropertyValuesHolder(this, pvhX, pvhY)
      anim.setDuration(300).start()
    } else {
      scrollBy(x!!, y!!)
    }
  }

  // package-private in Java
  inner class DownloadStartListener : DownloadListener {
    override fun onDownloadStart(url: String, userAgent: String, contentDisposition: String, mimeType: String, contentLength: Long) {
      val downloadStartRequest = DownloadStartRequest(
        url,
        userAgent,
        contentDisposition,
        mimeType,
        contentLength,
        URLUtil.guessFileName(url, contentDisposition, mimeType),
        null
      )
      if (channelDelegate != null) channelDelegate!!.onDownloadStarting(downloadStartRequest)
    }
  }

  fun setDesktopMode(enabled: Boolean) {
    val webSettings = getSettings()

    val newUserAgent: String
    if (enabled) {
      newUserAgent = webSettings.getUserAgentString().replace("Mobile", "eliboM").replace("Android", "diordnA")
    } else {
      newUserAgent = webSettings.getUserAgentString().replace("eliboM", "Mobile").replace("diordnA", "Android")
    }

    webSettings.setUserAgentString(newUserAgent)
    webSettings.setUseWideViewPort(enabled)
    webSettings.setLoadWithOverviewMode(enabled)
    webSettings.setSupportZoom(enabled)
    webSettings.setBuiltInZoomControls(enabled)
  }

  override fun printCurrentPage(settings: PrintJobSettings?): String? {
    val plugin = this.plugin
    if (plugin != null && plugin.activity != null) {
      // Get a PrintManager instance
      val printManager = plugin.activity!!.getSystemService(Context.PRINT_SERVICE) as PrintManager?

      if (printManager != null) {
        val builder = PrintAttributes.Builder()

        var jobName = (if (getTitle() != null) getTitle() else getUrl()) + " Document"

        if (settings != null) {
          if (settings.jobName != null && !settings.jobName!!.isEmpty()) {
            jobName = settings.jobName!!
          }
          if (settings.orientation != null) {
            val orientation: Int = settings.orientation!!
            when (orientation) {
              0 ->
                // PORTRAIT
                builder.setMediaSize(PrintAttributes.MediaSize.UNKNOWN_PORTRAIT)
              1 ->
                // LANDSCAPE
                builder.setMediaSize(PrintAttributes.MediaSize.UNKNOWN_LANDSCAPE)
            }
          }
//          if (settings.margins != null) {
//            // for some reason, Android doesn't set the margins
//            builder.setMinMargins(settings.margins.toMargins());
//          }
          if (settings.mediaSize != null) {
            builder.setMediaSize(settings.mediaSize!!.toMediaSize())
          }
          if (settings.colorMode != null) {
            builder.setColorMode(settings.colorMode!!)
          }
          if (settings.duplexMode != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            builder.setDuplexMode(settings.duplexMode!!)
          }
          if (settings.resolution != null) {
            builder.setResolution(settings.resolution!!.toResolution())
          }
        }

        // Get a printCurrentPage adapter instance
        var printAdapter: PrintDocumentAdapter
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          printAdapter = createPrintDocumentAdapter(jobName)
        } else {
          printAdapter = createPrintDocumentAdapter()
        }

        var printJobController: PrintJobController? = null
        var id: String? = null

        if (settings != null && settings.handledByClient!! && plugin.printJobManager != null) {
          id = UUID.randomUUID().toString()
          printJobController = PrintJobController(id, settings, plugin)
          plugin.printJobManager!!.jobs[printJobController.id] = printJobController
          val finalPrintJobController: PrintJobController = printJobController
          printAdapter = AqutterWebViewPrintDocumentAdapter(printAdapter, object : AqutterWebViewPrintDocumentAdapter.PrintDocumentAdapterCallback() {
            override fun onFinish() {
              finalPrintJobController.onComplete(true, null)
            }
          })
        }

        // Create a printCurrentPage job with name and adapter instance
        val job = printManager.print(jobName, printAdapter, builder.build())
        if (printJobController != null) printJobController.setJob(job)

        return id
      } else {
        Log.e(LOG_TAG, "No PrintManager available")
      }
    }
    return null
  }

  public override fun onCreateContextMenu(menu: ContextMenu) {
    super.onCreateContextMenu(menu)
    sendOnCreateContextMenuEvent()
  }

  private fun sendOnCreateContextMenuEvent() {
    val hitTestResult =
      com.github.aqutter.core.types.HitTestResult.fromWebViewHitTestResult(getHitTestResult())
    if (channelDelegate != null) channelDelegate!!.onCreateContextMenu(hitTestResult)
  }

  private var contextMenuPoint = Point(0, 0)
  private var lastTouch = Point(0, 0)

  override fun onTouchEvent(ev: MotionEvent): Boolean {
    if (!customSettings.isUserInteractionEnabled) {
      return true
    }

    if (shouldDropSystemGestureArtefact(ev)) {
      return true
    }

    lastTouch = Point(ev.x.toInt(), ev.y.toInt())

    val parent = getParent()
    if (parent is PullToRefreshLayout) {
      val pullToRefreshLayout: PullToRefreshLayout = parent
      if (ev.actionMasked == MotionEvent.ACTION_DOWN) {
        pullToRefreshLayout.setEnabled(false)
      }
    }

    return super.onTouchEvent(ev)
  }

  /**
   * Whether this event is the displaced `ACTION_MOVE` the system injects when it takes a
   * back gesture over from the app, which Chromium would otherwise apply as a real scroll.
   *
   * When the system claims an edge swipe it sends a synthetic `ACTION_MOVE` carrying a
   * position far from the finger, immediately followed by `ACTION_CANCEL` with the same
   * event time. That pattern exists so views using slop-based detection give up. Chromium instead
   * scrolls by the displacement, and the `ACTION_CANCEL` that follows does not undo it -- so
   * the page jumps every time the user swipes back over the WebView.
   *
   * Measured on a 1080x2400 / density 2.75 device: real moves within such a gesture displace at
   * most 16px, the injected one 268-269px. [GESTURE_ARTEFACT_THRESHOLD_DP] sits between the
   * two, and the check only runs for gestures that began inside the system gesture insets, so a
   * fast flick anywhere else is untouched. Dropping one event is safe regardless: later events
   * carry absolute positions, so nothing accumulates.
   */
  private fun shouldDropSystemGestureArtefact(ev: MotionEvent): Boolean {
    when (ev.actionMasked) {
      MotionEvent.ACTION_DOWN -> {
        gestureStartedInSystemGestureArea = isInsideSystemGestureArea(ev.x)
        lastGestureX = ev.x
        lastGestureY = ev.y
        return false
      }
      MotionEvent.ACTION_MOVE -> {
        if (!gestureStartedInSystemGestureArea) {
          return false
        }
        val thresholdPx =
          GESTURE_ARTEFACT_THRESHOLD_DP * getResources().getDisplayMetrics().density
        val displaced =
          Math.abs(ev.x - lastGestureX) > thresholdPx
            || Math.abs(ev.y - lastGestureY) > thresholdPx
        if (displaced) {
          // Deliberately not updating the last position: the injected event never happened as far
          // as this gesture is concerned.
          return true
        }
        lastGestureX = ev.x
        lastGestureY = ev.y
        return false
      }
      else -> {
        gestureStartedInSystemGestureArea = false
        return false
      }
    }
  }

  /** Whether `x` falls in the left or right strip reserved for system gestures. */
  private fun isInsideSystemGestureArea(x: Float): Boolean {
    // Gesture navigation arrived in API 29; below that there is no such strip and nothing to guard.
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
      return false
    }
    val insets = ViewCompat.getRootWindowInsets(this)
    if (insets == null) {
      return false
    }
    val gestureInsets = insets.getInsets(WindowInsetsCompat.Type.systemGestures())
    return x <= gestureInsets.left || x >= getWidth() - gestureInsets.right
  }

  override fun onOverScrolled(scrollX: Int, scrollY: Int, clampedX: Boolean, clampedY: Boolean) {
    super.onOverScrolled(scrollX, scrollY, clampedX, clampedY)

    val overScrolledHorizontally = canScrollHorizontally() && clampedX
    val overScrolledVertically = canScrollVertically() && clampedY

    val parent = getParent()
    if (parent is PullToRefreshLayout && overScrolledVertically && scrollY <= 10) {
      val pullToRefreshLayout: PullToRefreshLayout = parent
      // change over scroll mode to OVER_SCROLL_NEVER in order to disable temporarily the glow effect
      setOverScrollMode(View.OVER_SCROLL_NEVER)
      pullToRefreshLayout.setEnabled(pullToRefreshLayout.settings.enabled!!)
      // reset over scroll mode
      setOverScrollMode(customSettings.overScrollMode!!)
    }

    if (overScrolledHorizontally || overScrolledVertically) {
      if (channelDelegate != null)
        channelDelegate!!.onOverScrolled(scrollX, scrollY, overScrolledHorizontally, overScrolledVertically)
    }
  }

  override fun dispatchTouchEvent(event: MotionEvent): Boolean {
    return super.dispatchTouchEvent(event)
  }

  override fun onCreateInputConnection(outAttrs: EditorInfo): InputConnection? {
    val connection = super.onCreateInputConnection(outAttrs)
    if (connection == null && !customSettings.useHybridComposition && containerView != null) {
      // workaround to hide the Keyboard when the user click outside
      // on something not focusable such as input or a textarea.
      containerView!!
        .getHandler()
        .postDelayed(
          object : Runnable {
            override fun run() {
              val imm =
                getContext().getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager?

              var isAcceptingText = false
              if (imm != null) {
                try {
                  // imm.isAcceptingText() seems to sometimes crash on some devices
                  isAcceptingText = imm.isAcceptingText()
                } catch (ignored: Exception) {
                }
              }

              if (containerView != null && imm != null && !isAcceptingText) {
                imm.hideSoftInputFromWindow(
                  containerView!!.getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS)
              }
            }
          },
          128)
    }
    return connection
  }

  override fun startActionMode(callback: ActionMode.Callback): ActionMode? {
    if (customSettings.useHybridComposition && !customSettings.disableContextMenu && (contextMenu == null || contextMenu!!.keys.size == 0)) {
      return super.startActionMode(callback)
    }
    return rebuildActionMode(super.startActionMode(callback), callback)
  }

  @RequiresApi(Build.VERSION_CODES.M)
  override fun startActionMode(callback: ActionMode.Callback, type: Int): ActionMode? {
    if (customSettings.useHybridComposition && !customSettings.disableContextMenu && (contextMenu == null || contextMenu!!.keys.size == 0)) {
      return super.startActionMode(callback, type)
    }
    return rebuildActionMode(super.startActionMode(callback, type), callback)
  }

  @Suppress("UNCHECKED_CAST")
  fun rebuildActionMode(
    actionMode: ActionMode?,
    callback: ActionMode.Callback
  ): ActionMode? {
    // fix Android 10 clipboard not working properly https://github.com/pichillilorenzo/flutter_inappwebview/issues/678
    if (!customSettings.useHybridComposition && containerView != null) {
      onWindowFocusChanged(containerView!!.isFocused())
    }

    var hasBeenRemovedAndRebuilt = false
    if (floatingContextMenu != null) {
      hideContextMenu()
      hasBeenRemovedAndRebuilt = true
    }
    if (actionMode == null) {
      return null
    }

    val actionMenu = actionMode.getMenu()
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      actionMode.hide(3000)
    }
    val defaultMenuItems: MutableList<MenuItem> = ArrayList()
    for (i in 0 until actionMenu.size()) {
      defaultMenuItems.add(actionMenu.getItem(i))
    }
    actionMenu.clear()
    actionMode.finish()
    if (customSettings.disableContextMenu) {
      return actionMode
    }

    floatingContextMenu = LayoutInflater.from(this.getContext())
      .inflate(R.layout.floating_action_mode, this, false) as LinearLayout
    val horizontalScrollView = floatingContextMenu!!.getChildAt(0) as HorizontalScrollView
    val menuItemListLayout = horizontalScrollView.getChildAt(0) as LinearLayout

    var customMenuItems: List<Map<String, Any?>>? = ArrayList()
    val contextMenuSettings = ContextMenuSettings()
    if (contextMenu != null) {
      customMenuItems = contextMenu!!["menuItems"] as List<Map<String, Any?>>?
      val contextMenuSettingsMap = contextMenu!!["settings"] as MutableMap<String, Any?>?
      if (contextMenuSettingsMap != null) {
        contextMenuSettings.parse(contextMenuSettingsMap)
      }
    }
    customMenuItems = if (customMenuItems == null) ArrayList<Map<String, Any?>>() else customMenuItems

    if (contextMenuSettings.hideDefaultSystemContextMenuItems == null || !contextMenuSettings.hideDefaultSystemContextMenuItems!!) {
      for (menuItem in defaultMenuItems) {
        val itemId = menuItem.getItemId()
        val itemTitle = menuItem.getTitle()!!.toString()

        val text = LayoutInflater.from(this.getContext())
          .inflate(R.layout.floating_action_mode_item, this, false) as TextView
        text.setText(itemTitle)
        text.setOnClickListener(object : View.OnClickListener {
          override fun onClick(v: View) {
            hideContextMenu()
            callback.onActionItemClicked(actionMode, menuItem)

            if (channelDelegate != null)
              channelDelegate!!.onContextMenuActionItemClicked(itemId, itemTitle)
          }
        })
        if (floatingContextMenu != null) {
          menuItemListLayout.addView(text)
        }
      }
    }

    for (menuItem in customMenuItems!!) {
      val itemId = menuItem["id"] as Int
      val itemTitle = menuItem["title"] as String?
      val text = LayoutInflater.from(this.getContext())
        .inflate(R.layout.floating_action_mode_item, this, false) as TextView
      text.setText(itemTitle)
      text.setOnClickListener(object : View.OnClickListener {
        override fun onClick(v: View) {
          hideContextMenu()

          if (channelDelegate != null)
            channelDelegate!!.onContextMenuActionItemClicked(itemId, itemTitle)
        }
      })
      if (floatingContextMenu != null) {
        menuItemListLayout.addView(text)
      }
    }

    val x = if (lastTouch != null) lastTouch.x else 0
    val y = if (lastTouch != null) lastTouch.y else 0
    contextMenuPoint = Point(x, y)

    if (floatingContextMenu != null) {
      floatingContextMenu!!.getViewTreeObserver().addOnGlobalLayoutListener(object : ViewTreeObserver.OnGlobalLayoutListener {

        override fun onGlobalLayout() {
          if (floatingContextMenu != null) {
            floatingContextMenu!!.getViewTreeObserver().removeOnGlobalLayoutListener(this)
            if (getSettings().getJavaScriptEnabled()) {
              onScrollStopped()
            } else {
              onFloatingActionGlobalLayout(x, y)
            }
          }
        }
      })
      addView(floatingContextMenu, AbsoluteLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT, x, y))
      if (hasBeenRemovedAndRebuilt) {
        sendOnCreateContextMenuEvent()
      }
      if (checkContextMenuShouldBeClosedTask != null) {
        checkContextMenuShouldBeClosedTask!!.run()
      }
    }

    return actionMode
  }

  fun onFloatingActionGlobalLayout(x: Int, y: Int) {
    val maxWidth = getWidth()
    val maxHeight = getHeight()
    val width = floatingContextMenu!!.getWidth()
    val height = floatingContextMenu!!.getHeight()
    var curx = x - (width / 2)
    if (curx < 0) {
      curx = 0
    } else if (curx + width > maxWidth) {
      curx = maxWidth - width
    }
    // float size = 12 * scale;
    var cury = y - (height * 1.5f)
    if (cury < 0) {
      cury = (y + height).toFloat()
    }

    updateViewLayout(
      floatingContextMenu,
      AbsoluteLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT, curx + getScrollX(), (cury.toInt()) + getScrollY())
    )

    mainLooperHandler.post(object : Runnable {
      override fun run() {
        if (floatingContextMenu != null) {
          floatingContextMenu!!.setVisibility(View.VISIBLE)
          floatingContextMenu!!.animate().alpha(1f).setDuration(100).setListener(null)
        }
      }
    })
  }

  fun hideContextMenu() {
    removeView(floatingContextMenu)
    floatingContextMenu = null

    if (channelDelegate != null) channelDelegate!!.onHideContextMenu()
  }

  fun onScrollStopped() {
    if (floatingContextMenu != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
      adjustFloatingContextMenuPosition()
    }
  }

  @RequiresApi(Build.VERSION_CODES.KITKAT)
  fun adjustFloatingContextMenuPosition() {
    evaluateJavascript("(function(){" +
      "  var selection = window.getSelection();" +
      "  var rangeY = null;" +
      "  if (selection != null && selection.rangeCount > 0) {" +
      "    var range = selection.getRangeAt(0);" +
      "    var clientRect = range.getClientRects();" +
      "    if (clientRect.length > 0) {" +
      "      rangeY = clientRect[0].y;" +
      "    } else if (document.activeElement != null && document.activeElement.tagName.toLowerCase() !== 'iframe') {" +
      "      var boundingClientRect = document.activeElement.getBoundingClientRect();" +
      "      rangeY = boundingClientRect.y;" +
      "    }" +
      "  }" +
      "  return rangeY;" +
      "})();", object : ValueCallback<String> {
      override fun onReceiveValue(value: String?) {
        if (floatingContextMenu != null) {
          if (value != null && !value.equals("null", ignoreCase = true)) {
            val x = contextMenuPoint.x
            val y = ((java.lang.Float.parseFloat(value) * Util.getPixelDensity(getContext())) + (floatingContextMenu!!.getHeight() / 3.5)).toInt()
            contextMenuPoint.y = y
            onFloatingActionGlobalLayout(x, y)
          } else {
            floatingContextMenu!!.setVisibility(View.VISIBLE)
            floatingContextMenu!!.animate().alpha(1f).setDuration(100).setListener(null)
            onFloatingActionGlobalLayout(contextMenuPoint.x, contextMenuPoint.y)
          }
        }
      }
    })
  }

  @RequiresApi(Build.VERSION_CODES.KITKAT)
  override fun getSelectedText(resultCallback: ValueCallback<String>) {
    evaluateJavascript(PluginScriptsUtil.GET_SELECTED_TEXT_JS_SOURCE, object : ValueCallback<String> {
      override fun onReceiveValue(value: String?) {
        val result = if (value != null && !value.equals("null", ignoreCase = true)) value.substring(1, value.length - 1) else null
        resultCallback.onReceiveValue(result)
      }
    })
  }

  override fun requestFocusNodeHref(): MutableMap<String, Any?> {
    val msg = AqutterWebView.mHandler.obtainMessage()
    requestFocusNodeHref(msg)
    val bundle = msg.peekData()

    val obj: MutableMap<String, Any?> = HashMap()
    obj["src"] = bundle!!.getString("src")
    obj["url"] = bundle!!.getString("url")
    obj["title"] = bundle!!.getString("title")

    return obj
  }

  override fun requestImageRef(): MutableMap<String, Any?> {
    val msg = AqutterWebView.mHandler.obtainMessage()
    requestImageRef(msg)
    val bundle = msg.peekData()

    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = bundle!!.getString("url")

    return obj
  }

  @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
  override fun callAsyncJavaScript(functionBody: String, arguments: MutableMap<String, Any?>, contentWorld: ContentWorld?, resultCallback: ValueCallback<String>?) {
    val resultUuid = UUID.randomUUID().toString()
    if (resultCallback != null) {
      callAsyncJavaScriptCallbacks[resultUuid] = resultCallback
    }

    val functionArguments = JSONObject(arguments)
    val keys = functionArguments.keys()

    val functionArgumentNamesList: MutableList<String> = ArrayList()
    val functionArgumentValuesList: MutableList<String> = ArrayList()
    while (keys.hasNext()) {
      val key = keys.next()
      functionArgumentNamesList.add(key)
      functionArgumentValuesList.add("obj." + key)
    }

    val functionArgumentNames = TextUtils.join(", ", functionArgumentNamesList)
    val functionArgumentValues = TextUtils.join(", ", functionArgumentValuesList)
    val functionArgumentsObj = Util.JSONStringify(arguments)

    var sourceToInject = PluginScriptsUtil.CALL_ASYNC_JAVA_SCRIPT_WRAPPER_JS_SOURCE()
      .replace(PluginScriptsUtil.VAR_FUNCTION_ARGUMENT_NAMES, functionArgumentNames)
      .replace(PluginScriptsUtil.VAR_FUNCTION_ARGUMENT_VALUES, functionArgumentValues)
      .replace(PluginScriptsUtil.VAR_FUNCTION_ARGUMENTS_OBJ, functionArgumentsObj)
      .replace(PluginScriptsUtil.VAR_FUNCTION_BODY, functionBody)
      .replace(PluginScriptsUtil.VAR_RESULT_UUID, resultUuid)
      .replace(PluginScriptsUtil.VAR_RESULT_UUID, resultUuid)

    sourceToInject = userContentController.generateCodeForScriptEvaluation(sourceToInject, contentWorld)
    evaluateJavascript(sourceToInject, null)
  }

  @TargetApi(Build.VERSION_CODES.LOLLIPOP)
  override fun isSecureContext(resultCallback: ValueCallback<Boolean>) {
    evaluateJavascript("window.isSecureContext", object : ValueCallback<String> {
      override fun onReceiveValue(value: String?) {
        if (value == null || value.isEmpty() || value.equals("null", ignoreCase = true)
          || value.equals("false", ignoreCase = true)) {
          resultCallback.onReceiveValue(false)
          return
        }
        resultCallback.onReceiveValue(true)
      }
    })
  }

  override fun canScrollVertically(): Boolean {
    return computeVerticalScrollRange() > computeVerticalScrollExtent()
  }

  override fun canScrollHorizontally(): Boolean {
    return computeHorizontalScrollRange() > computeHorizontalScrollExtent()
  }

  override fun createCompatWebMessageChannel(): WebMessageChannel {
    val id = UUID.randomUUID().toString()
    val webMessageChannel = WebMessageChannel(id, this)
    webMessageChannels[id] = webMessageChannel
    return webMessageChannel
  }

  override fun createWebMessageChannel(callback: ValueCallback<WebMessageChannel>): WebMessageChannel {
    val webMessageChannel = createCompatWebMessageChannel()
    callback.onReceiveValue(webMessageChannel)
    return webMessageChannel
  }

  @Throws(Exception::class)
  override fun addWebMessageListener(webMessageListener: WebMessageListener) {
    if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_LISTENER)) {
      WebViewCompat.addWebMessageListener(this, webMessageListener.jsObjectName, webMessageListener.allowedOriginRules, webMessageListener.listener!!)
      webMessageListeners.add(webMessageListener)
    }
  }

  override fun disposeWebMessageChannels() {
    for (webMessageChannel in webMessageChannels.values) {
      webMessageChannel.dispose()
    }
    webMessageChannels.clear()
  }

  override fun disposeWebMessageListeners() {
    for (webMessageListener in webMessageListeners) {
      webMessageListener.dispose()
    }
    webMessageListeners.clear()
  }

  override fun getWebViewLooper(): Looper {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
      return super.getWebViewLooper()
    }
    return Looper.getMainLooper()
  }

  override fun isInFullscreen(): Boolean {
    return inFullscreen
  }

  override fun setInFullscreen(inFullscreen: Boolean) {
    this.inFullscreen = inFullscreen
  }

  @Throws(Exception::class)
  override fun postWebMessage(message: com.github.aqutter.core.types.WebMessage, targetOrigin: Uri, callback: ValueCallback<String>) {
    throw UnsupportedOperationException()
  }

  override fun onWindowVisibilityChanged(visibility: Int) {
    if (customSettings.allowBackgroundAudioPlaying) {
      if (visibility != View.GONE) {
        super.onWindowVisibilityChanged(View.VISIBLE)
      }
      return
    }
    super.onWindowVisibilityChanged(visibility)
  }

  override fun getZoomScale(): Float {
    return zoomScale
  }

  override fun getZoomScale(callback: ValueCallback<Float>) {
    callback.onReceiveValue(zoomScale)
  }

  override fun getContextMenu(): MutableMap<String, Any?>? {
    return contextMenu
  }

  override fun setContextMenu(contextMenu: MutableMap<String, Any?>?) {
    this.contextMenu = contextMenu
  }

  override fun getPlugin(): AqutterCorePlugin? {
    return plugin
  }

  override fun setPlugin(plugin: AqutterCorePlugin?) {
    this.plugin = plugin
  }

  override fun getAqutterBrowserDelegate(): AqutterBrowserDelegate? {
    return aqutterBrowserDelegate
  }

  override fun setAqutterBrowserDelegate(aqutterBrowserDelegate: AqutterBrowserDelegate?) {
    this.aqutterBrowserDelegate = aqutterBrowserDelegate
  }

  override fun getUserContentController(): UserContentController {
    return userContentController
  }

  override fun setUserContentController(userContentController: UserContentController) {
    this.userContentController = userContentController
  }

  override fun getWebMessageChannels(): MutableMap<String, WebMessageChannel> {
    return webMessageChannels
  }

  override fun setWebMessageChannels(webMessageChannels: MutableMap<String, WebMessageChannel>) {
    this.webMessageChannels = webMessageChannels
  }

  override fun getContentHeight(callback: ValueCallback<Int>) {
    callback.onReceiveValue(getContentHeight())
  }

  override fun getContentWidth(callback: ValueCallback<Int>) {
    evaluateJavascript("document.documentElement.scrollWidth;", object : ValueCallback<String> {
      override fun onReceiveValue(value: String?) {
        var contentWidth: Int? = null
        if (value != null && !value.equals("null", ignoreCase = true)) {
          contentWidth = Integer.parseInt(value)
        }
        callback.onReceiveValue(contentWidth)
      }
    })
  }

  override fun getHitTestResult(callback: ValueCallback<com.github.aqutter.core.types.HitTestResult>) {
    callback.onReceiveValue(com.github.aqutter.core.types.HitTestResult.fromWebViewHitTestResult(getHitTestResult()))
  }

  override fun getChannelDelegate(): WebViewChannelDelegate? {
    return channelDelegate
  }

  override fun setChannelDelegate(channelDelegate: WebViewChannelDelegate?) {
    this.channelDelegate = channelDelegate
  }

  override fun getCustomSettings(): AqutterWebViewSettings {
    return customSettings
  }

  override fun showInputMethod() {
    if (plugin == null || plugin!!.activity == null) {
      return
    }
    val imm = plugin!!.activity!!.getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager?
    if (imm != null) {
      imm.showSoftInput(this, 0)
    }
  }

  override fun hideInputMethod() {
    if (plugin == null || plugin!!.activity == null) {
      return
    }
    val imm = plugin!!.activity!!.getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager?
    if (imm != null) {
      var windowToken: IBinder? = getWindowToken()
      if (!customSettings.useHybridComposition && containerView != null) {
        windowToken = containerView!!.getWindowToken()
      }
      imm.hideSoftInputFromWindow(windowToken, 0)
    }
  }

  override fun saveState(): ByteArray? {
    val bundle = Bundle()
    if (saveState(bundle) != null) {
      val parcel = Parcel.obtain()
      bundle.writeToParcel(parcel, 0)
      val bytes = parcel.marshall()
      parcel.recycle()
      return bytes
    }
    return null
  }

  override fun restoreState(state: ByteArray?): Boolean {
    var restored = false
    val parcel = Parcel.obtain()
    try {
      parcel.unmarshall(state!!, 0, state.size)
      parcel.setDataPosition(0)
      val bundle = Bundle.CREATOR.createFromParcel(parcel)
      restored = restoreState(bundle) != null
    } catch (e: Exception) {
      e.printStackTrace()
    } finally {
      parcel.recycle()
    }
    return restored
  }


  public override fun dispose() {
    if (channelDelegate != null) {
      channelDelegate!!.dispose()
      channelDelegate = null
    }
    super.dispose()
    val settings = getSettings()
    settings.setJavaScriptEnabled(false)
    removeJavascriptInterface(JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME())
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q && WebViewFeature.isFeatureSupported(WebViewFeature.WEB_VIEW_RENDERER_CLIENT_BASIC_USAGE)) {
      WebViewCompat.setWebViewRenderProcessClient(this, null)
    }
    setWebChromeClient(WebChromeClient())
    setWebViewClient(object : WebViewClient() {
      override fun onPageFinished(view: WebView?, url: String?) {
        destroy()
      }
    })
    interceptOnlyAsyncAjaxRequestsPluginScript = null
    userContentController.dispose()
    if (findInteractionController != null) {
      findInteractionController!!.dispose()
      findInteractionController = null
    }
    if (webViewAssetLoaderExt != null) {
      webViewAssetLoaderExt!!.dispose()
      webViewAssetLoaderExt = null
    }
    if (windowId != null && plugin != null && plugin!!.aqutterWebViewManager != null) {
      plugin!!.aqutterWebViewManager!!.windowWebViewMessages.remove(windowId!!)
    }
    mainLooperHandler.removeCallbacksAndMessages(null)
    mHandler.removeCallbacksAndMessages(null)
    disposeWebMessageChannels()
    disposeWebMessageListeners()
    removeAllViews()
    if (checkContextMenuShouldBeClosedTask != null)
      removeCallbacks(checkContextMenuShouldBeClosedTask)
    if (checkScrollStoppedTask != null)
      removeCallbacks(checkScrollStoppedTask)
    callAsyncJavaScriptCallbacks.clear()
    evaluateJavaScriptContentWorldCallbacks.clear()
    aqutterBrowserDelegate = null
    if (aqutterWebViewRenderProcessClient != null) {
      aqutterWebViewRenderProcessClient!!.dispose()
      aqutterWebViewRenderProcessClient = null
    }
    if (aqutterWebViewChromeClient != null) {
      aqutterWebViewChromeClient!!.dispose()
      aqutterWebViewChromeClient = null
    }
    if (aqutterWebViewClientCompat != null) {
      aqutterWebViewClientCompat!!.dispose()
      aqutterWebViewClientCompat = null
    }
    if (aqutterWebViewClient != null) {
      aqutterWebViewClient!!.dispose()
      aqutterWebViewClient = null
    }
    if (javaScriptBridgeInterface != null) {
      javaScriptBridgeInterface!!.dispose()
      javaScriptBridgeInterface = null
    }
    plugin = null
    loadUrl("about:blank")
  }

  override fun destroy() {
    super.destroy()
  }
}
