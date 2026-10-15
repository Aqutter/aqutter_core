package com.github.aqutter.core.content_blocker

import java.util.regex.Pattern

open class ContentBlockerTrigger(
  urlFilter: String,
  urlFilterIsCaseSensitive: Boolean?,
  resourceType: MutableList<ContentBlockerTriggerResourceType>?,
  ifDomain: MutableList<String>?,
  unlessDomain: MutableList<String>?,
  loadType: MutableList<String>?,
  ifTopUrl: MutableList<String>?,
  unlessTopUrl: MutableList<String>?
) {

  var urlFilter: String

  var urlFilterPatternCompiled: Pattern

  var urlFilterIsCaseSensitive: Boolean

  var resourceType: MutableList<ContentBlockerTriggerResourceType> = ArrayList()

  var ifDomain: MutableList<String> = ArrayList()

  var unlessDomain: MutableList<String> = ArrayList()

  var loadType: MutableList<String> = ArrayList()

  var ifTopUrl: MutableList<String> = ArrayList()

  var unlessTopUrl: MutableList<String> = ArrayList()

  init {
    this.urlFilterIsCaseSensitive = if (urlFilterIsCaseSensitive != null) urlFilterIsCaseSensitive else false

    this.urlFilter = urlFilter
    this.urlFilterPatternCompiled = Pattern.compile(this.urlFilter, if (this.urlFilterIsCaseSensitive) 0 else Pattern.CASE_INSENSITIVE)

    this.resourceType = if (resourceType != null) resourceType else this.resourceType
    this.ifDomain = if (ifDomain != null) ifDomain else this.ifDomain
    this.unlessDomain = if (unlessDomain != null) unlessDomain else this.unlessDomain
    if ((!(this.ifDomain.isEmpty() || this.unlessDomain.isEmpty())) != false)
      throw AssertionError()
    this.loadType = if (loadType != null) loadType else this.loadType
    if ((this.loadType.size > 2)) throw AssertionError()
    this.ifTopUrl = if (ifTopUrl != null) ifTopUrl else this.ifTopUrl
    this.unlessTopUrl = if (unlessTopUrl != null) unlessTopUrl else this.unlessTopUrl
    if ((!(this.ifTopUrl.isEmpty() || this.unlessTopUrl.isEmpty())) != false)
      throw AssertionError()
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as ContentBlockerTrigger

    if (urlFilter != that.urlFilter) return false
    if (urlFilterPatternCompiled != that.urlFilterPatternCompiled) return false
    if (urlFilterIsCaseSensitive != that.urlFilterIsCaseSensitive) return false
    if (resourceType != that.resourceType) return false
    if (ifDomain != that.ifDomain) return false
    if (unlessDomain != that.unlessDomain) return false
    if (loadType != that.loadType) return false
    if (ifTopUrl != that.ifTopUrl) return false
    return unlessTopUrl == that.unlessTopUrl
  }

  override fun hashCode(): Int {
    var result = urlFilter.hashCode()
    result = 31 * result + urlFilterPatternCompiled.hashCode()
    result = 31 * result + urlFilterIsCaseSensitive.hashCode()
    result = 31 * result + resourceType.hashCode()
    result = 31 * result + ifDomain.hashCode()
    result = 31 * result + unlessDomain.hashCode()
    result = 31 * result + loadType.hashCode()
    result = 31 * result + ifTopUrl.hashCode()
    result = 31 * result + unlessTopUrl.hashCode()
    return result
  }

  override fun toString(): String {
    return "ContentBlockerTrigger{" +
      "urlFilter='" + urlFilter + '\'' +
      ", urlFilterPatternCompiled=" + urlFilterPatternCompiled +
      ", urlFilterIsCaseSensitive=" + urlFilterIsCaseSensitive +
      ", resourceType=" + resourceType +
      ", ifDomain=" + ifDomain +
      ", unlessDomain=" + unlessDomain +
      ", loadType=" + loadType +
      ", ifTopUrl=" + ifTopUrl +
      ", unlessTopUrl=" + unlessTopUrl +
      '}'
  }

  companion object {
    @JvmStatic
    fun fromMap(map: Map<String, Any?>): ContentBlockerTrigger {
      val urlFilter = map.get("url-filter") as String
      val urlFilterIsCaseSensitive = map.get("url-filter-is-case-sensitive") as Boolean?
      val resourceTypeStringList = map.get("resource-type") as List<String>?
      val resourceType: MutableList<ContentBlockerTriggerResourceType> = ArrayList()
      if (resourceTypeStringList != null) {
        for (type in resourceTypeStringList) {
          resourceType.add(ContentBlockerTriggerResourceType.fromValue(type))
        }
      } else {
        resourceType.addAll(ContentBlockerTriggerResourceType.values())
      }
      val ifDomain = map.get("if-domain") as MutableList<String>?
      val unlessDomain = map.get("unless-domain") as MutableList<String>?
      val loadType = map.get("load-type") as MutableList<String>?
      val ifTopUrl = map.get("if-top-url") as MutableList<String>?
      val unlessTopUrl = map.get("unless-top-url") as MutableList<String>?
      return ContentBlockerTrigger(urlFilter, urlFilterIsCaseSensitive, resourceType, ifDomain, unlessDomain, loadType, ifTopUrl, unlessTopUrl)
    }
  }
}
