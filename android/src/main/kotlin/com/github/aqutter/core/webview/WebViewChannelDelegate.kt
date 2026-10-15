package com.github.aqutter.core.webview

import android.net.Uri
import android.os.Build
import android.webkit.ValueCallback
import androidx.webkit.WebMessageCompat
import androidx.webkit.WebMessagePortCompat
import androidx.webkit.WebViewCompat
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.Util
import com.github.aqutter.core.find_interaction.FindInteractionChannelDelegate
import com.github.aqutter.core.browser.AqutterBrowserActivity
import com.github.aqutter.core.browser.AqutterBrowserSettings
import com.github.aqutter.core.print_job.PrintJobSettings
import com.github.aqutter.core.types.BaseCallbackResultImpl
import com.github.aqutter.core.types.ChannelDelegateImpl
import com.github.aqutter.core.types.ClientCertChallenge
import com.github.aqutter.core.types.ClientCertResponse
import com.github.aqutter.core.types.ContentWorld
import com.github.aqutter.core.types.CreateWindowAction
import com.github.aqutter.core.types.CustomSchemeResponse
import com.github.aqutter.core.types.DownloadStartRequest
import com.github.aqutter.core.types.GeolocationPermissionShowPromptResponse
import com.github.aqutter.core.types.HitTestResult
import com.github.aqutter.core.types.HttpAuthResponse
import com.github.aqutter.core.types.HttpAuthenticationChallenge
import com.github.aqutter.core.types.AqutterWebViewRect
import com.github.aqutter.core.types.JavaScriptHandlerFunctionData
import com.github.aqutter.core.types.JsAlertResponse
import com.github.aqutter.core.types.JsBeforeUnloadResponse
import com.github.aqutter.core.types.JsConfirmResponse
import com.github.aqutter.core.types.JsPromptResponse
import com.github.aqutter.core.types.NavigationAction
import com.github.aqutter.core.types.NavigationActionPolicy
import com.github.aqutter.core.types.PermissionResponse
import com.github.aqutter.core.types.SafeBrowsingResponse
import com.github.aqutter.core.types.ServerTrustAuthResponse
import com.github.aqutter.core.types.ServerTrustChallenge
import com.github.aqutter.core.types.ShowFileChooserRequest
import com.github.aqutter.core.types.ShowFileChooserResponse
import com.github.aqutter.core.types.SslCertificateExt
import com.github.aqutter.core.types.SyncBaseCallbackResultImpl
import com.github.aqutter.core.types.URLRequest
import com.github.aqutter.core.types.UserScript
import com.github.aqutter.core.types.WebMessageCompatExt
import com.github.aqutter.core.types.WebResourceErrorExt
import com.github.aqutter.core.types.WebResourceRequestExt
import com.github.aqutter.core.types.WebResourceResponseExt
import com.github.aqutter.core.webview.webview.AqutterWebView
import com.github.aqutter.core.webview.webview.AqutterWebViewSettings
import com.github.aqutter.core.webview.web_message.WebMessageListener
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.IOException
import java.util.ArrayList
import java.util.HashMap
import java.util.HashSet

open class WebViewChannelDelegate(webView: AqutterWebView, channel: MethodChannel) : ChannelDelegateImpl(channel) {
  companion object {
    // package-private in Java
    const val LOG_TAG = "WebViewChannelDelegate"

    const val EVENT_ON_SCROLL_CHANGED = "onScrollChanged"
    const val EVENT_ON_OVER_SCROLLED = "onOverScrolled"
    const val EVENT_ON_ZOOM_SCALE_CHANGED = "onZoomScaleChanged"
  }

  private var webView: AqutterWebView? = webView

  /**
   * The events above fire on every scrolled frame, so Dart reports up front which of them it
   * actually listens to and the rest are never sent. `null` means "Dart did not report",
   * in which case everything is emitted -- that keeps every creation path this gate does not
   * cover (in-app browser, headless, new windows) behaving exactly as before.
   */
  private var enabledHighFrequencyEvents: MutableSet<String>? = null

  fun setEnabledHighFrequencyEvents(eventNames: List<String>?) {
    enabledHighFrequencyEvents = if (eventNames == null) null else HashSet(eventNames)
  }

  private fun isHighFrequencyEventEnabled(eventName: String): Boolean {
    return enabledHighFrequencyEvents == null || enabledHighFrequencyEvents!!.contains(eventName)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    val webView = this.webView
    val method = try {
      WebViewChannelDelegateMethods.valueOf(call.method)
    } catch (e: IllegalArgumentException) {
      result.notImplemented()
      return
    }
    when (method) {
      WebViewChannelDelegateMethods.getUrl -> {
        result.success(webView?.getUrl())
      }
      WebViewChannelDelegateMethods.getTitle -> {
        result.success(webView?.getTitle())
      }
      WebViewChannelDelegateMethods.getProgress -> {
        result.success(webView?.getProgress())
      }
      WebViewChannelDelegateMethods.loadUrl -> {
        if (webView != null) {
          val urlRequest = call.argument<MutableMap<String, Any?>>("urlRequest")
          webView.loadUrl(URLRequest.fromMap(urlRequest)!!)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.postUrl -> {
        if (webView != null) {
          val url = call.argument<String>("url")
          val postData = call.argument<ByteArray>("postData")
          webView.postUrl(url!!, postData!!)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.loadData -> {
        if (webView != null) {
          val data = call.argument<String>("data")
          val mimeType = call.argument<String>("mimeType")
          val encoding = call.argument<String>("encoding")
          val baseUrl = call.argument<String>("baseUrl")
          val historyUrl = call.argument<String>("historyUrl")
          webView.loadDataWithBaseURL(baseUrl, data!!, mimeType, encoding, historyUrl)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.loadFile -> {
        if (webView != null) {
          val assetFilePath = call.argument<String>("assetFilePath")
          try {
            webView.loadFile(assetFilePath!!)
          } catch (e: IOException) {
            e.printStackTrace()
            result.error(LOG_TAG, e.message, null)
            return
          }
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.evaluateJavascript -> {
        if (webView != null) {
          val source = call.argument<String>("source")
          val contentWorldMap = call.argument<MutableMap<String, Any?>>("contentWorld")
          val contentWorld = ContentWorld.fromMap(contentWorldMap)
          webView.evaluateJavascript(source!!, contentWorld, ValueCallback<String> { value ->
            result.success(value)
          })
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.injectJavascriptFileFromUrl -> {
        if (webView != null) {
          val urlFile = call.argument<String>("urlFile")
          val scriptHtmlTagAttributes = call.argument<MutableMap<String, Any?>>("scriptHtmlTagAttributes")
          webView.injectJavascriptFileFromUrl(urlFile!!, scriptHtmlTagAttributes)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.injectCSSCode -> {
        if (webView != null) {
          val source = call.argument<String>("source")
          webView.injectCSSCode(source!!)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.injectCSSFileFromUrl -> {
        if (webView != null) {
          val urlFile = call.argument<String>("urlFile")
          val cssLinkHtmlTagAttributes = call.argument<MutableMap<String, Any?>>("cssLinkHtmlTagAttributes")
          webView.injectCSSFileFromUrl(urlFile!!, cssLinkHtmlTagAttributes)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.reload -> {
        if (webView != null)
          webView.reload()
        result.success(true)
      }
      WebViewChannelDelegateMethods.goBack -> {
        if (webView != null)
          webView.goBack()
        result.success(true)
      }
      WebViewChannelDelegateMethods.canGoBack -> {
        result.success((webView != null) && webView.canGoBack())
      }
      WebViewChannelDelegateMethods.goForward -> {
        if (webView != null)
          webView.goForward()
        result.success(true)
      }
      WebViewChannelDelegateMethods.canGoForward -> {
        result.success((webView != null) && webView.canGoForward())
      }
      WebViewChannelDelegateMethods.goBackOrForward -> {
        if (webView != null)
          webView.goBackOrForward(call.argument<Int>("steps")!!)
        result.success(true)
      }
      WebViewChannelDelegateMethods.canGoBackOrForward -> {
        result.success((webView != null) && webView.canGoBackOrForward(call.argument<Int>("steps")!!))
      }
      WebViewChannelDelegateMethods.stopLoading -> {
        if (webView != null)
          webView.stopLoading()
        result.success(true)
      }
      WebViewChannelDelegateMethods.isLoading -> {
        result.success((webView != null) && webView.isLoading())
      }
      WebViewChannelDelegateMethods.takeScreenshot -> {
        if (webView != null) {
          val screenshotConfiguration = call.argument<MutableMap<String, Any?>>("screenshotConfiguration")
          webView.takeScreenshot(screenshotConfiguration, result)
        } else
          result.success(null)
      }
      WebViewChannelDelegateMethods.setSettings -> {
        if (webView != null && webView.getAqutterBrowserDelegate() is AqutterBrowserActivity) {
          val aqutterBrowserActivity = webView.getAqutterBrowserDelegate() as AqutterBrowserActivity
          val aqutterBrowserSettings = AqutterBrowserSettings()
          val aqutterBrowserSettingsMap = call.argument<HashMap<String, Any?>>("settings")
          aqutterBrowserSettings.parse(aqutterBrowserSettingsMap!!)
          aqutterBrowserActivity.setSettings(aqutterBrowserSettings, aqutterBrowserSettingsMap)
        } else if (webView != null) {
          val aqutterWebViewSettings = AqutterWebViewSettings()
          val aqutterWebViewSettingsMap = call.argument<HashMap<String, Any?>>("settings")
          aqutterWebViewSettings.parse(aqutterWebViewSettingsMap!!)
          webView.setSettings(aqutterWebViewSettings, aqutterWebViewSettingsMap)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.getSettings -> {
        if (webView != null && webView.getAqutterBrowserDelegate() is AqutterBrowserActivity) {
          val aqutterBrowserActivity = webView.getAqutterBrowserDelegate() as AqutterBrowserActivity
          result.success(aqutterBrowserActivity.getCustomSettingsMap())
        } else {
          result.success(webView?.getCustomSettingsMap())
        }
      }
      WebViewChannelDelegateMethods.close -> {
        if (webView != null && webView.getAqutterBrowserDelegate() is AqutterBrowserActivity) {
          val aqutterBrowserActivity = webView.getAqutterBrowserDelegate() as AqutterBrowserActivity
          aqutterBrowserActivity.close(result)
        } else {
          result.notImplemented()
        }
      }
      WebViewChannelDelegateMethods.show -> {
        if (webView != null && webView.getAqutterBrowserDelegate() is AqutterBrowserActivity) {
          val aqutterBrowserActivity = webView.getAqutterBrowserDelegate() as AqutterBrowserActivity
          aqutterBrowserActivity.show()
          result.success(true)
        } else {
          result.notImplemented()
        }
      }
      WebViewChannelDelegateMethods.hide -> {
        if (webView != null && webView.getAqutterBrowserDelegate() is AqutterBrowserActivity) {
          val aqutterBrowserActivity = webView.getAqutterBrowserDelegate() as AqutterBrowserActivity
          aqutterBrowserActivity.hide()
          result.success(true)
        } else {
          result.notImplemented()
        }
      }
      WebViewChannelDelegateMethods.isHidden -> {
        if (webView != null && webView.getAqutterBrowserDelegate() is AqutterBrowserActivity) {
          val aqutterBrowserActivity = webView.getAqutterBrowserDelegate() as AqutterBrowserActivity
          result.success(aqutterBrowserActivity.isHidden)
        } else {
          result.notImplemented()
        }
      }
      WebViewChannelDelegateMethods.getCopyBackForwardList -> {
        result.success(webView?.getCopyBackForwardList())
      }
      WebViewChannelDelegateMethods.startSafeBrowsing -> {
        if (webView != null && WebViewFeature.isFeatureSupported(WebViewFeature.START_SAFE_BROWSING)) {
          WebViewCompat.startSafeBrowsing(webView.getContext(), ValueCallback<Boolean> { success ->
            result.success(success)
          })
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.clearCache -> {
        if (webView != null)
          webView.clearAllCache()
        result.success(true)
      }
      WebViewChannelDelegateMethods.clearSslPreferences -> {
        if (webView != null)
          webView.clearSslPreferences()
        result.success(true)
      }
      WebViewChannelDelegateMethods.findAll -> {
        if (webView != null) {
          val find = call.argument<String>("find")
          webView.findAllAsync(find!!)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.findNext -> {
        if (webView != null) {
          val forward = call.argument<Boolean>("forward")
          webView.findNext(forward!!)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.clearMatches -> {
        if (webView != null) {
          webView.clearMatches()
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.scrollTo -> {
        if (webView != null) {
          val x = call.argument<Int>("x")
          val y = call.argument<Int>("y")
          val animated = call.argument<Boolean>("animated")
          webView.scrollTo(x, y, animated)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.scrollBy -> {
        if (webView != null) {
          val x = call.argument<Int>("x")
          val y = call.argument<Int>("y")
          val animated = call.argument<Boolean>("animated")
          webView.scrollBy(x, y, animated)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.pause -> {
        if (webView != null) {
          webView.onPause()
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.resume -> {
        if (webView != null) {
          webView.onResume()
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.pauseTimers -> {
        if (webView != null) {
          webView.pauseTimers()
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.resumeTimers -> {
        if (webView != null) {
          webView.resumeTimers()
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.printCurrentPage -> {
        if (webView != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          val settings = PrintJobSettings()
          val settingsMap = call.argument<MutableMap<String, Any?>>("settings")
          if (settingsMap != null) {
            settings.parse(settingsMap)
          }
          result.success(webView.printCurrentPage(settings))
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.getContentHeight -> {
        if (webView is AqutterWebView) {
          result.success(webView.getContentHeight())
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.getContentWidth -> {
        if (webView is AqutterWebView) {
          webView.getContentWidth(ValueCallback<Int> { contentWidth ->
            result.success(contentWidth)
          })
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.zoomBy -> {
        if (webView != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          val zoomFactor = call.argument<Double>("zoomFactor")!!
          webView.zoomBy(zoomFactor.toFloat())
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.getOriginalUrl -> {
        result.success(webView?.getOriginalUrl())
      }
      WebViewChannelDelegateMethods.getZoomScale -> {
        if (webView is AqutterWebView) {
          result.success(webView.getZoomScale())
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.getSelectedText -> {
        if ((webView is AqutterWebView && Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT)) {
          webView.getSelectedText(ValueCallback<String> { value ->
            result.success(value)
          })
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.getHitTestResult -> {
        if (webView is AqutterWebView) {
          result.success(HitTestResult.fromWebViewHitTestResult(webView.getHitTestResult())!!.toMap())
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.pageDown -> {
        if (webView != null) {
          val bottom = call.argument<Boolean>("bottom")!!
          result.success(webView.pageDown(bottom))
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.pageUp -> {
        if (webView != null) {
          val top = call.argument<Boolean>("top")!!
          result.success(webView.pageUp(top))
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.saveWebArchive -> {
        if (webView != null) {
          val filePath = call.argument<String>("filePath")
          val autoname = call.argument<Boolean>("autoname")!!
          webView.saveWebArchive(filePath!!, autoname, ValueCallback<String> { value ->
            result.success(value)
          })
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.zoomIn -> {
        if (webView != null) {
          result.success(webView.zoomIn())
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.zoomOut -> {
        if (webView != null) {
          result.success(webView.zoomOut())
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.clearFocus -> {
        if (webView != null) {
          webView.clearFocus()
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.requestFocus -> {
        if (webView != null) {
          var resultValue = false
          val direction = call.argument<Int>("direction")
          val previouslyFocusedRect = AqutterWebViewRect.fromMap(call.argument<MutableMap<String, Any?>>("previouslyFocusedRect"))
          if (direction != null && previouslyFocusedRect != null) {
            resultValue = webView.requestFocus(direction, previouslyFocusedRect.toRect())
          } else if (direction != null) {
            resultValue = webView.requestFocus(direction)
          } else {
            resultValue = webView.requestFocus()
          }
          result.success(resultValue)
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.setContextMenu -> {
        if (webView != null) {
          val contextMenu = call.argument<MutableMap<String, Any?>>("contextMenu")
          webView.setContextMenu(contextMenu)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.requestFocusNodeHref -> {
        if (webView != null) {
          result.success(webView.requestFocusNodeHref())
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.requestImageRef -> {
        if (webView != null) {
          result.success(webView.requestImageRef())
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.getScrollX -> {
        if (webView != null) {
          result.success(webView.getScrollX())
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.getScrollY -> {
        if (webView != null) {
          result.success(webView.getScrollY())
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.getCertificate -> {
        if (webView != null) {
          result.success(SslCertificateExt.toMap(webView.getCertificate()))
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.clearHistory -> {
        if (webView != null) {
          webView.clearHistory()
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.addUserScript -> {
        if (webView != null && webView.getUserContentController() != null) {
          val userScriptMap = call.argument<MutableMap<String, Any?>>("userScript")
          val userScript = UserScript.fromMap(userScriptMap)
          result.success(webView.getUserContentController().addUserOnlyScript(userScript!!))
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.removeUserScript -> {
        if (webView != null && webView.getUserContentController() != null) {
          val index = call.argument<Int>("index")
          val userScriptMap = call.argument<MutableMap<String, Any?>>("userScript")
          val userScript = UserScript.fromMap(userScriptMap)
          result.success(webView.getUserContentController().removeUserOnlyScriptAt(index!!, userScript!!.injectionTime))
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.removeUserScriptsByGroupName -> {
        if (webView != null && webView.getUserContentController() != null) {
          val groupName = call.argument<String>("groupName")
          webView.getUserContentController().removeUserOnlyScriptsByGroupName(groupName)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.removeAllUserScripts -> {
        if (webView != null && webView.getUserContentController() != null) {
          webView.getUserContentController().removeAllUserOnlyScripts()
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.callAsyncJavaScript -> {
        if (webView != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          val functionBody = call.argument<String>("functionBody")
          val functionArguments = call.argument<MutableMap<String, Any?>>("arguments")
          val contentWorldMap = call.argument<MutableMap<String, Any?>>("contentWorld")
          val contentWorld = ContentWorld.fromMap(contentWorldMap)
          webView.callAsyncJavaScript(functionBody!!, functionArguments!!, contentWorld, ValueCallback<String> { value ->
            result.success(value)
          })
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.isSecureContext -> {
        if (webView != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          webView.isSecureContext(ValueCallback<Boolean> { value ->
            result.success(value)
          })
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.createWebMessageChannel -> {
        if (webView != null) {
          if (webView is AqutterWebView && WebViewFeature.isFeatureSupported(WebViewFeature.CREATE_WEB_MESSAGE_CHANNEL)) {
            result.success(webView.createCompatWebMessageChannel().toMap())
          } else {
            result.success(null)
          }
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.postWebMessage -> {
        if (webView != null && WebViewFeature.isFeatureSupported(WebViewFeature.POST_WEB_MESSAGE)) {
          val message = WebMessageCompatExt.fromMap(call.argument<MutableMap<String, Any?>>("message"))
          val targetOrigin = call.argument<String>("targetOrigin")
          val compatPorts: MutableList<WebMessagePortCompat> = ArrayList()
          val portsExt = message!!.ports
          if (portsExt != null) {
            for (portExt in portsExt) {
              val webMessageChannel = webView.getWebMessageChannels()[portExt.webMessageChannelId]
              if (webMessageChannel != null) {
                if (webView is AqutterWebView) {
                  compatPorts.add(webMessageChannel.compatPorts[portExt.index])
                }
              }
            }
          }
          val data = message.data
          if (webView is AqutterWebView) {
            try {
              if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_ARRAY_BUFFER) && data != null &&
                message.type == WebMessageCompat.TYPE_ARRAY_BUFFER) {
                WebViewCompat.postWebMessage(webView,
                  WebMessageCompat(data as ByteArray, compatPorts.toTypedArray()),
                  Uri.parse(targetOrigin))
              } else {
                WebViewCompat.postWebMessage(webView,
                  WebMessageCompat(data?.toString(), compatPorts.toTypedArray()),
                  Uri.parse(targetOrigin))
              }
              result.success(true)
            } catch (e: Exception) {
              result.error(LOG_TAG, e.message, null)
            }
          }
        } else {
          result.success(true)
        }
      }
      WebViewChannelDelegateMethods.addWebMessageListener -> {
        if (webView != null) {
          val webMessageListenerMap = call.argument<MutableMap<String, Any?>>("webMessageListener")
          val webMessageListener = WebMessageListener.fromMap(webView, webView.getPlugin()!!.messenger, webMessageListenerMap)
          if (webView is AqutterWebView && WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_LISTENER)) {
            try {
              webView.addWebMessageListener(webMessageListener!!)
              result.success(true)
            } catch (e: Exception) {
              result.error(LOG_TAG, e.message, null)
            }
          } else {
            result.success(true)
          }
        } else {
          result.success(true)
        }
      }
      WebViewChannelDelegateMethods.canScrollVertically -> {
        if (webView != null) {
          result.success(webView.canScrollVertically())
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.canScrollHorizontally -> {
        if (webView != null) {
          result.success(webView.canScrollHorizontally())
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.isInFullscreen -> {
        if (webView != null) {
          result.success(webView.isInFullscreen())
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.clearFormData -> {
        if (webView != null) {
          webView.clearFormData()
        }
        result.success(true)
        // NOTE: the Java original has no `break` here and falls through into hideInputMethod;
        // kept as-is, so result is answered a second time.
        if (webView != null) {
          webView.hideInputMethod()
          result.success(true)
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.hideInputMethod -> {
        if (webView != null) {
          webView.hideInputMethod()
          result.success(true)
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.showInputMethod -> {
        if (webView != null) {
          webView.showInputMethod()
          result.success(true)
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.saveState -> {
        if (webView != null) {
          result.success(webView.saveState())
        } else {
          result.success(null)
        }
      }
      WebViewChannelDelegateMethods.restoreState -> {
        if (webView != null) {
          val state = call.argument<ByteArray>("state")
          result.success(webView.restoreState(state))
        } else {
          result.success(false)
        }
      }
      WebViewChannelDelegateMethods.setFrameworkKeyboardInset -> {
        // Only AqutterWebView performs keyboard avoidance; the other AqutterWebViewInterface
        // implementations have no view to shift, so this is a no-op for them rather than a method
        // every one of them would have to carry.
        if (webView is AqutterWebView) {
          val heightPx = call.argument<Int>("height")
          webView.setFrameworkKeyboardInsetPx(if (heightPx != null) heightPx else 0)
        }
        result.success(true)
      }
      WebViewChannelDelegateMethods.setEnabledHighFrequencyEvents -> {
        // Resent whenever the platform view is (re)attached: a keepAlive webview can be handed
        // to a widget carrying a different set of callbacks than the one that created it.
        setEnabledHighFrequencyEvents(call.argument<List<String>>("enabledHighFrequencyEvents"))
        result.success(true)
      }
    }
  }

  /**
   * @deprecated Use [FindInteractionChannelDelegate.onFindResultReceived] instead.
   */
  @Deprecated("Use FindInteractionChannelDelegate#onFindResultReceived instead.")
  fun onFindResultReceived(activeMatchOrdinal: Int, numberOfMatches: Int, isDoneCounting: Boolean) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["activeMatchOrdinal"] = activeMatchOrdinal
    obj["numberOfMatches"] = numberOfMatches
    obj["isDoneCounting"] = isDoneCounting
    channel.invokeMethod("onFindResultReceived", obj)
  }

  fun onLongPressHitTestResult(hitTestResult: HitTestResult?) {
    val channel = getChannel()
    if (channel == null) return
    channel.invokeMethod("onLongPressHitTestResult", hitTestResult!!.toMap())
  }

  fun onScrollChanged(x: Int, y: Int) {
    val channel = getChannel()
    if (channel == null) return
    if (!isHighFrequencyEventEnabled(EVENT_ON_SCROLL_CHANGED)) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["x"] = x
    obj["y"] = y
    channel.invokeMethod(EVENT_ON_SCROLL_CHANGED, obj)
  }

  fun onDownloadStarting(downloadStartRequest: DownloadStartRequest) {
    val channel = getChannel()
    if (channel == null) return
    channel.invokeMethod("onDownloadStarting", downloadStartRequest.toMap())
  }

  fun onCreateContextMenu(hitTestResult: HitTestResult?) {
    val channel = getChannel()
    if (channel == null) return
    channel.invokeMethod("onCreateContextMenu", hitTestResult!!.toMap())
  }

  fun onOverScrolled(scrollX: Int, scrollY: Int, clampedX: Boolean, clampedY: Boolean) {
    val channel = getChannel()
    if (channel == null) return
    if (!isHighFrequencyEventEnabled(EVENT_ON_OVER_SCROLLED)) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["x"] = scrollX
    obj["y"] = scrollY
    obj["clampedX"] = clampedX
    obj["clampedY"] = clampedY
    channel.invokeMethod(EVENT_ON_OVER_SCROLLED, obj)
  }

  fun onContextMenuActionItemClicked(itemId: Int, itemTitle: String?) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["id"] = itemId
    obj["androidId"] = itemId
    obj["iosId"] = null
    obj["title"] = itemTitle
    channel.invokeMethod("onContextMenuActionItemClicked", obj)
  }

  fun onHideContextMenu() {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    channel.invokeMethod("onHideContextMenu", obj)
  }

  fun onEnterFullscreen() {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    channel.invokeMethod("onEnterFullscreen", obj)
  }

  fun onExitFullscreen() {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    channel.invokeMethod("onExitFullscreen", obj)
  }

  open class JsAlertCallback : BaseCallbackResultImpl<JsAlertResponse>() {
    override fun decodeResult(obj: Any?): JsAlertResponse? {
      return JsAlertResponse.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun onJsAlert(url: String?, message: String?, isMainFrame: Boolean?, callback: JsAlertCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    obj["message"] = message
    obj["isMainFrame"] = isMainFrame
    channel.invokeMethod("onJsAlert", obj, callback)
  }

  open class JsConfirmCallback : BaseCallbackResultImpl<JsConfirmResponse>() {
    override fun decodeResult(obj: Any?): JsConfirmResponse? {
      return JsConfirmResponse.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun onJsConfirm(url: String?, message: String?, isMainFrame: Boolean?, callback: JsConfirmCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    obj["message"] = message
    obj["isMainFrame"] = isMainFrame
    channel.invokeMethod("onJsConfirm", obj, callback)
  }

  open class JsPromptCallback : BaseCallbackResultImpl<JsPromptResponse>() {
    override fun decodeResult(obj: Any?): JsPromptResponse? {
      return JsPromptResponse.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun onJsPrompt(url: String?, message: String?, defaultValue: String?, isMainFrame: Boolean?, callback: JsPromptCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    obj["message"] = message
    obj["defaultValue"] = defaultValue
    obj["isMainFrame"] = isMainFrame
    channel.invokeMethod("onJsPrompt", obj, callback)
  }

  open class JsBeforeUnloadCallback : BaseCallbackResultImpl<JsBeforeUnloadResponse>() {
    override fun decodeResult(obj: Any?): JsBeforeUnloadResponse? {
      return JsBeforeUnloadResponse.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun onJsBeforeUnload(url: String?, message: String?, callback: JsBeforeUnloadCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    obj["message"] = message
    channel.invokeMethod("onJsBeforeUnload", obj, callback)
  }

  open class CreateWindowCallback : BaseCallbackResultImpl<Boolean>() {
    override fun decodeResult(obj: Any?): Boolean? {
      return (obj is Boolean) && obj
    }
  }

  fun onCreateWindow(createWindowAction: CreateWindowAction, callback: CreateWindowCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    channel.invokeMethod("onCreateWindow", createWindowAction.toMap(), callback)
  }

  fun onCloseWindow() {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    channel.invokeMethod("onCloseWindow", obj)
  }

  open class GeolocationPermissionsShowPromptCallback : BaseCallbackResultImpl<GeolocationPermissionShowPromptResponse>() {
    override fun decodeResult(obj: Any?): GeolocationPermissionShowPromptResponse? {
      return GeolocationPermissionShowPromptResponse.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun onGeolocationPermissionsShowPrompt(origin: String?, callback: GeolocationPermissionsShowPromptCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    val obj: MutableMap<String, Any?> = HashMap()
    obj["origin"] = origin
    channel.invokeMethod("onGeolocationPermissionsShowPrompt", obj, callback)
  }

  fun onGeolocationPermissionsHidePrompt() {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    channel.invokeMethod("onGeolocationPermissionsHidePrompt", obj)
  }

  fun onConsoleMessage(message: String?, messageLevel: Int) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["message"] = message
    obj["messageLevel"] = messageLevel
    channel.invokeMethod("onConsoleMessage", obj)
  }

  fun onProgressChanged(progress: Int) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["progress"] = progress
    channel.invokeMethod("onProgressChanged", obj)
  }

  fun onTitleChanged(title: String?) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["title"] = title
    channel.invokeMethod("onTitleChanged", obj)
  }

  fun onReceivedIcon(icon: ByteArray?) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["icon"] = icon
    channel.invokeMethod("onReceivedIcon", obj)
  }

  fun onReceivedTouchIconUrl(url: String?, precomposed: Boolean) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    obj["precomposed"] = precomposed
    channel.invokeMethod("onReceivedTouchIconUrl", obj)
  }

  open class PermissionRequestCallback : BaseCallbackResultImpl<PermissionResponse>() {
    override fun decodeResult(obj: Any?): PermissionResponse? {
      return PermissionResponse.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun onPermissionRequest(origin: String?, resources: List<String>?, frame: Any?, callback: PermissionRequestCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    val obj: MutableMap<String, Any?> = HashMap()
    obj["origin"] = origin
    obj["resources"] = resources
    obj["frame"] = frame
    channel.invokeMethod("onPermissionRequest", obj, callback)
  }

  fun onPermissionRequestCanceled(origin: String?, resources: List<String>?) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["origin"] = origin
    obj["resources"] = resources
    channel.invokeMethod("onPermissionRequestCanceled", obj)
  }

  open class ShouldOverrideUrlLoadingCallback : BaseCallbackResultImpl<NavigationActionPolicy>() {
    override fun decodeResult(obj: Any?): NavigationActionPolicy? {
      val action: Int = if (obj is Int) obj else NavigationActionPolicy.CANCEL.rawValue()
      return NavigationActionPolicy.fromValue(action)
    }
  }

  fun shouldOverrideUrlLoading(navigationAction: NavigationAction, callback: ShouldOverrideUrlLoadingCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    channel.invokeMethod("shouldOverrideUrlLoading", navigationAction.toMap(), callback)
  }

  fun onLoadStart(url: String?) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    channel.invokeMethod("onLoadStart", obj)
  }

  fun onLoadStop(url: String?) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    channel.invokeMethod("onLoadStop", obj)
  }

  fun onUpdateVisitedHistory(url: String?, isReload: Boolean) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    obj["isReload"] = isReload
    channel.invokeMethod("onUpdateVisitedHistory", obj)
  }

  fun onReceivedError(request: WebResourceRequestExt, error: WebResourceErrorExt) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["request"] = request.toMap()
    obj["error"] = error.toMap()
    channel.invokeMethod("onReceivedError", obj)
  }

  fun onReceivedHttpError(request: WebResourceRequestExt, errorResponse: WebResourceResponseExt) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["request"] = request.toMap()
    obj["errorResponse"] = errorResponse.toMap()
    channel.invokeMethod("onReceivedHttpError", obj)
  }

  open class ReceivedHttpAuthRequestCallback : BaseCallbackResultImpl<HttpAuthResponse>() {
    override fun decodeResult(obj: Any?): HttpAuthResponse? {
      return HttpAuthResponse.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun onReceivedHttpAuthRequest(challenge: HttpAuthenticationChallenge, callback: ReceivedHttpAuthRequestCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    channel.invokeMethod("onReceivedHttpAuthRequest", challenge.toMap(), callback)
  }

  open class ReceivedServerTrustAuthRequestCallback : BaseCallbackResultImpl<ServerTrustAuthResponse>() {
    override fun decodeResult(obj: Any?): ServerTrustAuthResponse? {
      return ServerTrustAuthResponse.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun onReceivedServerTrustAuthRequest(challenge: ServerTrustChallenge, callback: ReceivedServerTrustAuthRequestCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    channel.invokeMethod("onReceivedServerTrustAuthRequest", challenge.toMap(), callback)
  }

  open class ReceivedClientCertRequestCallback : BaseCallbackResultImpl<ClientCertResponse>() {
    override fun decodeResult(obj: Any?): ClientCertResponse? {
      return ClientCertResponse.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun onReceivedClientCertRequest(challenge: ClientCertChallenge, callback: ReceivedClientCertRequestCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    channel.invokeMethod("onReceivedClientCertRequest", challenge.toMap(), callback)
  }

  fun onZoomScaleChanged(oldScale: Float, newScale: Float) {
    val channel = getChannel()
    if (channel == null) return
    if (!isHighFrequencyEventEnabled(EVENT_ON_ZOOM_SCALE_CHANGED)) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["oldScale"] = oldScale
    obj["newScale"] = newScale
    channel.invokeMethod(EVENT_ON_ZOOM_SCALE_CHANGED, obj)
  }

  open class SafeBrowsingHitCallback : BaseCallbackResultImpl<SafeBrowsingResponse>() {
    override fun decodeResult(obj: Any?): SafeBrowsingResponse? {
      return SafeBrowsingResponse.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun onSafeBrowsingHit(url: String?, threatType: Int, callback: SafeBrowsingHitCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    obj["threatType"] = threatType
    channel.invokeMethod("onSafeBrowsingHit", obj, callback)
  }

  open class FormResubmissionCallback : BaseCallbackResultImpl<Int>() {
    override fun decodeResult(obj: Any?): Int? {
      return if (obj is Int) obj else null
    }
  }

  fun onFormResubmission(url: String?, callback: FormResubmissionCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    channel.invokeMethod("onFormResubmission", obj, callback)
  }

  fun onPageCommitVisible(url: String?) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    channel.invokeMethod("onPageCommitVisible", obj)
  }

  fun onRenderProcessGone(didCrash: Boolean, rendererPriorityAtExit: Int) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["didCrash"] = didCrash
    obj["rendererPriorityAtExit"] = rendererPriorityAtExit
    channel.invokeMethod("onRenderProcessGone", obj)
  }

  fun onReceivedLoginRequest(realm: String?, account: String?, args: String?) {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["realm"] = realm
    obj["account"] = account
    obj["args"] = args
    channel.invokeMethod("onReceivedLoginRequest", obj)
  }

  open class LoadResourceWithCustomSchemeCallback : BaseCallbackResultImpl<CustomSchemeResponse>() {
    override fun decodeResult(obj: Any?): CustomSchemeResponse? {
      return CustomSchemeResponse.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun onLoadResourceWithCustomScheme(request: WebResourceRequestExt, callback: LoadResourceWithCustomSchemeCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    val obj: MutableMap<String, Any?> = HashMap()
    obj["request"] = request.toMap()
    channel.invokeMethod("onLoadResourceWithCustomScheme", obj, callback)
  }

  open class SyncLoadResourceWithCustomSchemeCallback : SyncBaseCallbackResultImpl<CustomSchemeResponse>() {
    override fun decodeResult(obj: Any?): CustomSchemeResponse? {
      return (LoadResourceWithCustomSchemeCallback()).decodeResult(obj)
    }
  }

  @Throws(InterruptedException::class)
  fun onLoadResourceWithCustomScheme(request: WebResourceRequestExt): CustomSchemeResponse? {
    val channel = getChannel()
    if (channel == null) return null
    val obj: MutableMap<String, Any?> = HashMap()
    obj["request"] = request.toMap()
    val callback = SyncLoadResourceWithCustomSchemeCallback()
    return Util.invokeMethodAndWaitResult(channel, "onLoadResourceWithCustomScheme", obj, callback)
  }

  open class ShouldInterceptRequestCallback : BaseCallbackResultImpl<WebResourceResponseExt>() {
    override fun decodeResult(obj: Any?): WebResourceResponseExt? {
      return WebResourceResponseExt.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun shouldInterceptRequest(request: WebResourceRequestExt, callback: ShouldInterceptRequestCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    channel.invokeMethod("shouldInterceptRequest", request.toMap(), callback)
  }

  open class SyncShouldInterceptRequestCallback : SyncBaseCallbackResultImpl<WebResourceResponseExt>() {
    override fun decodeResult(obj: Any?): WebResourceResponseExt? {
      return (ShouldInterceptRequestCallback()).decodeResult(obj)
    }
  }

  @Throws(InterruptedException::class)
  fun shouldInterceptRequest(request: WebResourceRequestExt): WebResourceResponseExt? {
    val channel = getChannel()
    if (channel == null) return null
    val callback = SyncShouldInterceptRequestCallback()
    return Util.invokeMethodAndWaitResult(channel, "shouldInterceptRequest", request.toMap(), callback)
  }

  open class RenderProcessUnresponsiveCallback : BaseCallbackResultImpl<Int>() {
    override fun decodeResult(obj: Any?): Int? {
      return if (obj is Int) obj else null
    }
  }

  fun onRenderProcessUnresponsive(url: String?, callback: RenderProcessUnresponsiveCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    channel.invokeMethod("onRenderProcessUnresponsive", obj, callback)
  }

  open class RenderProcessResponsiveCallback : BaseCallbackResultImpl<Int>() {
    override fun decodeResult(obj: Any?): Int? {
      return if (obj is Int) obj else null
    }
  }

  fun onRenderProcessResponsive(url: String?, callback: RenderProcessResponsiveCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    channel.invokeMethod("onRenderProcessResponsive", obj, callback)
  }

  open class CallJsHandlerCallback : BaseCallbackResultImpl<Any>() {
    override fun decodeResult(obj: Any?): Any? {
      return obj
    }
  }

  fun onCallJsHandler(handlerName: String?, data: JavaScriptHandlerFunctionData, callback: CallJsHandlerCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    val obj: MutableMap<String, Any?> = HashMap()
    obj["handlerName"] = handlerName
    obj["data"] = data.toMap()
    channel.invokeMethod("onCallJsHandler", obj, callback)
  }

  open class PrintRequestCallback : BaseCallbackResultImpl<Boolean>() {
    override fun decodeResult(obj: Any?): Boolean? {
      return (obj is Boolean) && obj
    }
  }

  fun onPrintRequest(url: String?, printJobId: String?, callback: PrintRequestCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    val obj: MutableMap<String, Any?> = HashMap()
    obj["url"] = url
    obj["printJobId"] = printJobId
    channel.invokeMethod("onPrintRequest", obj, callback)
  }

  fun onRequestFocus() {
    val channel = getChannel()
    if (channel == null) return
    val obj: MutableMap<String, Any?> = HashMap()
    channel.invokeMethod("onRequestFocus", obj)
  }

  open class ShowFileChooserCallback : BaseCallbackResultImpl<ShowFileChooserResponse>() {
    override fun decodeResult(obj: Any?): ShowFileChooserResponse? {
      return ShowFileChooserResponse.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun onShowFileChooser(request: ShowFileChooserRequest, callback: ShowFileChooserCallback) {
    val channel = getChannel()
    if (channel == null) {
      callback.defaultBehaviour(null)
      return
    }
    channel.invokeMethod("onShowFileChooser", request.toMap(), callback)
  }

  override fun dispose() {
    super.dispose()
    webView = null
  }
}
