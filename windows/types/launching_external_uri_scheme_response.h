#ifndef AQUTTER_CORE_PLUGIN_LAUNCHING_EXTERNAL_URI_SCHEME_RESPONSE_H_
#define AQUTTER_CORE_PLUGIN_LAUNCHING_EXTERNAL_URI_SCHEME_RESPONSE_H_

#include <flutter/standard_method_codec.h>

#include "../utils/flutter.h"

namespace aqutter_core_plugin
{
  class LaunchingExternalUriSchemeResponse
  {
  public:
    const bool cancel;

    LaunchingExternalUriSchemeResponse(const bool& cancel);
    LaunchingExternalUriSchemeResponse(const flutter::EncodableMap& map);
    ~LaunchingExternalUriSchemeResponse() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_LAUNCHING_EXTERNAL_URI_SCHEME_RESPONSE_H_