#ifndef AQUTTER_CORE_PLUGIN_URL_CREDENTIAL_H_
#define AQUTTER_CORE_PLUGIN_URL_CREDENTIAL_H_

#include <flutter_linux/flutter_linux.h>

#include <optional>
#include <string>

namespace aqutter_core_plugin {

/**
 * URL credential for storing/providing authentication credentials.
 */
class URLCredential {
 public:
  std::optional<std::string> username;
  std::optional<std::string> password;

  URLCredential();
  URLCredential(const std::optional<std::string>& username,
                const std::optional<std::string>& password);
  URLCredential(FlValue* map);
  ~URLCredential() = default;

  FlValue* toFlValue() const;
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_URL_CREDENTIAL_H_
