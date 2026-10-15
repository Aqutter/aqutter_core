package com.github.aqutter.core.types

class FindSession(
  var resultCount: Int,
  var highlightedResultIndex: Int
) {
  var searchResultDisplayStyle: Int = 2 // matches NONE of iOS

  fun toMap(): MutableMap<String, Any?> {
    val obj: MutableMap<String, Any?> = HashMap()
    obj["resultCount"] = resultCount
    obj["highlightedResultIndex"] = highlightedResultIndex
    obj["searchResultDisplayStyle"] = searchResultDisplayStyle
    return obj
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as FindSession

    if (resultCount != that.resultCount) return false
    if (highlightedResultIndex != that.highlightedResultIndex) return false
    return searchResultDisplayStyle == that.searchResultDisplayStyle
  }

  override fun hashCode(): Int {
    var result = resultCount
    result = 31 * result + highlightedResultIndex
    result = 31 * result + searchResultDisplayStyle
    return result
  }

  override fun toString(): String {
    return "FindSession{" +
      "resultCount=" + resultCount +
      ", highlightedResultIndex=" + highlightedResultIndex +
      ", searchResultDisplayStyle=" + searchResultDisplayStyle +
      '}'
  }
}
