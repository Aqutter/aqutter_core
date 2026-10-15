package com.github.aqutter.core.types

import io.flutter.plugin.common.MethodChannel

interface IChannelDelegate : MethodChannel.MethodCallHandler, Disposable {
  fun getChannel(): MethodChannel?
}
