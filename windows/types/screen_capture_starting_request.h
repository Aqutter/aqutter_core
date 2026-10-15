#ifndef AQUTTER_CORE_PLUGIN_SCREEN_CAPTURE_STARTING_REQUEST_H_
#define AQUTTER_CORE_PLUGIN_SCREEN_CAPTURE_STARTING_REQUEST_H_

#include <flutter/standard_method_codec.h>
#include <memory>
#include <optional>

#include "../utils/flutter.h"
#include "frame_info.h"

namespace aqutter_core_plugin
{
  class ScreenCaptureStartingRequest
  {
  public:
    const std::optional<std::shared_ptr<FrameInfo>> frame;
    const std::optional<bool> cancel;
    const std::optional<bool> handled;

    ScreenCaptureStartingRequest(const std::optional<std::shared_ptr<FrameInfo>>& frame,
      const std::optional<bool>& cancel,
      const std::optional<bool>& handled);
    ~ScreenCaptureStartingRequest() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_SCREEN_CAPTURE_STARTING_REQUEST_H_