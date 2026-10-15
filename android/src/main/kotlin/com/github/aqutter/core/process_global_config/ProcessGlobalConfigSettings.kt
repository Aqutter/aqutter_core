package com.github.aqutter.core.process_global_config

import android.content.Context
import androidx.webkit.ProcessGlobalConfig
import androidx.webkit.WebViewFeature
import com.github.aqutter.core.ISettings
import java.io.File

class ProcessGlobalConfigSettings : ISettings<ProcessGlobalConfig> {
  companion object {
    const val LOG_TAG = "ProcessGlobalConfigSettings"
  }

  @JvmField
  var dataDirectorySuffix: String? = null
  @JvmField
  var directoryBasePaths: DirectoryBasePaths? = null

  override fun parse(settings: MutableMap<String, Any?>): ProcessGlobalConfigSettings {
    for (pair in settings.entries) {
      val key = pair.key
      val value = pair.value
      if (value == null) {
        continue
      }

      when (key) {
        "dataDirectorySuffix" -> dataDirectorySuffix = value as String
        "directoryBasePaths" -> directoryBasePaths = DirectoryBasePaths().parse(value as MutableMap<String, Any?>)
      }
    }

    return this
  }

  fun toProcessGlobalConfig(context: Context): ProcessGlobalConfig {
    val config = ProcessGlobalConfig()
    if (dataDirectorySuffix != null &&
      WebViewFeature.isStartupFeatureSupported(context, WebViewFeature.STARTUP_FEATURE_SET_DATA_DIRECTORY_SUFFIX)) {
      config.setDataDirectorySuffix(context, dataDirectorySuffix!!)
    }
    if (directoryBasePaths != null &&
      WebViewFeature.isStartupFeatureSupported(context, WebViewFeature.STARTUP_FEATURE_SET_DIRECTORY_BASE_PATHS)) {
      config.setDirectoryBasePaths(context,
        File(directoryBasePaths!!.dataDirectoryBasePath!!),
        File(directoryBasePaths!!.cacheDirectoryBasePath!!))
    }
    return config
  }

  override fun toMap(): MutableMap<String, Any?> {
    val settings: MutableMap<String, Any?> = HashMap()
    settings["dataDirectorySuffix"] = dataDirectorySuffix
    return settings
  }

  override fun getRealSettings(obj: ProcessGlobalConfig): MutableMap<String, Any?> {
    val realSettings = toMap()
    return realSettings
  }

  // package-private in Java
  class DirectoryBasePaths : ISettings<Any> {
    companion object {
      const val LOG_TAG = "ProcessGlobalConfigSettings"
    }

    @JvmField
    var cacheDirectoryBasePath: String? = null
    @JvmField
    var dataDirectoryBasePath: String? = null

    override fun parse(settings: MutableMap<String, Any?>): DirectoryBasePaths {
      for (pair in settings.entries) {
        val key = pair.key
        val value = pair.value
        if (value == null) {
          continue
        }

        when (key) {
          "cacheDirectoryBasePath" -> cacheDirectoryBasePath = value as String
          "dataDirectoryBasePath" -> dataDirectoryBasePath = value as String
        }
      }

      return this
    }

    override fun toMap(): MutableMap<String, Any?> {
      val settings: MutableMap<String, Any?> = HashMap()
      settings["cacheDirectoryBasePath"] = cacheDirectoryBasePath
      settings["dataDirectoryBasePath"] = dataDirectoryBasePath
      return settings
    }

    override fun getRealSettings(obj: Any): MutableMap<String, Any?> {
      val realSettings = toMap()
      return realSettings
    }
  }
}
