package com.github.aqutter.core.webview.webview

import android.view.View
import android.webkit.JavascriptInterface

/**
 * Shifts the WebView up so the focused editable element clears the soft keyboard.
 *
 * <p>This only runs once {@link InputAwareWebView} has consumed the IME insets, which stops
 * Chromium from performing its own {@code ScrollFocusedEditableIntoView}. Without that, both would
 * move the content and the shifts would add up.
 *
 * <p>The WebView is translated as a whole rather than scrolled internally, so page content is never
 * relaid out. The strip revealed below the view's shifted bottom edge sits behind the keyboard, and
 * the shift is clamped to the keyboard height so it can never become visible.
 */
open class KeyboardAvoidanceController(private val webView: View) {

  companion object {
    /** Gap left between the bottom of the focused element and the top of the keyboard, in dp. */
    private const val MARGIN_DP = 8

    /** Sentinel for "no editable element is focused". */
    private const val NO_FOCUS = -1f
  }

  /** Height of the consumed IME inset in physical pixels; 0 while the keyboard is closed. */
  private var keyboardHeightPx = 0

  /** Bottom edge of the focused element in physical pixels, or {@link #NO_FOCUS}. */
  private var focusedBottomPx = NO_FOCUS

  /** Scratch buffer for {@link View#getLocationInWindow}; reused to keep this off the hot path. */
  private val locationInWindow = IntArray(2)

  /**
   * @param heightPx height of the IME inset in physical pixels, 0 when the keyboard is closed
   */
  open fun setKeyboardHeightPx(heightPx: Int) {
    if (keyboardHeightPx == heightPx) {
      return
    }
    keyboardHeightPx = heightPx
    applyShift()
  }

  /**
   * Called from the injected script whenever the focused element changes or the page scrolls.
   *
   * @param bottomCssPx      bottom edge of the focused element in CSS pixels
   * @param devicePixelRatio the page's {@code window.devicePixelRatio}, folding in density and zoom
   */
  @JavascriptInterface
  open fun onFocusedRect(bottomCssPx: Float, devicePixelRatio: Float) {
    // @JavascriptInterface methods arrive on a background thread; every field below is only
    // touched from the UI thread so the shift cannot race the insets callback.
    webView.post(object : Runnable {
      override fun run() {
        focusedBottomPx = bottomCssPx * devicePixelRatio
        applyShift()
      }
    })
  }

  /** Called from the injected script when focus leaves every editable element. */
  @JavascriptInterface
  open fun onFocusCleared() {
    webView.post(object : Runnable {
      override fun run() {
        focusedBottomPx = NO_FOCUS
        applyShift()
      }
    })
  }

  /** Drops any applied shift. Used when the setting is turned off or the view goes away. */
  open fun reset() {
    keyboardHeightPx = 0
    focusedBottomPx = NO_FOCUS
    webView.translationY = 0f
  }

  private fun applyShift() {
    webView.translationY = -computeShiftPx()
  }

  private fun computeShiftPx(): Float {
    if (keyboardHeightPx <= 0 || focusedBottomPx == NO_FOCUS) {
      return 0f
    }

    val marginPx = MARGIN_DP * webView.resources.displayMetrics.density

    // Compared in window coordinates rather than inside the view, because the host may already
    // have shrunk the WebView for the keyboard (Scaffold.resizeToAvoidBottomInset left at its
    // default true). Measuring as `viewHeight - keyboardHeight` would then subtract the keyboard
    // twice and overshoot -- reintroducing the doubled shift this option exists to remove. In
    // window coordinates the shrink is already reflected in the view's own position and height,
    // so both host configurations fall out of the same arithmetic.
    webView.getLocationInWindow(locationInWindow)
    // getLocationInWindow reports where the view is drawn, translation included. Backing it out
    // gives a fixed reference, which keeps this idempotent -- recomputing without any change to
    // the inputs must not walk the view further up each time.
    val untranslatedTopInWindow = locationInWindow[1] - webView.translationY
    val keyboardTopInWindow = (webView.rootView.height - keyboardHeightPx).toFloat()

    val overlapPx =
      untranslatedTopInWindow + focusedBottomPx + marginPx - keyboardTopInWindow
    if (overlapPx <= 0f) {
      return 0f
    }

    // Shifting further than the keyboard height would expose the strip revealed below the view's
    // bottom edge above the keyboard's top edge, making the gap visible.
    return Math.min(overlapPx, keyboardHeightPx.toFloat())
  }
}
