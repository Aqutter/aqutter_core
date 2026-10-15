package com.github.aqutter.core.plugin_scripts_js

import com.github.aqutter.core.types.PluginScript
import com.github.aqutter.core.types.UserScriptInjectionTime

class OnLoadResourceJS {
  companion object {
    const val ON_LOAD_RESOURCE_JS_PLUGIN_SCRIPT_GROUP_NAME = "AQUTTER_WEBVIEW_ON_LOAD_RESOURCE_JS_PLUGIN_SCRIPT"

    @JvmStatic
    fun FLAG_VARIABLE_FOR_ON_LOAD_RESOURCE_JS_SOURCE(): String {
      return JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "._useOnLoadResource"
    }

    @JvmStatic
    fun ON_LOAD_RESOURCE_JS_PLUGIN_SCRIPT(
      allowedOriginRules: MutableSet<String>?,
      forMainFrameOnly: Boolean
    ): PluginScript {
      return PluginScript(
        OnLoadResourceJS.ON_LOAD_RESOURCE_JS_PLUGIN_SCRIPT_GROUP_NAME,
        OnLoadResourceJS.ON_LOAD_RESOURCE_JS_SOURCE(),
        UserScriptInjectionTime.AT_DOCUMENT_START,
        null,
        false,
        allowedOriginRules,
        forMainFrameOnly
      )
    }

    @JvmStatic
    fun ON_LOAD_RESOURCE_JS_SOURCE(): String {
      return "window." + FLAG_VARIABLE_FOR_ON_LOAD_RESOURCE_JS_SOURCE() + " = true;" +
        "(function() {" +
        "   var observer = new PerformanceObserver(function(list) {" +
        "       list.getEntries().forEach(function(entry) {" +
        "         if (" + FLAG_VARIABLE_FOR_ON_LOAD_RESOURCE_JS_SOURCE() + " == null || " + FLAG_VARIABLE_FOR_ON_LOAD_RESOURCE_JS_SOURCE() + " == true) {" +
        "           var resource = {" +
        "             'url': entry.name," +
        "             'initiatorType': entry.initiatorType," +
        "             'startTime': entry.startTime," +
        "             'duration': entry.duration" +
        "           };" +
        "           window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + ".callHandler('onLoadResource', resource);" +
        "         }" +
        "       });" +
        "   });" +
        "   observer.observe({entryTypes: ['resource']});" +
        "})();"
    }
  }
}
