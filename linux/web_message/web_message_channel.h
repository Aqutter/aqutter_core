#ifndef AQUTTER_CORE_PLUGIN_WEB_MESSAGE_CHANNEL_H_
#define AQUTTER_CORE_PLUGIN_WEB_MESSAGE_CHANNEL_H_

#include <flutter_linux/flutter_linux.h>

#include <memory>
#include <string>

#include "../types/channel_delegate.h"

namespace aqutter_core_plugin {

class AqutterWebView;

/**
 * Native C++ representation of a WebMessageChannel.
 *
 * Each WebMessageChannel has its own MethodChannel for communication
 * with the Dart side. This allows the Dart side to call port-specific
 * methods like setWebMessageCallback, postMessage, and close.
 */
class WebMessageChannel : public ChannelDelegate {
 public:
  static constexpr const char* METHOD_CHANNEL_NAME_PREFIX =
      "com.github.aqutter/webview_web_message_channel_";

  WebMessageChannel(FlBinaryMessenger* messenger, const std::string& channelId,
                    AqutterWebView* webView);
  ~WebMessageChannel();

  const std::string& id() const { return id_; }

  /**
   * Dispose of this WebMessageChannel, releasing resources and unregistering
   * the method call handler.
   */
  void dispose();

  /**
   * Send a message to the Dart side on a specific port.
   *
   * @param portIndex The port index (0 or 1)
   * @param message The message data (may be null)
   * @param messageType 0 for string, 1 for arrayBuffer
   */
  void onMessage(int portIndex, const std::string* message, int64_t messageType);

  // ChannelDelegate override
  void HandleMethodCall(FlMethodCall* method_call) override;

 private:
  std::string id_;
  AqutterWebView* webView_;  // Weak reference - AqutterWebView owns WebMessageChannels
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_WEB_MESSAGE_CHANNEL_H_
