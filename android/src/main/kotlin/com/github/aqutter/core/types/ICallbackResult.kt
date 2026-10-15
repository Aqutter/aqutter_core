package com.github.aqutter.core.types

import io.flutter.plugin.common.MethodChannel

interface ICallbackResult<T> : MethodChannel.Result {
  fun nonNullSuccess(result: T & Any): Boolean
  fun nullSuccess(): Boolean
  fun defaultBehaviour(result: T?)
  fun decodeResult(obj: Any?): T?
}
