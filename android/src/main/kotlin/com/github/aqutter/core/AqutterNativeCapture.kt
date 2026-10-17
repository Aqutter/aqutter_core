package com.github.aqutter.core

import android.graphics.Bitmap
import android.graphics.Rect
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.PixelCopy
import android.view.SurfaceView
import android.view.TextureView
import android.view.View
import android.view.ViewGroup
import android.webkit.WebView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.nio.ByteBuffer
import kotlin.math.min
import kotlin.math.roundToInt

/**
 * Android 原生擷取（native view 鏡像用）。
 *
 * `RenderRepaintBoundary.toImage` 抓不到 Texture 與 PlatformView 的內容（例如 texture 模式的 Google 地圖，
 * 鏡像出來是透明的）。這裡改用 [PixelCopy] 直接複製 Flutter 的繪圖表面（`FlutterSurfaceView`）：
 * 這類內容已被合成進該表面；而網頁（WebView）是獨立的 View，不在這個表面上，所以不會被拍進去。
 *
 * MethodChannel：`com.github.aqutter/nativeview`，method `capture`，
 * args `{x, y, w, h, pixelRatio?}`（logical，Flutter 全域座標），回傳 `{width, height, bytes}`（RGBA）。
 * 與 iOS 的 `AqutterNativeCapture` 同一個通道與介面。
 *
 * 限制：需要 API 26 以上；Flutter 以 texture 模式（`FlutterTextureView`）渲染時不支援；
 * 輸出是 PixelCopy 的 ARGB_8888（預乘 alpha），表面本身不透明，所以與 straight alpha 相同。
 */
class AqutterNativeCapture(private val plugin: AqutterCorePlugin) : MethodChannel.MethodCallHandler {
  companion object {
    const val CHANNEL_NAME = "com.github.aqutter/nativeview"
    private const val TAG = "AqutterNativeCapture"
  }

  private val mainHandler = Handler(Looper.getMainLooper())

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (call.method != "capture") {
      result.notImplemented()
      return
    }
    val activity = plugin.activity
    val x = call.argument<Double>("x")
    val y = call.argument<Double>("y")
    val w = call.argument<Double>("w")
    val h = call.argument<Double>("h")
    if (activity == null || x == null || y == null || w == null || h == null || Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
      Log.w(TAG, "skipped: activity=${activity != null} args=${x != null && y != null && w != null && h != null} sdk=${Build.VERSION.SDK_INT}")
      result.success(null)
      return
    }

    val density = activity.resources.displayMetrics.density
    val target = Rect(
      (x * density).roundToInt(),
      (y * density).roundToInt(),
      ((x + w) * density).roundToInt(),
      ((y + h) * density).roundToInt(),
    )
    val source = findSource(activity.window.decorView, target)
    if (source == null) {
      Log.w(TAG, "no texture or surface overlaps $target; views: ${describe(activity.window.decorView, 0)}")
      result.success(null)
      return
    }

    // 輸出尺寸：pixelRatio（每個 logical 像素要幾個像素）給了就縮到那個解析度，不放大
    val pixelRatio = call.argument<Double>("pixelRatio")
    val scale = if (pixelRatio != null && pixelRatio > 0) min(1.0, pixelRatio / density) else 1.0
    val dstWidth = (source.view.width * scale).roundToInt().coerceAtLeast(1)
    val dstHeight = (source.view.height * scale).roundToInt().coerceAtLeast(1)

    fun finish(bitmap: Bitmap?) {
      if (bitmap == null) {
        result.success(null)
        return
      }
      val buffer = ByteBuffer.allocate(bitmap.byteCount)
      bitmap.copyPixelsToBuffer(buffer)
      result.success(mapOf("width" to bitmap.width, "height" to bitmap.height, "bytes" to buffer.array()))
      bitmap.recycle()
    }

    val view = source.view
    if (view is TextureView) {
      // TextureView 直接取目前的內容（含 GL 繪製的地圖），與其他 View 的覆蓋無關
      finish(if (view.isAvailable) view.getBitmap(Bitmap.createBitmap(dstWidth, dstHeight, Bitmap.Config.ARGB_8888)) else null)
      return
    }
    view as SurfaceView
    val bitmap = Bitmap.createBitmap(dstWidth, dstHeight, Bitmap.Config.ARGB_8888)
    try {
      PixelCopy.request(view, bitmap, { code ->
        if (code == PixelCopy.SUCCESS) {
          finish(bitmap)
        }
        else {
          Log.w(TAG, "PixelCopy failed: code=$code view=${view.javaClass.simpleName} ${view.width}x${view.height}")
          bitmap.recycle()
          result.success(null)
        }
      }, mainHandler)
    }
    catch (e: IllegalArgumentException) {
      Log.w(TAG, "PixelCopy rejected: ${e.message}")
      bitmap.recycle()
      result.success(null)
    }
  }

  private class Source(val view: View, val overlap: Long)

  /**
   * 在視窗裡找要擷取的來源：與目標區域重疊最多的 [TextureView] 或 [SurfaceView]（不含 WebView 內部）。
   *
   * 不能靠類名比對：release 版的 R8 會把 Flutter 與 plugin 的類別混淆（實測 `FlutterSurfaceView` 變成 `rk`）。
   * Flutter 自己的繪圖表面（滿版的 SurfaceView）沒有可複製的資料（Vulkan 呈現時 PixelCopy 回 ERROR_SOURCE_NO_DATA），
   * 所以略過「幾乎滿版且位於視窗最底層」的那一個，改找被鏡像的內容本身（例如地圖裡的 TextureView）。
   */
  private fun findSource(root: View, target: Rect): Source? {
    var best: Source? = null
    val location = IntArray(2)
    fun visit(view: View) {
      if (view is WebView || view.visibility != View.VISIBLE) {
        return
      }
      if ((view is TextureView || view is SurfaceView) && view.width > 0 && view.height > 0) {
        view.getLocationInWindow(location)
        val bounds = Rect(location[0], location[1], location[0] + view.width, location[1] + view.height)
        val overlap = Rect()
        val isFlutterSurface = view is SurfaceView && view.width >= root.width * 0.9 && view.height >= root.height * 0.9 && target.height() < view.height * 0.9
        if (!isFlutterSurface && overlap.setIntersect(bounds, target)) {
          val area = overlap.width().toLong() * overlap.height().toLong()
          if (best == null || area > best!!.overlap) {
            best = Source(view, area)
          }
        }
      }
      if (view is ViewGroup) {
        for (i in 0 until view.childCount) {
          visit(view.getChildAt(i))
        }
      }
    }
    visit(root)
    return best
  }

  /** 除錯用：列出 view 階層的類名（含父類別與大小）。 */
  private fun describe(view: View, depth: Int): String {
    val name = view.javaClass.simpleName + "<" + view.javaClass.superclass?.simpleName + ">(" + view.width + "x" + view.height + (if (view.visibility == View.VISIBLE) "" else " hidden") + ")"
    if (view !is ViewGroup || depth >= 12) {
      return name
    }
    val children = (0 until view.childCount).joinToString(",") { describe(view.getChildAt(it), depth + 1) }
    return "$name[$children]"
  }
}
