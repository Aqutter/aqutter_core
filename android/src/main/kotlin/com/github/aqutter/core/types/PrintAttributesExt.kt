package com.github.aqutter.core.types

import android.os.Build
import android.print.PrintAttributes
import androidx.annotation.RequiresApi

@RequiresApi(api = Build.VERSION_CODES.KITKAT)
class PrintAttributesExt {
  private var colorMode: Int = 0
  private var duplex: Int? = null
  private var orientation: Int? = null
  private var mediaSize: MediaSizeExt? = null
  private var resolution: ResolutionExt? = null
  private var margins: MarginsExt? = null

  fun toMap(): MutableMap<String, Any?> {
    val obj: MutableMap<String, Any?> = HashMap()
    obj["colorMode"] = colorMode
    obj["duplex"] = duplex
    obj["orientation"] = orientation
    obj["mediaSize"] = if (mediaSize != null) mediaSize!!.toMap() else null
    obj["resolution"] = if (resolution != null) resolution!!.toMap() else null
    obj["margins"] = if (margins != null) margins!!.toMap() else null
    return obj
  }

  companion object {
    @JvmStatic
    fun fromPrintAttributes(attributes: PrintAttributes?): PrintAttributesExt? {
      if (attributes == null) {
        return null
      }
      val attributesExt = PrintAttributesExt()
      attributesExt.colorMode = attributes.colorMode
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        attributesExt.duplex = attributes.duplexMode
      }
      val mediaSize = attributes.mediaSize
      if (mediaSize != null) {
        attributesExt.mediaSize = MediaSizeExt.fromMediaSize(mediaSize)
        attributesExt.orientation = if (mediaSize.isPortrait) 0 else 1
      }
      attributesExt.resolution = ResolutionExt.fromResolution(attributes.resolution)
      attributesExt.margins = MarginsExt.fromMargins(attributes.minMargins)
      return attributesExt
    }
  }
}
