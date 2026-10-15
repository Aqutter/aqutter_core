#ifndef AQUTTER_CORE_PLUGIN_SAVE_FILE_SECURITY_CHECK_STARTING_REQUEST_H_
#define AQUTTER_CORE_PLUGIN_SAVE_FILE_SECURITY_CHECK_STARTING_REQUEST_H_

#include <flutter/standard_method_codec.h>
#include <optional>
#include <string>

#include "../utils/flutter.h"

namespace aqutter_core_plugin
{
  class SaveFileSecurityCheckStartingRequest
  {
  public:
    const std::optional<std::string> documentOriginUri;
    const std::optional<std::string> fileExtension;
    const std::optional<std::string> filePath;
    const std::optional<bool> cancelSave;
    const std::optional<bool> suppressDefaultPolicy;

    SaveFileSecurityCheckStartingRequest(const std::optional<std::string>& documentOriginUri,
      const std::optional<std::string>& fileExtension,
      const std::optional<std::string>& filePath,
      const std::optional<bool>& cancelSave,
      const std::optional<bool>& suppressDefaultPolicy);
    SaveFileSecurityCheckStartingRequest(const flutter::EncodableMap& map);
    ~SaveFileSecurityCheckStartingRequest() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_SAVE_FILE_SECURITY_CHECK_STARTING_REQUEST_H_