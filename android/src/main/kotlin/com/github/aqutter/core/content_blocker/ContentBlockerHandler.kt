package com.github.aqutter.core.content_blocker

import android.os.Build
import android.os.Handler
import android.text.TextUtils
import android.util.Log
import android.webkit.WebResourceResponse
import com.github.aqutter.core.Util
import com.github.aqutter.core.plugin_scripts_js.JavaScriptBridgeJS
import com.github.aqutter.core.types.WebResourceRequestExt
import com.github.aqutter.core.webview.webview.AqutterWebView
import java.io.ByteArrayInputStream
import java.io.InputStream
import java.net.HttpURLConnection
import java.net.MalformedURLException
import java.net.URI
import java.net.URISyntaxException
import java.net.URL
import java.util.concurrent.CopyOnWriteArrayList
import java.util.concurrent.CountDownLatch
import javax.net.ssl.SSLHandshakeException

open class ContentBlockerHandler() {
  @JvmField
  protected var ruleList: MutableList<ContentBlocker> = ArrayList()

  constructor(ruleList: MutableList<ContentBlocker>) : this() {
    this.ruleList = ruleList
  }

  fun getRuleList(): MutableList<ContentBlocker> {
    return this.ruleList
  }

  fun setRuleList(newRuleList: MutableList<ContentBlocker>) {
    this.ruleList = newRuleList
  }

  @Throws(URISyntaxException::class, InterruptedException::class, MalformedURLException::class)
  fun checkUrl(
    webView: AqutterWebView, request: WebResourceRequestExt,
    responseResourceType: ContentBlockerTriggerResourceType
  ): WebResourceResponse? {
    if (webView.customSettings.contentBlockers == null)
      return null

    val url = request.url

    val u: URI = try {
      URI(url)
    } catch (e: URISyntaxException) {
      val urlSplit = javaSplit(url, ":")
      val scheme = urlSplit[0]
      val tempUrl = URL(url.replace(scheme, "https"))
      URI(scheme, tempUrl.userInfo, tempUrl.host, tempUrl.port, tempUrl.path, tempUrl.query, tempUrl.ref)
    }
    val host = u.host
    val port = u.port
    val scheme = u.scheme
    // thread safe copy list
    val ruleListCopy: List<ContentBlocker> = CopyOnWriteArrayList(ruleList)

    for (contentBlocker in ruleListCopy) {
      val trigger = contentBlocker.trigger
      val resourceTypes = trigger.resourceType
      if (resourceTypes.contains(ContentBlockerTriggerResourceType.IMAGE) && !resourceTypes.contains(ContentBlockerTriggerResourceType.SVG_DOCUMENT)) {
        resourceTypes.add(ContentBlockerTriggerResourceType.SVG_DOCUMENT)
      }

      val action = contentBlocker.action

      val m = trigger.urlFilterPatternCompiled.matcher(url)
      if (m.matches()) {

        if (!resourceTypes.isEmpty() && !resourceTypes.contains(responseResourceType)) {
          return null
        }
        if (!trigger.ifDomain.isEmpty()) {
          var matchFound = false
          for (domain in trigger.ifDomain) {
            if ((domain.startsWith("*") && host.endsWith(domain.replace("*", ""))) || domain == host) {
              matchFound = true
              break
            }
          }
          if (!matchFound)
            return null
        }
        if (!trigger.unlessDomain.isEmpty()) {
          for (domain in trigger.unlessDomain)
            if ((domain.startsWith("*") && host.endsWith(domain.replace("*", ""))) || domain == host)
              return null
        }

        val webViewUrl = arrayOfNulls<String>(1)
        if (!trigger.loadType.isEmpty() || !trigger.ifTopUrl.isEmpty() || !trigger.unlessTopUrl.isEmpty()) {
          val latch = CountDownLatch(1)
          val handler = Handler(webView.webViewLooper)
          handler.post(Runnable {
            webViewUrl[0] = webView.url
            latch.countDown()
          })
          latch.await()
        }

        val currentWebViewUrl = webViewUrl[0]
        if (currentWebViewUrl != null) {
          if (!trigger.loadType.isEmpty()) {
            val cUrl = URI(currentWebViewUrl)
            val cHost = cUrl.host
            val cPort = cUrl.port
            val cScheme = cUrl.scheme

            if ((trigger.loadType.contains("first-party") && cHost != null && !(cScheme == scheme && cHost == host && cPort == port)) ||
              (trigger.loadType.contains("third-party") && cHost != null && cHost == host))
              return null
          }
          if (!trigger.ifTopUrl.isEmpty()) {
            var matchFound = false
            for (topUrl in trigger.ifTopUrl) {
              if (currentWebViewUrl.startsWith(topUrl)) {
                matchFound = true
                break
              }
            }
            if (!matchFound)
              return null
          }
          if (!trigger.unlessTopUrl.isEmpty()) {
            for (topUrl in trigger.unlessTopUrl)
              if (currentWebViewUrl.startsWith(topUrl))
                return null
          }
        }

        when (action.type) {

          ContentBlockerActionType.BLOCK ->
            return WebResourceResponse("", "", null)

          ContentBlockerActionType.CSS_DISPLAY_NONE -> {
            val cssSelector = action.selector
            val jsScript = "(function(d) { " +
              "   function hide () { " +
              "       if (d.body != null && !d.getElementById('" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "-css-display-none-style')) { " +
              "           var c = d.createElement('style'); " +
              "           c.id = '" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "-css-display-none-style'; " +
              "           c.innerHTML = '" + cssSelector + " { display: none !important; }'; " +
              "           d.body.appendChild(c); " +
              "       }" +
              "       d.querySelectorAll('" + cssSelector + "').forEach(function (item, index) { " +
              "           item.setAttribute('style', 'display: none !important;'); " +
              "       }); " +
              "   }; " +
              "   hide(); " +
              "   d.addEventListener('DOMContentLoaded', function(event) { hide(); }); " +
              "})(document);"

            val handler = Handler(webView.webViewLooper)
            handler.postDelayed(Runnable {
              if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                webView.evaluateJavascript(jsScript, null)
              } else {
                webView.loadUrl("javascript:" + jsScript)
              }
            }, 800)
          }

          ContentBlockerActionType.MAKE_HTTPS -> {
            if (scheme == "http" && (port == -1 || port == 80)) {
              val urlHttps = url.replace("http://", "https://")

              val urlConnection = Util.makeHttpRequest(urlHttps, request.method, request.headers)
              if (urlConnection != null) {
                try {
                  val dataBytes = Util.readAllBytes(urlConnection.inputStream)
                  if (dataBytes == null) {
                    return null
                  }
                  val dataStream: InputStream = ByteArrayInputStream(dataBytes)

                  var encoding: String? = urlConnection.contentEncoding
                  var contentType: String? = urlConnection.contentType
                  if (contentType == null) {
                    contentType = "text/plain"
                  } else {
                    val contentTypeSplit = javaSplit(contentType, ";")
                    contentType = contentTypeSplit[0].trim()
                    if (encoding == null) {
                      encoding = if (contentTypeSplit.size > 1 && contentTypeSplit[1].contains("charset="))
                        contentTypeSplit[1].replace("charset=", "").trim()
                      else
                        "utf-8"
                    }
                  }

                  val reasonPhrase = urlConnection.responseMessage
                  if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP && reasonPhrase != null) {
                    val responseHeaders: MutableMap<String, String> = HashMap()
                    for (responseHeader in urlConnection.headerFields.entries) {
                      responseHeaders.put(responseHeader.key, TextUtils.join(",", responseHeader.value))
                    }
                    return WebResourceResponse(
                      contentType,
                      encoding,
                      urlConnection.responseCode,
                      reasonPhrase,
                      responseHeaders,
                      dataStream
                    )
                  } else {
                    return WebResourceResponse(
                      contentType,
                      encoding,
                      dataStream
                    )
                  }
                } catch (e: Exception) {
                  if (e !is SSLHandshakeException) {
                    Log.e(LOG_TAG, "", e)
                  }
                } finally {
                  urlConnection.disconnect()
                }
              }

//                            Request mRequest = new Request.Builder().url(urlHttps).build();
//                            Response response = null;
//
//                            try {
//                                response = Util.getBasicOkHttpClient().newCall(mRequest).execute();
//                                byte[] dataBytes = response.body().bytes();
//                                InputStream dataStream = new ByteArrayInputStream(dataBytes);
//
//                                String[] contentTypeSplit = response.header("content-type", "text/plain").split(";");
//
//                                String contentType = contentTypeSplit[0].trim();
//                                String encoding = (contentTypeSplit.length > 1 && contentTypeSplit[1].contains("charset="))
//                                        ? contentTypeSplit[1].replace("charset=", "").trim()
//                                        : "utf-8";
//
//                                response.body().close();
//                                response.close();
//
//                                return new WebResourceResponse(contentType, encoding, dataStream);
//
//                            } catch (Exception e) {
//                                if (response != null) {
//                                    response.body().close();
//                                    response.close();
//                                }
//                                if (!(e instanceof SSLHandshakeException)) {
//                                    Log.e(LOG_TAG, "", e);
//                                }
//                            }
            }
          }
        }
      }
    }
    return null
  }

  @Throws(URISyntaxException::class, InterruptedException::class, MalformedURLException::class)
  fun checkUrl(webView: AqutterWebView, request: WebResourceRequestExt): WebResourceResponse? {
    val responseResourceType = getResourceTypeFromUrl(request)
    return checkUrl(webView, request, responseResourceType)
  }

  @Throws(URISyntaxException::class, InterruptedException::class, MalformedURLException::class)
  fun checkUrl(webView: AqutterWebView, request: WebResourceRequestExt, contentType: String): WebResourceResponse? {
    val responseResourceType = getResourceTypeFromContentType(contentType)
    return checkUrl(webView, request, responseResourceType)
  }

  fun getResourceTypeFromUrl(request: WebResourceRequestExt): ContentBlockerTriggerResourceType {
    var responseResourceType = ContentBlockerTriggerResourceType.RAW
    val url = request.url

    if (url.startsWith("http://") || url.startsWith("https://")) {
      // make an HTTP "HEAD" request to the server for that URL. This will not return the full content of the URL.
      val urlConnection = Util.makeHttpRequest(url, "HEAD", request.headers)
      if (urlConnection != null) {
        try {
          var contentType: String? = urlConnection.contentType
          if (contentType != null) {
            val contentTypeSplit = javaSplit(contentType, ";")
            contentType = contentTypeSplit[0].trim()
            responseResourceType = getResourceTypeFromContentType(contentType)
          }
        } catch (e: Exception) {
          Log.e(LOG_TAG, "", e)
        } finally {
          urlConnection.disconnect()
        }
      }
    }
    return responseResourceType
  }

  fun getResourceTypeFromContentType(contentType: String): ContentBlockerTriggerResourceType {
    var responseResourceType = ContentBlockerTriggerResourceType.RAW

    // https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types
    if (contentType == "text/css") {
      responseResourceType = ContentBlockerTriggerResourceType.STYLE_SHEET
    } else if (contentType == "image/svg+xml") {
      responseResourceType = ContentBlockerTriggerResourceType.SVG_DOCUMENT
    } else if (contentType.startsWith("image/")) {
      responseResourceType = ContentBlockerTriggerResourceType.IMAGE
    } else if (contentType.startsWith("font/")) {
      responseResourceType = ContentBlockerTriggerResourceType.FONT
    } else if (contentType.startsWith("audio/") || contentType.startsWith("video/") || contentType == "application/ogg") {
      responseResourceType = ContentBlockerTriggerResourceType.MEDIA
    } else if (contentType.endsWith("javascript")) {
      responseResourceType = ContentBlockerTriggerResourceType.SCRIPT
    } else if (contentType.startsWith("text/")) {
      responseResourceType = ContentBlockerTriggerResourceType.DOCUMENT
    }

    return responseResourceType
  }

  companion object {
    protected const val LOG_TAG = "ContentBlockerHandler"

    // 對應 Java String.split(regex) 的語意（無匹配時回傳原字串、去除尾端空字串）
    private fun javaSplit(value: String, delimiter: String): Array<String> {
      val parts = value.split(delimiter.toRegex())
      if (parts.size == 1) return arrayOf(value)
      return parts.dropLastWhile { it.isEmpty() }.toTypedArray()
    }
  }
}
