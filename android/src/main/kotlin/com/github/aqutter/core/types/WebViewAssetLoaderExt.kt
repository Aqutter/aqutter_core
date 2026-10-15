package com.github.aqutter.core.types

import android.content.Context
import android.os.Build
import android.util.Log
import android.webkit.WebResourceResponse
import androidx.webkit.WebViewAssetLoader
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.Util
import java.io.ByteArrayInputStream
import java.io.File
import io.flutter.plugin.common.MethodChannel

class WebViewAssetLoaderExt(
  @JvmField var loader: WebViewAssetLoader?,
  @JvmField var customPathHandlers: MutableList<PathHandlerExt>
) : Disposable {
  companion object {
    @JvmStatic
    fun fromMap(map: MutableMap<String, Any?>?, plugin: AqutterCorePlugin, context: Context): WebViewAssetLoaderExt? {
      if (map == null) {
        return null
      }
      val builder = WebViewAssetLoader.Builder()
      val domain = map["domain"] as String?
      val httpAllowed = map["httpAllowed"] as Boolean?
      val pathHandlers = map["pathHandlers"] as MutableList<MutableMap<String, Any?>>?
      val customPathHandlers: MutableList<PathHandlerExt> = ArrayList()
      if (domain != null && !domain.isEmpty()) {
        builder.setDomain(domain)
      }
      if (httpAllowed != null) {
        builder.setHttpAllowed(httpAllowed)
      }
      if (pathHandlers != null) {
        for (pathHandler in pathHandlers) {
          val type = pathHandler["type"] as String?
          val path = pathHandler["path"] as String?
          if (type == null || path == null) {
            continue
          }
          when (type) {
            "AssetsPathHandler" -> {
              val assetsPathHandler = WebViewAssetLoader.AssetsPathHandler(context)
              builder.addPathHandler(path, assetsPathHandler)
            }
            "InternalStoragePathHandler" -> {
              val directory = pathHandler["directory"] as String?
              if (directory == null) {
                continue
              }
              val dir = File(directory)
              val internalStoragePathHandler = WebViewAssetLoader.InternalStoragePathHandler(context, dir)
              builder.addPathHandler(path, internalStoragePathHandler)
            }
            "ResourcesPathHandler" -> {
              val resourcesPathHandler = WebViewAssetLoader.ResourcesPathHandler(context)
              builder.addPathHandler(path, resourcesPathHandler)
            }
            else -> {
              val id = pathHandler["id"] as String?
              if (id == null) {
                continue
              }
              val customPathHandler = PathHandlerExt(id, plugin)
              builder.addPathHandler(path, customPathHandler)
              customPathHandlers.add(customPathHandler)
            }
          }
        }
      }
      return WebViewAssetLoaderExt(builder.build(), customPathHandlers)
    }
  }

  override fun dispose() {
    for (pathHandler in customPathHandlers) {
      pathHandler.dispose()
    }
    customPathHandlers.clear()
  }

  class PathHandlerExt(
    @JvmField var id: String,
    plugin: AqutterCorePlugin
  ) : WebViewAssetLoader.PathHandler, Disposable {
    companion object {
      // protected in Java
      const val LOG_TAG = "PathHandlerExt"
      const val METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/webview_custompathhandler_"
    }

    @JvmField
    var channelDelegate: PathHandlerExtChannelDelegate?

    init {
      val channel = MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME_PREFIX + id)
      this.channelDelegate = PathHandlerExtChannelDelegate(this, channel)
    }

    override fun handle(path: String): WebResourceResponse? {
      val channelDelegate = channelDelegate
      if (channelDelegate != null) {
        var response: WebResourceResponseExt? = null

        try {
          response = channelDelegate.handle(path)
        } catch (e: InterruptedException) {
          Log.e(LOG_TAG, "", e)
          return null
        }

        if (response != null) {
          val contentType = response.contentType
          val contentEncoding = response.contentEncoding
          val data = response.data
          val responseHeaders = response.headers
          val statusCode = response.statusCode
          val reasonPhrase = response.reasonPhrase

          val inputStream = if (data != null) ByteArrayInputStream(data) else null

          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP && statusCode != null && reasonPhrase != null) {
            return WebResourceResponse(contentType, contentEncoding, statusCode, reasonPhrase, responseHeaders, inputStream)
          } else {
            return WebResourceResponse(contentType, contentEncoding, inputStream)
          }
        }
      }
      return null
    }

    override fun dispose() {
      if (channelDelegate != null) {
        channelDelegate!!.dispose()
        channelDelegate = null
      }
    }
  }

  class PathHandlerExtChannelDelegate(
    pathHandler: PathHandlerExt,
    channel: MethodChannel
  ) : ChannelDelegateImpl(channel) {
    private var pathHandler: PathHandlerExt? = pathHandler

    class HandleCallback : BaseCallbackResultImpl<WebResourceResponseExt>() {
      override fun decodeResult(obj: Any?): WebResourceResponseExt? {
        return WebResourceResponseExt.fromMap(obj as MutableMap<String, Any?>?)
      }
    }

    fun handle(path: String?, callback: HandleCallback) {
      val channel = getChannel()
      if (channel == null) return
      val obj: MutableMap<String, Any?> = HashMap()
      obj["path"] = path
      channel.invokeMethod("handle", obj, callback)
    }

    class SyncHandleCallback : SyncBaseCallbackResultImpl<WebResourceResponseExt>() {
      override fun decodeResult(obj: Any?): WebResourceResponseExt? {
        return HandleCallback().decodeResult(obj)
      }
    }

    @Throws(InterruptedException::class)
    fun handle(path: String?): WebResourceResponseExt? {
      val channel = getChannel()
      if (channel == null) return null
      val callback = SyncHandleCallback()
      val obj: MutableMap<String, Any?> = HashMap()
      obj["path"] = path
      return Util.invokeMethodAndWaitResult(channel, "handle", obj, callback)
    }

    override fun dispose() {
      super.dispose()
      pathHandler = null
    }
  }
}
