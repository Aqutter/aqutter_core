package com.github.aqutter.core.types

import android.os.Build
import android.print.PrintJobInfo
import androidx.annotation.RequiresApi

@RequiresApi(api = Build.VERSION_CODES.KITKAT)
class PrintJobInfoExt {
  private var state: Int = 0
  private var copies: Int = 0
  private var numberOfPages: Int? = null
  private var creationTime: Long = 0
  private var label: String? = null
  private var printerId: String? = null
  private var attributes: PrintAttributesExt? = null

  fun toMap(): MutableMap<String, Any?> {
    val obj: MutableMap<String, Any?> = HashMap()
    obj["state"] = state
    obj["copies"] = copies
    obj["numberOfPages"] = numberOfPages
    obj["creationTime"] = creationTime
    obj["label"] = label
    val printer: MutableMap<String, Any?> = HashMap()
    printer["id"] = printerId
    obj["printer"] = printer
    obj["attributes"] = if (attributes != null) attributes!!.toMap() else null
    return obj
  }

  companion object {
    @JvmStatic
    fun fromPrintJobInfo(info: PrintJobInfo?): PrintJobInfoExt? {
      if (info == null) {
        return null
      }
      val printJobInfoExt = PrintJobInfoExt()
      printJobInfoExt.state = info.state
      printJobInfoExt.copies = info.copies
      printJobInfoExt.numberOfPages = if (info.pages != null) info.pages!!.size else null
      printJobInfoExt.creationTime = info.creationTime
      printJobInfoExt.label = info.label
      printJobInfoExt.printerId = if (info.printerId != null) info.printerId!!.localId else null
      printJobInfoExt.attributes = PrintAttributesExt.fromPrintAttributes(info.attributes)
      return printJobInfoExt
    }
  }
}
