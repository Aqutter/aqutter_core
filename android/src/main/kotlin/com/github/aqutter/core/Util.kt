package com.github.aqutter.core

import android.content.Context
import android.graphics.BitmapFactory
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.net.http.SslCertificate
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.text.TextUtils
import android.util.DisplayMetrics
import android.util.Log
import android.view.WindowInsets
import android.view.WindowManager
import androidx.annotation.RequiresApi
import com.github.aqutter.core.types.Size2D
import com.github.aqutter.core.types.SyncBaseCallbackResultImpl
import io.flutter.plugin.common.MethodChannel
import org.json.JSONArray
import org.json.JSONObject
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.io.FileInputStream
import java.io.IOException
import java.io.InputStream
import java.lang.reflect.InvocationTargetException
import java.net.HttpURLConnection
import java.net.Inet6Address
import java.net.InetAddress
import java.net.URL
import java.net.UnknownHostException
import java.security.Key
import java.security.KeyStore
import java.security.PrivateKey
import java.security.cert.Certificate
import java.security.cert.CertificateException
import java.security.cert.CertificateFactory
import java.security.cert.X509Certificate
import java.util.Objects
import java.util.regex.Pattern
import javax.net.ssl.SSLHandshakeException

open class Util private constructor() {

  class PrivateKeyAndCertificates(
    @JvmField var privateKey: PrivateKey,
    @JvmField var certificates: Array<X509Certificate?>
  )

  companion object {
    const val LOG_TAG = "Util" // package-private in Java
    const val ANDROID_ASSET_URL = "file:///android_asset/"

    @JvmStatic
    @Throws(IOException::class)
    fun getUrlAsset(plugin: AqutterCorePlugin, assetFilePath: String): String {
      val key = plugin.flutterAssets.getAssetFilePathByName(assetFilePath)
      var inputStream: InputStream? = null
      var e: IOException? = null

      try {
        inputStream = getFileAsset(plugin, assetFilePath)
      } catch (ex: IOException) {
        e = ex
      } finally {
        val stream = inputStream
        if (stream != null) {
          try {
            stream.close()
          } catch (ex: IOException) {
            e = ex
          }
        }
      }
      if (e != null) {
        throw e
      }

      return ANDROID_ASSET_URL + key
    }

    @JvmStatic
    @Throws(IOException::class)
    fun getFileAsset(plugin: AqutterCorePlugin, assetFilePath: String): InputStream {
      val key = plugin.flutterAssets.getAssetFilePathByName(assetFilePath)
      val mg = plugin.applicationContext.resources.assets
      return mg.open(key)
    }

    @JvmStatic
    @Throws(InterruptedException::class)
    @Suppress("UNCHECKED_CAST")
    fun <T> invokeMethodAndWaitResult(channel: MethodChannel,
                                      method: String, arguments: Any?,
                                      callback: SyncBaseCallbackResultImpl<T>): T {
      val handler = Handler(Looper.getMainLooper())
      handler.post {
        channel.invokeMethod(method, arguments, callback)
      }
      callback.latch.await()
      return callback.result as T
    }

    @JvmStatic
    fun loadPrivateKeyAndCertificate(plugin: AqutterCorePlugin,
                                     certificatePath: String,
                                     certificatePassword: String?,
                                     keyStoreType: String): PrivateKeyAndCertificates? {
      var privateKeyAndCertificates: PrivateKeyAndCertificates? = null
      var certificateFileStream: InputStream? = null

      try {
        certificateFileStream = getFileAsset(plugin, certificatePath)
      } catch (ignored: IOException) {}

      try {
        if (certificateFileStream == null) {
          certificateFileStream = FileInputStream(certificatePath)
        }
        val keyStore = KeyStore.getInstance(keyStoreType)
        keyStore.load(certificateFileStream, (certificatePassword ?: "").toCharArray())

        val aliases = keyStore.aliases()
        val alias = aliases.nextElement()

        val key: Key? = keyStore.getKey(alias, (certificatePassword ?: "").toCharArray())
        if (key is PrivateKey) {
          val privateKey: PrivateKey = key
          val cert: Certificate? = keyStore.getCertificate(alias)
          val certificates = arrayOfNulls<X509Certificate>(1)
          certificates[0] = cert as X509Certificate?
          privateKeyAndCertificates = PrivateKeyAndCertificates(privateKey, certificates)
        }
        certificateFileStream.close()
      } catch (e: Exception) {
        Log.e(LOG_TAG, "", e)
      } finally {
        val stream = certificateFileStream
        if (stream != null) {
          try {
            stream.close()
          } catch (ex: IOException) {
            Log.e(LOG_TAG, "", ex)
          }
        }
      }

      return privateKeyAndCertificates
    }

    @JvmStatic
    fun makeHttpRequest(urlString: String?, method: String?, headers: Map<String, String>?): HttpURLConnection? {
      var urlConnection: HttpURLConnection? = null
      try {
        val url = URL(urlString)
        urlConnection = url.openConnection() as HttpURLConnection
        urlConnection.requestMethod = method
        if (headers != null) {
          for (header in headers.entries) {
            urlConnection.setRequestProperty(header.key, header.value)
          }
        }
        urlConnection.connectTimeout = 15000 // 15 seconds
        urlConnection.readTimeout = 15000 // 15 seconds
        urlConnection.doInput = true
        urlConnection.instanceFollowRedirects = true
        if ("GET".equals(method, ignoreCase = true)) {
          urlConnection.doOutput = false
        }
        urlConnection.connect()
        return urlConnection
      }
      catch (e: Exception) {
        if (e !is SSLHandshakeException) {
          Log.e(LOG_TAG, "", e)
        }
        if (urlConnection != null) {
          urlConnection.disconnect()
        }
      }
      return null
    }

    /**
     * SslCertificate class does not has a public getter for the underlying
     * X509Certificate, we can only do this by hack. This only works for Android 4.0+
     * https://groups.google.com/forum/#!topic/android-developers/eAPJ6b7mrmg
     */
    @JvmStatic
    fun getX509CertFromSslCertHack(sslCert: SslCertificate): X509Certificate? {
      var x509Certificate: X509Certificate? = null

      val bundle = SslCertificate.saveState(sslCert)
      val bytes = bundle.getByteArray("x509-certificate")

      if (bytes == null) {
        x509Certificate = null
      } else {
        try {
          val certFactory = CertificateFactory.getInstance("X.509")
          val cert = certFactory.generateCertificate(ByteArrayInputStream(bytes))
          x509Certificate = cert as X509Certificate
        } catch (e: CertificateException) {
          x509Certificate = null
        }
      }

      return x509Certificate
    }

    @JvmStatic
    @RequiresApi(api = Build.VERSION_CODES.KITKAT)
    @Suppress("UNCHECKED_CAST")
    fun JSONStringify(value: Any?): String {
      if (value == null) {
        return "null"
      }
      if (value is Map<*, *>) {
        return JSONObject(value as Map<String, Any?>).toString()
      } else if (value is List<*>) {
        return JSONArray(value as List<Any?>).toString()
      } else if (value is String) {
        return JSONObject.quote(value)
      } else {
        return JSONObject.wrap(value)!!.toString()
      }
    }

    @JvmStatic
    fun objEquals(a: Any?, b: Any?): Boolean {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
        return Objects.equals(a, b)
      }
      return (a === b) || (a != null && a == b)
    }

    @JvmStatic
    fun replaceAll(s: String, oldString: String, newString: String): String {
      return TextUtils.join(newString, Pattern.compile(Pattern.quote(oldString)).split(s))
    }

    @JvmStatic
    fun log(tag: String, message: String) {
      // Split by line, then ensure each line can fit into Log's maximum length.
      var i = 0
      val length = message.length
      while (i < length) {
        var newline = message.indexOf('\n', i)
        newline = if (newline != -1) newline else length
        do {
          val end = Math.min(newline, i + 4000)
          Log.d(tag, message.substring(i, end))
          i = end
        } while (i < newline)
        i++
      }
    }

    @JvmStatic
    fun getPixelDensity(context: Context): Float {
      return context.resources.displayMetrics.density
    }

    @JvmStatic
    fun getFullscreenSize(context: Context): Size2D {
      val fullscreenSize = Size2D(-1.0, -1.0)
      val wm = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager?
      if (wm != null) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
          val metrics = wm.currentWindowMetrics
          // Gets all excluding insets
          val windowInsets = metrics.windowInsets
          val insets = windowInsets.getInsetsIgnoringVisibility(WindowInsets.Type.navigationBars()
            or WindowInsets.Type.displayCutout())
          val insetsWidth = insets.right + insets.left
          val insetsHeight = insets.top + insets.bottom
          val bounds = metrics.bounds
          fullscreenSize.width = (bounds.width() - insetsWidth).toDouble()
          fullscreenSize.height = (bounds.height() - insetsHeight).toDouble()
        } else {
          val displayMetrics = DisplayMetrics()
          wm.defaultDisplay.getMetrics(displayMetrics)
          fullscreenSize.width = displayMetrics.widthPixels.toDouble()
          fullscreenSize.height = displayMetrics.heightPixels.toDouble()
        }
      }
      return fullscreenSize
    }

    @JvmStatic
    fun isClass(className: String): Boolean {
      try {
        Class.forName(className)
        return true
      } catch (e: ClassNotFoundException) {
        return false
      }
    }

    // NOTE: InetAddress.getByName also resolves host names, so this does not strictly test for IPv6 (same as the Java original)
    @JvmStatic
    fun isIPv6(address: String): Boolean {
      try {
        InetAddress.getByName(address)
      } catch (e: UnknownHostException) {
        return false
      }
      return true
    }

    @JvmStatic
    @Throws(Exception::class)
    fun normalizeIPv6(address: String): String {
      if (!Util.isIPv6(address)) {
        throw Exception("Invalid address: " + address)
      }
      return InetAddress.getByName(address).canonicalHostName
    }

    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun <T> getOrDefault(map: Map<String, Any?>, key: String, defaultValue: T): T {
      return if (map.containsKey(key)) (map.get(key) as T) else defaultValue
    }

    @JvmStatic
    fun readAllBytes(inputStream: InputStream?): ByteArray? {
      if (inputStream == null) {
        return null
      }

      val bufLen = 4 * 0x400 // 4KB
      val buf = ByteArray(bufLen)
      var readLen: Int
      var exception: IOException? = null
      val outputStream = ByteArrayOutputStream()
      var data: ByteArray? = null

      try {
        while (true) {
          readLen = inputStream.read(buf, 0, bufLen)
          if (readLen == -1) break
          outputStream.write(buf, 0, readLen)
        }

        data = outputStream.toByteArray()
      } catch (e: IOException) {
        exception = e
      } finally {
        try {
          inputStream.close()
        } catch (e: IOException) {
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT && exception != null) {
            exception.addSuppressed(e)
          }
        }
        try {
          outputStream.close()
        } catch (e: IOException) {
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT && exception != null) {
            exception.addSuppressed(e)
          }
        }
      }
      return data
    }

    @JvmStatic
    fun <O : Any> invokeMethodIfExists(o: O, methodName: String, vararg args: Any?): Any? {
      val methods = o.javaClass.methods
      for (method in methods) {
        if (method.name == methodName) {
          try {
            return method.invoke(o, *args)
          } catch (e: IllegalAccessException) {
            return null
          } catch (e: InvocationTargetException) {
            return null
          }
        }
      }
      return null
    }

    @JvmStatic
    fun drawableFromBytes(context: Context, data: ByteArray): Drawable {
      return BitmapDrawable(context.resources, BitmapFactory.decodeByteArray(data, 0, data.size))
    }
  }
}
