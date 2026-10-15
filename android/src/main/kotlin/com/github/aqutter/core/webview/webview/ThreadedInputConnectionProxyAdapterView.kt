package com.github.aqutter.core.webview.webview

import android.os.Handler
import android.os.IBinder
import android.view.View
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputConnection

/**
 * A fake View only exposed to InputMethodManager.
 *
 * https://github.com/flutter/plugins/blob/main/packages/webview_flutter/webview_flutter_android/android/src/main/java/io/flutter/plugins/webviewflutter/ThreadedInputConnectionProxyAdapterView.java
 */
// package-private in Java
class ThreadedInputConnectionProxyAdapterView(
  containerView: View,
  targetView: View,
  imeHandler: Handler
) : View(containerView.context) {
  @JvmField val imeHandler: Handler = imeHandler
  @JvmField val windowToken: IBinder?
  @JvmField val containerView: View = containerView
  @JvmField val rootView: View
  @JvmField val targetView: View = targetView

  private var triggerDelayed = true
  private var isLocked = false
  private var cachedConnection: InputConnection? = null

  init {
    windowToken = containerView.windowToken
    rootView = containerView.rootView
    setFocusable(true)
    setFocusableInTouchMode(true)
    setVisibility(VISIBLE)
  }

  /** Returns whether or not this is currently asynchronously acquiring an input connection. */
  fun isTriggerDelayed(): Boolean {
    return triggerDelayed
  }

  /** Sets whether or not this should use its previously cached input connection. */
  fun setLocked(locked: Boolean) {
    isLocked = locked
  }

  /**
   * This is expected to be called on the IME thread. See the setup required for this in {@link
   * InputAwareWebView#checkInputConnectionProxy(View)}.
   *
   * <p>Delegates to ThreadedInputConnectionProxyView to get WebView's input connection.
   */
  override fun onCreateInputConnection(outAttrs: EditorInfo): InputConnection? {
    triggerDelayed = false
    val inputConnection: InputConnection? =
      if (isLocked) cachedConnection else targetView.onCreateInputConnection(outAttrs)
    triggerDelayed = true
    cachedConnection = inputConnection
    return inputConnection
  }

  override fun checkInputConnectionProxy(view: View?): Boolean {
    return true
  }

  override fun hasWindowFocus(): Boolean {
    // None of our views here correctly report they have window focus because of how we're embedding
    // the platform view inside of a virtual display.
    return true
  }

  override fun getRootView(): View {
    return rootView
  }

  override fun onCheckIsTextEditor(): Boolean {
    return true
  }

  override fun isFocused(): Boolean {
    return true
  }

  override fun getWindowToken(): IBinder? {
    return windowToken
  }

  override fun getHandler(): Handler {
    return imeHandler
  }
}
