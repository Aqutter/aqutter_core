package com.github.aqutter.core.chrome_custom_tabs

import android.app.Activity
import android.app.PendingIntent
import android.content.Intent
import android.graphics.BitmapFactory
import android.graphics.Color
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.widget.RemoteViews
import androidx.annotation.CallSuper
import androidx.browser.customtabs.CustomTabColorSchemeParams
import androidx.browser.customtabs.CustomTabsCallback
import androidx.browser.customtabs.CustomTabsIntent
import androidx.browser.customtabs.CustomTabsService
import androidx.browser.customtabs.CustomTabsSession
import androidx.browser.customtabs.EngagementSignalsCallback
import com.github.aqutter.core.R
import com.github.aqutter.core.types.AndroidResource
import com.github.aqutter.core.types.CustomTabsActionButton
import com.github.aqutter.core.types.CustomTabsMenuItem
import com.github.aqutter.core.types.CustomTabsSecondaryToolbar
import com.github.aqutter.core.types.Disposable
import io.flutter.plugin.common.MethodChannel

open class ChromeCustomTabsActivity : Activity(), Disposable {
  @JvmField
  var id: String? = null
  @JvmField
  var builder: CustomTabsIntent.Builder? = null
  @JvmField
  var customSettings: ChromeCustomTabsSettings = ChromeCustomTabsSettings()
  @JvmField
  var customTabActivityHelper: CustomTabActivityHelper = CustomTabActivityHelper()
  @JvmField
  var customTabsSession: CustomTabsSession? = null
  @JvmField
  protected var onOpened: Boolean = false
  @JvmField
  protected var onCompletedInitialLoad: Boolean = false
  @JvmField
  protected var isBindSuccess: Boolean = false
  @JvmField
  var manager: ChromeSafariBrowserManager? = null
  @JvmField
  var initialUrl: String? = null
  @JvmField
  var initialOtherLikelyURLs: List<String>? = null
  @JvmField
  var initialHeaders: Map<String, String>? = null
  @JvmField
  var initialReferrer: String? = null
  @JvmField
  var menuItems: MutableList<CustomTabsMenuItem> = ArrayList()
  @JvmField
  var actionButton: CustomTabsActionButton? = null
  @JvmField
  var secondaryToolbar: CustomTabsSecondaryToolbar? = null
  @JvmField
  var channelDelegate: ChromeCustomTabsChannelDelegate? = null

  @Suppress("UNCHECKED_CAST")
  @CallSuper
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    setContentView(R.layout.chrome_custom_tabs_layout)

    val b = intent.extras
    if (b == null) {
      if (savedInstanceState != null) {
        close()
      }
      return
    }

    id = b.getString("id")

    val managerId = b.getString("managerId")
    manager = if (managerId != null) ChromeSafariBrowserManager.shared.get(managerId) else null
    val manager = this.manager
    if (manager == null || manager.plugin == null || manager.plugin!!.messenger == null) {
      if (savedInstanceState != null) {
        close()
      }
      return
    }

    manager.browsers.put(id, this)

    val channel = MethodChannel(manager.plugin!!.messenger, METHOD_CHANNEL_NAME_PREFIX + id)
    channelDelegate = ChromeCustomTabsChannelDelegate(this, channel)

    initialUrl = b.getString("url")
    initialHeaders = b.getSerializable("headers") as Map<String, String>?
    initialReferrer = b.getString("referrer")
    initialOtherLikelyURLs = b.getStringArrayList("otherLikelyURLs")

    customSettings = ChromeCustomTabsSettings()
    customSettings.parse(b.getSerializable("settings") as MutableMap<String, Any?>)
    actionButton = CustomTabsActionButton.fromMap(b.getSerializable("actionButton") as MutableMap<String, Any?>?)
    secondaryToolbar = CustomTabsSecondaryToolbar.fromMap(b.getSerializable("secondaryToolbar") as MutableMap<String, Any?>?)
    val menuItemList = b.getSerializable("menuItemList") as List<MutableMap<String, Any?>>
    for (menuItem in menuItemList) {
      menuItems.add(CustomTabsMenuItem.fromMap(menuItem)!!)
    }

    if (customSettings.noHistory && manager.plugin!!.noHistoryCustomTabsActivityCallbacks != null) {
      manager.plugin!!.noHistoryCustomTabsActivityCallbacks!!.noHistoryBrowserIDs.put(id, id)
    }

    val chromeCustomTabsActivity = this

    customTabActivityHelper.setConnectionCallback(object : CustomTabActivityHelper.ConnectionCallback {
      override fun onCustomTabsConnected() {
        customTabsConnected()
        if (channelDelegate != null) {
          channelDelegate!!.onServiceConnected()
        }
      }

      override fun onCustomTabsDisconnected() {
        chromeCustomTabsActivity.close()
        dispose()
      }
    })

    customTabActivityHelper.setCustomTabsCallback(object : CustomTabsCallback() {
      override fun onNavigationEvent(navigationEvent: Int, extras: Bundle?) {
        if (navigationEvent == TAB_SHOWN && !onOpened) {
          onOpened = true
          if (channelDelegate != null) {
            channelDelegate!!.onOpened()
          }
        }

        if (navigationEvent == NAVIGATION_FINISHED && !onCompletedInitialLoad) {
          onCompletedInitialLoad = true
          if (channelDelegate != null) {
            channelDelegate!!.onCompletedInitialLoad()
          }
        }

        if (channelDelegate != null) {
          channelDelegate!!.onNavigationEvent(navigationEvent)
        }
      }

      override fun extraCallback(callbackName: String, args: Bundle?) {
      }

      override fun onMessageChannelReady(extras: Bundle?) {
        if (channelDelegate != null) {
          channelDelegate!!.onMessageChannelReady()
        }
      }

      override fun onPostMessage(message: String, extras: Bundle?) {
        if (channelDelegate != null) {
          channelDelegate!!.onPostMessage(message)
        }
      }

      override fun onRelationshipValidationResult(@CustomTabsService.Relation relation: Int,
                                                  requestedOrigin: Uri,
                                                  result: Boolean, extras: Bundle?) {
        if (channelDelegate != null) {
          channelDelegate!!.onRelationshipValidationResult(relation, requestedOrigin, result)
        }
      }
    })
  }

  open fun launchUrl(url: String,
                     headers: Map<String, String>?,
                     referrer: String?,
                     otherLikelyURLs: List<String>?) {
    launchUrlWithSession(customTabsSession, url, headers, referrer, otherLikelyURLs)
  }

  open fun launchUrlWithSession(session: CustomTabsSession?,
                                url: String,
                                headers: Map<String, String>?,
                                referrer: String?,
                                otherLikelyURLs: List<String>?) {
    mayLaunchUrl(url, otherLikelyURLs)
    val builder = CustomTabsIntent.Builder(session)
    this.builder = builder
    prepareCustomTabs()

    val customTabsIntent = builder.build()
    prepareCustomTabsIntent(customTabsIntent)

    CustomTabActivityHelper.openCustomTab(this, customTabsIntent, Uri.parse(url), headers,
      if (referrer != null) Uri.parse(referrer) else null, CHROME_CUSTOM_TAB_REQUEST_CODE)
  }

  // NOTE: bundleOtherLikelyURL is never added to bundleOtherLikelyURLs, so otherLikelyURLs is effectively ignored (same as the Java original)
  open fun mayLaunchUrl(url: String?, otherLikelyURLs: List<String>?): Boolean {
    val uri = if (url != null) Uri.parse(url) else null

    val bundleOtherLikelyURLs = ArrayList<Bundle>()
    if (otherLikelyURLs != null) {
      val bundleOtherLikelyURL = Bundle()
      for (otherLikelyURL in otherLikelyURLs) {
        bundleOtherLikelyURL.putString(CustomTabsService.KEY_URL, otherLikelyURL)
      }
    }
    return customTabActivityHelper.mayLaunchUrl(uri!!, null, bundleOtherLikelyURLs)
  }

  @CallSuper
  open fun customTabsConnected() {
    customTabsSession = customTabActivityHelper.getSession()

    if (customTabsSession != null) {
      try {
        val bundle = Bundle()
        if (customTabsSession!!.isEngagementSignalsApiAvailable(bundle)) {
          customTabsSession!!.setEngagementSignalsCallback(object : EngagementSignalsCallback {
            override fun onVerticalScrollEvent(isDirectionUp: Boolean, extras: Bundle) {
              if (channelDelegate != null) {
                channelDelegate!!.onVerticalScrollEvent(isDirectionUp)
              }
            }

            override fun onGreatestScrollPercentageIncreased(scrollPercentage: Int, extras: Bundle) {
              if (channelDelegate != null) {
                channelDelegate!!.onGreatestScrollPercentageIncreased(scrollPercentage)
              }
            }

            override fun onSessionEnded(didUserInteract: Boolean, extras: Bundle) {
              if (channelDelegate != null) {
                channelDelegate!!.onSessionEnded(didUserInteract)
              }
            }
          }, bundle)
        }
      } catch (e: Throwable) {
        Log.d(LOG_TAG, "Custom Tabs Engagement Signals API not supported", e)
      }
    }

    // avoid webpage reopen if isBindSuccess is false: onServiceConnected->launchUrl
    if (isBindSuccess && initialUrl != null) {
      launchUrl(initialUrl!!, initialHeaders, initialReferrer, initialOtherLikelyURLs)
    }
  }

  private fun prepareCustomTabs() {
    val builder = this.builder
    if (builder == null) {
      return
    }

    val addDefaultShareMenuItem = customSettings.addDefaultShareMenuItem
    if (addDefaultShareMenuItem != null) {
      builder.setShareState(if (addDefaultShareMenuItem)
        CustomTabsIntent.SHARE_STATE_ON else CustomTabsIntent.SHARE_STATE_OFF)
    } else {
      builder.setShareState(customSettings.shareState)
    }

    val defaultColorSchemeBuilder = CustomTabColorSchemeParams.Builder()
    val toolbarBackgroundColor = customSettings.toolbarBackgroundColor
    if (toolbarBackgroundColor != null && !toolbarBackgroundColor.isEmpty()) {
      defaultColorSchemeBuilder.setToolbarColor(Color.parseColor(toolbarBackgroundColor))
    }
    val navigationBarColor = customSettings.navigationBarColor
    if (navigationBarColor != null && !navigationBarColor.isEmpty()) {
      defaultColorSchemeBuilder.setNavigationBarColor(Color.parseColor(navigationBarColor))
    }
    val navigationBarDividerColor = customSettings.navigationBarDividerColor
    if (navigationBarDividerColor != null && !navigationBarDividerColor.isEmpty()) {
      defaultColorSchemeBuilder.setNavigationBarDividerColor(Color.parseColor(navigationBarDividerColor))
    }
    val secondaryToolbarColor = customSettings.secondaryToolbarColor
    if (secondaryToolbarColor != null && !secondaryToolbarColor.isEmpty()) {
      defaultColorSchemeBuilder.setSecondaryToolbarColor(Color.parseColor(secondaryToolbarColor))
    }
    builder.setDefaultColorSchemeParams(defaultColorSchemeBuilder.build())

    builder.setShowTitle(customSettings.showTitle)
    builder.setUrlBarHidingEnabled(customSettings.enableUrlBarHiding)
    builder.setInstantAppsEnabled(customSettings.instantAppsEnabled)
    if (customSettings.startAnimations.size == 2) {
      builder.setStartAnimations(this,
        customSettings.startAnimations.get(0).getIdentifier(this),
        customSettings.startAnimations.get(1).getIdentifier(this))
    }
    if (customSettings.exitAnimations.size == 2) {
      builder.setExitAnimations(this,
        customSettings.exitAnimations.get(0).getIdentifier(this),
        customSettings.exitAnimations.get(1).getIdentifier(this))
    }

    for (menuItem in menuItems) {
      builder.addMenuItem(menuItem.label,
        createPendingIntent(menuItem.id))
    }

    val actionButton = this.actionButton
    if (actionButton != null) {
      val data = actionButton.icon
      val bitmapOptions = BitmapFactory.Options()
      bitmapOptions.inMutable = true
      val bmp = BitmapFactory.decodeByteArray(
        data, 0, data.size, bitmapOptions
      )
      builder.setActionButton(bmp, actionButton.description,
        createPendingIntent(actionButton.id),
        actionButton.isShouldTint)
    }

    val secondaryToolbar = this.secondaryToolbar
    if (secondaryToolbar != null) {
      val layout = secondaryToolbar.layout
      val remoteViews = RemoteViews(layout.defPackage, layout.getIdentifier(this))
      val clickableIDs = IntArray(secondaryToolbar.clickableIDs.size)
      var i = 0
      val length = secondaryToolbar.clickableIDs.size
      while (i < length) {
        val clickableID = secondaryToolbar.clickableIDs.get(i)
        clickableIDs[i] = clickableID.getIdentifier(this)
        i++
      }
      builder.setSecondaryToolbarViews(remoteViews, clickableIDs, getSecondaryToolbarOnClickPendingIntent())
    }
  }

  open fun getSecondaryToolbarOnClickPendingIntent(): PendingIntent {
    val broadcastIntent = Intent(this, ActionBroadcastReceiver::class.java)

    val extras = Bundle()
    extras.putString(ActionBroadcastReceiver.KEY_ACTION_VIEW_ID, id)
    extras.putString(ActionBroadcastReceiver.KEY_ACTION_MANAGER_ID, if (manager != null) manager!!.id else null)
    broadcastIntent.putExtras(extras)

    if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
      return PendingIntent.getBroadcast(
        this, 0, broadcastIntent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE)
    } else {
      return PendingIntent.getBroadcast(
        this, 0, broadcastIntent, PendingIntent.FLAG_UPDATE_CURRENT)
    }
  }

  private fun prepareCustomTabsIntent(customTabsIntent: CustomTabsIntent) {
    if (customSettings.packageName != null)
      customTabsIntent.intent.setPackage(customSettings.packageName)
    else
      customTabsIntent.intent.setPackage(CustomTabsHelper.getPackageNameToUse(this))

    if (customSettings.keepAliveEnabled)
      CustomTabsHelper.addKeepAliveExtra(this, customTabsIntent.intent)

    if (customSettings.alwaysUseBrowserUI)
      CustomTabsIntent.setAlwaysUseBrowserUI(customTabsIntent.intent)
  }

  open fun updateActionButton(icon: ByteArray, description: String) {
    if (customTabsSession == null || actionButton == null) {
      return
    }
    val bitmapOptions = BitmapFactory.Options()
    bitmapOptions.inMutable = true
    val bmp = BitmapFactory.decodeByteArray(
      icon, 0, icon.size, bitmapOptions
    )
    customTabsSession!!.setActionButton(bmp, description)
    actionButton!!.icon = icon
    actionButton!!.description = description
  }

  open fun updateSecondaryToolbar(secondaryToolbar: CustomTabsSecondaryToolbar?) {
    if (customTabsSession == null) {
      return
    }
    val layout = secondaryToolbar!!.layout
    val remoteViews = RemoteViews(layout.defPackage, layout.getIdentifier(this))
    val clickableIDs = IntArray(secondaryToolbar.clickableIDs.size)
    var i = 0
    val length = secondaryToolbar.clickableIDs.size
    while (i < length) {
      val clickableID = secondaryToolbar.clickableIDs.get(i)
      clickableIDs[i] = clickableID.getIdentifier(this)
      i++
    }
    customTabsSession!!.setSecondaryToolbarViews(remoteViews, clickableIDs, getSecondaryToolbarOnClickPendingIntent())
    this.secondaryToolbar = secondaryToolbar
  }

  override fun onStart() {
    super.onStart()
    isBindSuccess = customTabActivityHelper.bindCustomTabsService(this)

    if (!isBindSuccess && initialUrl != null) {
      // chrome process not running, start tab directly
      launchUrlWithSession(null, initialUrl!!, initialHeaders, initialReferrer, initialOtherLikelyURLs)
    }
  }

  // protected in Java; public so ChromeCustomTabsChannelDelegate (same package) can call it
  public override fun onStop() {
    super.onStop()
    customTabActivityHelper.unbindCustomTabsService(this)
    isBindSuccess = false
  }

  public override fun onDestroy() {
    super.onDestroy()
  }

  @Deprecated("Deprecated in Java")
  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    if (requestCode == CHROME_CUSTOM_TAB_REQUEST_CODE) {
      close()
      dispose()
    }
  }

  private fun createPendingIntent(actionSourceId: Int): PendingIntent {
    val actionIntent = Intent(this, ActionBroadcastReceiver::class.java)

    val extras = Bundle()
    extras.putInt(ActionBroadcastReceiver.KEY_ACTION_ID, actionSourceId)
    extras.putString(ActionBroadcastReceiver.KEY_ACTION_VIEW_ID, id)
    extras.putString(ActionBroadcastReceiver.KEY_ACTION_MANAGER_ID, if (manager != null) manager!!.id else null)
    actionIntent.putExtras(extras)

    if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
      return PendingIntent.getBroadcast(
        this, actionSourceId, actionIntent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE)
    } else {
      return PendingIntent.getBroadcast(
        this, actionSourceId, actionIntent, PendingIntent.FLAG_UPDATE_CURRENT)
    }
  }

  override fun dispose() {
    onStop()
    onDestroy()
    if (channelDelegate != null) {
      channelDelegate!!.dispose()
      channelDelegate = null
    }
    if (manager != null) {
      if (manager!!.browsers.containsKey(id)) {
        manager!!.browsers.put(id, null)
      }
    }
    manager = null
  }

  open fun close() {
    onStop()
    onDestroy()
    customTabsSession = null
    finish()
    if (channelDelegate != null) {
      channelDelegate!!.onClosed()
    }
  }

  companion object {
    protected const val LOG_TAG = "CustomTabsActivity"
    const val METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/chromesafaribrowser_"
    const val CHROME_CUSTOM_TAB_REQUEST_CODE = 100
    const val NO_HISTORY_CHROME_CUSTOM_TAB_REQUEST_CODE = 101
  }
}
