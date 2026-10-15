package com.github.aqutter.core.service_worker

import android.os.Build
import androidx.annotation.RequiresApi
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.Util
import com.github.aqutter.core.types.BaseCallbackResultImpl
import com.github.aqutter.core.types.ChannelDelegateImpl
import com.github.aqutter.core.types.SyncBaseCallbackResultImpl
import com.github.aqutter.core.types.WebResourceRequestExt
import com.github.aqutter.core.types.WebResourceResponseExt
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

@RequiresApi(api = Build.VERSION_CODES.N)
class ServiceWorkerChannelDelegate(serviceWorkerManager: ServiceWorkerManager, channel: MethodChannel) : ChannelDelegateImpl(channel) {
  private var serviceWorkerManager: ServiceWorkerManager? = serviceWorkerManager

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    ServiceWorkerManager.init()
    val serviceWorkerController = ServiceWorkerManager.serviceWorkerController
    val serviceWorkerWebSettings = if (serviceWorkerController != null)
      serviceWorkerController.getServiceWorkerWebSettings() else null

    when (call.method) {
      "setServiceWorkerClient" ->
        if (serviceWorkerManager != null) {
          val isNull = call.argument<Boolean>("isNull")
          serviceWorkerManager!!.setServiceWorkerClient(isNull)
          result.success(true)
        } else {
          result.success(false)
        }
      "getAllowContentAccess" ->
        if (serviceWorkerWebSettings != null && WebViewFeature.isFeatureSupported(WebViewFeature.SERVICE_WORKER_CONTENT_ACCESS)) {
          result.success(serviceWorkerWebSettings.getAllowContentAccess())
        } else {
          result.success(false)
        }
      "getAllowFileAccess" ->
        if (serviceWorkerWebSettings != null && WebViewFeature.isFeatureSupported(WebViewFeature.SERVICE_WORKER_FILE_ACCESS)) {
          result.success(serviceWorkerWebSettings.getAllowFileAccess())
        } else {
          result.success(false)
        }
      "getBlockNetworkLoads" ->
        if (serviceWorkerWebSettings != null && WebViewFeature.isFeatureSupported(WebViewFeature.SERVICE_WORKER_BLOCK_NETWORK_LOADS)) {
          result.success(serviceWorkerWebSettings.getBlockNetworkLoads())
        } else {
          result.success(false)
        }
      "getCacheMode" ->
        if (serviceWorkerWebSettings != null && WebViewFeature.isFeatureSupported(WebViewFeature.SERVICE_WORKER_CACHE_MODE)) {
          result.success(serviceWorkerWebSettings.getCacheMode())
        } else {
          result.success(null)
        }
      "setAllowContentAccess" -> {
        if (serviceWorkerWebSettings != null && WebViewFeature.isFeatureSupported(WebViewFeature.SERVICE_WORKER_CONTENT_ACCESS)) {
          val allow = call.argument<Boolean>("allow")
          serviceWorkerWebSettings.setAllowContentAccess(allow!!)
        }
        result.success(true)
      }
      "setAllowFileAccess" -> {
        if (serviceWorkerWebSettings != null && WebViewFeature.isFeatureSupported(WebViewFeature.SERVICE_WORKER_FILE_ACCESS)) {
          val allow = call.argument<Boolean>("allow")
          serviceWorkerWebSettings.setAllowFileAccess(allow!!)
        }
        result.success(true)
      }
      "setBlockNetworkLoads" -> {
        if (serviceWorkerWebSettings != null && WebViewFeature.isFeatureSupported(WebViewFeature.SERVICE_WORKER_BLOCK_NETWORK_LOADS)) {
          val flag = call.argument<Boolean>("flag")
          serviceWorkerWebSettings.setBlockNetworkLoads(flag!!)
        }
        result.success(true)
      }
      "setCacheMode" -> {
        if (serviceWorkerWebSettings != null && WebViewFeature.isFeatureSupported(WebViewFeature.SERVICE_WORKER_CACHE_MODE)) {
          val mode = call.argument<Int>("mode")
          serviceWorkerWebSettings.setCacheMode(mode!!)
        }
        result.success(true)
      }
      else -> result.notImplemented()
    }
  }

  class ShouldInterceptRequestCallback : BaseCallbackResultImpl<WebResourceResponseExt>() {
    override fun decodeResult(obj: Any?): WebResourceResponseExt? {
      return WebResourceResponseExt.fromMap(obj as MutableMap<String, Any?>?)
    }
  }

  fun shouldInterceptRequest(request: WebResourceRequestExt, callback: ShouldInterceptRequestCallback) {
    val channel = getChannel() ?: return
    channel.invokeMethod("shouldInterceptRequest", request.toMap(), callback)
  }

  class SyncShouldInterceptRequestCallback : SyncBaseCallbackResultImpl<WebResourceResponseExt>() {
    override fun decodeResult(obj: Any?): WebResourceResponseExt? {
      return ShouldInterceptRequestCallback().decodeResult(obj)
    }
  }

  @Throws(InterruptedException::class)
  fun shouldInterceptRequest(request: WebResourceRequestExt): WebResourceResponseExt? {
    val channel = getChannel() ?: return null
    val callback = SyncShouldInterceptRequestCallback()
    return Util.invokeMethodAndWaitResult(channel, "shouldInterceptRequest", request.toMap(), callback)
  }

  override fun dispose() {
    super.dispose()
    serviceWorkerManager = null
  }
}
