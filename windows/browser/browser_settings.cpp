#include "../utils/flutter.h"
#include "../utils/log.h"
#include "../utils/string.h"
#include "browser_settings.h"

#include "browser.h"

namespace aqutter_core_plugin
{
  namespace
  {
    AqutterBrowserWindowType aqutterBrowserWindowTypeFromString(const std::string& s)
    {
      if (string_equals(s, "CHILD")) {
        return AqutterBrowserWindowType::child;
      }
      return AqutterBrowserWindowType::window;
    }

    std::string aqutterBrowserWindowTypeToString(const AqutterBrowserWindowType& t)
    {
      switch (t) {
      case AqutterBrowserWindowType::child:
        return "CHILD";
      default:
        return "WINDOW";
      }
    }
  }

  AqutterBrowserSettings::AqutterBrowserSettings() {};

  AqutterBrowserSettings::AqutterBrowserSettings(const flutter::EncodableMap& encodableMap)
  {
    hidden = get_fl_map_value(encodableMap, "hidden", hidden);
    windowType = aqutterBrowserWindowTypeFromString(get_fl_map_value<std::string>(encodableMap, "windowType", aqutterBrowserWindowTypeToString(AqutterBrowserWindowType::window)));
    toolbarTopFixedTitle = get_fl_map_value(encodableMap, "toolbarTopFixedTitle", toolbarTopFixedTitle);
    windowAlphaValue = get_fl_map_value(encodableMap, "windowAlphaValue", windowAlphaValue);
    auto windowFrameMap = get_optional_fl_map_value<flutter::EncodableMap>(encodableMap, "windowFrame");
    if (windowFrameMap.has_value()) {
      windowFrame = std::make_shared<Rect>(windowFrameMap.value());
    }
  }

  flutter::EncodableMap AqutterBrowserSettings::toEncodableMap() const
  {
    return flutter::EncodableMap{
      {"hidden", hidden},
      {"windowType", aqutterBrowserWindowTypeToString(windowType)},
      {"toolbarTopFixedTitle", toolbarTopFixedTitle},
      {"windowAlphaValue", windowAlphaValue},
      {"windowFrame", windowFrame ? windowFrame->toEncodableMap() : make_fl_value()},
    };
  }

  flutter::EncodableMap AqutterBrowserSettings::getRealSettings(const AqutterBrowser* aqutterBrowser) const
  {
    auto settingsMap = toEncodableMap();
    settingsMap["hidden"] = aqutterBrowser->isHidden();

    BYTE alphaValue = 0;
    GetLayeredWindowAttributes(aqutterBrowser->getHWND(), nullptr, &alphaValue, nullptr);
    settingsMap["windowAlphaValue"] = (double)alphaValue;

    RECT position;
    GetWindowRect(aqutterBrowser->getHWND(), &position);
    settingsMap["windowFrame"] = std::make_unique<Rect>(position.left, position.top, position.right - position.left, position.bottom - position.top)->toEncodableMap();

    return settingsMap;
  }

  AqutterBrowserSettings::~AqutterBrowserSettings()
  {
    debugLog("dealloc AqutterBrowserSettings");
  };
}
