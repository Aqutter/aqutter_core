#ifndef AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_SETTINGS_H_
#define AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_SETTINGS_H_

#include <flutter_linux/flutter_linux.h>

#include <memory>
#include <optional>
#include <string>

namespace aqutter_core_plugin {

class AqutterBrowser;

/// Window type for AqutterBrowser
enum class AqutterBrowserWindowType {
  window,  // Top-level window
  child    // Child window (transient for parent)
};

/// Rect structure for window frame
struct AqutterBrowserRect {
  double x = 0;
  double y = 0;
  double width = 0;
  double height = 0;

  AqutterBrowserRect() = default;
  AqutterBrowserRect(double x, double y, double width, double height)
      : x(x), y(y), width(width), height(height) {}
  explicit AqutterBrowserRect(FlValue* map);

  FlValue* toFlValue() const;
};

/// Settings class for AqutterBrowser
///
/// Stores configuration options for the browser window appearance and behavior.
class AqutterBrowserSettings {
 public:
  /// Start with hidden window
  bool hidden = false;

  /// Hide the top toolbar
  bool hideToolbarTop = false;

  /// Toolbar background color (CSS color string, e.g., "#RRGGBB" or "#AARRGGBB")
  std::string toolbarTopBackgroundColor;

  /// Hide the URL bar in the toolbar
  bool hideUrlBar = false;

  /// Hide the progress bar
  bool hideProgressBar = false;

  /// Hide the default menu items (back, forward, reload)
  bool hideDefaultMenuItems = false;

  /// Fixed title for the window (instead of using page title)
  std::string toolbarTopFixedTitle;

  /// Window type (top-level or child)
  AqutterBrowserWindowType windowType = AqutterBrowserWindowType::window;

  /// Window opacity (0.0 to 1.0)
  double windowAlphaValue = 1.0;

  /// Window frame (position and size)
  std::shared_ptr<AqutterBrowserRect> windowFrame;

  AqutterBrowserSettings();
  explicit AqutterBrowserSettings(FlValue* map);
  ~AqutterBrowserSettings();

  /// Convert settings to FlValue map
  FlValue* toFlValue() const;

  /// Get actual settings from a live browser instance
  FlValue* getRealSettings(const AqutterBrowser* browser) const;
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_SETTINGS_H_
