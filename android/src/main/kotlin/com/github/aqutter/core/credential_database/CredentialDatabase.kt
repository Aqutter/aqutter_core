package com.github.aqutter.core.credential_database

import android.content.Context
import android.util.Log
import com.github.aqutter.core.types.URLCredential
import com.github.aqutter.core.types.URLProtectionSpace

open class CredentialDatabase private constructor(
  db: CredentialDatabaseHelper,
  protectionSpaceDao: URLProtectionSpaceDao,
  credentialDao: URLCredentialDao
) {

  @JvmField
  var protectionSpaceDao: URLProtectionSpaceDao = protectionSpaceDao

  @JvmField
  var credentialDao: URLCredentialDao = credentialDao

  @JvmField
  var db: CredentialDatabaseHelper = db

  fun getHttpAuthCredentials(host: String?, protocol: String?, realm: String?, port: Int?): MutableList<URLCredential> {
    var credentials: MutableList<URLCredential> = ArrayList()
    val protectionSpace = protectionSpaceDao.find(host, protocol, realm, port)
    if (protectionSpace != null) {
      credentials = credentialDao.getAllByProtectionSpaceId(protectionSpace.id)
    }
    return credentials
  }

  fun clearAllAuthCredentials() {
    db.clearAllTables(db.writableDatabase)
  }

  fun removeHttpAuthCredentials(host: String?, protocol: String?, realm: String?, port: Int?) {
    val urlProtectionSpace = protectionSpaceDao.find(host, protocol, realm, port)
    if (urlProtectionSpace != null) {
      protectionSpaceDao.delete(urlProtectionSpace)
    }
  }

  fun removeHttpAuthCredential(host: String?, protocol: String?, realm: String?, port: Int?, username: String?, password: String?) {
    val protectionSpace = protectionSpaceDao.find(host, protocol, realm, port)
    if (protectionSpace != null) {
      val credential = credentialDao.find(username, password, protectionSpace.id)
      credentialDao.delete(credential!!)
    }
  }

  fun setHttpAuthCredential(host: String?, protocol: String?, realm: String?, port: Int?, username: String?, password: String?) {
    val protectionSpace = protectionSpaceDao.find(host, protocol, realm, port)
    val protectionSpaceId: Long?
    if (protectionSpace == null) {
      protectionSpaceId = protectionSpaceDao.insert(URLProtectionSpace(null, host, protocol, realm, port!!))
    } else {
      protectionSpaceId = protectionSpace.id
    }

    var credential = credentialDao.find(username, password, protectionSpaceId)
    if (credential != null) {
      var needUpdate = false
      if (!credential.username!!.equals(username)) {
        credential.username = username
        needUpdate = true
      }
      if (!credential.password!!.equals(password)) {
        credential.password = password
        needUpdate = true
      }
      if (needUpdate)
        credentialDao.update(credential)
    } else {
      credential = URLCredential(null, username!!, password!!, protectionSpaceId)
      credential.id = credentialDao.insert(credential)
    }
  }

  companion object {
    private var instance: CredentialDatabase? = null
    const val LOG_TAG = "CredentialDatabase" // package-private in Java

    // If you change the database schema, you must increment the database version.
    const val DATABASE_VERSION = 2
    const val DATABASE_NAME = "aqutter_credential_database.db"
    private const val LEGACY_DATABASE_NAME = "CredentialDatabase.db"
    private val DATABASE_FILE_SUFFIXES = arrayOf("", "-journal", "-wal", "-shm")

    // 舊版資料庫名稱為 CredentialDatabase.db；首次開啟時把檔案（含 journal／wal／shm）搬到新名稱，已存的 HTTP 認證不遺失
    private fun migrateLegacyDatabase(context: Context) {
      try {
        val legacy = context.getDatabasePath(LEGACY_DATABASE_NAME)
        val target = context.getDatabasePath(DATABASE_NAME)
        if (!legacy.exists() || target.exists()) {
          return
        }
        target.parentFile?.mkdirs()
        for (suffix in DATABASE_FILE_SUFFIXES) {
          val from = java.io.File(legacy.path + suffix)
          if (!from.exists()) {
            continue
          }
          val to = java.io.File(target.path + suffix)
          if (!from.renameTo(to)) {
            from.copyTo(to, overwrite = true)
            from.delete()
          }
        }
      } catch (e: Exception) {
        Log.e(LOG_TAG, "Failed to migrate the legacy credential database", e)
      }
    }

    @JvmStatic
    fun getInstance(context: Context): CredentialDatabase {
      if (instance != null)
        return instance!!
      migrateLegacyDatabase(context)
      val db = CredentialDatabaseHelper(context)
      instance = CredentialDatabase(db, URLProtectionSpaceDao(db), URLCredentialDao(db))
      return instance!!
    }
  }
}
