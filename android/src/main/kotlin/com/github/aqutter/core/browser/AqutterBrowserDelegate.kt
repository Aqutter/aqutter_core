package com.github.aqutter.core.browser

import android.app.Activity

interface AqutterBrowserDelegate {
  fun getActivity(): Activity?
  fun getActivityResultListeners(): MutableList<ActivityResultListener>?
  fun didChangeTitle(title: String?)
  fun didStartNavigation(url: String?)
  fun didUpdateVisitedHistory(url: String?)
  fun didFinishNavigation(url: String?)
  fun didFailNavigation(url: String?, errorCode: Int, description: String?)
  fun didChangeProgress(progress: Int)
}
