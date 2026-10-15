package com.github.aqutter.core

import androidx.core.content.FileProvider

open class AqutterWebViewFileProvider : FileProvider() {

  companion object {
    const val fileProviderAuthorityExtension = "aqutter_core.fileprovider"
  }

}
