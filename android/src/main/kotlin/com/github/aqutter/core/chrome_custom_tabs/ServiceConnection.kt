package com.github.aqutter.core.chrome_custom_tabs

import android.content.ComponentName
import androidx.browser.customtabs.CustomTabsClient
import androidx.browser.customtabs.CustomTabsServiceConnection
import java.lang.ref.WeakReference

/**
 * Implementation for the CustomTabsServiceConnection that avoids leaking the
 * ServiceConnectionCallback
 */
open class ServiceConnection(connectionCallback: ServiceConnectionCallback) : CustomTabsServiceConnection() {
  // A weak reference to the ServiceConnectionCallback to avoid leaking it.
  private val mConnectionCallback: WeakReference<ServiceConnectionCallback> = WeakReference(connectionCallback)

  override fun onCustomTabsServiceConnected(name: ComponentName, client: CustomTabsClient) {
    val connectionCallback = mConnectionCallback.get()
    if (connectionCallback != null) connectionCallback.onServiceConnected(client)
  }

  override fun onServiceDisconnected(name: ComponentName) {
    val connectionCallback = mConnectionCallback.get()
    if (connectionCallback != null) connectionCallback.onServiceDisconnected()
  }
}
