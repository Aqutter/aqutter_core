#ifndef AQUTTER_CORE_PLUGIN_URL_REQUEST_H_
#define AQUTTER_CORE_PLUGIN_URL_REQUEST_H_

#include <flutter_linux/flutter_linux.h>

#include <map>
#include <optional>
#include <string>
#include <vector>

namespace aqutter_core_plugin {

class URLRequest {
 public:
  const std::optional<std::string> url;
  const std::optional<std::string> method;
  const std::optional<std::map<std::string, std::string>> headers;
  const std::optional<std::vector<uint8_t>> body;

  URLRequest(const std::optional<std::string>& url, const std::optional<std::string>& method,
             const std::optional<std::map<std::string, std::string>>& headers,
             const std::optional<std::vector<uint8_t>>& body);

  URLRequest(FlValue* map);

  ~URLRequest() = default;

  FlValue* toFlValue() const;
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_URL_REQUEST_H_
