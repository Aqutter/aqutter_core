/*
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
 */

package com.github.aqutter.core.browser

import android.app.Activity
import android.content.Intent
import android.content.pm.ResolveInfo
import android.net.Uri
import android.os.Bundle
import android.os.Parcelable
import android.provider.Browser
import android.util.Log
import android.webkit.MimeTypeMap

import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.types.ChannelDelegateImpl

import java.io.Serializable
import java.util.UUID

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

/**
 * AqutterBrowserManager
 */
class AqutterBrowserManager(plugin: AqutterCorePlugin) :
  ChannelDelegateImpl(MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME)) {

  @JvmField
  var plugin: AqutterCorePlugin? = plugin

  @JvmField
  var id: String = UUID.randomUUID().toString()

  init {
    shared[this.id] = this
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "open" -> {
        val plugin = this.plugin
        val activity = plugin?.activity
        if (plugin != null && activity != null) {
          open(activity, call.arguments<MutableMap<String, Any?>>()!!)
          result.success(true)
        } else {
          result.success(false)
        }
      }
      "openWithSystemBrowser" -> {
        val plugin = this.plugin
        val activity = plugin?.activity
        if (plugin != null && activity != null) {
          val url = call.argument<String>("url")
          openWithSystemBrowser(activity, url, result)
        } else {
          result.success(false)
        }
      }
      else -> result.notImplemented()
    }
  }

  /**
   * Display a new browser with the specified URL.
   *
   * @param url the url to load.
   * @param result
   * @return "" if ok, or error message.
   */
  fun openWithSystemBrowser(activity: Activity, url: String?, result: Result) {
    try {
      val intent: Intent
      intent = Intent(Intent.ACTION_VIEW)
      // Omitting the MIME type for file: URLs causes "No Activity found to handle Intent".
      // Adding the MIME type to http: URLs causes them to not be handled by the downloader.
      val uri = Uri.parse(url!!)
      if ("file" == uri.scheme) {
        intent.setDataAndType(uri, getMimeType(url))
      } else {
        intent.data = uri
      }
      intent.putExtra(Browser.EXTRA_APPLICATION_ID, activity.packageName)
      // CB-10795: Avoid circular loops by preventing it from opening in the current app
      this.openExternalExcludeCurrentApp(activity, intent)
      result.success(true)
      // not catching FileUriExposedException explicitly because buildtools<24 doesn't know about it
    } catch (e: RuntimeException) {
      Log.d(LOG_TAG, url + " cannot be opened: " + e.toString())
      result.error(LOG_TAG, url + " cannot be opened!", null)
    }
  }

  /**
   * Opens the intent, providing a chooser that excludes the current app to avoid
   * circular loops.
   */
  fun openExternalExcludeCurrentApp(activity: Activity, intent: Intent) {
    val currentPackage = activity.packageName
    var hasCurrentPackage = false
    val pm = activity.packageManager
    val activities: List<ResolveInfo> = pm.queryIntentActivities(intent, 0)
    val targetIntents = ArrayList<Intent>()
    for (ri in activities) {
      if (currentPackage != ri.activityInfo.packageName) {
        val targetIntent = intent.clone() as Intent
        targetIntent.setPackage(ri.activityInfo.packageName)
        targetIntents.add(targetIntent)
      } else {
        hasCurrentPackage = true
      }
    }
    // If the current app package isn't a target for this URL, then use
    // the normal launch behavior
    if (!hasCurrentPackage || targetIntents.size == 0) {
      activity.startActivity(intent)
    }
    // If there's only one possible intent, launch it directly
    else if (targetIntents.size == 1) {
      activity.startActivity(targetIntents[0])
    }
    // Otherwise, show a custom chooser without the current app listed
    else if (targetIntents.size > 0) {
      val chooser = Intent.createChooser(targetIntents.removeAt(targetIntents.size - 1), null)
      chooser.putExtra(Intent.EXTRA_INITIAL_INTENTS, targetIntents.toTypedArray<Parcelable>())
      activity.startActivity(chooser)
    }
  }

  fun open(activity: Activity, arguments: MutableMap<String, Any?>) {
    val id = arguments["id"] as String?
    val urlRequest = arguments["urlRequest"] as MutableMap<String, Any?>?
    val assetFilePath = arguments["assetFilePath"] as String?
    val data = arguments["data"] as String?
    val mimeType = arguments["mimeType"] as String?
    val encoding = arguments["encoding"] as String?
    val baseUrl = arguments["baseUrl"] as String?
    val historyUrl = arguments["historyUrl"] as String?
    val settings = arguments["settings"] as MutableMap<String, Any?>?
    val contextMenu = arguments["contextMenu"] as MutableMap<String, Any?>?
    val windowId = arguments["windowId"] as Int?
    val initialUserScripts = arguments["initialUserScripts"] as List<MutableMap<String, Any?>>?
    val pullToRefreshInitialSettings = arguments["pullToRefreshSettings"] as MutableMap<String, Any?>?
    val menuItems = arguments["menuItems"] as List<MutableMap<String, Any?>>?

    val extras = Bundle()
    extras.putString("fromActivity", activity.javaClass.name)
    extras.putSerializable("initialUrlRequest", urlRequest as Serializable?)
    extras.putString("initialFile", assetFilePath)
    extras.putString("initialData", data)
    extras.putString("initialMimeType", mimeType)
    extras.putString("initialEncoding", encoding)
    extras.putString("initialBaseUrl", baseUrl)
    extras.putString("initialHistoryUrl", historyUrl)
    extras.putString("id", id)
    extras.putString("managerId", this.id)
    extras.putSerializable("settings", settings as Serializable?)
    extras.putSerializable("contextMenu", contextMenu as Serializable?)
    extras.putInt("windowId", windowId ?: -1)
    extras.putSerializable("initialUserScripts", initialUserScripts as Serializable?)
    extras.putSerializable("pullToRefreshInitialSettings", pullToRefreshInitialSettings as Serializable?)
    extras.putSerializable("menuItems", menuItems as Serializable?)
    startAqutterBrowserActivity(activity, extras)
  }

  fun startAqutterBrowserActivity(activity: Activity, extras: Bundle?) {
    val intent = Intent(activity, AqutterBrowserActivity::class.java)
    if (extras != null)
      intent.putExtras(extras)
    activity.startActivity(intent)
  }

  override fun dispose() {
    super.dispose()
    shared.remove(this.id)
    plugin = null
  }

  companion object {
    // protected static in Java
    const val LOG_TAG = "AqutterBrowserManager"
    const val METHOD_CHANNEL_NAME = "com.github.aqutter/browser"

    @JvmField
    val shared: MutableMap<String, AqutterBrowserManager> = HashMap()

    @JvmStatic
    fun getMimeType(url: String?): String? {
      var type: String? = null
      val extension = MimeTypeMap.getFileExtensionFromUrl(url)
      if (extension != null) {
        type = MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension)
      }
      return type
    }
  }
}
