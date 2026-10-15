package com.github.aqutter.core.print_job

import android.os.Build
import androidx.annotation.RequiresApi
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.types.Disposable
import com.github.aqutter.core.types.PrintJobInfoExt
import io.flutter.plugin.common.MethodChannel

@RequiresApi(api = Build.VERSION_CODES.KITKAT)
class PrintJobController(
  @JvmField var id: String,
  settings: PrintJobSettings?,
  plugin: AqutterCorePlugin
) : Disposable {
  companion object {
    // protected static in Java
    const val LOG_TAG = "PrintJob"
    const val METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/webview_printjobcontroller_"
  }

  @JvmField
  var plugin: AqutterCorePlugin? = plugin
  @JvmField
  var channelDelegate: PrintJobChannelDelegate?
  @JvmField
  var job: android.print.PrintJob? = null
  @JvmField
  var settings: PrintJobSettings? = settings

  init {
    val channel = MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME_PREFIX + id)
    this.channelDelegate = PrintJobChannelDelegate(this, channel)
  }

  fun setJob(job: android.print.PrintJob?) {
    this.job = job
  }

  fun cancel() {
    if (this.job != null) {
      this.job!!.cancel()
    }
  }

  fun restart() {
    if (this.job != null) {
      this.job!!.restart()
    }
  }

  fun getInfo(): PrintJobInfoExt? {
    if (this.job != null) {
      return PrintJobInfoExt.fromPrintJobInfo(this.job!!.info)
    }
    return null
  }

  fun disposeNoCancel() {
    if (channelDelegate != null) {
      channelDelegate!!.dispose()
      channelDelegate = null
    }
    if (plugin != null) {
      val printJobManager = plugin!!.printJobManager
      if (printJobManager != null && printJobManager.jobs.containsKey(id)) {
        printJobManager.jobs[id] = null
      }
    }
    if (job != null) {
      job = null
    }
    plugin = null
  }

  override fun dispose() {
    if (channelDelegate != null) {
      channelDelegate!!.dispose()
      channelDelegate = null
    }
    if (plugin != null) {
      val printJobManager = plugin!!.printJobManager
      if (printJobManager != null && printJobManager.jobs.containsKey(id)) {
        printJobManager.jobs[id] = null
      }
    }
    if (job != null) {
      job!!.cancel()
      job = null
    }
    plugin = null
  }

  fun onComplete(completed: Boolean, error: String?) {
    if (channelDelegate != null) channelDelegate!!.onComplete(completed, error)
  }
}
