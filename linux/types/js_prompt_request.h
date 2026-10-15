#ifndef AQUTTER_CORE_PLUGIN_JS_PROMPT_REQUEST_H_
#define AQUTTER_CORE_PLUGIN_JS_PROMPT_REQUEST_H_

#include <flutter_linux/flutter_linux.h>

#include <optional>
#include <string>

namespace aqutter_core_plugin {

/**
 * Represents a JavaScript prompt() dialog request.
 */
class JsPromptRequest {
 public:
  std::optional<std::string> url;
  std::string message;
  std::optional<std::string> defaultValue;
  bool isMainFrame;

  JsPromptRequest(const std::optional<std::string>& url, const std::string& message,
                  const std::optional<std::string>& defaultValue, bool isMainFrame);
  ~JsPromptRequest() = default;

  FlValue* toFlValue() const;
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_JS_PROMPT_REQUEST_H_
