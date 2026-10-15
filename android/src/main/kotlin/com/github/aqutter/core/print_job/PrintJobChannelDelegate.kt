package com.github.aqutter.core.print_job

import android.os.Build
import androidx.annotation.RequiresApi
import com.github.aqutter.core.types.ChannelDelegateImpl
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

@RequiresApi(api = Build.VERSION_CODES.KITKAT)
class PrintJobChannelDelegate(printJobController: PrintJobController, channel: MethodChannel) : ChannelDelegateImpl(channel) {
  private var printJobController: PrintJobController? = printJobController

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "cancel" ->
        if (printJobController != null) {
          printJobController!!.cancel()
          result.success(true)
        } else {
          result.success(false)
        }
      "restart" ->
        if (printJobController != null) {
          printJobController!!.restart()
          result.success(true)
        } else {
          result.success(false)
        }
      "getInfo" ->
        if (printJobController != null) {
          val info = printJobController!!.getInfo()
          result.success(if (info != null) info.toMap() else null)
        } else {
          result.success(null)
        }
      "dispose" ->
        if (printJobController != null) {
          printJobController!!.dispose()
          result.success(true)
        } else {
          result.success(false)
        }
      else -> result.notImplemented()
    }
  }

  fun onComplete(completed: Boolean, error: String?) {
    val channel = getChannel() ?: return
    val obj: MutableMap<String, Any?> = HashMap()
    obj["completed"] = completed
    obj["error"] = error
    channel.invokeMethod("onComplete", obj)
  }

  override fun dispose() {
    super.dispose()
    printJobController = null
  }
}
