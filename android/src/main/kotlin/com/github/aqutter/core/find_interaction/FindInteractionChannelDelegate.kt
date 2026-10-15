package com.github.aqutter.core.find_interaction

import com.github.aqutter.core.types.ChannelDelegateImpl
import com.github.aqutter.core.types.FindSession
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

open class FindInteractionChannelDelegate(
  findInteractionController: FindInteractionController,
  channel: MethodChannel
) : ChannelDelegateImpl(channel) {
  private var findInteractionController: FindInteractionController? = findInteractionController

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    val findInteractionController = this.findInteractionController
    when (call.method) {
      "findAll" -> {
        if (findInteractionController != null) {
          val find = call.argument<String>("find")
          findInteractionController.findAll(find)
        }
        result.success(true)
      }
      "findNext" -> {
        if (findInteractionController != null) {
          val forward = call.argument<Boolean>("forward")
          findInteractionController.findNext(forward!!)
        }
        result.success(true)
      }
      "clearMatches" -> {
        if (findInteractionController != null) {
          findInteractionController.clearMatches()
        }
        result.success(true)
      }
      "setSearchText" -> {
        if (findInteractionController != null) {
          findInteractionController.searchText = call.argument<String>("searchText")
          result.success(true)
        } else {
          result.success(false)
        }
      }
      "getSearchText" -> {
        if (findInteractionController != null) {
          result.success(findInteractionController.searchText)
        } else {
          result.success(false)
        }
      }
      "getActiveFindSession" -> {
        val activeFindSession = findInteractionController?.activeFindSession
        if (findInteractionController != null && activeFindSession != null) {
          result.success(activeFindSession.toMap())
        } else {
          result.success(null)
        }
      }
      else -> result.notImplemented()
    }
  }

  fun onFindResultReceived(activeMatchOrdinal: Int, numberOfMatches: Int, isDoneCounting: Boolean) {
    val channel = channel
    if (channel == null) return

    val findInteractionController = this.findInteractionController
    if (isDoneCounting && findInteractionController != null && findInteractionController.webView != null) {
      findInteractionController.activeFindSession = FindSession(numberOfMatches, activeMatchOrdinal)
    }

    val obj: MutableMap<String, Any?> = HashMap()
    obj.put("activeMatchOrdinal", activeMatchOrdinal)
    obj.put("numberOfMatches", numberOfMatches)
    obj.put("isDoneCounting", isDoneCounting)
    channel.invokeMethod("onFindResultReceived", obj)
  }

  override fun dispose() {
    super.dispose()
    findInteractionController = null
  }
}
