/*
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
 */

package com.github.aqutter.core.print_job

import android.os.Build
import androidx.annotation.RequiresApi
import com.github.aqutter.core.AqutterCorePlugin
import com.github.aqutter.core.types.Disposable

@RequiresApi(api = Build.VERSION_CODES.KITKAT)
class PrintJobManager(plugin: AqutterCorePlugin) : Disposable {
  companion object {
    // protected static in Java
    const val LOG_TAG = "PrintJobManager"
  }

  @JvmField
  var plugin: AqutterCorePlugin? = plugin
  @JvmField
  val jobs: MutableMap<String, PrintJobController?> = HashMap()

  override fun dispose() {
    val printJobControllers = jobs.values
    for (job in printJobControllers) {
      if (job != null) {
        job.dispose()
      }
    }
    jobs.clear()
    plugin = null
  }
}
