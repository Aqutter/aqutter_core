package com.github.aqutter.core.types

import android.net.http.SslCertificate
import android.net.http.SslError
import java.util.HashMap

class SslErrorExt private constructor(error: Int, certificate: SslCertificate, url: String) : SslError(error, certificate, url) {
  companion object {
    @JvmStatic
    fun toMap(sslError: SslError?): MutableMap<String, Any?>? {
      if (sslError == null) {
        return null
      }

      val primaryError = sslError.primaryError

      val message: String?
      when (primaryError) {
        SslError.SSL_DATE_INVALID -> message = "The date of the certificate is invalid"
        SslError.SSL_EXPIRED -> message = "The certificate has expired"
        SslError.SSL_IDMISMATCH -> message = "Hostname mismatch"
        SslError.SSL_INVALID -> message = "A generic error occurred"
        SslError.SSL_NOTYETVALID -> message = "The certificate is not yet valid"
        SslError.SSL_UNTRUSTED -> message = "The certificate authority is not trusted"
        else -> message = null
      }

      val urlProtectionSpaceMap: MutableMap<String, Any?> = HashMap()
      urlProtectionSpaceMap["code"] = if (primaryError >= 0) primaryError else null
      urlProtectionSpaceMap["message"] = message
      return urlProtectionSpaceMap
    }
  }
}
