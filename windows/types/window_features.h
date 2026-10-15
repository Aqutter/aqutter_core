#ifndef AQUTTER_CORE_PLUGIN_WINDOW_FEATURES_H_
#define AQUTTER_CORE_PLUGIN_WINDOW_FEATURES_H_

#include <flutter/standard_method_codec.h>
#include <optional>
#include <WebView2.h>
#include <wil/com.h>

namespace aqutter_core_plugin
{
  class WindowFeatures
  {
  public:
    std::optional<double> width;
    std::optional<double> height;
    std::optional<double> x;
    std::optional<double> y;
    std::optional<bool> menuBarVisibility;
    std::optional<bool> statusBarVisibility;
    std::optional<bool> toolbarsVisibility;

    WindowFeatures(const std::optional<double>& width,
      const std::optional<double>& height,
      const std::optional<double>& x,
      const std::optional<double>& y,
      const std::optional<bool>& menuBarVisibility,
      const std::optional<bool>& statusBarVisibility,
      const std::optional<bool>& toolbarsVisibility);

    WindowFeatures(wil::com_ptr<ICoreWebView2WindowFeatures> features);

    ~WindowFeatures() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_WINDOW_FEATURES_H_