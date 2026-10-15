package com.github.aqutter.core.types

import android.net.http.SslCertificate
import android.net.http.SslError
import java.util.HashMap

class URLProtectionSpace(
  var host: String?,
  var protocol: String?,
  var realm: String?,
  var port: Int,
  var sslCertificate: SslCertificate?,
  var sslError: SslError?
) {
  var id: Long? = null

  constructor(id: Long?, host: String?, protocol: String?, realm: String?, port: Int) : this(host, protocol, realm, port, null, null) {
    this.id = id
  }

  fun toMap(): MutableMap<String, Any?> {
    val urlProtectionSpaceMap: MutableMap<String, Any?> = HashMap()
    urlProtectionSpaceMap["host"] = host
    urlProtectionSpaceMap["protocol"] = protocol
    urlProtectionSpaceMap["realm"] = realm
    urlProtectionSpaceMap["port"] = port
    urlProtectionSpaceMap["sslCertificate"] = SslCertificateExt.toMap(sslCertificate)
    urlProtectionSpaceMap["sslError"] = SslErrorExt.toMap(sslError)
    urlProtectionSpaceMap["authenticationMethod"] = null
    urlProtectionSpaceMap["distinguishedNames"] = null
    urlProtectionSpaceMap["receivesCredentialSecurely"] = null
    urlProtectionSpaceMap["isProxy"] = null
    urlProtectionSpaceMap["proxyType"] = null
    return urlProtectionSpaceMap
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || javaClass != other.javaClass) return false

    val that = other as URLProtectionSpace

    if (port != that.port) return false
    if (host!! != that.host) return false
    if (protocol!! != that.protocol) return false
    if (if (realm != null) realm != that.realm else that.realm != null) return false
    if (if (sslCertificate != null) sslCertificate != that.sslCertificate else that.sslCertificate != null)
      return false
    return if (sslError != null) sslError == that.sslError else that.sslError == null
  }

  override fun hashCode(): Int {
    var result = host!!.hashCode()
    result = 31 * result + protocol!!.hashCode()
    result = 31 * result + (if (realm != null) realm.hashCode() else 0)
    result = 31 * result + port
    result = 31 * result + (if (sslCertificate != null) sslCertificate.hashCode() else 0)
    result = 31 * result + (if (sslError != null) sslError.hashCode() else 0)
    return result
  }

  override fun toString(): String {
    return "URLProtectionSpace{" +
      "host='" + host + '\'' +
      ", protocol='" + protocol + '\'' +
      ", realm='" + realm + '\'' +
      ", port=" + port +
      ", sslCertificate=" + sslCertificate +
      ", sslError=" + sslError +
      '}'
  }
}
