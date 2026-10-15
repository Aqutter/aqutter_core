#ifndef AQUTTER_CORE_PLUGIN_HEADLESS_AQUTTER_WEBVIEW_MANAGER_H_
#define AQUTTER_CORE_PLUGIN_HEADLESS_AQUTTER_WEBVIEW_MANAGER_H_

#include <flutter/method_channel.h>
#include <map>
#include <string>
#include <wil/com.h>
#include <winrt/base.h>

#include "../aqutter_core_plugin.h"
#include "../types/channel_delegate.h"
#include "headless_webview.h"

namespace aqutter_core_plugin
{
  class AqutterHeadlessWebViewManager : public ChannelDelegate
  {
  public:
    static inline const std::string METHOD_CHANNEL_NAME = "com.github.aqutter/headless_webview";

    const AqutterCorePlugin* plugin;
    std::map<std::string, std::unique_ptr<AqutterHeadlessWebView>> webViews;

    AqutterHeadlessWebViewManager(const AqutterCorePlugin* plugin);
    ~AqutterHeadlessWebViewManager();

    void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue>& method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

    void run(const flutter::EncodableMap* arguments, std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
  private:
    WNDCLASS windowClass_ = {};
  };
}
#endif //AQUTTER_CORE_PLUGIN_HEADLESS_AQUTTER_WEBVIEW_MANAGER_H_