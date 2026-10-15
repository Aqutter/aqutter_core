#ifndef AQUTTER_CORE_PLUGIN_HEADLESS_WEBVIEW_CHANNEL_DELEGATE_H_
#define AQUTTER_CORE_PLUGIN_HEADLESS_WEBVIEW_CHANNEL_DELEGATE_H_

#include <flutter_linux/flutter_linux.h>

#include <memory>
#include <string>

#include "../types/channel_delegate.h"

namespace aqutter_core_plugin {

class AqutterHeadlessWebView;

/**
 * Channel delegate for AqutterHeadlessWebView.
 * Handles method calls specific to headless webview operations (dispose, setSize, getSize).
 * This mirrors the iOS HeadlessWebViewChannelDelegate pattern.
 */
class HeadlessWebViewChannelDelegate : public ChannelDelegate {
 public:
  static constexpr const char* METHOD_CHANNEL_NAME_PREFIX =
      "com.github.aqutter/headless_webview_";

  HeadlessWebViewChannelDelegate(AqutterHeadlessWebView* headlessWebView,
                                  FlBinaryMessenger* messenger,
                                  const std::string& id);
  ~HeadlessWebViewChannelDelegate() override;

  void HandleMethodCall(FlMethodCall* method_call) override;

  // === Events to send to Dart ===

  /**
   * Notify Dart that the headless webview has been created.
   */
  void onWebViewCreated() const;

 private:
  AqutterHeadlessWebView* headlessWebView_ = nullptr;
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_HEADLESS_WEBVIEW_CHANNEL_DELEGATE_H_
