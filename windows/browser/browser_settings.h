#ifndef AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_SETTINGS_H_
#define AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_SETTINGS_H_

#include <flutter/standard_message_codec.h>
#include <optional>
#include <string>

#include "../types/rect.h"

namespace aqutter_core_plugin
{
  class AqutterBrowser;

  enum class AqutterBrowserWindowType {
    window,
    child
  };

  class AqutterBrowserSettings
  {
  public:
    bool hidden = false;
    AqutterBrowserWindowType windowType = AqutterBrowserWindowType::window;
    std::string toolbarTopFixedTitle;
    double windowAlphaValue = 1.0;
    std::shared_ptr<Rect> windowFrame;

    AqutterBrowserSettings();
    AqutterBrowserSettings(const flutter::EncodableMap& encodableMap);
    ~AqutterBrowserSettings();

    flutter::EncodableMap toEncodableMap() const;
    flutter::EncodableMap getRealSettings(const AqutterBrowser* aqutterBrowser) const;
  };
}
#endif //AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_SETTINGS_H_