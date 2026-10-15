#ifndef AQUTTER_CORE_PLUGIN_WEB_RESOURCE_ERROR_H_
#define AQUTTER_CORE_PLUGIN_WEB_RESOURCE_ERROR_H_

#include <flutter_linux/flutter_linux.h>

#include <cstdint>
#include <string>

namespace aqutter_core_plugin {

class WebResourceError {
 public:
  const std::string description;
  const int64_t type;

  WebResourceError(const std::string& description, int64_t type);
  WebResourceError(FlValue* map);
  ~WebResourceError() = default;

  FlValue* toFlValue() const;
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_WEB_RESOURCE_ERROR_H_
