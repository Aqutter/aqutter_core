package com.github.aqutter.core.plugin_scripts_js

import com.github.aqutter.core.types.PluginScript
import com.github.aqutter.core.types.UserScriptInjectionTime

/**
 * Reports the focused editable element's position so the native side can shift the WebView out
 * from under the soft keyboard.
 *
 * <p>The report goes straight to a dedicated {@code @JavascriptInterface} rather than through
 * {@code callHandler}, because that route hops to Dart and back -- too slow for something that has
 * to land within the keyboard animation, and it would need Dart plumbing for data that never
 * leaves the native side.
 *
 * <p>Only injected while {@code AqutterWebViewSettings.keyboardAvoidance} is enabled.
 */
class KeyboardAvoidanceJS {
  companion object {
    const val KEYBOARD_AVOIDANCE_JS_PLUGIN_SCRIPT_GROUP_NAME = "AQUTTER_WEBVIEW_KEYBOARD_AVOIDANCE_JS_PLUGIN_SCRIPT"

    /**
     * Name the interface is bound to on {@code window}. Derived from the bridge name so it moves
     * with it if the bridge is renamed at runtime.
     */
    @JvmStatic
    fun getInterfaceName(): String {
      return JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "KeyboardAvoidance"
    }

    // This plugin is only for the main frame
    @JvmStatic
    fun KEYBOARD_AVOIDANCE_JS_PLUGIN_SCRIPT(allowedOriginRules: MutableSet<String>?): PluginScript {
      return PluginScript(
        KeyboardAvoidanceJS.KEYBOARD_AVOIDANCE_JS_PLUGIN_SCRIPT_GROUP_NAME,
        KeyboardAvoidanceJS.KEYBOARD_AVOIDANCE_JS_SOURCE(),
        UserScriptInjectionTime.AT_DOCUMENT_START,
        null,
        false,
        allowedOriginRules,
        true
      )
    }

    @JvmStatic
    fun KEYBOARD_AVOIDANCE_JS_SOURCE(): String {
      return "(function(){" +
        "  var api = window." + getInterfaceName() + ";" +
        "  if (!api) { return; }" +
        "  var EDITABLE = 'input, textarea, select, [contenteditable=\"\"], [contenteditable=\"true\"]';" +
        "  function report() {" +
        "    var el = document.activeElement;" +
        "    if (!el || !el.matches || !el.matches(EDITABLE)) { api.onFocusCleared(); return; }" +
        "    var rect = el.getBoundingClientRect();" +
        // devicePixelRatio is sent along so the native side does not have to guess the
        // page scale; it already folds density and zoom together.
        "    api.onFocusedRect(rect.bottom, window.devicePixelRatio);" +
        "  }" +
        "  document.addEventListener('focusin', report, true);" +
        // focusout fires before activeElement settles, so let it land first.
        "  document.addEventListener('focusout', function(){ setTimeout(report, 0); }, true);" +
        // The page can scroll the focused field out from under the shift we applied.
        "  window.addEventListener('scroll', report, true);" +
        // A host that leaves Scaffold.resizeToAvoidBottomInset at its default shrinks
        // the WebView *after* focusin has already reported. Without re-reporting on
        // relayout the rect stays at its full-height value and the shift overshoots by
        // roughly the keyboard height.
        "  window.addEventListener('resize', report);" +
        "  if (window.visualViewport) {" +
        "    window.visualViewport.addEventListener('resize', report);" +
        "  }" +
        "})();"
    }
  }
}
