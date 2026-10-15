#ifndef AQUTTER_CORE_PLUGIN_URL_AUTHENTICATION_CHALLENGE_H_
#define AQUTTER_CORE_PLUGIN_URL_AUTHENTICATION_CHALLENGE_H_

#include <flutter/standard_method_codec.h>

#include "url_protection_space.h"

namespace aqutter_core_plugin
{
  class URLAuthenticationChallenge
  {
  public:
    const std::shared_ptr<URLProtectionSpace> protectionSpace;

    URLAuthenticationChallenge(const std::shared_ptr<URLProtectionSpace> protectionSpace);
    ~URLAuthenticationChallenge() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_URL_AUTHENTICATION_CHALLENGE_H_