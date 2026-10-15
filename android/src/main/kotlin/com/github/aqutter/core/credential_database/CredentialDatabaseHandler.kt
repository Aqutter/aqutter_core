package com.github.aqutter.core.credential_database

import android.os.Build
import android.webkit.WebViewDatabase
import androidx.annotation.RequiresApi
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.types.ChannelDelegateImpl
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

@RequiresApi(api = Build.VERSION_CODES.O)
open class CredentialDatabaseHandler(plugin: AqutterCorePlugin) :
  ChannelDelegateImpl(MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME)) {

  @JvmField
  var plugin: AqutterCorePlugin? = plugin

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    val plugin = this.plugin
    if (plugin != null) {
      init(plugin)
    }
    val credentialDatabase = Companion.credentialDatabase

    when (call.method) {
      "getAllAuthCredentials" -> {
        val allCredentials: MutableList<Map<String, Any?>> = ArrayList()
        if (credentialDatabase != null) {
          val protectionSpaces = credentialDatabase.protectionSpaceDao.getAll()
          for (protectionSpace in protectionSpaces) {
            val credentials: MutableList<Map<String, Any?>> = ArrayList()
            for (credential in credentialDatabase.credentialDao.getAllByProtectionSpaceId(protectionSpace.id)) {
              credentials.add(credential.toMap())
            }
            val obj: MutableMap<String, Any?> = HashMap()
            obj.put("protectionSpace", protectionSpace.toMap())
            obj.put("credentials", credentials)
            allCredentials.add(obj)
          }
        }
        result.success(allCredentials)
      }
      "getHttpAuthCredentials" -> {
        val credentials: MutableList<Map<String, Any?>> = ArrayList()
        if (credentialDatabase != null) {
          val host = call.argument<String>("host")
          val protocol = call.argument<String>("protocol")
          val realm = call.argument<String>("realm")
          val port = call.argument<Int>("port")

          for (credential in credentialDatabase.getHttpAuthCredentials(host, protocol, realm, port)) {
            credentials.add(credential.toMap())
          }
        }
        result.success(credentials)
      }
      "setHttpAuthCredential" -> {
        if (credentialDatabase != null) {
          val host = call.argument<String>("host")
          val protocol = call.argument<String>("protocol")
          val realm = call.argument<String>("realm")
          val port = call.argument<Int>("port")
          val username = call.argument<String>("username")
          val password = call.argument<String>("password")

          credentialDatabase.setHttpAuthCredential(host, protocol, realm, port, username, password)
          result.success(true)
        } else {
          result.success(false)
        }
      }
      "removeHttpAuthCredential" -> {
        if (credentialDatabase != null) {
          val host = call.argument<String>("host")
          val protocol = call.argument<String>("protocol")
          val realm = call.argument<String>("realm")
          val port = call.argument<Int>("port")
          val username = call.argument<String>("username")
          val password = call.argument<String>("password")

          credentialDatabase.removeHttpAuthCredential(host, protocol, realm, port, username, password)
          result.success(true)
        } else {
          result.success(false)
        }
      }
      "removeHttpAuthCredentials" -> {
        if (credentialDatabase != null) {
          val host = call.argument<String>("host")
          val protocol = call.argument<String>("protocol")
          val realm = call.argument<String>("realm")
          val port = call.argument<Int>("port")

          credentialDatabase.removeHttpAuthCredentials(host, protocol, realm, port)
          result.success(true)
        } else {
          result.success(false)
        }
      }
      "clearAllAuthCredentials" -> {
        if (credentialDatabase != null) {
          credentialDatabase.clearAllAuthCredentials()
          if (plugin != null && plugin.applicationContext != null) {
            WebViewDatabase.getInstance(plugin.applicationContext).clearHttpAuthUsernamePassword()
          }
          result.success(true)
        } else {
          result.success(false)
        }
      }
      else -> result.notImplemented()
    }
  }

  override fun dispose() {
    super.dispose()
    plugin = null
    credentialDatabase = null
  }

  companion object {
    protected const val LOG_TAG = "CredentialDatabaseHandler"
    const val METHOD_CHANNEL_NAME = "com.github.aqutter/webview_credential_database"

    @JvmField
    var credentialDatabase: CredentialDatabase? = null

    @JvmStatic
    fun init(plugin: AqutterCorePlugin) {
      if (credentialDatabase == null) {
        credentialDatabase = CredentialDatabase.getInstance(plugin.applicationContext)
      }
    }
  }
}
