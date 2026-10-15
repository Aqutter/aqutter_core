#ifndef AQUTTER_CORE_PLUGIN_HEADLESS_WEBVIEW_CHANNEL_DELEGATE_H_
#define AQUTTER_CORE_PLUGIN_HEADLESS_WEBVIEW_CHANNEL_DELEGATE_H_

#include "../types/channel_delegate.h"
#include <flutter/method_channel.h>

namespace aqutter_core_plugin
{
  class AqutterHeadlessWebView;

  class HeadlessWebViewChannelDelegate : public ChannelDelegate
  {
  public:
    AqutterHeadlessWebView* webView;

    HeadlessWebViewChannelDelegate(AqutterHeadlessWebView* webView, flutter::BinaryMessenger* messenger);
    ~HeadlessWebViewChannelDelegate();

    void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue>& method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

    void onWebViewCreated() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_HEADLESS_WEBVIEW_CHANNEL_DELEGATE_H_