package com.github.aqutter.core.types

import androidx.annotation.CallSuper
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

open class ChannelDelegateImpl(channel: MethodChannel) : IChannelDelegate {
  @JvmField
  protected var channel: MethodChannel? = channel

  init {
    channel.setMethodCallHandler(this)
  }

  override fun getChannel(): MethodChannel? {
    return channel
  }

  @CallSuper
  override fun dispose() {
    if (channel != null) {
      channel!!.setMethodCallHandler(null)
      channel = null
    }
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

  }
}
