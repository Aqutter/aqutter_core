#ifndef AQUTTER_CORE_PLUGIN_SAVE_FILE_SECURITY_CHECK_STARTING_RESPONSE_H_
#define AQUTTER_CORE_PLUGIN_SAVE_FILE_SECURITY_CHECK_STARTING_RESPONSE_H_

#include <flutter/standard_method_codec.h>
#include <optional>

#include "../utils/flutter.h"

namespace aqutter_core_plugin
{
  class SaveFileSecurityCheckStartingResponse
  {
  public:
    const std::optional<bool> cancelSave;
    const std::optional<bool> suppressDefaultPolicy;

    SaveFileSecurityCheckStartingResponse(const std::optional<bool>& cancelSave,
      const std::optional<bool>& suppressDefaultPolicy);
    SaveFileSecurityCheckStartingResponse(const flutter::EncodableMap& map);
    ~SaveFileSecurityCheckStartingResponse() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_SAVE_FILE_SECURITY_CHECK_STARTING_RESPONSE_H_