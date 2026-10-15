package com.github.aqutter.core.browser

import com.github.aqutter.core.types.ChannelDelegateImpl
import com.github.aqutter.core.types.AqutterBrowserMenuItem

import io.flutter.plugin.common.MethodChannel

class AqutterBrowserChannelDelegate(channel: MethodChannel) : ChannelDelegateImpl(channel) {
  fun onBrowserCreated() {
    val channel = getChannel() ?: return
    val obj: MutableMap<String, Any?> = HashMap()
    channel.invokeMethod("onBrowserCreated", obj)
  }

  fun onMenuItemClicked(menuItem: AqutterBrowserMenuItem) {
    val channel = getChannel() ?: return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["id"] = menuItem.id
    channel.invokeMethod("onMenuItemClicked", obj)
  }

  fun onExit() {
    val channel = getChannel() ?: return
    val obj: MutableMap<String, Any?> = HashMap()
    channel.invokeMethod("onExit", obj)
  }
}
