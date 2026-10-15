package com.github.aqutter.core

import android.app.Activity
import android.content.Context
import android.os.Build
import com.github.aqutter.core.chrome_custom_tabs.ChromeSafariBrowserManager
import com.github.aqutter.core.chrome_custom_tabs.NoHistoryCustomTabsActivityCallbacks
import com.github.aqutter.core.credential_database.CredentialDatabaseHandler
import com.github.aqutter.core.headless_webview.AqutterHeadlessWebViewManager
import com.github.aqutter.core.browser.AqutterBrowserManager
import com.github.aqutter.core.print_job.PrintJobManager
import com.github.aqutter.core.process_global_config.ProcessGlobalConfigManager
import com.github.aqutter.core.proxy.ProxyManager
import com.github.aqutter.core.service_worker.ServiceWorkerManager
import com.github.aqutter.core.tracing.TracingControllerManager
import com.github.aqutter.core.webview.FlutterWebViewFactory
import com.github.aqutter.core.webview.AqutterWebViewManager
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformViewRegistry

open class AqutterCorePlugin : FlutterPlugin, ActivityAware {

  @JvmField
  var platformUtil: PlatformUtil? = null
  @JvmField
  var aqutterBrowserManager: AqutterBrowserManager? = null
  @JvmField
  var headlessAqutterWebViewManager: AqutterHeadlessWebViewManager? = null
  @JvmField
  var chromeSafariBrowserManager: ChromeSafariBrowserManager? = null
  @JvmField
  var noHistoryCustomTabsActivityCallbacks: NoHistoryCustomTabsActivityCallbacks? = null
  @JvmField
  var aqutterWebViewManager: AqutterWebViewManager? = null
  @JvmField
  var myCookieManager: MyCookieManager? = null
  @JvmField
  var credentialDatabaseHandler: CredentialDatabaseHandler? = null
  @JvmField
  var myWebStorage: MyWebStorage? = null
  @JvmField
  var serviceWorkerManager: ServiceWorkerManager? = null
  @JvmField
  var webViewFeatureManager: WebViewFeatureManager? = null
  @JvmField
  var proxyManager: ProxyManager? = null
  @JvmField
  var printJobManager: PrintJobManager? = null
  @JvmField
  var tracingControllerManager: TracingControllerManager? = null
  @JvmField
  var processGlobalConfigManager: ProcessGlobalConfigManager? = null
  lateinit var flutterWebViewFactory: FlutterWebViewFactory
  lateinit var applicationContext: Context
  lateinit var messenger: BinaryMessenger
  lateinit var flutterAssets: FlutterPlugin.FlutterAssets
  @JvmField
  var activityPluginBinding: ActivityPluginBinding? = null
  @JvmField
  var activity: Activity? = null
  @JvmField
  var flutterView: FlutterView? = null

  override fun onAttachedToEngine(binding: FlutterPluginBinding) {
    this.flutterAssets = binding.flutterAssets

    // Shared.activity could be null or not.
    // It depends on who is called first between onAttachedToEngine event and onAttachedToActivity event.
    //
    // See https://github.com/pichillilorenzo/flutter_inappwebview/issues/390#issuecomment-647039084
    onAttachedToEngine(
      binding.applicationContext, binding.binaryMessenger, this.activity, binding.platformViewRegistry, null)
  }

  private fun onAttachedToEngine(applicationContext: Context, messenger: BinaryMessenger, activity: Activity?, platformViewRegistry: PlatformViewRegistry, flutterView: FlutterView?) {
    this.applicationContext = applicationContext
    this.activity = activity
    this.messenger = messenger
    this.flutterView = flutterView

    aqutterBrowserManager = AqutterBrowserManager(this)
    headlessAqutterWebViewManager = AqutterHeadlessWebViewManager(this)
    chromeSafariBrowserManager = ChromeSafariBrowserManager(this)
    noHistoryCustomTabsActivityCallbacks = NoHistoryCustomTabsActivityCallbacks(this)
    flutterWebViewFactory = FlutterWebViewFactory(this)
    platformViewRegistry.registerViewFactory(
      FlutterWebViewFactory.VIEW_TYPE_ID, flutterWebViewFactory)

    platformUtil = PlatformUtil(this)
    aqutterWebViewManager = AqutterWebViewManager(this)
    myCookieManager = MyCookieManager(this)
    myWebStorage = MyWebStorage(this)
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
      serviceWorkerManager = ServiceWorkerManager(this)
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      credentialDatabaseHandler = CredentialDatabaseHandler(this)
    }
    webViewFeatureManager = WebViewFeatureManager(this)
    proxyManager = ProxyManager(this)
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
      printJobManager = PrintJobManager(this)
    }
    tracingControllerManager = TracingControllerManager(this)
    processGlobalConfigManager = ProcessGlobalConfigManager(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
    if (platformUtil != null) {
      platformUtil?.dispose()
      platformUtil = null
    }
    if (aqutterBrowserManager != null) {
      aqutterBrowserManager?.dispose()
      aqutterBrowserManager = null
    }
    if (headlessAqutterWebViewManager != null) {
      headlessAqutterWebViewManager?.dispose()
      headlessAqutterWebViewManager = null
    }
    if (chromeSafariBrowserManager != null) {
      chromeSafariBrowserManager?.dispose()
      chromeSafariBrowserManager = null
    }
    if (noHistoryCustomTabsActivityCallbacks != null) {
      noHistoryCustomTabsActivityCallbacks?.dispose()
      noHistoryCustomTabsActivityCallbacks = null
    }
    if (myCookieManager != null) {
      myCookieManager?.dispose()
      myCookieManager = null
    }
    if (myWebStorage != null) {
      myWebStorage?.dispose()
      myWebStorage = null
    }
    if (credentialDatabaseHandler != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      credentialDatabaseHandler?.dispose()
      credentialDatabaseHandler = null
    }
    if (aqutterWebViewManager != null) {
      aqutterWebViewManager?.dispose()
      aqutterWebViewManager = null
    }
    if (serviceWorkerManager != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
      serviceWorkerManager?.dispose()
      serviceWorkerManager = null
    }
    if (webViewFeatureManager != null) {
      webViewFeatureManager?.dispose()
      webViewFeatureManager = null
    }
    if (proxyManager != null) {
      proxyManager?.dispose()
      proxyManager = null
    }
    if (printJobManager != null && Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
      printJobManager?.dispose()
      printJobManager = null
    }
    if (tracingControllerManager != null) {
      tracingControllerManager?.dispose()
      tracingControllerManager = null
    }
    if (processGlobalConfigManager != null) {
      processGlobalConfigManager?.dispose()
      processGlobalConfigManager = null
    }
  }

  override fun onAttachedToActivity(activityPluginBinding: ActivityPluginBinding) {
    this.activityPluginBinding = activityPluginBinding
    val activity = activityPluginBinding.activity
    this.activity = activity

    if (noHistoryCustomTabsActivityCallbacks != null) {
      activity.application.registerActivityLifecycleCallbacks(noHistoryCustomTabsActivityCallbacks!!.activityLifecycleCallbacks)
    }
  }

  override fun onDetachedFromActivityForConfigChanges() {
    if (activity != null && noHistoryCustomTabsActivityCallbacks != null) {
      activity!!.application.unregisterActivityLifecycleCallbacks(noHistoryCustomTabsActivityCallbacks!!.activityLifecycleCallbacks)
    }

    activityPluginBinding = null
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(activityPluginBinding: ActivityPluginBinding) {
    this.activityPluginBinding = activityPluginBinding
    val activity = activityPluginBinding.activity
    this.activity = activity

    if (noHistoryCustomTabsActivityCallbacks != null) {
      activity.application.registerActivityLifecycleCallbacks(noHistoryCustomTabsActivityCallbacks!!.activityLifecycleCallbacks)
    }
  }

  override fun onDetachedFromActivity() {
    if (activity != null && noHistoryCustomTabsActivityCallbacks != null) {
      activity!!.application.unregisterActivityLifecycleCallbacks(noHistoryCustomTabsActivityCallbacks!!.activityLifecycleCallbacks)
    }

    activityPluginBinding = null
    activity = null
  }

  companion object {
    protected const val LOG_TAG = "AqutterWebViewFlutterPL"
  }
}
