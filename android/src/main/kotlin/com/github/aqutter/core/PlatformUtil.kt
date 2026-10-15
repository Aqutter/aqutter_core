package com.github.aqutter.core

import android.os.Build
import com.github.aqutter.core.types.ChannelDelegateImpl
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.TimeZone
import java.util.regex.Pattern

open class PlatformUtil(plugin: AqutterCorePlugin) :
  ChannelDelegateImpl(MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME)) {

  @JvmField
  var plugin: AqutterCorePlugin? = plugin

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "getSystemVersion" ->
        result.success(Build.VERSION.SDK_INT.toString())
      "formatDate" -> {
        val date = call.argument<Long>("date")!!
        val format = call.argument<String>("format")
        val locale = getLocaleFromString(call.argument<String>("locale"))
        var timezone = call.argument<String>("timezone")
        if (timezone == null) {
          timezone = "UTC"
        }
        result.success(formatDate(date, format, locale, TimeZone.getTimeZone(timezone)))
      }
      else -> result.notImplemented()
    }
  }

  override fun dispose() {
    super.dispose()
    plugin = null
  }

  companion object {
    protected const val LOG_TAG = "PlatformUtil"
    const val METHOD_CHANNEL_NAME = "com.github.aqutter/webview_platformutil"

    @JvmStatic
    fun getLocaleFromString(locale: String?): Locale {
      if (locale == null) {
        return Locale.US
      }
      val localeSplit = Pattern.compile("_").split(locale)
      val language = localeSplit[0]
      val country = if (localeSplit.size > 1) localeSplit[1] else ""
      val variant = if (localeSplit.size > 2) localeSplit[2] else ""
      return Locale(language, country, variant)
    }

    @JvmStatic
    fun formatDate(date: Long, format: String?, locale: Locale, timezone: TimeZone): String {
      val sdf = SimpleDateFormat(format, locale)
      sdf.timeZone = timezone
      return sdf.format(Date(date))
    }
  }
}
