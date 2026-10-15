package com.github.aqutter.core.types

class WebMessage(
  @JvmField var data: String?,
  @JvmField var ports: MutableList<WebMessagePort>?
) {
  fun dispose() {
    if (ports != null) {
      ports!!.clear()
    }
  }
}
