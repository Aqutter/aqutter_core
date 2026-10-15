#ifndef AQUTTER_CORE_PLUGIN_NOTIFICATION_RECEIVED_RESPONSE_H_
#define AQUTTER_CORE_PLUGIN_NOTIFICATION_RECEIVED_RESPONSE_H_

#include <flutter/standard_method_codec.h>

#include "../utils/flutter.h"

namespace aqutter_core_plugin
{
  class NotificationReceivedResponse
  {
  public:
    const bool handled;

    NotificationReceivedResponse(const bool& handled);
    NotificationReceivedResponse(const flutter::EncodableMap& map);
    ~NotificationReceivedResponse() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_NOTIFICATION_RECEIVED_RESPONSE_H_