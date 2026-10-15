package com.github.aqutter.core.webview.webview

import android.Manifest
import android.annotation.TargetApi
import android.app.Activity
import android.app.Activity.RESULT_OK
import android.content.DialogInterface
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Color
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.os.Message
import android.os.Parcelable
import android.provider.MediaStore
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import android.webkit.ConsoleMessage
import android.webkit.GeolocationPermissions
import android.webkit.JsPromptResult
import android.webkit.JsResult
import android.webkit.MimeTypeMap
import android.webkit.PermissionRequest
import android.webkit.ValueCallback
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.widget.EditText
import android.widget.FrameLayout
import android.widget.LinearLayout
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AlertDialog
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import com.github.aqutter.core.AqutterWebViewFileProvider
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.browser.ActivityResultListener
import com.github.aqutter.core.browser.AqutterBrowserDelegate
import com.github.aqutter.core.types.CreateWindowAction
import com.github.aqutter.core.types.GeolocationPermissionShowPromptResponse
import com.github.aqutter.core.types.JsAlertResponse
import com.github.aqutter.core.types.JsBeforeUnloadResponse
import com.github.aqutter.core.types.JsConfirmResponse
import com.github.aqutter.core.types.JsPromptResponse
import com.github.aqutter.core.types.PermissionResponse
import com.github.aqutter.core.types.ShowFileChooserRequest
import com.github.aqutter.core.types.ShowFileChooserResponse
import com.github.aqutter.core.types.URLRequest
import com.github.aqutter.core.webview.WebViewChannelDelegate
import io.flutter.plugin.common.PluginRegistry
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.IOException
import java.util.Arrays
import java.util.Locale

class AqutterWebViewChromeClient(
  plugin: AqutterCorePlugin,
  aqutterWebView: AqutterWebView,
  aqutterBrowserDelegate: AqutterBrowserDelegate?
) : WebChromeClient(), PluginRegistry.ActivityResultListener, ActivityResultListener {

  companion object {
    protected const val LOG_TAG = "IABWebChromeClient"

    private const val PICKER = 1
    private const val PICKER_LEGACY = 3

    @JvmField
    protected val FULLSCREEN_LAYOUT_PARAMS = FrameLayout.LayoutParams(
      ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT, Gravity.CENTER)

    @RequiresApi(api = Build.VERSION_CODES.KITKAT)
    protected const val FULLSCREEN_SYSTEM_UI_VISIBILITY_KITKAT = View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION or
      View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or
      View.SYSTEM_UI_FLAG_LAYOUT_STABLE or
      View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or
      View.SYSTEM_UI_FLAG_FULLSCREEN or
      View.SYSTEM_UI_FLAG_IMMERSIVE or
      View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY

    protected const val FULLSCREEN_SYSTEM_UI_VISIBILITY = View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION or
      View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or
      View.SYSTEM_UI_FLAG_LAYOUT_STABLE or
      View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or
      View.SYSTEM_UI_FLAG_FULLSCREEN
  }

  private var aqutterBrowserDelegate: AqutterBrowserDelegate? = aqutterBrowserDelegate

  // package-private in Java
  @JvmField
  val DEFAULT_MIME_TYPES: String = "*/*"

  // package-private in Java
  @JvmField
  val dialogs: MutableMap<DialogInterface, JsResult> = HashMap()

  private var mCustomView: View? = null
  private var mCustomViewCallback: CustomViewCallback? = null
  private var mOriginalOrientation = 0
  private var mOriginalSystemUiVisibility = 0

  @JvmField
  var plugin: AqutterCorePlugin? = plugin

  @JvmField
  var aqutterWebView: AqutterWebView? = aqutterWebView

  private var filePathCallbackLegacy: ValueCallback<Uri>? = null
  private var filePathCallback: ValueCallback<Array<Uri>>? = null
  private var videoOutputFileUri: Uri? = null
  private var imageOutputFileUri: Uri? = null

  init {
    if (this.aqutterBrowserDelegate != null) {
      this.aqutterBrowserDelegate!!.getActivityResultListeners()!!.add(this)
    }

    if (plugin.activityPluginBinding != null)
      plugin.activityPluginBinding!!.addActivityResultListener(this)
  }

  override fun getDefaultVideoPoster(): Bitmap? {
    val webView = aqutterWebView
    if (webView != null && webView.customSettings.defaultVideoPoster != null) {
      val data: ByteArray = webView.customSettings.defaultVideoPoster!!
      val bitmapOptions = BitmapFactory.Options()
      bitmapOptions.inMutable = true
      return BitmapFactory.decodeByteArray(
        data, 0, data.size, bitmapOptions
      )
    }
    return Bitmap.createBitmap(50, 50, Bitmap.Config.ARGB_8888)
  }

  override fun onHideCustomView() {
    val activity = getActivity()
    if (activity == null) {
      return
    }

    val decorView: View? = getRootView()
    if (decorView == null) {
      return
    }
    if (this.mCustomView != null) {
      (decorView as FrameLayout).removeView(this.mCustomView)
    }
    this.mCustomView = null
    decorView.systemUiVisibility = this.mOriginalSystemUiVisibility
    activity.requestedOrientation = this.mOriginalOrientation
    if (this.mCustomViewCallback != null) {
      this.mCustomViewCallback!!.onCustomViewHidden()
    }
    this.mCustomViewCallback = null
    activity.window.clearFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS)

    val webView = aqutterWebView
    if (webView != null) {
      val eventWebViewChannelDelegate = webView.channelDelegate
      if (eventWebViewChannelDelegate != null)
        eventWebViewChannelDelegate.onExitFullscreen()
      webView.setInFullscreen(false)
    }
  }

  override fun onShowCustomView(paramView: View?, paramCustomViewCallback: CustomViewCallback?) {
    if (this.mCustomView != null) {
      onHideCustomView()
      return
    }

    val activity = getActivity()
    if (activity == null) {
      return
    }

    val decorView: View? = getRootView()
    if (decorView == null) {
      return
    }
    this.mCustomView = paramView
    this.mOriginalSystemUiVisibility = decorView.systemUiVisibility
    this.mOriginalOrientation = activity.requestedOrientation
    this.mCustomViewCallback = paramCustomViewCallback
    if (this.mCustomView != null) {
      this.mCustomView!!.setBackgroundColor(Color.BLACK)
    }

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
      decorView.systemUiVisibility = FULLSCREEN_SYSTEM_UI_VISIBILITY_KITKAT
    } else {
      decorView.systemUiVisibility = FULLSCREEN_SYSTEM_UI_VISIBILITY
    }
    activity.window.setFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS, WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS)
    (decorView as FrameLayout).addView(this.mCustomView, FULLSCREEN_LAYOUT_PARAMS)

    val webView = aqutterWebView
    if (webView != null) {
      val eventWebViewChannelDelegate = webView.channelDelegate
      if (eventWebViewChannelDelegate != null)
        eventWebViewChannelDelegate.onEnterFullscreen()
      webView.setInFullscreen(true)
    }
  }

  override fun onJsAlert(view: WebView, url: String?, message: String?, result: JsResult): Boolean {
    val channelDelegate = aqutterWebView?.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onJsAlert(url, message, null, object : WebViewChannelDelegate.JsAlertCallback() {
        override fun nonNullSuccess(response: JsAlertResponse): Boolean {
          if (response.isHandledByClient) {
            var action = response.action
            action = if (action != null) action else 1
            when (action) {
              0 -> result.confirm()
              else -> result.cancel()
            }
            return false
          }
          return true
        }

        override fun defaultBehaviour(response: JsAlertResponse?) {
          var responseMessage: String? = null
          var confirmButtonTitle: String? = null
          if (response != null) {
            responseMessage = response.message
            confirmButtonTitle = response.confirmButtonTitle
          }
          createAlertDialog(message, result, responseMessage, confirmButtonTitle)
        }

        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
          Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
          result.cancel()
        }
      })

      return true
    }

    return false
  }

  fun createAlertDialog(message: String?, result: JsResult, responseMessage: String?, confirmButtonTitle: String?) {
    val alertMessage = if (responseMessage != null && !responseMessage.isEmpty()) responseMessage else message

    val clickListener = DialogInterface.OnClickListener { dialog, which ->
      result.confirm()
      dialog.dismiss()
      dialogs.remove(dialog)
    }

    val activity = getActivity()
    if (activity == null) {
      return
    }

    val alertDialogBuilder = AlertDialog.Builder(activity, androidx.appcompat.R.style.Theme_AppCompat_Dialog_Alert)
    alertDialogBuilder.setMessage(alertMessage)
    if (confirmButtonTitle != null && !confirmButtonTitle.isEmpty()) {
      alertDialogBuilder.setPositiveButton(confirmButtonTitle, clickListener)
    } else {
      alertDialogBuilder.setPositiveButton(android.R.string.ok, clickListener)
    }

    alertDialogBuilder.setOnCancelListener { dialog ->
      result.cancel()
      dialog.dismiss()
      dialogs.remove(dialog)
    }

    val alertDialog = alertDialogBuilder.create()
    dialogs.put(alertDialog, result)
    alertDialog.show()
  }

  override fun onJsConfirm(view: WebView, url: String?, message: String?, result: JsResult): Boolean {
    val channelDelegate = aqutterWebView?.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onJsConfirm(url, message, null, object : WebViewChannelDelegate.JsConfirmCallback() {
        override fun nonNullSuccess(response: JsConfirmResponse): Boolean {
          if (response.isHandledByClient) {
            var action = response.action
            action = if (action != null) action else 1
            when (action) {
              0 -> result.confirm()
              else -> result.cancel()
            }
            return false
          }
          return true
        }

        override fun defaultBehaviour(response: JsConfirmResponse?) {
          var responseMessage: String? = null
          var confirmButtonTitle: String? = null
          var cancelButtonTitle: String? = null
          if (response != null) {
            responseMessage = response.message
            confirmButtonTitle = response.confirmButtonTitle
            cancelButtonTitle = response.cancelButtonTitle
          }
          createConfirmDialog(message, result, responseMessage, confirmButtonTitle, cancelButtonTitle)
        }

        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
          Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
          result.cancel()
        }
      })

      return true
    }

    return false
  }

  fun createConfirmDialog(message: String?, result: JsResult, responseMessage: String?, confirmButtonTitle: String?, cancelButtonTitle: String?) {
    val alertMessage = if (responseMessage != null && !responseMessage.isEmpty()) responseMessage else message
    val confirmClickListener = DialogInterface.OnClickListener { dialog, which ->
      result.confirm()
      dialog.dismiss()
      dialogs.remove(dialog)
    }
    val cancelClickListener = DialogInterface.OnClickListener { dialog, which ->
      result.cancel()
      dialog.dismiss()
      dialogs.remove(dialog)
    }

    val activity = getActivity()
    if (activity == null) {
      return
    }

    val alertDialogBuilder = AlertDialog.Builder(activity, androidx.appcompat.R.style.Theme_AppCompat_Dialog_Alert)
    alertDialogBuilder.setMessage(alertMessage)
    if (confirmButtonTitle != null && !confirmButtonTitle.isEmpty()) {
      alertDialogBuilder.setPositiveButton(confirmButtonTitle, confirmClickListener)
    } else {
      alertDialogBuilder.setPositiveButton(android.R.string.ok, confirmClickListener)
    }
    if (cancelButtonTitle != null && !cancelButtonTitle.isEmpty()) {
      alertDialogBuilder.setNegativeButton(cancelButtonTitle, cancelClickListener)
    } else {
      alertDialogBuilder.setNegativeButton(android.R.string.cancel, cancelClickListener)
    }

    alertDialogBuilder.setOnCancelListener { dialog ->
      result.cancel()
      dialog.dismiss()
      dialogs.remove(dialog)
    }

    val alertDialog = alertDialogBuilder.create()
    dialogs.put(alertDialog, result)
    alertDialog.show()
  }

  override fun onJsPrompt(view: WebView, url: String?, message: String?, defaultValue: String?, result: JsPromptResult): Boolean {
    val channelDelegate = aqutterWebView?.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onJsPrompt(url, message, defaultValue, null, object : WebViewChannelDelegate.JsPromptCallback() {
        override fun nonNullSuccess(response: JsPromptResponse): Boolean {
          if (response.isHandledByClient) {
            var action = response.action
            action = if (action != null) action else 1
            when (action) {
              0 -> result.confirm(response.value)
              else -> result.cancel()
            }
            return false
          }
          return true
        }

        override fun defaultBehaviour(response: JsPromptResponse?) {
          var responseMessage: String? = null
          var responseDefaultValue: String? = null
          var value: String? = null
          var confirmButtonTitle: String? = null
          var cancelButtonTitle: String? = null
          if (response != null) {
            responseMessage = response.message
            responseDefaultValue = response.defaultValue
            value = response.value
            confirmButtonTitle = response.confirmButtonTitle
            cancelButtonTitle = response.cancelButtonTitle
          }
          createPromptDialog(view, message, defaultValue, result, responseMessage, responseDefaultValue, value, cancelButtonTitle, confirmButtonTitle)
        }

        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
          Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
          result.cancel()
        }
      })

      return true
    }

    return false
  }

  fun createPromptDialog(view: WebView, message: String?, defaultValue: String?, result: JsPromptResult, responseMessage: String?, responseDefaultValue: String?, value: String?, cancelButtonTitle: String?, confirmButtonTitle: String?) {
    val layout = FrameLayout(view.context)

    val input = EditText(view.context)
    input.maxLines = 1
    input.setText(if (responseDefaultValue != null && !responseDefaultValue.isEmpty()) responseDefaultValue else defaultValue)
    val lp = LinearLayout.LayoutParams(
      LinearLayout.LayoutParams.MATCH_PARENT,
      LinearLayout.LayoutParams.MATCH_PARENT)
    input.layoutParams = lp

    layout.setPaddingRelative(45, 15, 45, 0)
    layout.addView(input)

    val alertMessage = if (responseMessage != null && !responseMessage.isEmpty()) responseMessage else message

    val finalValue = value
    val confirmClickListener = DialogInterface.OnClickListener { dialog, which ->
      val text = input.text.toString()
      result.confirm(if (finalValue != null) finalValue else text)
      dialog.dismiss()
      dialogs.remove(dialog)
    }
    val cancelClickListener = DialogInterface.OnClickListener { dialog, which ->
      result.cancel()
      dialog.dismiss()
      dialogs.remove(dialog)
    }

    val activity = getActivity()
    if (activity == null) {
      return
    }

    val alertDialogBuilder = AlertDialog.Builder(activity, androidx.appcompat.R.style.Theme_AppCompat_Dialog_Alert)
    alertDialogBuilder.setMessage(alertMessage)
    if (confirmButtonTitle != null && !confirmButtonTitle.isEmpty()) {
      alertDialogBuilder.setPositiveButton(confirmButtonTitle, confirmClickListener)
    } else {
      alertDialogBuilder.setPositiveButton(android.R.string.ok, confirmClickListener)
    }
    if (cancelButtonTitle != null && !cancelButtonTitle.isEmpty()) {
      alertDialogBuilder.setNegativeButton(cancelButtonTitle, cancelClickListener)
    } else {
      alertDialogBuilder.setNegativeButton(android.R.string.cancel, cancelClickListener)
    }

    alertDialogBuilder.setOnCancelListener { dialog ->
      result.cancel()
      dialog.dismiss()
      dialogs.remove(dialog)
    }

    val alertDialog = alertDialogBuilder.create()
    alertDialog.setView(layout)
    dialogs.put(alertDialog, result)
    alertDialog.show()
  }

  override fun onJsBeforeUnload(view: WebView, url: String?, message: String?, result: JsResult): Boolean {
    val channelDelegate = aqutterWebView?.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onJsBeforeUnload(url, message, object : WebViewChannelDelegate.JsBeforeUnloadCallback() {
        override fun nonNullSuccess(response: JsBeforeUnloadResponse): Boolean {
          if (response.isHandledByClient) {
            var action = response.action
            action = if (action != null) action else 1
            when (action) {
              0 -> result.confirm()
              else -> result.cancel()
            }
            return false
          }
          return true
        }

        override fun defaultBehaviour(response: JsBeforeUnloadResponse?) {
          var responseMessage: String? = null
          var confirmButtonTitle: String? = null
          var cancelButtonTitle: String? = null
          if (response != null) {
            responseMessage = response.message
            confirmButtonTitle = response.confirmButtonTitle
            cancelButtonTitle = response.cancelButtonTitle
          }
          createBeforeUnloadDialog(message, result, responseMessage, confirmButtonTitle, cancelButtonTitle)
        }

        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
          Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
          result.cancel()
        }
      })

      return true
    }

    return false
  }

  fun createBeforeUnloadDialog(message: String?, result: JsResult, responseMessage: String?, confirmButtonTitle: String?, cancelButtonTitle: String?) {
    val alertMessage = if (responseMessage != null && !responseMessage.isEmpty()) responseMessage else message
    val confirmClickListener = DialogInterface.OnClickListener { dialog, which ->
      result.confirm()
      dialog.dismiss()
      dialogs.remove(dialog)
    }
    val cancelClickListener = DialogInterface.OnClickListener { dialog, which ->
      result.cancel()
      dialog.dismiss()
      dialogs.remove(dialog)
    }

    val activity = getActivity()
    if (activity == null) {
      return
    }

    val alertDialogBuilder = AlertDialog.Builder(activity, androidx.appcompat.R.style.Theme_AppCompat_Dialog_Alert)
    alertDialogBuilder.setMessage(alertMessage)
    if (confirmButtonTitle != null && !confirmButtonTitle.isEmpty()) {
      alertDialogBuilder.setPositiveButton(confirmButtonTitle, confirmClickListener)
    } else {
      alertDialogBuilder.setPositiveButton(android.R.string.ok, confirmClickListener)
    }
    if (cancelButtonTitle != null && !cancelButtonTitle.isEmpty()) {
      alertDialogBuilder.setNegativeButton(cancelButtonTitle, cancelClickListener)
    } else {
      alertDialogBuilder.setNegativeButton(android.R.string.cancel, cancelClickListener)
    }

    alertDialogBuilder.setOnCancelListener { dialog ->
      result.cancel()
      dialog.dismiss()
      dialogs.remove(dialog)
    }

    val alertDialog = alertDialogBuilder.create()
    dialogs.put(alertDialog, result)
    alertDialog.show()
  }

  override fun onCreateWindow(view: WebView, isDialog: Boolean, isUserGesture: Boolean, resultMsg: Message): Boolean {
    var windowId = 0
    val manager = plugin?.aqutterWebViewManager
    if (manager != null) {
      manager.windowAutoincrementId++
      windowId = manager.windowAutoincrementId
    }

    val result = view.hitTestResult
    var url: String? = result.extra

    // Ensure that images with hyperlink return the correct URL, not the image source
    if (result.type == WebView.HitTestResult.SRC_IMAGE_ANCHOR_TYPE) {
      val href = view.handler.obtainMessage()
      view.requestFocusNodeHref(href)
      val data = href.data
      if (data != null) {
        val imageUrl = data.getString("url")
        if (imageUrl != null && !imageUrl.isEmpty()) {
          url = imageUrl
        }
      }
    }

    val request = URLRequest(url, "GET", null, null)
    val createWindowAction = CreateWindowAction(
      request,
      true,
      isUserGesture,
      false,
      windowId,
      isDialog
    )

    val windowManager = plugin?.aqutterWebViewManager
    if (windowManager != null) {
      windowManager.windowWebViewMessages.put(windowId, resultMsg)
    }

    val channelDelegate = aqutterWebView?.channelDelegate
    if (channelDelegate != null) {
      val finalWindowId = windowId
      channelDelegate.onCreateWindow(createWindowAction, object : WebViewChannelDelegate.CreateWindowCallback() {
        override fun nonNullSuccess(handledByClient: Boolean): Boolean {
          return !handledByClient
        }

        override fun defaultBehaviour(handledByClient: Boolean?) {
          val callbackManager = plugin?.aqutterWebViewManager
          if (callbackManager != null) {
            callbackManager.windowWebViewMessages.remove(finalWindowId)
          }
        }

        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
          Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
          defaultBehaviour(null)
        }
      })

      return true
    }

    return false
  }

  override fun onCloseWindow(window: WebView) {
    val channelDelegate = aqutterWebView?.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onCloseWindow()
    }

    super.onCloseWindow(window)
  }

  override fun onGeolocationPermissionsShowPrompt(origin: String?, callback: GeolocationPermissions.Callback) {
    val resultCallback = object : WebViewChannelDelegate.GeolocationPermissionsShowPromptCallback() {
      override fun nonNullSuccess(response: GeolocationPermissionShowPromptResponse): Boolean {
        callback.invoke(response.origin, response.isAllow, response.isRetain)
        return false
      }

      override fun defaultBehaviour(response: GeolocationPermissionShowPromptResponse?) {
        callback.invoke(origin, false, false)
      }

      override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
        defaultBehaviour(null)
      }
    }

    val channelDelegate = aqutterWebView?.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onGeolocationPermissionsShowPrompt(origin, resultCallback)
    } else {
      resultCallback.defaultBehaviour(null)
    }
  }

  override fun onGeolocationPermissionsHidePrompt() {
    val channelDelegate = aqutterWebView?.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onGeolocationPermissionsHidePrompt()
    }
  }

  override fun onConsoleMessage(consoleMessage: ConsoleMessage): Boolean {
    val channelDelegate = aqutterWebView?.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onConsoleMessage(
        consoleMessage.message(),
        consoleMessage.messageLevel().ordinal)
    }
    return super.onConsoleMessage(consoleMessage)
  }

  override fun onProgressChanged(view: WebView, progress: Int) {
    super.onProgressChanged(view, progress)

    if (aqutterBrowserDelegate != null) {
      aqutterBrowserDelegate!!.didChangeProgress(progress)
    }


    val webView = view as AqutterWebView

    if (webView.aqutterWebViewClientCompat != null) {
      webView.aqutterWebViewClientCompat!!.loadCustomJavaScriptOnPageStarted(view)
    } else if (webView.aqutterWebViewClient != null) {
      webView.aqutterWebViewClient!!.loadCustomJavaScriptOnPageStarted(view)
    }

    if (webView.channelDelegate != null) {
      webView.channelDelegate!!.onProgressChanged(progress)
    }
  }

  override fun onReceivedTitle(view: WebView, title: String?) {
    super.onReceivedTitle(view, title)

    if (aqutterBrowserDelegate != null) {
      aqutterBrowserDelegate!!.didChangeTitle(title)
    }

    val webView = view as AqutterWebView

    if (webView.channelDelegate != null) {
      webView.channelDelegate!!.onTitleChanged(title)
    }
  }

  override fun onReceivedIcon(view: WebView, icon: Bitmap) {
    super.onReceivedIcon(view, icon)

    val byteArrayOutputStream = ByteArrayOutputStream()
    icon.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
    try {
      byteArrayOutputStream.close()
    } catch (e: IOException) {
      Log.e(LOG_TAG, "", e)
    }
    icon.recycle()

    val webView = view as AqutterWebView
    if (webView.channelDelegate != null) {
      webView.channelDelegate!!.onReceivedIcon(byteArrayOutputStream.toByteArray())
    }
  }

  override fun onReceivedTouchIconUrl(view: WebView,
                                      url: String?,
                                      precomposed: Boolean) {
    super.onReceivedTouchIconUrl(view, url, precomposed)

    val webView = view as AqutterWebView
    if (webView.channelDelegate != null) {
      webView.channelDelegate!!.onReceivedTouchIconUrl(url, precomposed)
    }
  }

  protected fun getRootView(): ViewGroup? {
    val activity = getActivity()
    if (activity == null) {
      return null
    }
    return activity.findViewById<View>(android.R.id.content) as ViewGroup?
  }

  @Suppress("UNCHECKED_CAST")
  private fun onShowFileChooser(request: ShowFileChooserRequest, filePathsCallback: ValueCallback<*>): Boolean {
    val callback = object : WebViewChannelDelegate.ShowFileChooserCallback() {
      override fun nonNullSuccess(response: ShowFileChooserResponse): Boolean {
        if (response.isHandledByClient) {
          var uriArray: Array<Uri>? = null
          if (response.filePaths != null) {
            uriArray = Array(response.filePaths!!.size) { i -> Uri.parse(response.filePaths!![i]) }
          }
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            (filePathsCallback as ValueCallback<Array<Uri>?>).onReceiveValue(uriArray)
          } else {
            (filePathsCallback as ValueCallback<Uri?>).onReceiveValue(if (uriArray != null) uriArray[0] else null)
          }
          return false
        }
        return true
      }

      override fun defaultBehaviour(response: ShowFileChooserResponse?) {
        val acceptTypes = request.acceptTypes.toTypedArray()
        val captureEnabled = request.isCaptureEnabled
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          val allowMultiple = request.mode == FileChooserParams.MODE_OPEN_MULTIPLE
          startPickerIntent(filePathsCallback as ValueCallback<Array<Uri>>, acceptTypes, allowMultiple, captureEnabled)
        } else {
          startPickerIntent(filePathsCallback as ValueCallback<Uri>, if (acceptTypes.size > 0) acceptTypes[0] else "", captureEnabled)
        }
      }

      override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
        defaultBehaviour(null)
      }
    }

    val webView = aqutterWebView
    if (webView != null && webView.channelDelegate != null && webView.customSettings.useOnShowFileChooser) {
      webView.channelDelegate!!.onShowFileChooser(request, callback)
    } else {
      callback.defaultBehaviour(null)
    }

    return true
  }

  protected fun openFileChooser(filePathCallback: ValueCallback<Uri>, acceptType: String) {
    val acceptTypes: MutableList<String> = ArrayList()
    acceptTypes.add(acceptType)
    onShowFileChooser(ShowFileChooserRequest(0, acceptTypes, false, null, null), filePathCallback)
  }

  protected fun openFileChooser(filePathCallback: ValueCallback<Uri>) {
    val acceptTypes: MutableList<String> = ArrayList()
    acceptTypes.add("")
    onShowFileChooser(ShowFileChooserRequest(0, acceptTypes, false, null, null), filePathCallback)
  }

  protected fun openFileChooser(filePathCallback: ValueCallback<Uri>, acceptType: String, capture: String) {
    val acceptTypes: MutableList<String> = ArrayList()
    acceptTypes.add(acceptType)
    onShowFileChooser(ShowFileChooserRequest(0, acceptTypes, true, null, null), filePathCallback)
  }

  @TargetApi(Build.VERSION_CODES.LOLLIPOP)
  override fun onShowFileChooser(webView: WebView, filePathCallback: ValueCallback<Array<Uri>>, fileChooserParams: FileChooserParams): Boolean {
    return onShowFileChooser(ShowFileChooserRequest.fromFileChooserParams(fileChooserParams), filePathCallback)
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    if (filePathCallback == null && filePathCallbackLegacy == null) {
      return true
    }

    // based off of which button was pressed, we get an activity result and a file
    // the camera activity doesn't properly return the filename* (I think?) so we use
    // this filename instead
    when (requestCode) {
      PICKER -> {
        var results: Array<Uri>? = null
        if (resultCode == RESULT_OK) {
          results = getSelectedFiles(data, resultCode)
        }

        if (filePathCallback != null) {
          filePathCallback!!.onReceiveValue(results)
        }
      }

      PICKER_LEGACY -> {
        var result: Uri? = null
        if (resultCode == RESULT_OK) {
          result = if (data != null) data.data else getCapturedMediaFile()
        }
        if (filePathCallbackLegacy != null) {
          filePathCallbackLegacy!!.onReceiveValue(result)
        }
      }
    }

    filePathCallback = null
    filePathCallbackLegacy = null
    imageOutputFileUri = null
    videoOutputFileUri = null

    return true
  }

  private fun getSelectedFiles(data: Intent?, resultCode: Int): Array<Uri>? {
    // we have one file selected
    if (data != null && data.data != null) {
      if (resultCode == RESULT_OK && Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        return FileChooserParams.parseResult(resultCode, data)
      } else {
        return null
      }
    }

    // we have multiple files selected
    if (data != null && data.clipData != null) {
      val numSelectedFiles = data.clipData!!.itemCount
      val result = Array<Uri>(numSelectedFiles) { i -> data.clipData!!.getItemAt(i).uri }
      return result
    }

    // we have a captured image or video file
    val mediaUri = getCapturedMediaFile()
    if (mediaUri != null) {
      return arrayOf(mediaUri)
    }

    return null
  }

  private fun isFileNotEmpty(uri: Uri): Boolean {
    val activity = getActivity()
    if (activity == null) {
      return false
    }

    val length: Long
    try {
      val descriptor = activity.contentResolver.openAssetFileDescriptor(uri, "r")
      length = descriptor!!.length
      descriptor.close()
    } catch (e: IOException) {
      return false
    }

    return length > 0
  }

  private fun getCapturedMediaFile(): Uri? {
    val imageUri = imageOutputFileUri
    if (imageUri != null && isFileNotEmpty(imageUri)) {
      return imageUri
    }

    val videoUri = videoOutputFileUri
    if (videoUri != null && isFileNotEmpty(videoUri)) {
      return videoUri
    }

    return null
  }

  fun startPickerIntent(filePathCallback: ValueCallback<Uri>, acceptType: String, captureEnabled: Boolean) {
    filePathCallbackLegacy = filePathCallback

    val images = acceptsImages(acceptType)
    val video = acceptsVideo(acceptType)

    var pickerIntent: Intent? = null

    if (captureEnabled) {
      if (!needsCameraPermission()) {
        if (images) {
          pickerIntent = getPhotoIntent()
        } else if (video) {
          pickerIntent = getVideoIntent()
        }
      }
    }
    if (pickerIntent == null) {
      val fileChooserIntent = getFileChooserIntent(acceptType)
      pickerIntent = Intent.createChooser(fileChooserIntent, "")

      val extraIntents = ArrayList<Parcelable>()
      if (!needsCameraPermission()) {
        if (images) {
          extraIntents.add(getPhotoIntent())
        }
        if (video) {
          extraIntents.add(getVideoIntent())
        }
      }
      pickerIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, extraIntents.toTypedArray())
    }

    val activity = getActivity()
    if (activity != null && pickerIntent!!.resolveActivity(activity.packageManager) != null) {
      activity.startActivityForResult(pickerIntent, PICKER_LEGACY)
    } else {
      Log.d(LOG_TAG, "there is no Activity to handle this Intent")
    }
  }

  @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
  fun startPickerIntent(callback: ValueCallback<Array<Uri>>, acceptTypes: Array<String>,
                        allowMultiple: Boolean, captureEnabled: Boolean): Boolean {
    filePathCallback = callback

    val images = acceptsImages(acceptTypes)
    val video = acceptsVideo(acceptTypes)

    var pickerIntent: Intent? = null

    if (captureEnabled) {
      if (!needsCameraPermission()) {
        if (images) {
          pickerIntent = getPhotoIntent()
        } else if (video) {
          pickerIntent = getVideoIntent()
        }
      }
    }
    if (pickerIntent == null) {
      val extraIntents = ArrayList<Parcelable>()
      if (!needsCameraPermission()) {
        if (images) {
          extraIntents.add(getPhotoIntent())
        }
        if (video) {
          extraIntents.add(getVideoIntent())
        }
      }

      val fileSelectionIntent = getFileChooserIntent(acceptTypes, allowMultiple)

      pickerIntent = Intent(Intent.ACTION_CHOOSER)
      pickerIntent.putExtra(Intent.EXTRA_INTENT, fileSelectionIntent)
      pickerIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, extraIntents.toTypedArray())
    }

    val activity = getActivity()
    if (activity != null && pickerIntent!!.resolveActivity(activity.packageManager) != null) {
      activity.startActivityForResult(pickerIntent, PICKER)
    } else {
      Log.d(LOG_TAG, "there is no Activity to handle this Intent")
    }

    return true
  }

  protected fun needsCameraPermission(): Boolean {
    var needed = false

    val activity = getActivity()
    if (activity == null) {
      return true
    }
    val packageManager = activity.packageManager
    try {
      val requestedPermissions = packageManager.getPackageInfo(activity.applicationContext.packageName, PackageManager.GET_PERMISSIONS).requestedPermissions
      if (Arrays.asList(*requestedPermissions!!).contains(Manifest.permission.CAMERA)
        && ContextCompat.checkSelfPermission(activity, Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
        needed = true
      }
    } catch (e: PackageManager.NameNotFoundException) {
      needed = true
    }

    return needed
  }

  private fun getPhotoIntent(): Intent {
    val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
    imageOutputFileUri = getOutputUri(MediaStore.ACTION_IMAGE_CAPTURE)
    intent.putExtra(MediaStore.EXTRA_OUTPUT, imageOutputFileUri)
    return intent
  }

  private fun getVideoIntent(): Intent {
    val intent = Intent(MediaStore.ACTION_VIDEO_CAPTURE)
    videoOutputFileUri = getOutputUri(MediaStore.ACTION_VIDEO_CAPTURE)
    intent.putExtra(MediaStore.EXTRA_OUTPUT, videoOutputFileUri)
    return intent
  }

  private fun getFileChooserIntent(acceptTypes: String): Intent {
    var _acceptTypes: String? = acceptTypes
    if (acceptTypes.isEmpty()) {
      _acceptTypes = DEFAULT_MIME_TYPES
    }
    if (acceptTypes.matches(Regex("\\.\\w+"))) {
      _acceptTypes = getMimeTypeFromExtension(acceptTypes.replace(".", ""))
    }
    val intent = Intent(Intent.ACTION_GET_CONTENT)
    intent.addCategory(Intent.CATEGORY_OPENABLE)
    intent.setType(_acceptTypes)
    return intent
  }

  @RequiresApi(api = Build.VERSION_CODES.KITKAT)
  private fun getFileChooserIntent(acceptTypes: Array<String>, allowMultiple: Boolean): Intent {
    val intent = Intent(Intent.ACTION_GET_CONTENT)
    intent.addCategory(Intent.CATEGORY_OPENABLE)
    intent.setType("*/*")
    intent.putExtra(Intent.EXTRA_MIME_TYPES, getAcceptedMimeType(acceptTypes))
    intent.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, allowMultiple)
    return intent
  }

  private fun acceptsAny(types: Array<String>): Boolean {
    if (isArrayEmpty(types)) {
      return true
    }

    for (type in types) {
      if (type == "*/*") {
        return true
      }
    }

    return false
  }

  private fun acceptsImages(types: String): Boolean {
    var mimeType: String = types
    if (types.matches(Regex("\\.\\w+"))) {
      mimeType = getMimeTypeFromExtension(types.replace(".", ""))!!
    }
    return mimeType.isEmpty() || mimeType.lowercase(Locale.getDefault()).contains("image")
  }

  private fun acceptsImages(types: Array<String>): Boolean {
    val mimeTypes = getAcceptedMimeType(types)
    return acceptsAny(types) || arrayContainsString(mimeTypes, "image")
  }

  private fun acceptsVideo(types: String): Boolean {
    var mimeType: String = types
    if (types.matches(Regex("\\.\\w+"))) {
      mimeType = getMimeTypeFromExtension(types.replace(".", ""))!!
    }
    return mimeType.isEmpty() || mimeType.lowercase(Locale.getDefault()).contains("video")
  }

  private fun acceptsVideo(types: Array<String>): Boolean {
    val mimeTypes = getAcceptedMimeType(types)
    return acceptsAny(types) || arrayContainsString(mimeTypes, "video")
  }

  private fun arrayContainsString(array: Array<String?>, pattern: String): Boolean {
    for (content in array) {
      if (content != null && content.contains(pattern)) {
        return true
      }
    }
    return false
  }

  private fun getAcceptedMimeType(types: Array<String>): Array<String?> {
    if (isArrayEmpty(types)) {
      return arrayOf(DEFAULT_MIME_TYPES)
    }
    val mimeTypes = arrayOfNulls<String>(types.size)
    for (i in types.indices) {
      val t = types[i]
      // convert file extensions to mime types
      if (t.matches(Regex("\\.\\w+"))) {
        val mimeType = getMimeTypeFromExtension(t.replace(".", ""))
        mimeTypes[i] = mimeType
      } else {
        mimeTypes[i] = t
      }
    }
    return mimeTypes
  }

  private fun getMimeTypeFromExtension(extension: String?): String? {
    var type: String? = null
    if (extension != null) {
      type = MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension)
    }
    return type
  }

  private fun getOutputUri(intentType: String): Uri? {
    var capturedFile: File? = null
    try {
      capturedFile = getCapturedFile(intentType)
    } catch (e: IOException) {
      Log.e(LOG_TAG, "Error occurred while creating the File", e)
    }
    if (capturedFile == null) {
      return null
    }

    // for versions below 6.0 (23) we use the old File creation & permissions model
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
      return Uri.fromFile(capturedFile)
    }

    val activity = getActivity()
    if (activity == null) {
      return null
    }
    // for versions 6.0+ (23) we use the FileProvider to avoid runtime permissions
    val fileProviderAuthority = activity.applicationContext.packageName + "." +
      AqutterWebViewFileProvider.fileProviderAuthorityExtension
    try {
      return FileProvider.getUriForFile(activity.applicationContext,
        fileProviderAuthority,
        capturedFile)
    } catch (e: Exception) {
      Log.e(LOG_TAG, "", e)
    }
    return null
  }

  @Throws(IOException::class)
  private fun getCapturedFile(intentType: String): File? {
    var prefix = ""
    var suffix = ""
    var dir = ""

    if (intentType == MediaStore.ACTION_IMAGE_CAPTURE) {
      prefix = "image"
      suffix = ".jpg"
      dir = Environment.DIRECTORY_PICTURES
    } else if (intentType == MediaStore.ACTION_VIDEO_CAPTURE) {
      prefix = "video"
      suffix = ".mp4"
      dir = Environment.DIRECTORY_MOVIES
    }

    // for versions below 6.0 (23) we use the old File creation & permissions model
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
      // only this Directory works on all tested Android versions
      // ctx.getExternalFilesDir(dir) was failing on Android 5.0 (sdk 21)
      val storageDir = Environment.getExternalStoragePublicDirectory(dir)
      val filename = String.format("%s-%d%s", prefix, System.currentTimeMillis(), suffix)
      return File(storageDir, filename)
    }

    val activity = getActivity()
    if (activity == null) {
      return null
    }
    val storageDir = activity.applicationContext.getExternalFilesDir(null)
    return File.createTempFile(prefix, suffix, storageDir)
  }

  private fun isArrayEmpty(arr: Array<String>): Boolean {
    // when our array returned from getAcceptTypes() has no values set from the webview
    // i.e. <input type="file" />, without any "accept" attr
    // will be an array with one empty string element, afaik
    return arr.size == 0 || (arr.size == 1 && arr[0].length == 0)
  }

  override fun onPermissionRequest(request: PermissionRequest) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      val callback = object : WebViewChannelDelegate.PermissionRequestCallback() {
        override fun nonNullSuccess(response: PermissionResponse): Boolean {
          val action = response.action
          if (action != null) {
            when (action) {
              1 -> {
                val resources = response.resources.toTypedArray()
                request.grant(resources)
              }
              else -> request.deny()
            }
            return false
          }
          return true
        }

        override fun defaultBehaviour(response: PermissionResponse?) {
          request.deny()
        }

        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
          Log.e(LOG_TAG, errorCode + ", " + (if (errorMessage != null) errorMessage else ""))
          defaultBehaviour(null)
        }
      }

      val channelDelegate = aqutterWebView?.channelDelegate
      if (channelDelegate != null) {
        channelDelegate.onPermissionRequest(request.origin.toString(),
          Arrays.asList(*request.resources), null, callback)
      } else {
        callback.defaultBehaviour(null)
      }
    }
  }

  override fun onRequestFocus(view: WebView) {
    val channelDelegate = aqutterWebView?.channelDelegate
    if (channelDelegate != null) {
      channelDelegate.onRequestFocus()
    }
  }

  override fun onPermissionRequestCanceled(request: PermissionRequest) {
    val channelDelegate = aqutterWebView?.channelDelegate
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP &&
      channelDelegate != null) {
      channelDelegate.onPermissionRequestCanceled(request.origin.toString(),
        Arrays.asList(*request.resources))
    }
  }

  private fun getActivity(): Activity? {
    if (aqutterBrowserDelegate != null) {
      return aqutterBrowserDelegate!!.getActivity()
    } else if (plugin != null) {
      return plugin!!.activity
    }
    return null
  }

  fun dispose() {
    for (dialog in dialogs.entries) {
      dialog.value.cancel()
      dialog.key.dismiss()
    }
    dialogs.clear()
    if (plugin != null && plugin!!.activityPluginBinding != null) {
      plugin!!.activityPluginBinding!!.removeActivityResultListener(this)
    }
    if (aqutterBrowserDelegate != null) {
      aqutterBrowserDelegate!!.getActivityResultListeners()!!.clear()
      aqutterBrowserDelegate = null
    }
    filePathCallbackLegacy = null
    filePathCallback = null
    videoOutputFileUri = null
    imageOutputFileUri = null
    aqutterWebView = null
    plugin = null
  }
}
