package com.github.aqutter.core.webview

import android.os.Build
import android.os.Handler
import android.util.Log
import android.webkit.JavascriptInterface
import android.webkit.ValueCallback
import com.github.aqutter.core.plugin_scripts_js.JavaScriptBridgeJS
import com.github.aqutter.core.print_job.PrintJobSettings
import com.github.aqutter.core.types.JavaScriptHandlerFunctionData
import com.github.aqutter.core.webview.webview.AqutterWebView
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

class JavaScriptBridgeInterface(
  private var aqutterWebView: AqutterWebView?,
  private val expectedBridgeSecret: String
) {
  companion object {
    private const val LOG_TAG = "JSBridgeInterface"
  }

  @JavascriptInterface
  fun _hideContextMenu() {
    val webView = aqutterWebView
    if (webView == null) {
      return
    }

    val handler = Handler(webView.webViewLooper)
    handler.post(object : Runnable {
      override fun run() {
        if (aqutterWebView != null && aqutterWebView!!.floatingContextMenu != null) {
          aqutterWebView!!.hideContextMenu()
        }
      }
    })
  }

  @JavascriptInterface
  fun _callHandler(jsonStringifiedData: String?) {
    val webView = aqutterWebView
    if (webView == null) {
      return
    }

    val data: JSONObject
    try {
      data = JSONObject(jsonStringifiedData)
    } catch (e: Exception) {
      e.printStackTrace()
      Log.e(LOG_TAG, "Cannot convert jsonStringifiedData parameter of _callHandler method to a valid JSONObject")
      return
    }

    if (!data.has("handlerName") || data.isNull("handlerName")) {
      Log.d(LOG_TAG, "handlerName is null or undefined")
      return
    }

    val handlerName = data.optString("handlerName")
    val bridgeSecret = data.optString("_bridgeSecret")
    val _callHandlerID = data.optInt("_callHandlerID")
    val origin = data.optString("origin")
    val requestUrl = data.optString("requestUrl")
    val isMainFrame = data.optBoolean("isMainFrame")
    val args = data.optString("args")

    if (expectedBridgeSecret != bridgeSecret) {
      Log.e(LOG_TAG, "Bridge access attempt with wrong secret token, possibly from malicious code from origin: " + origin)
      return
    }

    var isOriginAllowed = false
    if (webView.customSettings.javaScriptHandlersOriginAllowList != null) {
      for (allowedOrigin in webView.customSettings.javaScriptHandlersOriginAllowList) {
        if (allowedOrigin.matcher(origin).matches()) {
          isOriginAllowed = true
          break
        }
      }
    } else {
      // origin is by default allowed if the allow list is null
      isOriginAllowed = true
    }
    if (!isOriginAllowed) {
      Log.e(LOG_TAG, "Bridge access attempt from an origin not allowed: " + origin)
      return
    }

    if (webView.customSettings.javaScriptHandlersForMainFrameOnly && !isMainFrame) {
      Log.e(LOG_TAG, "Bridge access attempt from a sub-frame origin: " + origin)
      return
    }

    // java.lang.RuntimeException: Methods marked with @UiThread must be executed on the main thread.
    // https://github.com/pichillilorenzo/flutter_inappwebview/issues/98
    val handler = Handler(webView.webViewLooper)
    handler.post(object : Runnable {
      override fun run() {
        if (aqutterWebView == null) {
          // The webview has already been disposed, ignore.
          return
        }

        var isInternalHandler = true
        when (handlerName) {
          "onPrintRequest" -> {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
              val settings = PrintJobSettings()
              settings.handledByClient = true
              val printJobId = aqutterWebView!!.printCurrentPage(settings)
              val printChannelDelegate = aqutterWebView?.channelDelegate
              if (printChannelDelegate != null) {
                printChannelDelegate.onPrintRequest(aqutterWebView!!.url, printJobId, object : WebViewChannelDelegate.PrintRequestCallback() {
                  override fun nonNullSuccess(handledByClient: Boolean): Boolean {
                    return !handledByClient
                  }

                  override fun defaultBehaviour(handledByClient: Boolean?) {
                    val printJobManager = aqutterWebView?.plugin?.printJobManager
                    if (printJobManager != null) {
                      val printJobController = printJobManager.jobs.get(printJobId)
                      if (printJobController != null) {
                        printJobController.disposeNoCancel()
                      }
                    }
                  }

                  override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                    Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
                    defaultBehaviour(null)
                  }
                })
              }
            }
          }
          "callAsyncJavaScript" -> {
            try {
              val arguments = JSONArray(args)
              val jsonObject = arguments.getJSONObject(0)
              val resultUuid = jsonObject.getString("resultUuid")
              val callAsyncJavaScriptCallback = aqutterWebView!!.callAsyncJavaScriptCallbacks.get(resultUuid)
              if (callAsyncJavaScriptCallback != null) {
                callAsyncJavaScriptCallback.onReceiveValue(jsonObject.toString())
                aqutterWebView!!.callAsyncJavaScriptCallbacks.remove(resultUuid)
              }
            } catch (e: JSONException) {
              Log.e(LOG_TAG, "", e)
            }
          }
          "evaluateJavaScriptWithContentWorld" -> {
            try {
              val arguments = JSONArray(args)
              val jsonObject = arguments.getJSONObject(0)
              val resultUuid = jsonObject.getString("resultUuid")
              val evaluateJavaScriptCallback = aqutterWebView!!.evaluateJavaScriptContentWorldCallbacks.get(resultUuid)
              if (evaluateJavaScriptCallback != null) {
                evaluateJavaScriptCallback.onReceiveValue(if (jsonObject.has("value")) jsonObject.get("value").toString() else "null")
                aqutterWebView!!.evaluateJavaScriptContentWorldCallbacks.remove(resultUuid)
              }
            } catch (e: JSONException) {
              Log.e(LOG_TAG, "", e)
            }
          }
          else -> {
            isInternalHandler = false
          }
        }

        if (isInternalHandler) {
          if (aqutterWebView != null) {
            val sourceCode = "if (window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "[" + _callHandlerID + "] != null) { " +
                    "window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "[" + _callHandlerID + "].resolve(); " +
                    "delete window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "[" + _callHandlerID + "]; " +
                    "}"
            aqutterWebView!!.evaluateJavascript(sourceCode, null as ValueCallback<String>?)
          }
          return
        }


        val channelDelegate = aqutterWebView!!.channelDelegate
        if (channelDelegate != null) {
          val data = JavaScriptHandlerFunctionData(origin, requestUrl, isMainFrame, args)
          // invoke flutter javascript handler and send back flutter data as a JSON Object to javascript
          channelDelegate.onCallJsHandler(handlerName, data, object : WebViewChannelDelegate.CallJsHandlerCallback() {
            override fun defaultBehaviour(json: Any?) {
              if (aqutterWebView == null) {
                // The webview has already been disposed, ignore.
                return
              }
              val sourceCode = "if (window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "[" + _callHandlerID + "] != null) { " +
                      "window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "[" + _callHandlerID + "].resolve(" + json + "); " +
                      "delete window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "[" + _callHandlerID + "]; " +
                      "}"
              aqutterWebView!!.evaluateJavascript(sourceCode, null as ValueCallback<String>?)
            }

            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
              val message = errorCode + (if (errorMessage != null) ", " + errorMessage else "")
              Log.e(LOG_TAG, message)

              if (aqutterWebView == null) {
                // The webview has already been disposed, ignore.
                return
              }

              val sourceCode = "if (window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "[" + _callHandlerID + "] != null) { " +
                      "window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "[" + _callHandlerID + "].reject(new Error(" + JSONObject.quote(message) + ")); " +
                      "delete window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "[" + _callHandlerID + "]; " +
                      "}"
              aqutterWebView!!.evaluateJavascript(sourceCode, null as ValueCallback<String>?)
            }
          })
        }
      }
    })
  }

  fun dispose() {
    aqutterWebView = null
  }
}
