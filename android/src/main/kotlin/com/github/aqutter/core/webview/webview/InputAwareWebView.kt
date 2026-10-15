package com.github.aqutter.core.webview.webview

import android.content.Context
import android.content.Context.INPUT_METHOD_SERVICE
import android.graphics.Rect
import android.os.Build
import android.util.AttributeSet
import android.util.Log
import android.view.View
import android.view.inputmethod.InputMethodManager
import android.webkit.WebView
import android.widget.ListPopupWindow
import androidx.core.graphics.Insets
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsAnimationCompat
import androidx.core.view.WindowInsetsCompat
import com.github.aqutter.core.plugin_scripts_js.KeyboardAvoidanceJS

/**
 * A WebView subclass that mirrors the same implementation hacks that the system WebView does in
 * order to correctly create an InputConnection.
 *
 * These hacks are only needed in Android versions below N and exist to create an InputConnection
 * on the WebView's dedicated input, or IME, thread. The majority of this proxying logic is in
 * https://github.com/flutter/plugins/blob/main/packages/webview_flutter/webview_flutter_android/android/src/main/java/io/flutter/plugins/webviewflutter/InputAwareWebView.java
 */
open class InputAwareWebView : WebView {
  companion object {
    private const val LOG_TAG = "InputAwareWebView"
  }

  @JvmField
  var containerView: View?
  private var threadedInputConnectionProxyView: View? = null
  private var proxyAdapterView: ThreadedInputConnectionProxyAdapterView? = null
  private var useHybridComposition = false
  private var keyboardAvoidanceController: KeyboardAvoidanceController? = null

  constructor(context: Context, containerView: View?, useHybridComposition: Boolean?) : super(context) {
    this.containerView = containerView
    this.useHybridComposition = if (useHybridComposition == null) false else useHybridComposition
  }

  constructor(context: Context, attrs: AttributeSet?) : super(context, attrs) {
    this.containerView = null
  }

  constructor(context: Context) : super(context) {
    this.containerView = null
  }

  constructor(context: Context, attrs: AttributeSet?, defaultStyle: Int) : super(context, attrs, defaultStyle) {
    this.containerView = null
  }

  /**
   * Installs or removes the listener that hides the IME window insets from the system WebView.
   *
   * <p>Chromium reacts to IME insets by running its own {@code ScrollFocusedEditableIntoView},
   * which translates the visual viewport. That makes it a second actor competing with any keyboard
   * avoidance the app performs, and the two shifts add up before snapping back. Chromium's side
   * lives inside the Android System WebView and cannot be changed, but it only triggers when this
   * View actually receives IME insets -- which is what this intercepts.
   *
   * <p>Nothing is installed while disabled, so the WebView behaves exactly as it does upstream.
   *
   * @param enabled whether the IME insets should be hidden from the WebView
   */
  open fun setKeyboardAvoidanceEnabled(enabled: Boolean) {
    if (!enabled) {
      ViewCompat.setOnApplyWindowInsetsListener(this, null)
      if (keyboardAvoidanceController != null) {
        keyboardAvoidanceController!!.reset()
        keyboardAvoidanceController = null
      }
      return
    }

    // IME insets are only reported as a distinct type from API 30 (R). Below that they arrive
    // merged into the system window insets, where they cannot be separated from the navigation
    // bar without guessing -- so the interception is not attempted there.
    // Below API 30 the shift still runs, but its two inputs come from elsewhere -- see
    // [setFrameworkKeyboardInsetPx] for where the keyboard height comes from and why nothing is
    // consumed here.
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) {
      val controller = KeyboardAvoidanceController(this)
      keyboardAvoidanceController = controller
      addJavascriptInterface(controller, KeyboardAvoidanceJS.getInterfaceName())
      return
    }

    val controller = KeyboardAvoidanceController(this)
    keyboardAvoidanceController = controller
    addJavascriptInterface(controller, KeyboardAvoidanceJS.getInterfaceName())

    ViewCompat.setOnApplyWindowInsetsListener(this) { view, insets ->
      // The height is read from the root window insets, not from the insets dispatched here.
      // By the time they reach this View the ancestors have already consumed part of them -- the
      // two differ by the navigation bar (measured: dispatched 883 vs root 949 at density 2.75).
      // The shift is computed in window coordinates, so it needs the window-level value; mixing
      // the two left the field short by that difference, which was enough to hide it behind the
      // keyboard whenever the required shift was not already near the keyboard height.
      val rootInsets = ViewCompat.getRootWindowInsets(view)
      val currentController = keyboardAvoidanceController
      if (currentController != null && rootInsets != null) {
        currentController.setKeyboardHeightPx(
          rootInsets.getInsets(WindowInsetsCompat.Type.ime()).bottom)
      }

      val withoutIme = WindowInsetsCompat.Builder(insets)
        .setInsets(WindowInsetsCompat.Type.ime(), Insets.NONE)
        .build()
      // The listener replaces the View's own onApplyWindowInsets, so the (modified) insets still
      // have to be handed to the WebView explicitly -- otherwise it sees no insets at all.
      ViewCompat.onApplyWindowInsets(view, withoutIme)
    }

    // onApplyWindowInsets only reports the settled value, so on its own the shift snaps into
    // place and snaps back when the keyboard closes. This follows the IME animation frame by
    // frame so the WebView travels with the keyboard instead.
    ViewCompat.setWindowInsetsAnimationCallback(this,
      object : WindowInsetsAnimationCompat.Callback(WindowInsetsAnimationCompat.Callback.DISPATCH_MODE_CONTINUE_ON_SUBTREE) {
        override fun onProgress(
          insets: WindowInsetsCompat,
          runningAnimations: MutableList<WindowInsetsAnimationCompat>
        ): WindowInsetsCompat {
          val currentController = keyboardAvoidanceController
          if (currentController != null) {
            currentController.setKeyboardHeightPx(
              insets.getInsets(WindowInsetsCompat.Type.ime()).bottom)
          }
          return insets
        }
      })
  }

  /**
   * Feeds the keyboard height measured by the Flutter framework, for the API levels where this
   * View cannot measure it itself.
   *
   * <p>Below API 30 there is no channel here that reports the IME. The type-based insets carry no
   * {@code ime()} value at all, and the window insets that do arrive are consumed by the Flutter
   * embedding before reaching this View -- measured on API 29, both the system-window and stable
   * bottoms stay 0 for the whole keyboard cycle. The visible display frame does move, but reading
   * it needs a layout pass, and with {@code Scaffold.resizeToAvoidBottomInset: false} nothing in
   * the view tree relayouts, so the observer never fires.
   *
   * <p>The engine, on the other hand, has the value: that is what makes the framework's own resize
   * work on those versions. So the Dart side of this package observes it and pushes it down here.
   *
   * <p>Nothing is consumed on this path, and none is needed: unlike API 30+, Chromium does not act
   * on the keyboard here -- verified on API 29 by pointing an app with a long, non-reflowing page
   * at it with the framework resize off, where the focused field stayed covered and the page never
   * moved. There is therefore no second actor to suppress, only the shift to perform.
   *
   * @param heightPx height of the keyboard in physical pixels, 0 when it is closed
   */
  open fun setFrameworkKeyboardInsetPx(heightPx: Int) {
    // API 30+ measures the IME itself, frame by frame, from a source that cannot lag behind the
    // animation. Accepting the framework's value there would mean two writers for one field.
    val controller = keyboardAvoidanceController
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R || controller == null) {
      return
    }
    controller.setKeyboardHeightPx(heightPx)
  }

  open fun setContainerView(containerView: View?) {
    this.containerView = containerView

    if (proxyAdapterView == null) {
      return
    }

    Log.w(LOG_TAG, "The containerView has changed while the proxyAdapterView exists.")
    if (containerView != null) {
      setInputConnectionTarget(proxyAdapterView!!)
    }
  }

  /**
   * Set our proxy adapter view to use its cached input connection instead of creating new ones.
   *
   * <p>This is used to avoid losing our input connection when the virtual display is resized.
   */
  open fun lockInputConnection() {
    if (proxyAdapterView == null) {
      return
    }

    proxyAdapterView!!.setLocked(true)
  }

  /** Sets the proxy adapter view back to its default behavior. */
  open fun unlockInputConnection() {
    if (proxyAdapterView == null) {
      return
    }

    proxyAdapterView!!.setLocked(false)
  }

  /** Restore the original InputConnection, if needed. */
  // package-private in Java
  open fun dispose() {
    if (useHybridComposition) {
      return
    }
    resetInputConnection()
  }

  /**
   * Creates an InputConnection from the IME thread when needed.
   *
   * <p>We only need to create a {@link ThreadedInputConnectionProxyAdapterView} and create an
   * InputConnectionProxy on the IME thread when WebView is doing the same thing. So we rely on the
   * system calling this method for WebView's proxy view in order to know when we need to create our
   * own.
   *
   * <p>This method would normally be called for any View that used the InputMethodManager. We rely
   * on flutter/engine filtering the calls we receive down to the ones in our hierarchy and the
   * system WebView in order to know whether or not the system WebView expects an InputConnection on
   * the IME thread.
   */
  override fun checkInputConnectionProxy(view: View?): Boolean {
    if (useHybridComposition) {
      return super.checkInputConnectionProxy(view)
    }
    // Check to see if the view param is WebView's ThreadedInputConnectionProxyView.
    val previousProxy = threadedInputConnectionProxyView
    threadedInputConnectionProxyView = view
    if (previousProxy === view) {
      // This isn't a new ThreadedInputConnectionProxyView. Ignore it.
      return super.checkInputConnectionProxy(view)
    }
    if (containerView == null) {
      Log.e(
        LOG_TAG,
        "Can't create a proxy view because there's no container view. Text input may not work.")
      return super.checkInputConnectionProxy(view)
    }

    // We've never seen this before, so we make the assumption that this is WebView's
    // ThreadedInputConnectionProxyView. We are making the assumption that the only view that could
    // possibly be interacting with the IMM here is WebView's ThreadedInputConnectionProxyView.
    val newProxyAdapterView =
      ThreadedInputConnectionProxyAdapterView(
        /*containerView=*/ containerView!!,
        /*targetView=*/ view!!,
        /*imeHandler=*/ view.handler)
    proxyAdapterView = newProxyAdapterView
    setInputConnectionTarget(/*targetView=*/ newProxyAdapterView)
    return super.checkInputConnectionProxy(view)
  }

  /**
   * Ensure that input creation happens back on {@link #containerView}'s thread once this view no
   * longer has focus.
   *
   * <p>The logic in {@link #checkInputConnectionProxy} forces input creation to happen on Webview's
   * thread for all connections. We undo it here so users will be able to go back to typing in
   * Flutter UIs as expected.
   */
  override fun clearFocus() {
    super.clearFocus()

    if (useHybridComposition) {
      return
    }
    resetInputConnection()
  }

  /**
   * Ensure that input creation happens back on {@link #containerView}.
   *
   * <p>The logic in {@link #checkInputConnectionProxy} forces input creation to happen on Webview's
   * thread for all connections. We undo it here so users will be able to go back to typing in
   * Flutter UIs as expected.
   */
  private fun resetInputConnection() {
    if (proxyAdapterView == null) {
      // No need to reset the InputConnection to the default thread if we've never changed it.
      return
    }
    if (containerView == null) {
      Log.e(LOG_TAG, "Can't reset the input connection to the container view because there is none.")
      return
    }
    setInputConnectionTarget(/*targetView=*/ containerView!!)
  }

  /**
   * This is the crucial trick that gets the InputConnection creation to happen on the correct
   * thread pre Android N.
   * https://cs.chromium.org/chromium/src/content/public/android/java/src/org/chromium/content/browser/input/ThreadedInputConnectionFactory.java?l=169&rcl=f0698ee3e4483fad5b0c34159276f71cfaf81f3a
   *
   * <p>{@code targetView} should have a {@link View#getHandler} method with the thread that future
   * InputConnections should be created on.
   */
  private fun setInputConnectionTarget(targetView: View) {
    if (containerView == null) {
      Log.e(
        LOG_TAG,
        "Can't set the input connection target because there is no containerView to use as a handler.")
      return
    }

    targetView.requestFocus()
    containerView!!.post(
      object : Runnable {
        override fun run() {
          if (containerView == null) {
            Log.e(
              LOG_TAG,
              "Can't set the input connection target because there is no containerView to use as a handler.")
            return
          }

          val imm = context.getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager?
          // This is a hack to make InputMethodManager believe that the target view now has focus.
          // As a result, InputMethodManager will think that targetView is focused, and will call
          // getHandler() of the view when creating input connection.

          // Step 1: Set targetView as InputMethodManager#mNextServedView. This does not affect
          // the real window focus.
          targetView.onWindowFocusChanged(true)

          // Step 2: Have InputMethodManager focus in on targetView. As a result, IMM will call
          // onCreateInputConnection() on targetView on the same thread as
          // targetView.getHandler(). It will also call subsequent InputConnection methods on this
          // thread. This is the IME thread in cases where targetView is our proxyAdapterView.

          // TODO (ALexVincent525): Currently only prompt has been tested, still needs more test cases.
          if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            imm!!.isActive(containerView!!)
          }
        }
      })
  }

  override fun onFocusChanged(focused: Boolean, direction: Int, previouslyFocusedRect: Rect?) {
    if (useHybridComposition) {
      super.onFocusChanged(focused, direction, previouslyFocusedRect)
      return
    }
    // This works around a crash when old (<67.0.3367.0) Chromium versions are used.

    // Prior to Chromium 67.0.3367 the following sequence happens when a select drop down is shown
    // on tablets:
    //
    //  - WebView is calling ListPopupWindow#show
    //  - buildDropDown is invoked, which sets mDropDownList to a DropDownListView.
    //  - showAsDropDown is invoked - resulting in mDropDownList being added to the window and is
    //    also synchronously performing the following sequence:
    //    - WebView's focus change listener is loosing focus (as mDropDownList got it)
    //    - WebView is hiding all popups (as it lost focus)
    //    - WebView's SelectPopupDropDown#hide is invoked.
    //    - DropDownPopupWindow#dismiss is invoked setting mDropDownList to null.
    //  - mDropDownList#setSelection is invoked and is throwing a NullPointerException (as we just set mDropDownList to null).
    //
    // To workaround this, we drop the problematic focus lost call.
    // See more details on: https://github.com/flutter/flutter/issues/54164
    //
    // We don't do this after Android P as it shipped with a new enough WebView version, and it's
    // better to not do this on all future Android versions in case DropDownListView's code changes.
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.P
      && isCalledFromListPopupWindowShow()
      && !focused) {
      return
    }
    super.onFocusChanged(focused, direction, previouslyFocusedRect)
  }

  private fun isCalledFromListPopupWindowShow(): Boolean {
    val stackTraceElements = Thread.currentThread().stackTrace
    for (stackTraceElement in stackTraceElements) {
      if (stackTraceElement.className == ListPopupWindow::class.java.canonicalName
        && stackTraceElement.methodName == "show") {
        return true
      }
    }
    return false
  }
}
