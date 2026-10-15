package com.github.aqutter.core

import android.os.Build
import android.util.Log
import android.webkit.CookieManager
import android.webkit.CookieSyncManager
import android.webkit.ValueCallback
import androidx.webkit.CookieManagerCompat
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.types.ChannelDelegateImpl
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.TimeZone
import java.util.regex.Pattern

open class MyCookieManager(plugin: AqutterCorePlugin) :
  ChannelDelegateImpl(MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME)) {

  @JvmField
  var plugin: AqutterCorePlugin? = plugin

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    init()

    when (call.method) {
      "setCookie" -> {
        val url = call.argument<String>("url")
        val name = call.argument<String>("name")
        val value = call.argument<String>("value")
        val domain = call.argument<String>("domain")
        val path = call.argument<String>("path")
        val expiresDateString = call.argument<String>("expiresDate")
        val expiresDate: Long? = if (expiresDateString != null) expiresDateString.toLong() else null
        val maxAge = call.argument<Int>("maxAge")
        val isSecure = call.argument<Boolean>("isSecure")
        val isHttpOnly = call.argument<Boolean>("isHttpOnly")
        val sameSite = call.argument<String>("sameSite")
        setCookie(url,
          name,
          value,
          domain,
          path,
          expiresDate,
          maxAge,
          isSecure,
          isHttpOnly,
          sameSite,
          result)
      }
      "getCookies" ->
        result.success(getCookies(call.argument<String>("url")))
      "deleteCookie" -> {
        val url = call.argument<String>("url")
        val name = call.argument<String>("name")
        val domain = call.argument<String>("domain")
        val path = call.argument<String>("path")
        deleteCookie(url, name, domain, path, result)
      }
      "deleteCookies" -> {
        val url = call.argument<String>("url")
        val domain = call.argument<String>("domain")
        val path = call.argument<String>("path")
        deleteCookies(url, domain, path, result)
      }
      "deleteAllCookies" ->
        deleteAllCookies(result)
      "removeSessionCookies" ->
        removeSessionCookies(result)
      "flush" ->
        flush(result)
      else -> result.notImplemented()
    }
  }

  open fun setCookie(url: String?,
                     name: String?,
                     value: String?,
                     domain: String?,
                     path: String?,
                     expiresDate: Long?,
                     maxAge: Int?,
                     isSecure: Boolean?,
                     isHttpOnly: Boolean?,
                     sameSite: String?,
                     result: MethodChannel.Result) {
    cookieManager = getCookieManager()
    val manager = cookieManager
    if (manager == null) {
      result.success(false)
      return
    }
    val plugin = this.plugin

    var cookieValue = name + "=" + value + "; Path=" + path

    if (domain != null)
      cookieValue += "; Domain=" + domain

    if (expiresDate != null)
      cookieValue += "; Expires=" + getCookieExpirationDate(expiresDate)

    if (maxAge != null)
      cookieValue += "; Max-Age=" + maxAge.toString()

    if (isSecure != null && isSecure)
      cookieValue += "; Secure"

    if (isHttpOnly != null && isHttpOnly)
      cookieValue += "; HttpOnly"

    if (sameSite != null)
      cookieValue += "; SameSite=" + sameSite

    cookieValue += ";"

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      manager.setCookie(url, cookieValue, ValueCallback<Boolean> { successful ->
        result.success(successful)
      })
      manager.flush()
    }
    else if (plugin != null) {
      val cookieSyncMngr = CookieSyncManager.createInstance(plugin.applicationContext)
      cookieSyncMngr.startSync()
      manager.setCookie(url, cookieValue)
      cookieSyncMngr.stopSync()
      cookieSyncMngr.sync()
      result.success(true)
    } else {
      manager.setCookie(url, cookieValue)
      result.success(true)
    }
  }

  open fun getCookies(url: String?): MutableList<MutableMap<String, Any?>> {

    val cookieListMap = ArrayList<MutableMap<String, Any?>>()

    cookieManager = getCookieManager()
    val manager = cookieManager
    if (manager == null) return cookieListMap

    var cookies: List<String> = ArrayList()
    if (WebViewFeature.isFeatureSupported(WebViewFeature.GET_COOKIE_INFO)) {
      cookies = CookieManagerCompat.getCookieInfo(manager, url!!)
    } else {
      val cookiesString = manager.getCookie(url)
      if (cookiesString != null) {
        cookies = Pattern.compile(";").split(cookiesString).asList()
      }
    }

    for (cookie in cookies) {
      val cookieParams = Pattern.compile(";").split(cookie)
      if (cookieParams.size == 0) continue

      val nameValue = cookieParams[0].split("=", limit = 2)
      val name = javaTrim(nameValue[0])
      val value = if (nameValue.size > 1) javaTrim(nameValue[1]) else ""

      val cookieMap = HashMap<String, Any?>()
      cookieMap["name"] = name
      cookieMap["value"] = value
      cookieMap["expiresDate"] = null
      cookieMap["isSessionOnly"] = null
      cookieMap["domain"] = null
      cookieMap["sameSite"] = null
      cookieMap["isSecure"] = null
      cookieMap["isHttpOnly"] = null
      cookieMap["path"] = null

      if (WebViewFeature.isFeatureSupported(WebViewFeature.GET_COOKIE_INFO)) {
        cookieMap["isSecure"] = false
        cookieMap["isHttpOnly"] = false

        for (i in 1 until cookieParams.size) {
          val cookieParamNameValue = cookieParams[i].split("=", limit = 2)
          val cookieParamName = javaTrim(cookieParamNameValue[0])
          val cookieParamValue = if (cookieParamNameValue.size > 1) javaTrim(cookieParamNameValue[1]) else ""

          if (cookieParamName.equals("Expires", ignoreCase = true)) {
            try {
              val sdf = SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss z", Locale.US)
              val expiryDate = sdf.parse(cookieParamValue)
              if (expiryDate != null) {
                cookieMap["expiresDate"] = expiryDate.time
              }
            } catch (e: ParseException) {
              Log.e(LOG_TAG, "", e)
            }
          } else if (cookieParamName.equals("Max-Age", ignoreCase = true)) {
            try {
              val maxAge = cookieParamValue.toLong()
              cookieMap["expiresDate"] = System.currentTimeMillis() + maxAge
            } catch (e: NumberFormatException) {
              Log.e(LOG_TAG, "", e)
            }
          } else if (cookieParamName.equals("Domain", ignoreCase = true)) {
            cookieMap["domain"] = cookieParamValue
          } else if (cookieParamName.equals("SameSite", ignoreCase = true)) {
            cookieMap["sameSite"] = cookieParamValue
          } else if (cookieParamName.equals("Secure", ignoreCase = true)) {
            cookieMap["isSecure"] = true
          } else if (cookieParamName.equals("HttpOnly", ignoreCase = true)) {
            cookieMap["isHttpOnly"] = true
          } else if (cookieParamName.equals("Path", ignoreCase = true)) {
            cookieMap["path"] = cookieParamValue
          }
        }
      }

      cookieListMap.add(cookieMap)
    }
    return cookieListMap

  }

  open fun deleteCookie(url: String?, name: String?, domain: String?, path: String?, result: MethodChannel.Result) {
    cookieManager = getCookieManager()
    val manager = cookieManager
    if (manager == null) {
      result.success(false)
      return
    }
    val plugin = this.plugin

    var cookieValue = name + "=; Path=" + path + "; Max-Age=-1"

    if (domain != null)
      cookieValue += "; Domain=" + domain

    cookieValue += ";"

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      manager.setCookie(url, cookieValue, ValueCallback<Boolean> { successful ->
        result.success(successful)
      })
      manager.flush()
    }
    else if (plugin != null) {
      val cookieSyncMngr = CookieSyncManager.createInstance(plugin.applicationContext)
      cookieSyncMngr.startSync()
      manager.setCookie(url, cookieValue)
      cookieSyncMngr.stopSync()
      cookieSyncMngr.sync()
      result.success(true)
    } else {
      manager.setCookie(url, cookieValue)
      result.success(true)
    }
  }

  open fun deleteCookies(url: String?, domain: String?, path: String?, result: MethodChannel.Result) {
    cookieManager = getCookieManager()
    val manager = cookieManager
    if (manager == null) {
      result.success(false)
      return
    }
    val plugin = this.plugin

    var cookieSyncMngr: CookieSyncManager? = null

    val cookiesString = manager.getCookie(url)
    if (cookiesString != null) {

      if (Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP && plugin != null) {
        cookieSyncMngr = CookieSyncManager.createInstance(plugin.applicationContext)
        cookieSyncMngr.startSync()
      }

      val cookies = Pattern.compile(";").split(cookiesString)
      for (cookie in cookies) {
        val nameValue = cookie.split("=", limit = 2)
        val name = javaTrim(nameValue[0])

        var cookieValue = name + "=; Path=" + path + "; Max-Age=-1"

        if (domain != null)
          cookieValue += "; Domain=" + domain

        cookieValue += ";"

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
          manager.setCookie(url, cookieValue, null)
        else
          manager.setCookie(url, cookieValue)
      }

      if (cookieSyncMngr != null) {
        cookieSyncMngr.stopSync()
        cookieSyncMngr.sync()
      } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
        manager.flush()
    }
    result.success(true)
  }

  open fun deleteAllCookies(result: MethodChannel.Result) {
    cookieManager = getCookieManager()
    val manager = cookieManager
    if (manager == null) {
      result.success(false)
      return
    }
    val plugin = this.plugin

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      manager.removeAllCookies(ValueCallback<Boolean> { successful ->
        result.success(successful)
      })
      manager.flush()
    }
    else if (plugin != null) {
      val cookieSyncMngr = CookieSyncManager.createInstance(plugin.applicationContext)
      cookieSyncMngr.startSync()
      manager.removeAllCookie()
      cookieSyncMngr.stopSync()
      cookieSyncMngr.sync()
      result.success(true)
    } else {
      manager.removeAllCookie()
      result.success(true)
    }
  }

  open fun removeSessionCookies(result: MethodChannel.Result) {
    cookieManager = getCookieManager()
    val manager = cookieManager
    if (manager == null) {
      result.success(false)
      return
    }
    val plugin = this.plugin

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      manager.removeSessionCookies(ValueCallback<Boolean> { successful ->
        result.success(successful)
      })
      manager.flush()
    }
    else if (plugin != null) {
      val cookieSyncMngr = CookieSyncManager.createInstance(plugin.applicationContext)
      cookieSyncMngr.startSync()
      manager.removeSessionCookie()
      cookieSyncMngr.stopSync()
      cookieSyncMngr.sync()
      result.success(true)
    } else {
      manager.removeSessionCookie()
      result.success(true)
    }
  }

  // NOTE: flush never calls result.success (same as the Java original)
  open fun flush(result: MethodChannel.Result) {
    cookieManager = getCookieManager()
    val manager = cookieManager
    if (manager == null) {
      result.success(false)
      return
    }
    val plugin = this.plugin
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      manager.flush()
    } else if (plugin != null) {
      val cookieSyncMngr = CookieSyncManager.createInstance(plugin.applicationContext)
      cookieSyncMngr.sync()
    }
  }

  override fun dispose() {
    super.dispose()
    plugin = null
  }

  companion object {
    protected const val LOG_TAG = "MyCookieManager"
    const val METHOD_CHANNEL_NAME = "com.github.aqutter/webview_cookiemanager"

    @JvmField
    var cookieManager: CookieManager? = null

    @JvmStatic
    fun init() {
      if (cookieManager == null) {
        cookieManager = getCookieManager()
      }
    }

    /**
     * Instantiating CookieManager will load the Chromium task taking a 100ish ms so we do it lazily
     * to make sure it's done on a background thread as needed.
     *
     * https://github.com/facebook/react-native/blob/1903f6680d9750e244d97c3cd4a9f755a9a47c61/ReactAndroid/src/main/java/com/facebook/react/modules/network/ForwardingCookieHandler.java#L132
     */
    private fun getCookieManager(): CookieManager? {
      if (cookieManager == null) {
        try {
          cookieManager = CookieManager.getInstance()
        } catch (ex: IllegalArgumentException) {
          // https://bugs.chromium.org/p/chromium/issues/detail?id=559720
          return null
        } catch (exception: Exception) {
          val message = exception.message
          // We cannot catch MissingWebViewPackageException as it is in a private / system API
          // class. This validates the exception's message to ensure we are only handling this
          // specific exception.
          // https://android.googlesource.com/platform/frameworks/base/+/master/core/java/android/webkit/WebViewFactory.java#348
          if (message != null
            && exception
              .javaClass
              .canonicalName
              .equals("android.webkit.WebViewFactory.MissingWebViewPackageException")) {
            return null
          } else {
            throw exception
          }
        }
      }

      return cookieManager
    }

    private fun javaTrim(s: String): String = s.trim { it <= ' ' }

    @JvmStatic
    fun getCookieExpirationDate(timestamp: Long): String {
      val sdf = SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss z", Locale.US)
      sdf.timeZone = TimeZone.getTimeZone("GMT")
      return sdf.format(Date(timestamp))
    }
  }
}
