package com.github.aqutter.core.types

open class BaseCallbackResultImpl<T> : ICallbackResult<T> {
  override fun nonNullSuccess(result: T & Any): Boolean {
    return true
  }

  override fun nullSuccess(): Boolean {
    return true
  }

  override fun defaultBehaviour(result: T?) {}

  override fun success(obj: Any?) {
    val result = decodeResult(obj)
    val shouldRunDefaultBehaviour: Boolean
    if (result == null) {
      shouldRunDefaultBehaviour = nullSuccess()
    } else {
      shouldRunDefaultBehaviour = nonNullSuccess(result)
    }
    if (shouldRunDefaultBehaviour) {
      defaultBehaviour(result)
    }
  }

  override fun decodeResult(obj: Any?): T? {
    return null
  }

  override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {}

  override fun notImplemented() {
    defaultBehaviour(null)
  }
}
