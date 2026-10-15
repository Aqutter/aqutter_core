#include "browser_settings.h"

#include <gtk/gtk.h>

#include "../utils/flutter.h"
#include "../utils/log.h"
#include "browser.h"

namespace aqutter_core_plugin {

namespace {

AqutterBrowserWindowType windowTypeFromString(const std::string& s) {
  if (s == "CHILD") {
    return AqutterBrowserWindowType::child;
  }
  return AqutterBrowserWindowType::window;
}

std::string windowTypeToString(AqutterBrowserWindowType t) {
  switch (t) {
    case AqutterBrowserWindowType::child:
      return "CHILD";
    default:
      return "WINDOW";
  }
}

}  // namespace

// AqutterBrowserRect implementation

AqutterBrowserRect::AqutterBrowserRect(FlValue* map) {
  if (map == nullptr || fl_value_get_type(map) != FL_VALUE_TYPE_MAP) {
    return;
  }
  x = get_fl_map_value<double>(map, "x", 0);
  y = get_fl_map_value<double>(map, "y", 0);
  width = get_fl_map_value<double>(map, "width", 0);
  height = get_fl_map_value<double>(map, "height", 0);
}

FlValue* AqutterBrowserRect::toFlValue() const {
  return to_fl_map({
      {"x", make_fl_value(x)},
      {"y", make_fl_value(y)},
      {"width", make_fl_value(width)},
      {"height", make_fl_value(height)},
  });
}

// AqutterBrowserSettings implementation

AqutterBrowserSettings::AqutterBrowserSettings() = default;

AqutterBrowserSettings::AqutterBrowserSettings(FlValue* map) {
  if (map == nullptr || fl_value_get_type(map) != FL_VALUE_TYPE_MAP) {
    return;
  }

  hidden = get_fl_map_value<bool>(map, "hidden", hidden);
  hideToolbarTop = get_fl_map_value<bool>(map, "hideToolbarTop", hideToolbarTop);
  toolbarTopBackgroundColor = get_fl_map_value<std::string>(map, "toolbarTopBackgroundColor", toolbarTopBackgroundColor);
  hideUrlBar = get_fl_map_value<bool>(map, "hideUrlBar", hideUrlBar);
  hideProgressBar = get_fl_map_value<bool>(map, "hideProgressBar", hideProgressBar);
  hideDefaultMenuItems = get_fl_map_value<bool>(map, "hideDefaultMenuItems", hideDefaultMenuItems);
  toolbarTopFixedTitle = get_fl_map_value<std::string>(map, "toolbarTopFixedTitle", toolbarTopFixedTitle);

  auto windowTypeStr = get_fl_map_value<std::string>(map, "windowType", "WINDOW");
  windowType = windowTypeFromString(windowTypeStr);

  windowAlphaValue = get_fl_map_value<double>(map, "windowAlphaValue", windowAlphaValue);

  FlValue* frameValue = fl_value_lookup_string(map, "windowFrame");
  if (frameValue != nullptr && fl_value_get_type(frameValue) == FL_VALUE_TYPE_MAP) {
    windowFrame = std::make_shared<AqutterBrowserRect>(frameValue);
  }
}

AqutterBrowserSettings::~AqutterBrowserSettings() {
  debugLog("dealloc AqutterBrowserSettings");
}

FlValue* AqutterBrowserSettings::toFlValue() const {
  FlValue* result = to_fl_map({
      {"hidden", make_fl_value(hidden)},
      {"hideToolbarTop", make_fl_value(hideToolbarTop)},
      {"toolbarTopBackgroundColor", make_fl_value(toolbarTopBackgroundColor)},
      {"hideUrlBar", make_fl_value(hideUrlBar)},
      {"hideProgressBar", make_fl_value(hideProgressBar)},
      {"hideDefaultMenuItems", make_fl_value(hideDefaultMenuItems)},
      {"toolbarTopFixedTitle", make_fl_value(toolbarTopFixedTitle)},
      {"windowType", make_fl_value(windowTypeToString(windowType))},
      {"windowAlphaValue", make_fl_value(windowAlphaValue)},
      {"windowFrame", windowFrame ? windowFrame->toFlValue() : fl_value_new_null()},
  });
  return result;
}

FlValue* AqutterBrowserSettings::getRealSettings(const AqutterBrowser* browser) const {
  FlValue* settingsMap = toFlValue();

  if (browser != nullptr) {
    GtkWindow* window = browser->getWindow();
    if (window != nullptr) {
      // Update hidden state
      fl_value_set_string_take(settingsMap, "hidden",
                               make_fl_value(!gtk_widget_is_visible(GTK_WIDGET(window))));

      // Update window opacity
      fl_value_set_string_take(settingsMap, "windowAlphaValue",
                               make_fl_value(gtk_widget_get_opacity(GTK_WIDGET(window))));

      // Update window frame
      int x = 0, y = 0, width = 0, height = 0;
      gtk_window_get_position(window, &x, &y);
      gtk_window_get_size(window, &width, &height);
      AqutterBrowserRect frame(static_cast<double>(x), static_cast<double>(y),
                             static_cast<double>(width), static_cast<double>(height));
      fl_value_set_string_take(settingsMap, "windowFrame", frame.toFlValue());
    }
  }

  return settingsMap;
}

}  // namespace aqutter_core_plugin
