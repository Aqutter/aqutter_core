package com.github.aqutter.core.types

import android.annotation.SuppressLint
import android.text.TextUtils
import android.webkit.WebView
import androidx.webkit.ScriptHandler
import androidx.webkit.WebViewCompat
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.Util
import com.github.aqutter.core.plugin_scripts_js.JavaScriptBridgeJS
import com.github.aqutter.core.plugin_scripts_js.PluginScriptsUtil
import org.json.JSONObject
import java.util.ArrayList
import java.util.HashMap
import java.util.HashSet
import java.util.LinkedHashSet

@SuppressLint("RestrictedApi")
class UserContentController(@JvmField var webView: WebView?) : Disposable {
  private val contentWorlds: MutableSet<ContentWorld> = HashSet<ContentWorld>().apply {
    add(ContentWorld.PAGE)
  }

  private val scriptHandlerMap: MutableMap<UserScript, ScriptHandler> = HashMap()

  private var contentWorldsCreatorScript: ScriptHandler? = null

  private val userOnlyScripts: MutableMap<UserScriptInjectionTime, LinkedHashSet<UserScript>> = HashMap<UserScriptInjectionTime, LinkedHashSet<UserScript>>().apply {
    put(UserScriptInjectionTime.AT_DOCUMENT_START, LinkedHashSet<UserScript>())
    put(UserScriptInjectionTime.AT_DOCUMENT_END, LinkedHashSet<UserScript>())
  }

  private val pluginScripts: MutableMap<UserScriptInjectionTime, LinkedHashSet<PluginScript>> = HashMap<UserScriptInjectionTime, LinkedHashSet<PluginScript>>().apply {
    put(UserScriptInjectionTime.AT_DOCUMENT_START, LinkedHashSet<PluginScript>())
    put(UserScriptInjectionTime.AT_DOCUMENT_END, LinkedHashSet<PluginScript>())
  }

  fun generateWrappedCodeForDocumentStart(): String {
    return Util.replaceAll(
      DOCUMENT_READY_WRAPPER_JS_SOURCE,
      PluginScriptsUtil.VAR_PLACEHOLDER_VALUE,
      generateCodeForDocumentStart())
  }

  fun generateWrappedCodeForDocumentEnd(): String {
    val injectionTime = UserScriptInjectionTime.AT_DOCUMENT_END
    var js = ""
    if (!WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT)) {
      // try to reload scripts if they were not loaded during the AT_DOCUMENT_START event
      js += generateCodeForDocumentStart()
    }
    js += generatePluginScriptsCodeAt(injectionTime)
    js += generateUserOnlyScriptsCodeAt(injectionTime)
    js = USER_SCRIPTS_AT_DOCUMENT_END_WRAPPER_JS_SOURCE().replace(PluginScriptsUtil.VAR_PLACEHOLDER_VALUE, js)
    return js
  }

  fun generateCodeForDocumentStart(): String {
    val injectionTime = UserScriptInjectionTime.AT_DOCUMENT_START
    var js = ""
    js += generatePluginScriptsCodeAt(injectionTime)
    js += generateContentWorldsCreatorCode()
    js += generateUserOnlyScriptsCodeAt(injectionTime)
    js = USER_SCRIPTS_AT_DOCUMENT_START_WRAPPER_JS_SOURCE().replace(PluginScriptsUtil.VAR_PLACEHOLDER_VALUE, js)
    return js
  }

  fun generateContentWorldsCreatorCode(): String {
    if (this.contentWorlds.size == 1) {
      return ""
    }

    val source = StringBuilder()
    val pluginScriptsRequired = this.getPluginScriptsRequiredInAllContentWorlds()
    for (script in pluginScriptsRequired) {
      source.append(script.source)
    }
    val contentWorldsNames: MutableList<String> = ArrayList()
    for (contentWorld in this.contentWorlds) {
      if (contentWorld == ContentWorld.PAGE) {
        continue
      }
      contentWorldsNames.add("'" + escapeContentWorldName(contentWorld.name) + "'")
    }

    return CONTENT_WORLDS_GENERATOR_JS_SOURCE()
      .replace(PluginScriptsUtil.VAR_CONTENT_WORLD_NAME_ARRAY, TextUtils.join(", ", contentWorldsNames))
      .replace(PluginScriptsUtil.VAR_JSON_SOURCE_ENCODED, escapeCode(source.toString()))

  }

  fun generatePluginScriptsCodeAt(injectionTime: UserScriptInjectionTime): String {
    val js = StringBuilder()
    val scripts = this.getPluginScriptsAt(injectionTime)
    for (script in scripts) {
      var source = ";" + script.source
      source = wrapSourceCodeInContentWorld(script.contentWorld, source)
      source = wrapSourceCodeAddChecks(source, script)
      js.append(source)
    }
    return js.toString()
  }

  fun generateUserOnlyScriptsCodeAt(injectionTime: UserScriptInjectionTime): String {
    val js = StringBuilder()
    val scripts = this.getUserOnlyScriptsAt(injectionTime)
    for (script in scripts) {
      var source = ";" + script.source
      source = wrapSourceCodeInContentWorld(script.contentWorld, source)
      source = wrapSourceCodeAddChecks(source, script)
      js.append(source)
    }
    return js.toString()
  }

  fun generateCodeForScriptEvaluation(source: String, contentWorld: ContentWorld?): String {
    if (contentWorld != null && contentWorld != ContentWorld.PAGE) {
      val sourceWrapped = StringBuilder()
      if (!contentWorlds.contains(contentWorld)) {
        contentWorlds.add(contentWorld)

        val pluginScriptsSource = StringBuilder()
        val pluginScriptsRequired = this.getPluginScriptsRequiredInAllContentWorlds()
        for (script in pluginScriptsRequired) {
          pluginScriptsSource.append(script.source)
        }
        val contentWorldCreatorCode = CONTENT_WORLDS_GENERATOR_JS_SOURCE()
          .replace(PluginScriptsUtil.VAR_CONTENT_WORLD_NAME_ARRAY, "'" + escapeContentWorldName(contentWorld.name) + "'")
          .replace(PluginScriptsUtil.VAR_JSON_SOURCE_ENCODED, escapeCode(pluginScriptsSource.toString()))
        sourceWrapped.append(contentWorldCreatorCode).append(";")
      }
      return sourceWrapped.append(wrapSourceCodeInContentWorld(contentWorld, source)).toString()
    }
    return source
  }

  fun wrapSourceCodeInContentWorld(contentWorld: ContentWorld?, source: String): String {
    val sourceWrapped = if (contentWorld == null || contentWorld == ContentWorld.PAGE) source else
      CONTENT_WORLD_WRAPPER_JS_SOURCE()
        .replace(PluginScriptsUtil.VAR_CONTENT_WORLD_NAME, escapeContentWorldName(contentWorld.name))
        .replace(PluginScriptsUtil.VAR_JSON_SOURCE_ENCODED, escapeCode(source))

    return sourceWrapped
  }

  fun getUserOnlyScriptsAt(injectionTime: UserScriptInjectionTime): LinkedHashSet<UserScript> {
    return LinkedHashSet(this.userOnlyScripts[injectionTime]!!)
  }

  private fun updateContentWorldsCreatorScript() {
    val source = generateContentWorldsCreatorCode()
    if (WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT)) {
      if (contentWorldsCreatorScript != null) {
        contentWorldsCreatorScript!!.remove()
      }
      if (!source.isEmpty() && webView != null) {
        contentWorldsCreatorScript = WebViewCompat.addDocumentStartJavaScript(
          webView!!,
          source,
          HashSet<String>().apply {
            add("*")
          }
        )
      }
    }
  }

  fun addUserOnlyScript(userOnlyScript: UserScript): Boolean {
    val contentWorld = userOnlyScript.contentWorld
    contentWorlds.add(contentWorld)
    this.updateContentWorldsCreatorScript()
    if (webView != null && WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT)) {
      var source = userOnlyScript.source
      if (userOnlyScript.injectionTime == UserScriptInjectionTime.AT_DOCUMENT_END) {
        source = "if (document.readyState === 'complete') { " + source + "} else { window.addEventListener('load', function() { " + source + " }); }"
      }
      source = wrapSourceCodeAddChecks(source, userOnlyScript)

      val scriptHandler = WebViewCompat.addDocumentStartJavaScript(
        webView!!,
        wrapSourceCodeInContentWorld(userOnlyScript.contentWorld, source),
        userOnlyScript.allowedOriginRules
      )
      this.scriptHandlerMap.put(userOnlyScript, scriptHandler)
    }
    return this.userOnlyScripts[userOnlyScript.injectionTime]!!.add(userOnlyScript)
  }

  fun addUserOnlyScripts(userOnlyScripts: List<UserScript>) {
    for (userOnlyScript in userOnlyScripts) {
      this.addUserOnlyScript(userOnlyScript)
    }
  }

  fun removeUserOnlyScript(userOnlyScript: UserScript): Boolean {
    if (WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT)) {
      val scriptHandler = this.scriptHandlerMap[userOnlyScript]
      if (scriptHandler != null) {
        scriptHandler.remove()
        this.scriptHandlerMap.remove(userOnlyScript)
      }
      this.updateContentWorldsCreatorScript()
    }
    return this.userOnlyScripts[userOnlyScript.injectionTime]!!.remove(userOnlyScript)
  }

  fun removeUserOnlyScriptAt(index: Int, injectionTime: UserScriptInjectionTime): Boolean {
    val userOnlyScript = ArrayList(this.userOnlyScripts[injectionTime]!!)[index]
    return this.removeUserOnlyScript(userOnlyScript)
  }

  fun removeAllUserOnlyScripts() {
    if (WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT)) {
      for (userOnlyScript in this.userOnlyScripts[UserScriptInjectionTime.AT_DOCUMENT_START]!!) {
        val scriptHandler = this.scriptHandlerMap[userOnlyScript]
        if (scriptHandler != null) {
          scriptHandler.remove()
          this.scriptHandlerMap.remove(userOnlyScript)
        }
      }
      for (userOnlyScript in this.userOnlyScripts[UserScriptInjectionTime.AT_DOCUMENT_END]!!) {
        val scriptHandler = this.scriptHandlerMap[userOnlyScript]
        if (scriptHandler != null) {
          scriptHandler.remove()
          this.scriptHandlerMap.remove(userOnlyScript)
        }
      }
    }
    this.userOnlyScripts[UserScriptInjectionTime.AT_DOCUMENT_START]!!.clear()
    this.userOnlyScripts[UserScriptInjectionTime.AT_DOCUMENT_END]!!.clear()
  }

  fun getPluginScriptsAt(injectionTime: UserScriptInjectionTime): LinkedHashSet<PluginScript> {
    return LinkedHashSet(this.pluginScripts[injectionTime]!!)
  }

  fun getPluginScriptsRequiredInAllContentWorlds(): LinkedHashSet<PluginScript> {
    val pluginScriptsRequired = LinkedHashSet<PluginScript>()
    val scripts = this.getPluginScriptsAt(UserScriptInjectionTime.AT_DOCUMENT_START)
    for (script in scripts) {
      if (script.isRequiredInAllContentWorlds) {
        pluginScriptsRequired.add(script)
      }
    }
    return pluginScriptsRequired
  }

  fun addPluginScript(pluginScript: PluginScript): Boolean {
    val contentWorld = pluginScript.contentWorld
    contentWorlds.add(contentWorld)
    this.updateContentWorldsCreatorScript()
    if (webView != null && WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT)) {
      var source = pluginScript.source
      if (pluginScript.injectionTime == UserScriptInjectionTime.AT_DOCUMENT_END) {
        source = "if (document.readyState === 'complete') { " + source + "} else { window.addEventListener('load', function() { " + source + " }); }"
      }
      source = wrapSourceCodeAddChecks(source, pluginScript)

      val scriptHandler = WebViewCompat.addDocumentStartJavaScript(
        webView!!,
        wrapSourceCodeInContentWorld(pluginScript.contentWorld, source),
        pluginScript.allowedOriginRules
      )
      this.scriptHandlerMap.put(pluginScript, scriptHandler)
    }
    return this.pluginScripts[pluginScript.injectionTime]!!.add(pluginScript)
  }

  fun addPluginScripts(pluginScripts: List<PluginScript>) {
    for (pluginScript in pluginScripts) {
      this.addPluginScript(pluginScript)
    }
  }

  fun removePluginScript(pluginScript: PluginScript): Boolean {
    if (WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT)) {
      val scriptHandler = this.scriptHandlerMap[pluginScript]
      if (scriptHandler != null) {
        scriptHandler.remove()
        this.scriptHandlerMap.remove(pluginScript)
      }
      this.updateContentWorldsCreatorScript()
    }
    return this.pluginScripts[pluginScript.injectionTime]!!.remove(pluginScript)
  }

  fun removeAllPluginScripts() {
    if (WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT)) {
      for (pluginScript in this.pluginScripts[UserScriptInjectionTime.AT_DOCUMENT_START]!!) {
        val scriptHandler = this.scriptHandlerMap[pluginScript]
        if (scriptHandler != null) {
          scriptHandler.remove()
          this.scriptHandlerMap.remove(pluginScript)
        }
      }
      for (pluginScript in this.pluginScripts[UserScriptInjectionTime.AT_DOCUMENT_END]!!) {
        val scriptHandler = this.scriptHandlerMap[pluginScript]
        if (scriptHandler != null) {
          scriptHandler.remove()
          this.scriptHandlerMap.remove(pluginScript)
        }
      }
    }
    this.pluginScripts[UserScriptInjectionTime.AT_DOCUMENT_START]!!.clear()
    this.pluginScripts[UserScriptInjectionTime.AT_DOCUMENT_END]!!.clear()
  }

  fun getUserOnlyScriptAsList(): LinkedHashSet<UserScript> {
    val userOnlyScripts = LinkedHashSet<UserScript>()
    val collection = this.userOnlyScripts.values
    for (list in collection) {
      userOnlyScripts.addAll(list)
    }
    return userOnlyScripts
  }

  fun getPluginScriptAsList(): LinkedHashSet<PluginScript> {
    val pluginScripts = LinkedHashSet<PluginScript>()
    val collection = this.pluginScripts.values
    for (list in collection) {
      pluginScripts.addAll(list)
    }
    return pluginScripts
  }

  fun resetContentWorlds() {
    this.contentWorlds.clear()
    this.contentWorlds.add(ContentWorld.PAGE)

    val pluginScripts = this.getPluginScriptAsList()
    for (pluginScript in pluginScripts) {
      val contentWorld = pluginScript.contentWorld
      this.contentWorlds.add(contentWorld)
    }

    val userOnlyScripts = this.getUserOnlyScriptAsList()
    for (userOnlyScript in userOnlyScripts) {
      val contentWorld = userOnlyScript.contentWorld
      this.contentWorlds.add(contentWorld)
    }
  }

  fun containsPluginScript(pluginScript: PluginScript): Boolean {
    return this.getPluginScriptAsList().contains(pluginScript)
  }

  fun containsPluginScriptByGroupName(groupName: String?): Boolean {
    val pluginScripts = this.getPluginScriptAsList()
    for (pluginScript in pluginScripts) {
      if (Util.objEquals(groupName, pluginScript.groupName)) {
        return true
      }
    }
    return false
  }

  fun containsUserOnlyScript(userOnlyScript: UserScript): Boolean {
    return this.getUserOnlyScriptAsList().contains(userOnlyScript)
  }

  fun containsUserOnlyScriptByGroupName(groupName: String?): Boolean {
    val userOnlyScripts = this.getUserOnlyScriptAsList()
    for (userOnlyScript in userOnlyScripts) {
      if (Util.objEquals(groupName, userOnlyScript.groupName)) {
        return true
      }
    }

    return false
  }

  fun removePluginScriptsByGroupName(groupName: String?) {
    val pluginScripts = this.getPluginScriptAsList()
    for (pluginScript in pluginScripts) {
      if (Util.objEquals(groupName, pluginScript.groupName)) {
        this.removePluginScript(pluginScript)
      }
    }
  }

  fun removeUserOnlyScriptsByGroupName(groupName: String?) {
    val userOnlyScripts = this.getUserOnlyScriptAsList()
    for (userOnlyScript in userOnlyScripts) {
      if (Util.objEquals(groupName, userOnlyScript.groupName)) {
        this.removeUserOnlyScript(userOnlyScript)
      }
    }
  }

  fun getContentWorlds(): LinkedHashSet<ContentWorld> {
    return LinkedHashSet(this.contentWorlds)
  }

  override fun dispose() {
    if (WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT) && contentWorldsCreatorScript != null) {
      contentWorldsCreatorScript!!.remove()
    }
    removeAllUserOnlyScripts()
    removeAllPluginScripts()
    webView = null
  }

  companion object {
    // NOTE: protected static in Java; Kotlin companion cannot restrict to subclasses of the enclosing class.
    const val LOG_TAG = "UserContentController"

    @JvmStatic
    fun escapeCode(code: String?): String {
      val escapedCode = JSONObject.quote(code)
      // escapedCode = escapedCode.substring(1, escapedCode.length() - 1);
      return escapedCode
    }

    @JvmStatic
    fun escapeContentWorldName(name: String): String {
      return name.replace(Regex("'"), "\\\\'")
    }

    private fun wrapSourceCodeAddChecks(source: String, userScript: UserScript): String {
      val ifStatement = StringBuilder("if (")
      val allowedOriginRules = userScript.allowedOriginRules
      val forMainFrameOnly = userScript.isForMainFrameOnly
      if (!WebViewFeature.isFeatureSupported(WebViewFeature.DOCUMENT_START_SCRIPT) && !allowedOriginRules.contains("*")) {
        if (allowedOriginRules.isEmpty()) {
          // return empty source string if allowedOriginRules is an empty list.
          // an empty list means that this UserScript is not allowed for any origin.
          return ""
        }
        val jsRegExpArray = StringBuilder("[")
        for (allowedOriginRule in allowedOriginRules) {
          if (jsRegExpArray.length > 1) {
            jsRegExpArray.append(", ")
          }
          jsRegExpArray.append("new RegExp(").append(UserContentController.escapeCode(allowedOriginRule)).append(")")
        }
        if (jsRegExpArray.length > 1) {
          jsRegExpArray.append("]")
          ifStatement.append(jsRegExpArray).append(".some(function(rx) { return rx.test(window.location.origin); })")
        }
      }
      if (forMainFrameOnly) {
        if (ifStatement.length > 4) {
          ifStatement.append(" && ")
        }
        ifStatement.append("window === window.top")
      }
      return if (ifStatement.length > 4) ifStatement.append(") {").append(source).append("}").toString() else source
    }

    private fun USER_SCRIPTS_AT_DOCUMENT_START_WRAPPER_JS_SOURCE(): String {
      return "if (window._" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "_userScriptsAtDocumentStartLoaded == null || !window._" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "_userScriptsAtDocumentStartLoaded) {" +
        "  window._" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "_userScriptsAtDocumentStartLoaded = true;" +
        "  " + PluginScriptsUtil.VAR_PLACEHOLDER_VALUE +
        "}"
    }

    private fun USER_SCRIPTS_AT_DOCUMENT_END_WRAPPER_JS_SOURCE(): String {
      return "if (window._" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "_userScriptsAtDocumentEndLoaded == null || !window._" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "_userScriptsAtDocumentEndLoaded) {" +
        "  window._" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "_userScriptsAtDocumentEndLoaded = true;" +
        "  " + PluginScriptsUtil.VAR_PLACEHOLDER_VALUE +
        "}"
    }

    private fun CONTENT_WORLDS_GENERATOR_JS_SOURCE(): String {
      return "(function() {" +
        "  var interval = setInterval(function() {" +
        "    if (document.body == null) {return;}" +
        "    var contentWorldNames = [" + PluginScriptsUtil.VAR_CONTENT_WORLD_NAME_ARRAY + "];" +
        "    for (var contentWorldName of contentWorldNames) {" +
        "      var iframeId = '" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "_' + contentWorldName;" +
        "      var iframe = document.getElementById(iframeId);" +
        "      if (iframe == null) {" +
        "        iframe = document.createElement('iframe');" +
        "        iframe.id = iframeId;" +
        "        iframe.style = 'display: none; z-index: 0; position: absolute; width: 0px; height: 0px';" +
        "        document.body.append(iframe);" +
        "      }" +
        "      if (iframe.contentWindow.document.getElementById('" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "_plugin_scripts') == null) {" +
        "        var script = iframe.contentWindow.document.createElement('script');" +
        "        script.id = '" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "_plugin_scripts';" +
        "        script.innerHTML = " + PluginScriptsUtil.VAR_JSON_SOURCE_ENCODED + ";" +
        "        iframe.contentWindow.document.body.append(script);" +
        "      }" +
        "    }" +
        "    clearInterval(interval);" +
        "  });" +
        "})();"
    }

    private fun CONTENT_WORLD_WRAPPER_JS_SOURCE(): String {
      return "(function() {" +
        "  var interval = setInterval(function() {" +
        "    if (document.body == null) {return;}" +
        "    var iframeId = '" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "_" + PluginScriptsUtil.VAR_CONTENT_WORLD_NAME + "';" +
        "    var iframe = document.getElementById(iframeId);" +
        "    if (iframe == null) {" +
        "      iframe = document.createElement('iframe');" +
        "      iframe.id = iframeId;" +
        "      iframe.style = 'display: none; z-index: 0; position: absolute; width: 0px; height: 0px';" +
        "      document.body.append(iframe);" +
        "    }" +
        "    if (iframe.contentWindow.document.querySelector('#" + JavaScriptBridgeJS.get_JAVASCRIPT_BRIDGE_NAME() + "_plugin_scripts') == null) {" +
        "      return;" +
        "    }" +
        "    var script = iframe.contentWindow.document.createElement('script');" +
        "    script.innerHTML = " + PluginScriptsUtil.VAR_JSON_SOURCE_ENCODED + ";" +
        "    iframe.contentWindow.document.body.append(script);" +
        "    clearInterval(interval);" +
        "  });" +
        "})();"
    }

    private val DOCUMENT_READY_WRAPPER_JS_SOURCE = "if (document.readyState === 'interactive' || document.readyState === 'complete') { " +
      "  " + PluginScriptsUtil.VAR_PLACEHOLDER_VALUE +
      "}"
  }
}
