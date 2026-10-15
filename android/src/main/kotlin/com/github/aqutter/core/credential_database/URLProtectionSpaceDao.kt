package com.github.aqutter.core.credential_database

import android.content.ContentValues
import android.provider.BaseColumns
import com.github.aqutter.core.types.URLProtectionSpace

open class URLProtectionSpaceDao(credentialDatabaseHelper: CredentialDatabaseHelper) {
  @JvmField
  var credentialDatabaseHelper: CredentialDatabaseHelper = credentialDatabaseHelper // package-private in Java

  @JvmField
  var projection: Array<String> = arrayOf( // package-private in Java
    BaseColumns._ID,
    URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_HOST,
    URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_PROTOCOL,
    URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_REALM,
    URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_PORT
  )

  fun getAll(): MutableList<URLProtectionSpace> {
    val readableDatabase = credentialDatabaseHelper.readableDatabase

    val cursor = readableDatabase.query(
      URLProtectionSpaceContract.FeedEntry.TABLE_NAME,
      projection,
      null,
      null,
      null,
      null,
      null
    )

    val urlProtectionSpaces: MutableList<URLProtectionSpace> = ArrayList()
    while (cursor.moveToNext()) {
      val rowId = cursor.getLong(cursor.getColumnIndexOrThrow(BaseColumns._ID))
      val rowHost = cursor.getString(cursor.getColumnIndexOrThrow(URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_HOST))
      val rowProtocol = cursor.getString(cursor.getColumnIndexOrThrow(URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_PROTOCOL))
      val rowRealm = cursor.getString(cursor.getColumnIndexOrThrow(URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_REALM))
      val rowPort = cursor.getInt(cursor.getColumnIndexOrThrow(URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_PORT))
      urlProtectionSpaces.add(URLProtectionSpace(rowId, rowHost, rowProtocol, rowRealm, rowPort))
    }
    cursor.close()

    return urlProtectionSpaces
  }

  fun find(host: String?, protocol: String?, realm: String?, port: Int?): URLProtectionSpace? {
    val readableDatabase = credentialDatabaseHelper.readableDatabase

    val selection = URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_HOST + " = ? AND " + URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_PROTOCOL + " = ? AND " +
      URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_REALM + " = ? AND " + URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_PORT + " = ?"
    val selectionArgs = arrayOf(host, protocol, realm, port!!.toString())

    val cursor = readableDatabase.query(
      URLProtectionSpaceContract.FeedEntry.TABLE_NAME,
      projection,
      selection,
      selectionArgs,
      null,
      null,
      null
    )

    var urlProtectionSpace: URLProtectionSpace? = null
    if (cursor.moveToNext()) {
      val rowId = cursor.getLong(cursor.getColumnIndexOrThrow(BaseColumns._ID))
      val rowHost = cursor.getString(cursor.getColumnIndexOrThrow(URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_HOST))
      val rowProtocol = cursor.getString(cursor.getColumnIndexOrThrow(URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_PROTOCOL))
      val rowRealm = cursor.getString(cursor.getColumnIndexOrThrow(URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_REALM))
      val rowPort = cursor.getInt(cursor.getColumnIndexOrThrow(URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_PORT))
      urlProtectionSpace = URLProtectionSpace(rowId, rowHost, rowProtocol, rowRealm, rowPort)
    }
    cursor.close()

    return urlProtectionSpace
  }

  fun insert(urlProtectionSpace: URLProtectionSpace): Long {
    val protectionSpaceValues = ContentValues()
    protectionSpaceValues.put(URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_HOST, urlProtectionSpace.host)
    protectionSpaceValues.put(URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_PROTOCOL, urlProtectionSpace.protocol)
    protectionSpaceValues.put(URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_REALM, urlProtectionSpace.realm)
    protectionSpaceValues.put(URLProtectionSpaceContract.FeedEntry.COLUMN_NAME_PORT, urlProtectionSpace.port)

    return credentialDatabaseHelper.writableDatabase.insert(URLProtectionSpaceContract.FeedEntry.TABLE_NAME, null, protectionSpaceValues)
  }

  fun delete(urlProtectionSpace: URLProtectionSpace): Long {
    val whereClause = BaseColumns._ID + " = ?"
    val whereArgs = arrayOf(urlProtectionSpace.id!!.toString())

    return credentialDatabaseHelper.writableDatabase.delete(URLProtectionSpaceContract.FeedEntry.TABLE_NAME, whereClause, whereArgs).toLong()
  }
}
