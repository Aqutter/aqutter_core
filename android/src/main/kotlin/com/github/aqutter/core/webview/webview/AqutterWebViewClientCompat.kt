package com.github.aqutter.core.webview.webview

import android.annotation.SuppressLint
import android.graphics.Bitmap
import android.net.Uri
import android.net.http.SslError
import android.os.Build
import android.os.Message
import android.util.Log
import android.view.KeyEvent
import android.webkit.ClientCertRequest
import android.webkit.CookieManager
import android.webkit.CookieSyncManager
import android.webkit.HttpAuthHandler
import android.webkit.RenderProcessGoneDetail
import android.webkit.SslErrorHandler
import android.webkit.ValueCallback
import android.webkit.WebResourceRequest
import android.webkit.WebResourceResponse
import android.webkit.WebView
import androidx.annotation.RequiresApi
import androidx.webkit.SafeBrowsingResponseCompat
import androidx.webkit.WebResourceErrorCompat
import androidx.webkit.WebResourceRequestCompat
import androidx.webkit.WebViewClientCompat
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.Util
import com.github.aqutter.core.credential_database.CredentialDatabase
import com.github.aqutter.core.browser.AqutterBrowserDelegate
import com.github.aqutter.core.plugin_scripts_js.JavaScriptBridgeJS
import com.github.aqutter.core.types.ClientCertChallenge
import com.github.aqutter.core.types.ClientCertResponse
import com.github.aqutter.core.types.CustomSchemeResponse
import com.github.aqutter.core.types.HttpAuthResponse
import com.github.aqutter.core.types.HttpAuthenticationChallenge
import com.github.aqutter.core.types.NavigationAction
import com.github.aqutter.core.types.NavigationActionPolicy
import com.github.aqutter.core.types.SafeBrowsingResponse
import com.github.aqutter.core.types.ServerTrustAuthResponse
import com.github.aqutter.core.types.ServerTrustChallenge
import com.github.aqutter.core.types.URLCredential
import com.github.aqutter.core.types.URLProtectionSpace
import com.github.aqutter.core.types.URLRequest
import com.github.aqutter.core.types.WebResourceErrorExt
import com.github.aqutter.core.types.WebResourceRequestExt
import com.github.aqutter.core.types.WebResourceResponseExt
import com.github.aqutter.core.webview.WebViewChannelDelegate
import java.io.ByteArrayInputStream
import java.net.URI
import java.net.URISyntaxException
import java.util.Locale
import java.util.regex.Pattern

open class AqutterWebViewClientCompat(
  private var aqutterBrowserDelegate: AqutterBrowserDelegate?
) : WebViewClientCompat() {

  companion object {
    protected const val LOG_TAG = "IAWebViewClientCompat"
    private var previousAuthRequestFailureCount = 0
    private var credentialsProposed: MutableList<URLCredential>? = null
  }

  @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
  override fun shouldOverrideUrlLoading(view: WebView, request: WebResourceRequest): Boolean {
    val webView = view as AqutterWebView

    if (allowSyncUrlLoading(webView, request.url.toString())) {
      // Allow the request synchronously.
      return false
    }

    if (webView.customSettings.useShouldOverrideUrlLoading) {
      var isRedirect = false
      if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_RESOURCE_REQUEST_IS_REDIRECT)) {
        isRedirect = WebResourceRequestCompat.isRedirect(request)
      } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
        isRedirect = request.isRedirect
      }
      onShouldOverrideUrlLoading(
        webView,
        request.url.toString(),
        request.method,
        request.requestHeaders,
        request.isForMainFrame,
        request.hasGesture(),
        isRedirect)
    }
    val regexToCancelSubFramesLoading = webView.customSettings.regexToCancelSubFramesLoading
    if (regexToCancelSubFramesLoading != null && !request.isForMainFrame) {
      val m = regexToCancelSubFramesLoading.matcher(request.url.toString())
      return m.matches()
    }
    if (webView.customSettings.useShouldOverrideUrlLoading) {
      // There isn't any way to load an URL for a frame that is not the main frame,
      // so if the request is not for the main frame, the navigation is allowed.
      return request.isForMainFrame
    }

    return false
  }

  override fun shouldOverrideUrlLoading(view: WebView, url: String?): Boolean {
    val webView = view as AqutterWebView

    if (allowSyncUrlLoading(webView, url)) {
      // Allow the request synchronously.
      return false
    }

    if (webView.customSettings.useShouldOverrideUrlLoading) {
      onShouldOverrideUrlLoading(webView, url, "GET", null, true, false, false)
      return true
    }
    return false
  }

  private fun allowSyncUrlLoading(webView: AqutterWebView, url: String?): Boolean {
    val regexToAllowSyncUrlLoading = webView.customSettings.regexToAllowSyncUrlLoading
    if (regexToAllowSyncUrlLoading != null) {
      val m = regexToAllowSyncUrlLoading.matcher(url!!)
      if (m.matches()) {
        Log.d(LOG_TAG, "Request '" + url + "' automatically allowed as it is a match for 'regexToAllowSyncUrlLoading'.")
        return true
      }
    }
    return false
  }

  private fun allowShouldOverrideUrlLoading(
    webView: WebView, url: String?,
    headers: MutableMap<String, String>?,
    isForMainFrame: Boolean
  ) {
    if (isForMainFrame) {
      // There isn't any way to load an URL for a frame that is not the main frame,
      // so call this only on main frame.
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP && headers != null)
        webView.loadUrl(url!!, headers)
      else
        webView.loadUrl(url!!)
    }
  }

  open fun onShouldOverrideUrlLoading(
    webView: AqutterWebView, url: String?,
    method: String?,
    headers: MutableMap<String, String>?,
    isForMainFrame: Boolean, hasGesture: Boolean,
    isRedirect: Boolean
  ) {
    val request = URLRequest(url, method, null, headers)
    val navigationAction = NavigationAction(
      request,
      isForMainFrame,
      hasGesture,
      isRedirect
    )

    val callback = object : WebViewChannelDelegate.ShouldOverrideUrlLoadingCallback() {
      override fun nonNullSuccess(result: NavigationActionPolicy): Boolean {
        when (result) {
          NavigationActionPolicy.ALLOW ->
            allowShouldOverrideUrlLoading(webView, url, headers, isForMainFrame)
          NavigationActionPolicy.CANCEL -> {}
        }
        return false
      }

      override fun defaultBehaviour(result: NavigationActionPolicy?) {
        allowShouldOverrideUrlLoading(webView, url, headers, isForMainFrame)
      }

      override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
        defaultBehaviour(null)
      }
    }

    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.shouldOverrideUrlLoading(navigationAction, callback)
    } else {
      callback.defaultBehaviour(null)
    }
  }

  @SuppressLint("RestrictedApi")
  open fun loadCustomJavaScriptOnPageStarted(view: WebView) {
    val webView = view as AqutterWebView

    if (!WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT)) {
      val source = webView.userContentController.generateWrappedCodeForDocumentStart()
      webView.evaluateJavascript(source, null as ValueCallback<String>?)
    }
  }

  open fun loadCustomJavaScriptOnPageFinished(view: WebView) {
    val webView = view as AqutterWebView

    if (!WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT)) {
      val source = webView.userContentController.generateWrappedCodeForDocumentEnd()
      webView.evaluateJavascript(source, null as ValueCallback<String>?)
    }
  }

  override fun onPageStarted(view: WebView, url: String?, favicon: Bitmap?) {
    val webView = view as AqutterWebView
    webView.isLoading = true
    webView.disposeWebMessageChannels()
    webView.userContentController.resetContentWorlds()
    loadCustomJavaScriptOnPageStarted(webView)

    super.onPageStarted(view, url, favicon)

    if (aqutterBrowserDelegate != null) {
      aqutterBrowserDelegate!!.didStartNavigation(url)
    }

    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onLoadStart(url)
    }
  }

  override fun onPageFinished(view: WebView, url: String?) {
    val webView = view as AqutterWebView
    webView.isLoading = false
    loadCustomJavaScriptOnPageFinished(webView)
    previousAuthRequestFailureCount = 0
    credentialsProposed = null

    super.onPageFinished(view, url)

    if (aqutterBrowserDelegate != null) {
      aqutterBrowserDelegate!!.didFinishNavigation(url)
    }

    // WebView not storing cookies reliable to local device storage
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      CookieManager.getInstance().flush()
    } else {
      CookieSyncManager.getInstance().sync()
    }

    val js = JavaScriptBridgeJS.PLATFORM_READY_JS_SOURCE()
    webView.evaluateJavascript(js, null as ValueCallback<String>?)

    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onLoadStop(url)
    }
  }

  override fun doUpdateVisitedHistory(view: WebView, url: String?, isReload: Boolean) {
    super.doUpdateVisitedHistory(view, url, isReload)

    // url argument sometimes doesn't contain the new changed URL, so we get it again from the webview.
    val currentUrl: String? = view.url

    if (aqutterBrowserDelegate != null) {
      aqutterBrowserDelegate!!.didUpdateVisitedHistory(currentUrl)
    }

    val webView = view as AqutterWebView
    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onUpdateVisitedHistory(currentUrl, isReload)
    }
  }

  @RequiresApi(Build.VERSION_CODES.M)
  override fun onReceivedError(
    view: WebView,
    request: WebResourceRequest,
    error: WebResourceErrorCompat
  ) {
    val webView = view as AqutterWebView

    if (request.isForMainFrame) {
      if (webView.customSettings.disableDefaultErrorPage) {
        webView.stopLoading()
        webView.loadUrl("about:blank")
      }

      webView.isLoading = false
      previousAuthRequestFailureCount = 0
      credentialsProposed = null

      if (aqutterBrowserDelegate != null) {
        var type = -1
        if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_RESOURCE_ERROR_GET_CODE)) {
          type = error.errorCode
        }
        var description = ""
        if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_RESOURCE_ERROR_GET_DESCRIPTION)) {
          description = error.description.toString()
        }
        aqutterBrowserDelegate!!.didFailNavigation(request.url.toString(), type, description)
      }
    }

    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onReceivedError(
        WebResourceRequestExt.fromWebResourceRequest(request),
        WebResourceErrorExt.fromWebResourceError(error))
    }
  }

  @SuppressLint("RestrictedApi")
  override fun onReceivedError(view: WebView, errorCode: Int, description: String?, failingUrl: String?) {
    val webView = view as AqutterWebView

    if (webView.customSettings.disableDefaultErrorPage) {
      webView.stopLoading()
      webView.loadUrl("about:blank")
    }

    webView.isLoading = false
    previousAuthRequestFailureCount = 0
    credentialsProposed = null

    if (aqutterBrowserDelegate != null) {
      aqutterBrowserDelegate!!.didFailNavigation(failingUrl, errorCode, description)
    }

    val request = WebResourceRequestExt(
      failingUrl!!,
      null,
      false,
      false,
      true,
      "GET")

    val error = WebResourceErrorExt(
      errorCode,
      description!!
    )

    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onReceivedError(
        request,
        error)
    }

    super.onReceivedError(view, errorCode, description, failingUrl)
  }

  @RequiresApi(Build.VERSION_CODES.M)
  override fun onReceivedHttpError(
    view: WebView,
    request: WebResourceRequest,
    errorResponse: WebResourceResponse
  ) {
    super.onReceivedHttpError(view, request, errorResponse)

    val webView = view as AqutterWebView
    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onReceivedHttpError(
        WebResourceRequestExt.fromWebResourceRequest(request),
        WebResourceResponseExt.fromWebResourceResponse(errorResponse))
    }
  }

  override fun onReceivedHttpAuthRequest(view: WebView, handler: HttpAuthHandler, host: String?, realm: String?) {
    val url: String? = view.url
    var protocol: String? = "https"
    var port = 0

    if (url != null) {
      try {
        val uri = URI(url)
        protocol = uri.scheme
        port = uri.port
      } catch (e: URISyntaxException) {
        Log.e(LOG_TAG, "", e)
      }
    }

    previousAuthRequestFailureCount++

    if (credentialsProposed == null)
      credentialsProposed = CredentialDatabase.getInstance(view.context).getHttpAuthCredentials(host, protocol, realm, port)

    var credentialProposed: URLCredential? = null
    if (credentialsProposed != null && !credentialsProposed!!.isEmpty()) {
      credentialProposed = credentialsProposed!![0]
    }

    val protectionSpace = URLProtectionSpace(host, protocol, realm, port, view.certificate, null)
    val challenge = HttpAuthenticationChallenge(protectionSpace, previousAuthRequestFailureCount, credentialProposed)

    val webView = view as AqutterWebView
    val finalProtocol = protocol
    val finalPort = port
    val callback = object : WebViewChannelDelegate.ReceivedHttpAuthRequestCallback() {
      override fun nonNullSuccess(result: HttpAuthResponse): Boolean {
        val action = result.action
        if (action != null) {
          when (action) {
            1 -> {
              val username = result.username
              val password = result.password
              val permanentPersistence = result.isPermanentPersistence
              if (permanentPersistence) {
                CredentialDatabase.getInstance(view.context)
                  .setHttpAuthCredential(host, finalProtocol, realm, finalPort, username, password)
              }
              handler.proceed(username, password)
            }
            2 -> {
              if (!credentialsProposed!!.isEmpty()) {
                val credential = credentialsProposed!!.removeAt(0)
                handler.proceed(credential.username, credential.password)
              } else {
                handler.cancel()
              }
              // used custom CredentialDatabase!
              // handler.useHttpAuthUsernamePassword();
            }
            else -> {
              credentialsProposed = null
              previousAuthRequestFailureCount = 0
              handler.cancel()
            }
          }

          return false
        }

        return true
      }

      override fun defaultBehaviour(result: HttpAuthResponse?) {
        super@AqutterWebViewClientCompat.onReceivedHttpAuthRequest(view, handler, host, realm)
      }

      override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
        defaultBehaviour(null)
      }
    }

    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onReceivedHttpAuthRequest(challenge, callback)
    } else {
      callback.defaultBehaviour(null)
    }
  }

  override fun onReceivedSslError(view: WebView, handler: SslErrorHandler, sslError: SslError) {
    val url = sslError.url
    var host: String? = ""
    var protocol: String? = "https"
    var port = 0

    try {
      val uri = URI(url)
      host = uri.host
      protocol = uri.scheme
      port = uri.port
    } catch (e: URISyntaxException) {
      Log.e(LOG_TAG, "", e)
    }

    val protectionSpace = URLProtectionSpace(host, protocol, null, port, sslError.certificate, sslError)
    val challenge = ServerTrustChallenge(protectionSpace)

    val webView = view as AqutterWebView
    val callback = object : WebViewChannelDelegate.ReceivedServerTrustAuthRequestCallback() {
      override fun nonNullSuccess(result: ServerTrustAuthResponse): Boolean {
        val action = result.action
        if (action != null) {
          when (action) {
            1 -> handler.proceed()
            else -> handler.cancel()
          }

          return false
        }

        return true
      }

      override fun defaultBehaviour(result: ServerTrustAuthResponse?) {
        super@AqutterWebViewClientCompat.onReceivedSslError(view, handler, sslError)
      }

      override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
        defaultBehaviour(null)
      }
    }

    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onReceivedServerTrustAuthRequest(challenge, callback)
    } else {
      callback.defaultBehaviour(null)
    }
  }

  @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
  override fun onReceivedClientCertRequest(view: WebView, request: ClientCertRequest) {
    val url: String? = view.url
    val host = request.host
    var protocol: String? = "https"
    val port = request.port

    if (url != null) {
      try {
        val uri = URI(url)
        protocol = uri.scheme
      } catch (e: URISyntaxException) {
        Log.e(LOG_TAG, "", e)
      }
    }

    val protectionSpace = URLProtectionSpace(host, protocol, null, port, view.certificate, null)
    val challenge = ClientCertChallenge(protectionSpace, request.principals, request.keyTypes)

    val webView = view as AqutterWebView
    val callback = object : WebViewChannelDelegate.ReceivedClientCertRequestCallback() {
      override fun nonNullSuccess(result: ClientCertResponse): Boolean {
        val action = result.action
        val plugin = webView.plugin
        if (action != null && plugin != null) {
          when (action) {
            1 -> {
              val certificatePath: String = result.certificatePath
              val certificatePassword: String? = result.certificatePassword
              val keyStoreType: String = result.keyStoreType
              val privateKeyAndCertificates =
                Util.loadPrivateKeyAndCertificate(plugin, certificatePath, certificatePassword, keyStoreType)
              if (privateKeyAndCertificates != null) {
                request.proceed(privateKeyAndCertificates.privateKey, privateKeyAndCertificates.certificates)
              } else {
                request.cancel()
              }
            }
            2 -> request.ignore()
            else -> request.cancel()
          }

          return false
        }

        return true
      }

      override fun defaultBehaviour(result: ClientCertResponse?) {
        super@AqutterWebViewClientCompat.onReceivedClientCertRequest(view, request)
      }

      override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
        defaultBehaviour(null)
      }
    }

    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onReceivedClientCertRequest(challenge, callback)
    } else {
      callback.defaultBehaviour(null)
    }
  }

  override fun onScaleChanged(view: WebView, oldScale: Float, newScale: Float) {
    super.onScaleChanged(view, oldScale, newScale)
    val webView = view as AqutterWebView
    webView.zoomScale = newScale / Util.getPixelDensity(webView.context)

    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onZoomScaleChanged(oldScale, newScale)
    }
  }

  @RequiresApi(Build.VERSION_CODES.O_MR1)
  override fun onSafeBrowsingHit(
    view: WebView,
    request: WebResourceRequest,
    threatType: Int,
    callback: SafeBrowsingResponseCompat
  ) {
    val webView = view as AqutterWebView
    val resultCallback = object : WebViewChannelDelegate.SafeBrowsingHitCallback() {
      override fun nonNullSuccess(result: SafeBrowsingResponse): Boolean {
        val action = result.action
        if (action != null) {
          val report = result.isReport
          when (action) {
            0 -> {
              if (WebViewFeature.isFeatureSupported(WebViewFeature.SAFE_BROWSING_RESPONSE_BACK_TO_SAFETY)) {
                callback.backToSafety(report)
              } else {
                return true
              }
            }
            1 -> {
              if (WebViewFeature.isFeatureSupported(WebViewFeature.SAFE_BROWSING_RESPONSE_PROCEED)) {
                callback.proceed(report)
              } else {
                return true
              }
            }
            else -> {
              if (WebViewFeature.isFeatureSupported(WebViewFeature.SAFE_BROWSING_RESPONSE_SHOW_INTERSTITIAL)) {
                callback.showInterstitial(report)
              } else {
                return true
              }
            }
          }

          return false
        }

        return true
      }

      override fun defaultBehaviour(result: SafeBrowsingResponse?) {
        super@AqutterWebViewClientCompat.onSafeBrowsingHit(view, request, threatType, callback)
      }

      override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
        defaultBehaviour(null)
      }
    }

    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onSafeBrowsingHit(request.url.toString(), threatType, resultCallback)
    } else {
      resultCallback.defaultBehaviour(null)
    }
  }

  open fun shouldInterceptRequest(view: WebView, request: WebResourceRequestExt): WebResourceResponse? {
    val webView = view as AqutterWebView

    val assetLoaderExt = webView.webViewAssetLoaderExt
    val assetLoader = if (assetLoaderExt != null) assetLoaderExt.loader else null
    if (assetLoader != null) {
      try {
        val uri = Uri.parse(request.url)
        val webResourceResponse = assetLoader.shouldInterceptRequest(uri)
        if (webResourceResponse != null) {
          return webResourceResponse
        }
      } catch (e: Exception) {
        Log.e(LOG_TAG, "", e)
      }
    }

    if (webView.customSettings.useShouldInterceptRequest) {
      var response: WebResourceResponseExt? = null
      val channelDelegate = webView.channelDelegate
      if (channelDelegate != null) {
        try {
          response = channelDelegate.shouldInterceptRequest(request)
        } catch (e: InterruptedException) {
          Log.e(LOG_TAG, "", e)
          return null
        }
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

      return null
    }

    val url = request.url
    // Pattern.split keeps the exact semantics of Java's String.split (trailing empty strings removed)
    var scheme: String? = Pattern.compile(":").split(url)[0].lowercase(Locale.getDefault())
    try {
      scheme = Uri.parse(request.url).scheme
    } catch (ignored: Exception) {}

    val resourceCustomSchemes = webView.customSettings.resourceCustomSchemes
    if (resourceCustomSchemes != null && scheme != null && resourceCustomSchemes.contains(scheme)) {
      var customSchemeResponse: CustomSchemeResponse? = null
      val channelDelegate = webView.channelDelegate
      if (channelDelegate != null) {
        try {
          customSchemeResponse = channelDelegate.onLoadResourceWithCustomScheme(request)
        } catch (e: InterruptedException) {
          Log.e(LOG_TAG, "", e)
          return null
        }
      }

      if (customSchemeResponse != null) {
        var response: WebResourceResponse? = null
        try {
          response = webView.contentBlockerHandler.checkUrl(webView, request, customSchemeResponse.contentType)
        } catch (e: Exception) {
          Log.e(LOG_TAG, "", e)
        }
        if (response != null)
          return response
        // NOTE: contentType is passed for both the mime type and the encoding arguments (the encoding is
        // customSchemeResponse.contentEncoding); preserved from the Java source.
        return WebResourceResponse(customSchemeResponse.contentType,
          customSchemeResponse.contentType,
          ByteArrayInputStream(customSchemeResponse.data))
      }
    }

    var response: WebResourceResponse? = null
    if (!webView.contentBlockerHandler.getRuleList().isEmpty()) {
      try {
        response = webView.contentBlockerHandler.checkUrl(webView, request)
      } catch (e: Exception) {
        Log.e(LOG_TAG, "", e)
      }
    }
    return response
  }

  override fun shouldInterceptRequest(view: WebView, url: String?): WebResourceResponse? {
    val requestExt = WebResourceRequestExt(
      url!!, null, false,
      false, true, "GET"
    )
    return shouldInterceptRequest(view, requestExt)
  }

  @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
  override fun shouldInterceptRequest(view: WebView, request: WebResourceRequest): WebResourceResponse? {
    val requestExt = WebResourceRequestExt.fromWebResourceRequest(request)
    return shouldInterceptRequest(view, requestExt)
  }

  override fun onFormResubmission(view: WebView, dontResend: Message, resend: Message) {
    val webView = view as AqutterWebView
    val callback = object : WebViewChannelDelegate.FormResubmissionCallback() {
      override fun nonNullSuccess(result: Int): Boolean {
        when (result) {
          0 -> resend.sendToTarget()
          else -> dontResend.sendToTarget()
        }
        return false
      }

      override fun defaultBehaviour(result: Int?) {
        super@AqutterWebViewClientCompat.onFormResubmission(view, dontResend, resend)
      }

      override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
        defaultBehaviour(null)
      }
    }

    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onFormResubmission(webView.url, callback)
    } else {
      callback.defaultBehaviour(null)
    }
  }

  override fun onPageCommitVisible(view: WebView, url: String) {
    super.onPageCommitVisible(view, url)

    val webView = view as AqutterWebView
    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onPageCommitVisible(url)
    }
  }

  @RequiresApi(Build.VERSION_CODES.O)
  override fun onRenderProcessGone(view: WebView, detail: RenderProcessGoneDetail): Boolean {
    val webView = view as AqutterWebView

    val channelDelegate = webView.channelDelegate
    if (webView.customSettings.useOnRenderProcessGone && channelDelegate != null) {
      val didCrash = detail.didCrash()
      val rendererPriorityAtExit = detail.rendererPriorityAtExit()
      channelDelegate.onRenderProcessGone(didCrash, rendererPriorityAtExit)
      return true
    }

    return super.onRenderProcessGone(view, detail)
  }

  override fun onReceivedLoginRequest(view: WebView, realm: String?, account: String?, args: String?) {
    val webView = view as AqutterWebView
    val channelDelegate = webView.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onReceivedLoginRequest(realm, account, args)
    }
  }

  override fun onUnhandledKeyEvent(view: WebView, event: KeyEvent) {}

  open fun dispose() {
    if (aqutterBrowserDelegate != null) {
      aqutterBrowserDelegate = null
    }
  }
}
