package com.github.aqutter.core.credential_database

import android.provider.BaseColumns

open class URLProtectionSpaceContract private constructor() {

  /* Inner class that defines the table contents */
  open class FeedEntry : BaseColumns {
    companion object {
      const val TABLE_NAME = "protection_space"
      const val COLUMN_NAME_HOST = "host"
      const val COLUMN_NAME_PROTOCOL = "protocol"
      const val COLUMN_NAME_REALM = "realm"
      const val COLUMN_NAME_PORT = "port"
    }
  }
}
