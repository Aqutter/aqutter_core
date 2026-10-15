package com.github.aqutter.core.plugin_scripts_js

import com.github.aqutter.core.types.PluginScript
import com.github.aqutter.core.types.UserScriptInjectionTime

class OnWindowFocusEventJS {
  companion object {
    const val ON_WINDOW_FOCUS_EVENT_JS_PLUGIN_SCRIPT_GROUP_NAME = "AQUTTER_WEBVIEW_ON_WINDOW_FOCUS_EVENT_JS_PLUGIN_SCRIPT"

    // This plugin is only for main frame
    @JvmStatic
    fun ON_WINDOW_FOCUS_EVENT_JS_PLUGIN_SCRIPT(allowedOriginRules: MutableSet<String>?): PluginScript {
      return PluginScript(
        OnWindowFocusEventJS.ON_WINDOW_FOCUS_EVENT_JS_PLUGIN_SCRIPT_GROUP_NAME,
        OnWindowFocusEventJS.ON_WINDOW_FOCUS_EVENT_JS_SOURCE(),
        UserScriptInjectionTime.AT_DOCUMENT_START,
        null,
        false,
        allowedOriginRules,
        true
      )
    }

    @JvmStatic
    fun ON_WINDOW_FOCUS_EVENT_JS_SOURCE(): String {
      return "(function(){" +
        "  window.addEventListener('focus', function(e) {" +
        "    window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + ".callHandler('onWindowFocus');" +
        "  });" +
        "})();"
    }
  }
}
