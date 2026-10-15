#ifndef AQUTTER_CORE_PLUGIN_HEADLESS_AQUTTER_WEBVIEW_MANAGER_H_
#define AQUTTER_CORE_PLUGIN_HEADLESS_AQUTTER_WEBVIEW_MANAGER_H_

#include <flutter_linux/flutter_linux.h>

#include <map>
#include <memory>
#include <string>

#include "headless_webview.h"

namespace aqutter_core_plugin {

class PluginInstance;

class AqutterHeadlessWebViewManager {
 public:
  static constexpr const char* METHOD_CHANNEL_NAME =
      "com.github.aqutter/headless_webview";

  AqutterHeadlessWebViewManager(PluginInstance* plugin);
  ~AqutterHeadlessWebViewManager();

  PluginInstance* plugin() const { return plugin_; }
  FlPluginRegistrar* registrar() const;
  FlBinaryMessenger* messenger() const { return messenger_; }

  // Get a headless webview by ID
  AqutterHeadlessWebView* GetHeadlessWebView(const std::string& id) const;

  // Remove a headless webview by ID (called during dispose)
  void RemoveHeadlessWebView(const std::string& id);

 private:
  PluginInstance* plugin_ = nullptr;
  FlPluginRegistrar* registrar_ = nullptr;
  FlBinaryMessenger* messenger_ = nullptr;
  FlMethodChannel* method_channel_ = nullptr;
  GtkWindow* gtk_window_ = nullptr;  // Cached GTK window (can be null for headless)

  // Map of id to AqutterHeadlessWebView instance
  std::map<std::string, std::unique_ptr<AqutterHeadlessWebView>> webviews_;

  // Handle method calls from Flutter
  static void HandleMethodCall(FlMethodChannel* channel, FlMethodCall* method_call,
                               gpointer user_data);
  void HandleMethodCallImpl(FlMethodCall* method_call);
  void Run(FlMethodCall* method_call);
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_HEADLESS_AQUTTER_WEBVIEW_MANAGER_H_
