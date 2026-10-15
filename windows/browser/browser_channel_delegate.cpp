#include "../utils/log.h"
#include "browser.h"
#include "browser_channel_delegate.h"

namespace aqutter_core_plugin
{
  AqutterBrowserChannelDelegate::AqutterBrowserChannelDelegate(const std::string& id, flutter::BinaryMessenger* messenger)
    : ChannelDelegate(messenger, AqutterBrowser::METHOD_CHANNEL_NAME_PREFIX + id)
  {}

  void AqutterBrowserChannelDelegate::HandleMethodCall(const flutter::MethodCall<flutter::EncodableValue>& method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    result->NotImplemented();
  }

  void AqutterBrowserChannelDelegate::onBrowserCreated() const
  {
    if (!channel) {
      return;
    }
    channel->InvokeMethod("onBrowserCreated", nullptr);
  }

  void AqutterBrowserChannelDelegate::onExit() const
  {
    if (!channel) {
      return;
    }
    channel->InvokeMethod("onExit", nullptr);
  }

  AqutterBrowserChannelDelegate::~AqutterBrowserChannelDelegate()
  {
    debugLog("dealloc AqutterBrowserChannelDelegate");
  }
}