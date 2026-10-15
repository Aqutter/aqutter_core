#ifndef AQUTTER_CORE_PLUGIN_JS_BEFORE_UNLOAD_RESPONSE_H_
#define AQUTTER_CORE_PLUGIN_JS_BEFORE_UNLOAD_RESPONSE_H_

#include <flutter_linux/flutter_linux.h>

#include <optional>
#include <string>

namespace aqutter_core_plugin {

/**
 * Response for beforeunload dialogs.
 */
class JsBeforeUnloadResponse {
 public:
  bool handledByClient;
  bool shouldAllowNavigation;
  std::optional<std::string> message;

  JsBeforeUnloadResponse();
  JsBeforeUnloadResponse(FlValue* map);
  ~JsBeforeUnloadResponse() = default;
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_JS_BEFORE_UNLOAD_RESPONSE_H_
