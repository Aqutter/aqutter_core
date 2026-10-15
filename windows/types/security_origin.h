#ifndef AQUTTER_CORE_PLUGIN_SECURITY_ORIGIN_H_
#define AQUTTER_CORE_PLUGIN_SECURITY_ORIGIN_H_

#include <flutter/standard_method_codec.h>
#include <string>

namespace aqutter_core_plugin
{

  class SecurityOrigin
  {
  public:
    const std::string host;
    const int64_t port;
    const std::string protocol;

    SecurityOrigin(const std::string& host, const int64_t& port, const std::string& protocol);
    ~SecurityOrigin() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_SECURITY_ORIGIN_H_