package com.github.aqutter.core.types

import android.net.http.SslCertificate
import android.os.Build
import com.github.aqutter.core.Util
import java.security.cert.CertificateEncodingException
import java.security.cert.X509Certificate
import java.util.HashMap

class SslCertificateExt private constructor(certificate: X509Certificate) : SslCertificate(certificate) {
  companion object {
    @JvmStatic
    fun toMap(sslCertificate: SslCertificate?): MutableMap<String, Any?>? {
      if (sslCertificate == null) {
        return null
      }

      val issuedByName: SslCertificate.DName? = sslCertificate.issuedBy
      var issuedBy: MutableMap<String, Any?>? = null
      if (issuedByName != null) {
        issuedBy = HashMap()
        issuedBy["CName"] = issuedByName.cName
        issuedBy["DName"] = issuedByName.dName
        issuedBy["OName"] = issuedByName.oName
        issuedBy["UName"] = issuedByName.uName
      }

      val issuedToName: SslCertificate.DName? = sslCertificate.issuedTo
      var issuedTo: MutableMap<String, Any?>? = null
      if (issuedToName != null) {
        issuedTo = HashMap()
        issuedTo["CName"] = issuedToName.cName
        issuedTo["DName"] = issuedToName.dName
        issuedTo["OName"] = issuedToName.oName
        issuedTo["UName"] = issuedToName.uName
      }

      var x509CertificateData: ByteArray? = null

      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
        try {
          val certificate: X509Certificate? = sslCertificate.x509Certificate
          if (certificate != null) {
            x509CertificateData = certificate.encoded
          }
        } catch (e: CertificateEncodingException) {
          e.printStackTrace()
        }
      } else {
        try {
          x509CertificateData = Util.getX509CertFromSslCertHack(sslCertificate)!!.encoded
        } catch (e: CertificateEncodingException) {
          e.printStackTrace()
        }
      }

      val validNotAfterDate: Long = sslCertificate.validNotAfterDate.time
      val validNotBeforeDate: Long = sslCertificate.validNotBeforeDate.time

      val sslCertificateMap: MutableMap<String, Any?> = HashMap()
      sslCertificateMap["issuedBy"] = issuedBy
      sslCertificateMap["issuedTo"] = issuedTo
      sslCertificateMap["validNotAfterDate"] = validNotAfterDate
      sslCertificateMap["validNotBeforeDate"] = validNotBeforeDate
      sslCertificateMap["x509Certificate"] = x509CertificateData
      return sslCertificateMap
    }
  }
}
