package com.github.aqutter.core.print_job

import android.os.Build
import androidx.annotation.RequiresApi
import com.github.aqutter.core.ISettings
import com.github.aqutter.core.types.MediaSizeExt
import com.github.aqutter.core.types.ResolutionExt

@RequiresApi(api = Build.VERSION_CODES.KITKAT)
class PrintJobSettings : ISettings<PrintJobController> {
  companion object {
    const val LOG_TAG = "PrintJobSettings"
  }

  @JvmField
  var handledByClient: Boolean? = false
  @JvmField
  var jobName: String? = null
  @JvmField
  var orientation: Int? = null
//  @Nullable
//  public MarginsExt margins;
  @JvmField
  var mediaSize: MediaSizeExt? = null
  @JvmField
  var colorMode: Int? = null
  @JvmField
  var duplexMode: Int? = null
  @JvmField
  var resolution: ResolutionExt? = null

  override fun parse(settings: MutableMap<String, Any?>): PrintJobSettings {
    for (pair in settings.entries) {
      val key = pair.key
      val value = pair.value
      if (value == null) {
        continue
      }

      when (key) {
        "handledByClient" -> handledByClient = value as Boolean
        "jobName" -> jobName = value as String
        "orientation" -> orientation = value as Int
//        case "margins":
//          margins = MarginsExt.fromMap((Map<String, Object>) value);
//          break;
        "mediaSize" -> mediaSize = MediaSizeExt.fromMap(value as MutableMap<String, Any?>)
        "colorMode" -> colorMode = value as Int
        "duplexMode" -> duplexMode = value as Int
        "resolution" -> resolution = ResolutionExt.fromMap(value as MutableMap<String, Any?>)
      }
    }

    return this
  }

  override fun toMap(): MutableMap<String, Any?> {
    val settings: MutableMap<String, Any?> = HashMap()
    settings["handledByClient"] = handledByClient
    settings["jobName"] = jobName
    settings["orientation"] = orientation
//    settings.put("margins", margins != null ? margins.toMap() : null);
    settings["mediaSize"] = if (mediaSize != null) mediaSize!!.toMap() else null
    settings["colorMode"] = colorMode
    settings["duplexMode"] = duplexMode
    settings["resolution"] = if (resolution != null) resolution!!.toMap() else null
    return settings
  }

  override fun getRealSettings(obj: PrintJobController): MutableMap<String, Any?> {
    val realSettings = toMap()
    return realSettings
  }
}
