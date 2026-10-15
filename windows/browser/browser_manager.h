#ifndef AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_MANAGER_H_
#define AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_MANAGER_H_

#include <flutter/method_channel.h>
#include <flutter/standard_message_codec.h>
#include <map>
#include <string>

#include "../aqutter_core_plugin.h"
#include "../types/channel_delegate.h"
#include "browser.h"

namespace aqutter_core_plugin
{
  class AqutterBrowserManager : public ChannelDelegate
  {
  public:
    static inline const std::string METHOD_CHANNEL_NAME = "com.github.aqutter/browser";

    const AqutterCorePlugin* plugin;
    std::map<std::string, std::unique_ptr<AqutterBrowser>> browsers;

    AqutterBrowserManager(const AqutterCorePlugin* plugin);
    ~AqutterBrowserManager();

    void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue>& method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

    void createAqutterBrowser(const flutter::EncodableMap* arguments);
  };
}
#endif //AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_MANAGER_H_