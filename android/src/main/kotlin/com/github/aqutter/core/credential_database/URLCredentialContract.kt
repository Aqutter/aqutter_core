package com.github.aqutter.core.credential_database

import android.provider.BaseColumns

open class URLCredentialContract private constructor() {

  /* Inner class that defines the table contents */
  open class FeedEntry : BaseColumns {
    companion object {
      const val TABLE_NAME = "credential"
      const val COLUMN_NAME_USERNAME = "username"
      const val COLUMN_NAME_PASSWORD = "password"
      const val COLUMN_NAME_PROTECTION_SPACE_ID = "protection_space_id"
    }
  }
}
