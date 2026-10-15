package com.github.aqutter.core.types

import android.annotation.TargetApi
import android.os.Build
import android.webkit.WebChromeClient
import java.util.Arrays
import java.util.HashMap

class ShowFileChooserRequest(
  var mode: Int,
  var acceptTypes: List<String>,
  var isCaptureEnabled: Boolean,
  var title: String?,
  var filenameHint: String?
) {
  companion object {
    @JvmStatic
    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    fun fromFileChooserParams(fileChooserParams: WebChromeClient.FileChooserParams): ShowFileChooserRequest {
      val mode = fileChooserParams.mode
      val acceptTypes: List<String> = Arrays.asList(*fileChooserParams.acceptTypes)
      val isCaptureEnabled = fileChooserParams.isCaptureEnabled
      val title = if (fileChooserParams.title != null) fileChooserParams.title.toString() else null
      val filenameHint = fileChooserParams.filenameHint
      return ShowFileChooserRequest(mode, acceptTypes, isCaptureEnabled, title, filenameHint)
    }

    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun fromMap(map: Map<String, Any?>?): ShowFileChooserRequest? {
      if (map == null) {
        return null
      }
      val mode = map["mode"] as Int
      val acceptTypes = map["acceptTypes"] as List<String>
      val isCaptureEnabled = map["isCaptureEnabled"] as Boolean
      val title = map["title"] as String?
      val filenameHint = map["filenameHint"] as String?
      return ShowFileChooserRequest(mode, acceptTypes, isCaptureEnabled, title, filenameHint)
    }
  }

  fun toMap(): MutableMap<String, Any?> {
    val showFileChooserRequestMap: MutableMap<String, Any?> = HashMap()
    showFileChooserRequestMap["mode"] = mode
    showFileChooserRequestMap["acceptTypes"] = acceptTypes
    showFileChooserRequestMap["isCaptureEnabled"] = isCaptureEnabled
    showFileChooserRequestMap["title"] = title
    showFileChooserRequestMap["filenameHint"] = filenameHint
    return showFileChooserRequestMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as ShowFileChooserRequest
    return mode == that.mode && isCaptureEnabled == that.isCaptureEnabled && acceptTypes == that.acceptTypes && title == that.title && filenameHint == that.filenameHint
  }

  override fun hashCode(): Int {
    var result = mode
    result = 31 * result + acceptTypes.hashCode()
    result = 31 * result + isCaptureEnabled.hashCode()
    result = 31 * result + (title?.hashCode() ?: 0)
    result = 31 * result + (filenameHint?.hashCode() ?: 0)
    return result
  }

  override fun toString(): String {
    return "ShowFileChooserRequest{" +
      "mode=" + mode +
      ", acceptTypes=" + acceptTypes +
      ", isCaptureEnabled=" + isCaptureEnabled +
      ", title='" + title + '\'' +
      ", filenameHint='" + filenameHint + '\'' +
      '}'
  }
}
