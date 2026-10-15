package com.github.aqutter.core.plugin_scripts_js

import com.github.aqutter.core.types.PluginScript
import com.github.aqutter.core.types.UserScriptInjectionTime

class PluginScriptsUtil {
  companion object {
    const val VAR_PLACEHOLDER_VALUE = "\$AQUTTER_WEBVIEW_PLACEHOLDER_VALUE"
    const val VAR_CONTENT_WORLD_NAME_ARRAY = "\$AQUTTER_WEBVIEW_CONTENT_WORLD_NAME_ARRAY"
    const val VAR_CONTENT_WORLD_NAME = "\$AQUTTER_WEBVIEW_CONTENT_WORLD_NAME"
    const val VAR_JSON_SOURCE_ENCODED = "\$AQUTTER_WEBVIEW_JSON_SOURCE_ENCODED"
    const val VAR_FUNCTION_ARGUMENT_NAMES = "\$AQUTTER_WEBVIEW_FUNCTION_ARGUMENT_NAMES"
    const val VAR_FUNCTION_ARGUMENT_VALUES = "\$AQUTTER_WEBVIEW_FUNCTION_ARGUMENT_VALUES"
    const val VAR_FUNCTION_ARGUMENTS_OBJ = "\$AQUTTER_WEBVIEW_FUNCTION_ARGUMENTS_OBJ"
    const val VAR_FUNCTION_BODY = "\$AQUTTER_WEBVIEW_FUNCTION_BODY"
    const val VAR_RESULT_UUID = "\$AQUTTER_WEBVIEW_RESULT_UUID"
    const val VAR_RANDOM_NAME = "\$AQUTTER_WEBVIEW_VARIABLE_RANDOM_NAME"

    @JvmStatic
    fun CALL_ASYNC_JAVA_SCRIPT_WRAPPER_JS_SOURCE(): String {
      return "(function(obj) {" +
        "  (async function(" + VAR_FUNCTION_ARGUMENT_NAMES + ") {" +
        "    \n" + VAR_FUNCTION_BODY + "\n" +
        "  })(" + VAR_FUNCTION_ARGUMENT_VALUES + ").then(function(value) {" +
        "    window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + ".callHandler('callAsyncJavaScript', {'value': value, 'error': null, 'resultUuid': '" + VAR_RESULT_UUID + "'});" +
        "  }).catch(function(error) {" +
        "    window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + ".callHandler('callAsyncJavaScript', {'value': null, 'error': error + '', 'resultUuid': '" + VAR_RESULT_UUID + "'});" +
        "  });" +
        "  return null;" +
        "})(" + VAR_FUNCTION_ARGUMENTS_OBJ + ");"
    }

    @JvmStatic
    fun EVALUATE_JAVASCRIPT_WITH_CONTENT_WORLD_WRAPPER_JS_SOURCE(): String {
      return "var \$AQUTTER_WEBVIEW_VARIABLE_RANDOM_NAME = null;" +
        "try {" +
        "  \$AQUTTER_WEBVIEW_VARIABLE_RANDOM_NAME = eval(" + VAR_PLACEHOLDER_VALUE + ");" +
        "} catch(e) {" +
        "  console.error(e);" +
        "}" +
        "window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + ".callHandler('evaluateJavaScriptWithContentWorld', {'value': \$AQUTTER_WEBVIEW_VARIABLE_RANDOM_NAME, 'resultUuid': '" + VAR_RESULT_UUID + "'});"
    }

    const val IS_ACTIVE_ELEMENT_INPUT_EDITABLE_JS_SOURCE =
      "var activeEl = document.activeElement;" +
        "var nodeName = (activeEl != null) ? activeEl.nodeName.toLowerCase() : '';" +
        "var isActiveElementInputEditable = activeEl != null && " +
        "(activeEl.nodeType == 1 && (nodeName == 'textarea' || (nodeName == 'input' && /^(?:text|email|number|search|tel|url|password)\$/i.test(activeEl.type != null ? activeEl.type : 'text')))) && " +
        "!activeEl.disabled && !activeEl.readOnly;" +
        "var isActiveElementEditable = isActiveElementInputEditable || (activeEl != null && activeEl.isContentEditable) || document.designMode === 'on';"

    // android Workaround to hide context menu when selected text is empty
    // and the document active element is not an input element.
    const val CHECK_CONTEXT_MENU_SHOULD_BE_HIDDEN_JS_SOURCE = "(function(){" +
      "  var txt;" +
      "  if (window.getSelection) {" +
      "    txt = window.getSelection().toString();" +
      "  } else if (window.document.getSelection) {" +
      "    txt = window.document.getSelection().toString();" +
      "  } else if (window.document.selection) {" +
      "    txt = window.document.selection.createRange().text;" +
      "  }" +
      IS_ACTIVE_ELEMENT_INPUT_EDITABLE_JS_SOURCE +
      "  return txt === '' && !isActiveElementEditable;" +
      "})();"

    const val GET_SELECTED_TEXT_JS_SOURCE = "(function(){" +
      "  var txt;" +
      "  if (window.getSelection) {" +
      "    txt = window.getSelection().toString();" +
      "  } else if (window.document.getSelection) {" +
      "    txt = window.document.getSelection().toString();" +
      "  } else if (window.document.selection) {" +
      "    txt = window.document.selection.createRange().text;" +
      "  }" +
      "  return txt;" +
      "})();"

    const val CHECK_GLOBAL_KEY_DOWN_EVENT_TO_HIDE_CONTEXT_MENU_JS_PLUGIN_SCRIPT_GROUP_NAME = "CHECK_GLOBAL_KEY_DOWN_EVENT_TO_HIDE_CONTEXT_MENU_JS_PLUGIN_SCRIPT"

    @JvmStatic
    fun CHECK_GLOBAL_KEY_DOWN_EVENT_TO_HIDE_CONTEXT_MENU_JS_PLUGIN_SCRIPT(
      allowedOriginRules: MutableSet<String>?,
      forMainFrameOnly: Boolean
    ): PluginScript {
      return PluginScript(
        PluginScriptsUtil.CHECK_GLOBAL_KEY_DOWN_EVENT_TO_HIDE_CONTEXT_MENU_JS_PLUGIN_SCRIPT_GROUP_NAME,
        PluginScriptsUtil.CHECK_GLOBAL_KEY_DOWN_EVENT_TO_HIDE_CONTEXT_MENU_JS_SOURCE(),
        UserScriptInjectionTime.AT_DOCUMENT_START,
        null,
        false,
        allowedOriginRules,
        forMainFrameOnly
      )
    }

    // android Workaround to hide context menu when user emit a keydown event
    @JvmStatic
    fun CHECK_GLOBAL_KEY_DOWN_EVENT_TO_HIDE_CONTEXT_MENU_JS_SOURCE(): String {
      return "(function(){" +
        "  document.addEventListener('keydown', function(e) {" +
        "    window." + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "._hideContextMenu();" +
        "  });" +
        "})();"
    }
  }
}
