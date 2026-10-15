package com.github.aqutter.core.service_worker

import android.os.Build
import android.util.Log
import android.webkit.WebResourceRequest
import android.webkit.WebResourceResponse
import androidx.annotation.RequiresApi
import androidx.webkit.ServiceWorkerClientCompat
import androidx.webkit.ServiceWorkerControllerCompat
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.types.Disposable
import com.github.aqutter.core.types.WebResourceRequestExt
import com.github.aqutter.core.types.WebResourceResponseExt
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayInputStream

@RequiresApi(api = Build.VERSION_CODES.N)
class ServiceWorkerManager(plugin: AqutterCorePlugin) : Disposable {
  companion object {
    // protected static in Java
    const val LOG_TAG = "ServiceWorkerManager"
    const val METHOD_CHANNEL_NAME = "com.github.aqutter/webview_serviceworkercontroller"

    @JvmField
    var serviceWorkerController: ServiceWorkerControllerCompat? = null

    @JvmStatic
    fun init() {
      if (serviceWorkerController == null &&
        WebViewFeature.isFeatureSupported(WebViewFeature.SERVICE_WORKER_BASIC_USAGE)) {
        serviceWorkerController = ServiceWorkerControllerCompat.getInstance()
      }
    }
  }

  @JvmField
  var channelDelegate: ServiceWorkerChannelDelegate?
  @JvmField
  var plugin: AqutterCorePlugin? = plugin

  init {
    val channel = MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME)
    this.channelDelegate = ServiceWorkerChannelDelegate(this, channel)
  }

  fun setServiceWorkerClient(isNull: Boolean?) {
    if (serviceWorkerController != null) {
      // set ServiceWorkerClient as null makes the app crashes, so just set a dummy ServiceWorkerClientCompat.
      // https://github.com/pichillilorenzo/flutter_inappwebview/issues/1151
      serviceWorkerController!!.setServiceWorkerClient(if (isNull!!) dummyServiceWorkerClientCompat() else object : ServiceWorkerClientCompat() {
        override fun shouldInterceptRequest(request: WebResourceRequest): WebResourceResponse? {
          val requestExt = WebResourceRequestExt.fromWebResourceRequest(request)

          var response: WebResourceResponseExt? = null
          if (channelDelegate != null) {
            try {
              response = channelDelegate!!.shouldInterceptRequest(requestExt)
            } catch (e: InterruptedException) {
              Log.e(LOG_TAG, "", e)
              return null
            }
          }

          if (response != null) {
            val contentType = response.contentType
            val contentEncoding = response.contentEncoding
            val data = response.data
            val responseHeaders = response.headers
            val statusCode = response.statusCode
            val reasonPhrase = response.reasonPhrase

            val inputStream = if (data != null) ByteArrayInputStream(data) else null

            return if (statusCode != null && reasonPhrase != null) {
              WebResourceResponse(contentType, contentEncoding, statusCode, reasonPhrase, responseHeaders, inputStream)
            } else {
              WebResourceResponse(contentType, contentEncoding, inputStream)
            }
          }

          return null
        }
      })
    }
  }

  private fun dummyServiceWorkerClientCompat(): ServiceWorkerClientCompat {
    return DummyServiceWorkerClientCompat.INSTANCE
  }

  override fun dispose() {
    if (channelDelegate != null) {
      channelDelegate!!.dispose()
      channelDelegate = null
    }
    plugin = null
  }

  private class DummyServiceWorkerClientCompat : ServiceWorkerClientCompat() {
    companion object {
      val INSTANCE: ServiceWorkerClientCompat = DummyServiceWorkerClientCompat()
    }

    override fun shouldInterceptRequest(request: WebResourceRequest): WebResourceResponse? {
      return null
    }
  }
}
