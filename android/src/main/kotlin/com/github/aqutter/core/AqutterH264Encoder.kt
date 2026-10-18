package com.github.aqutter.core

import android.graphics.Bitmap
import android.media.MediaCodec
import android.media.MediaCodecInfo
import android.media.MediaFormat
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.HandlerThread
import android.view.Surface
import java.util.concurrent.ConcurrentLinkedQueue

/**
 * 把一張張 Bitmap 編成 H.264（Annex B）：用 Surface 輸入（硬體編碼器直接讀 GPU 緩衝，不必在 CPU 上轉 YUV）。
 *
 * 編碼輸出走非同步回呼（獨立執行緒），[encode] 不會等編碼器：送進一張、取回「目前已經編好的」一個存取單元
 * （硬體編碼器有幾幀的管線延遲，所以取到的可能是更早送進去的幀；順序不會亂，也不能丟，丟了後面的幀就解不出來）。
 * 關鍵幀前面會補上 SPS／PPS，網頁端的解碼器因此能從任何一個關鍵幀開始。
 */
class AqutterH264Encoder(val width: Int, val height: Int, bitrate: Int, frameRate: Int) {
  class Output(val bytes: ByteArray, val isKey: Boolean)

  private val thread = HandlerThread("aqutter-h264").also { it.start() }
  private val codec: MediaCodec = MediaCodec.createEncoderByType(MediaFormat.MIMETYPE_VIDEO_AVC)
  private val surface: Surface
  @Volatile private var config: ByteArray? = null
  private val outputs = ConcurrentLinkedQueue<Output>()

  init {
    val format = MediaFormat.createVideoFormat(MediaFormat.MIMETYPE_VIDEO_AVC, width, height)
    format.setInteger(MediaFormat.KEY_COLOR_FORMAT, MediaCodecInfo.CodecCapabilities.COLOR_FormatSurface)
    format.setInteger(MediaFormat.KEY_BIT_RATE, bitrate)
    format.setInteger(MediaFormat.KEY_FRAME_RATE, frameRate)
    format.setInteger(MediaFormat.KEY_I_FRAME_INTERVAL, 2)
    format.setInteger(MediaFormat.KEY_BITRATE_MODE, MediaCodecInfo.EncoderCapabilities.BITRATE_MODE_VBR)
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
      format.setInteger(MediaFormat.KEY_LOW_LATENCY, 1)
    }
    format.setInteger(MediaFormat.KEY_PRIORITY, 0) // 即時
    codec.setCallback(object : MediaCodec.Callback() {
      override fun onInputBufferAvailable(codec: MediaCodec, index: Int) {}

      override fun onOutputBufferAvailable(codec: MediaCodec, index: Int, info: MediaCodec.BufferInfo) {
        val buffer = codec.getOutputBuffer(index)
        val bytes = ByteArray(info.size)
        if (buffer != null && info.size > 0) {
          buffer.position(info.offset)
          buffer.limit(info.offset + info.size)
          buffer.get(bytes)
        }
        val flags = info.flags
        codec.releaseOutputBuffer(index, false)
        if ((flags and MediaCodec.BUFFER_FLAG_CODEC_CONFIG) != 0) {
          config = bytes
          return
        }
        val key = (flags and MediaCodec.BUFFER_FLAG_KEY_FRAME) != 0
        val prefix = config
        outputs.add(Output(if (key && prefix != null) prefix + bytes else bytes, key))
      }

      override fun onError(codec: MediaCodec, e: MediaCodec.CodecException) {}

      override fun onOutputFormatChanged(codec: MediaCodec, format: MediaFormat) {}
    }, Handler(thread.looper))
    codec.configure(format, null, null, MediaCodec.CONFIGURE_FLAG_ENCODE)
    surface = codec.createInputSurface()
    codec.start()
  }

  /** 送進一張 Bitmap（左上角裁成偶數寬高）並取回目前已編好的一個輸出；還沒有時回 null。[forceKey] 要求下一幀為關鍵幀。 */
  fun encode(bitmap: Bitmap, forceKey: Boolean): Output? {
    if (forceKey) {
      val params = Bundle()
      params.putInt(MediaCodec.PARAMETER_KEY_REQUEST_SYNC_FRAME, 0)
      codec.setParameters(params)
    }
    val canvas = surface.lockHardwareCanvas()
    canvas.drawBitmap(bitmap, 0f, 0f, null)
    surface.unlockCanvasAndPost(canvas)
    return outputs.poll()
  }

  fun release() {
    try {
      codec.stop()
    }
    catch (_: Exception) {
    }
    codec.release()
    surface.release()
    thread.quitSafely()
  }
}
