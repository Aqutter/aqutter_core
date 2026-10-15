package com.github.aqutter.core

import android.webkit.ValueCallback
import android.webkit.WebStorage
import com.github.aqutter.core.types.ChannelDelegateImpl
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

open class MyWebStorage(plugin: AqutterCorePlugin) :
  ChannelDelegateImpl(MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME)) {

  @JvmField
  var plugin: AqutterCorePlugin? = plugin

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    init()

    when (call.method) {
      "getOrigins" ->
        getOrigins(result)
      "deleteAllData" -> {
        val manager = webStorageManager
        if (manager != null) {
          manager.deleteAllData()
          result.success(true)
        } else {
          result.success(false)
        }
      }
      "deleteOrigin" -> {
        val manager = webStorageManager
        if (manager != null) {
          val origin = call.argument<String>("origin")
          manager.deleteOrigin(origin)
          result.success(true)
        } else {
          result.success(false)
        }
      }
      "getQuotaForOrigin" -> {
        val origin = call.argument<String>("origin")
        getQuotaForOrigin(origin, result)
      }
      "getUsageForOrigin" -> {
        val origin = call.argument<String>("origin")
        getUsageForOrigin(origin, result)
      }
      else -> result.notImplemented()
    }
  }

  open fun getOrigins(result: MethodChannel.Result) {
    val manager = webStorageManager
    if (manager == null) {
      result.success(ArrayList<Any>())
      return
    }
    manager.getOrigins(ValueCallback<Map<*, *>> { value ->
      val origins = ArrayList<Map<String, Any?>>()
      for (key in value.keys) {
        val originObj = value[key] as WebStorage.Origin

        val originInfo = HashMap<String, Any?>()
        originInfo["origin"] = originObj.origin
        originInfo["quota"] = originObj.quota
        originInfo["usage"] = originObj.usage

        origins.add(originInfo)
      }
      result.success(origins)
    })
  }

  open fun getQuotaForOrigin(origin: String?, result: MethodChannel.Result) {
    val manager = webStorageManager
    if (manager == null) {
      result.success(0)
      return
    }
    manager.getQuotaForOrigin(origin, ValueCallback<Long> { value ->
      result.success(value)
    })
  }

  open fun getUsageForOrigin(origin: String?, result: MethodChannel.Result) {
    val manager = webStorageManager
    if (manager == null) {
      result.success(0)
      return
    }
    manager.getUsageForOrigin(origin, ValueCallback<Long> { value ->
      result.success(value)
    })
  }

  override fun dispose() {
    super.dispose()
    plugin = null
  }

  companion object {
    protected const val LOG_TAG = "MyWebStorage"
    const val METHOD_CHANNEL_NAME = "com.github.aqutter/webview_webstoragemanager"

    @JvmField
    var webStorageManager: WebStorage? = null

    @JvmStatic
    fun init() {
      if (webStorageManager == null) {
        webStorageManager = WebStorage.getInstance()
      }
    }
  }
}
