#ifndef AQUTTER_CORE_PLUGIN_SCREEN_CAPTURE_STARTING_RESPONSE_H_
#define AQUTTER_CORE_PLUGIN_SCREEN_CAPTURE_STARTING_RESPONSE_H_

#include <flutter/standard_method_codec.h>
#include <optional>

#include "../utils/flutter.h"

namespace aqutter_core_plugin
{
  class ScreenCaptureStartingResponse
  {
  public:
    const std::optional<bool> cancel;
    const std::optional<bool> handled;

    ScreenCaptureStartingResponse(const std::optional<bool>& cancel,
      const std::optional<bool>& handled);
    ScreenCaptureStartingResponse(const flutter::EncodableMap& map);
    ~ScreenCaptureStartingResponse() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_SCREEN_CAPTURE_STARTING_RESPONSE_H_