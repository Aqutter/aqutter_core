#ifndef AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_MANAGER_H_
#define AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_MANAGER_H_

#include <flutter_linux/flutter_linux.h>

#include <map>
#include <memory>
#include <string>

#include "browser.h"

namespace aqutter_core_plugin {

class PluginInstance;

/// Manager class for AqutterBrowser instances
///
/// Handles the static method channel for creating browsers and opening URLs
/// with the system browser. Maintains a map of all active browser instances.
class AqutterBrowserManager {
 public:
  static constexpr const char* METHOD_CHANNEL_NAME =
      "com.github.aqutter/browser";

  /// Create the manager
  /// @param plugin The plugin instance
  AqutterBrowserManager(PluginInstance* plugin);
  ~AqutterBrowserManager();

  /// Get the plugin instance
  PluginInstance* plugin() const { return plugin_; }

  /// Get the registrar
  FlPluginRegistrar* registrar() const;

  /// Get the messenger
  FlBinaryMessenger* messenger() const { return messenger_; }

  /// Create a new AqutterBrowser instance
  /// @param arguments The creation arguments from Dart
  void createAqutterBrowser(FlValue* arguments);

  /// Open a URL with the system browser
  /// @param url The URL to open
  /// @param result The method result to respond to
  void openWithSystemBrowser(const std::string& url, FlMethodCall* method_call);

  /// Remove a browser from the manager (called when browser is destroyed)
  /// @param id The browser ID to remove
  void removeBrowser(const std::string& id);

  /// Get a browser by ID
  /// @param id The browser ID
  /// @return The browser instance or nullptr
  AqutterBrowser* getBrowser(const std::string& id);

 private:
  PluginInstance* plugin_ = nullptr;
  FlPluginRegistrar* registrar_ = nullptr;
  FlBinaryMessenger* messenger_ = nullptr;
  FlMethodChannel* method_channel_ = nullptr;
  GtkWindow* gtk_window_ = nullptr;
  FlView* fl_view_ = nullptr;

  /// Map of browser ID to browser instance
  std::map<std::string, std::unique_ptr<AqutterBrowser>> browsers_;

  /// Handle method calls from Flutter
  static void HandleMethodCall(FlMethodChannel* channel, FlMethodCall* method_call,
                               gpointer user_data);
  void HandleMethodCallImpl(FlMethodCall* method_call);
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_MANAGER_H_
