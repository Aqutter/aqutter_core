#ifndef AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_CHANNEL_DELEGATE_H_
#define AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_CHANNEL_DELEGATE_H_

#include <flutter/method_channel.h>
#include <flutter/standard_message_codec.h>

#include "../types/channel_delegate.h"

namespace aqutter_core_plugin
{
  class AqutterBrowserChannelDelegate : public ChannelDelegate
  {
  public:
    AqutterBrowserChannelDelegate(const std::string& id, flutter::BinaryMessenger* messenger);
    ~AqutterBrowserChannelDelegate();

    void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue>& method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

    void onBrowserCreated() const;
    void onExit() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_CHANNEL_DELEGATE_H_