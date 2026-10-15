package com.github.aqutter.core.proxy

import androidx.webkit.ProxyConfig
import com.github.aqutter.core.ISettings
import com.github.aqutter.core.types.ProxyRuleExt

class ProxySettings : ISettings<ProxyConfig> {
  // package-private in Java
  @JvmField
  var bypassRules: MutableList<String> = ArrayList()
  // package-private in Java
  @JvmField
  var directs: MutableList<String> = ArrayList()
  // package-private in Java
  @JvmField
  var proxyRules: MutableList<ProxyRuleExt> = ArrayList()
  // package-private in Java
  @JvmField
  var bypassSimpleHostnames: Boolean? = null
  // package-private in Java
  @JvmField
  var removeImplicitRules: Boolean? = null
  // package-private in Java
  @JvmField
  var reverseBypassEnabled: Boolean? = false

  override fun parse(settings: MutableMap<String, Any?>): ProxySettings {
    for (pair in settings.entries) {
      val key = pair.key
      val value = pair.value
      if (value == null) {
        continue
      }

      when (key) {
        "bypassRules" -> bypassRules = value as MutableList<String>
        "directs" -> directs = value as MutableList<String>
        "proxyRules" -> {
          proxyRules = ArrayList()
          val proxyRuleMapList = value as MutableList<MutableMap<String, String?>>
          for (proxyRuleMap in proxyRuleMapList) {
            val proxyRuleExt = ProxyRuleExt.fromMap(proxyRuleMap)
            if (proxyRuleExt != null) {
              proxyRules.add(proxyRuleExt)
            }
          }
        }
        "bypassSimpleHostnames" -> bypassSimpleHostnames = value as Boolean
        "removeImplicitRules" -> removeImplicitRules = value as Boolean
        "reverseBypassEnabled" -> reverseBypassEnabled = value as Boolean
      }
    }

    return this
  }

  override fun toMap(): MutableMap<String, Any?> {
    val proxyRuleMapList: MutableList<Map<String, String?>> = ArrayList()
    for (proxyRuleExt in proxyRules) {
      proxyRuleMapList.add(proxyRuleExt.toMap())
    }
    val settings: MutableMap<String, Any?> = HashMap()
    settings["bypassRules"] = bypassRules
    settings["directs"] = directs
    settings["proxyRules"] = proxyRuleMapList
    settings["bypassSimpleHostnames"] = bypassSimpleHostnames
    settings["removeImplicitRules"] = removeImplicitRules
    settings["reverseBypassEnabled"] = reverseBypassEnabled
    return settings
  }

  override fun getRealSettings(obj: ProxyConfig): MutableMap<String, Any?> {
    val realSettings = toMap()
    val proxyRuleMapList: MutableList<Map<String, String?>> = ArrayList()
    val proxyRules = obj.proxyRules
    for (proxyRule in proxyRules) {
      val proxyRuleMap: MutableMap<String, String?> = HashMap()
      proxyRuleMap["url"] = proxyRule.url
      proxyRuleMap["schemeFilter"] = proxyRule.schemeFilter
      proxyRuleMapList.add(proxyRuleMap)
    }
    realSettings["bypassRules"] = obj.bypassRules
    realSettings["proxyRules"] = proxyRuleMapList
    realSettings["reverseBypassEnabled"] = obj.isReverseBypassEnabled
    return realSettings
  }
}
