//
//  PluginScripts.swift
//  aqutter_core
//
//  Created by Lorenzo Pichilli on 16/02/21.
//

import Foundation

public class PluginScriptsUtil {
    public static let VAR_PLACEHOLDER_VALUE = "$AQUTTER_WEBVIEW_PLACEHOLDER_VALUE"
    public static let VAR_FUNCTION_ARGUMENT_NAMES = "$AQUTTER_WEBVIEW_FUNCTION_ARGUMENT_NAMES"
    public static let VAR_FUNCTION_ARGUMENT_VALUES = "$AQUTTER_WEBVIEW_FUNCTION_ARGUMENT_VALUES"
    public static let VAR_FUNCTION_ARGUMENTS_OBJ = "$AQUTTER_WEBVIEW_FUNCTION_ARGUMENTS_OBJ"
    public static let VAR_FUNCTION_BODY = "$AQUTTER_WEBVIEW_FUNCTION_BODY"
    public static let VAR_RESULT_UUID = "$AQUTTER_WEBVIEW_RESULT_UUID"

    public static let GET_SELECTED_TEXT_JS_SOURCE = """
(function(){
    var txt;
    if (window.getSelection) {
      txt = window.getSelection().toString();
    } else if (window.document.getSelection) {
      txt = window.document.getSelection().toString();
    } else if (window.document.selection) {
      txt = window.document.selection.createRange().text;
    }
    return txt;
})();
"""
}
