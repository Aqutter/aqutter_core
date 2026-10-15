#ifndef AQUTTER_CORE_PLUGIN_SSL_CERTIFICATE_H_
#define AQUTTER_CORE_PLUGIN_SSL_CERTIFICATE_H_

#include <flutter/standard_method_codec.h>

namespace aqutter_core_plugin
{
  class SslCertificate
  {
  public:
    const std::string x509Certificate;

    SslCertificate(std::string x509Certificate);
    ~SslCertificate() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_SSL_CERTIFICATE_H_