package com.github.aqutter.core.types

import java.util.HashMap

class URLCredential(var username: String?, var password: String?) {
  var id: Long? = null
  var protectionSpaceId: Long? = null

  constructor(id: Long?, username: String, password: String, protectionSpaceId: Long?) : this(username, password) {
    this.id = id
    this.protectionSpaceId = protectionSpaceId
  }

  fun toMap(): MutableMap<String, Any?> {
    val urlCredentialMap: MutableMap<String, Any?> = HashMap()
    urlCredentialMap["username"] = username
    urlCredentialMap["password"] = password
    urlCredentialMap["certificates"] = null
    urlCredentialMap["persistence"] = null
    return urlCredentialMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as URLCredential

    if (if (username != null) username != that.username else that.username != null) return false
    return if (password != null) password == that.password else that.password == null
  }

  override fun hashCode(): Int {
    var result = if (username != null) username.hashCode() else 0
    result = 31 * result + (if (password != null) password.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "URLCredential{" +
      "username='" + username + '\'' +
      ", password='" + password + '\'' +
      '}'
  }
}
