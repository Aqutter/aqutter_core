#ifndef AQUTTER_CORE_PLUGIN_SHOW_FILE_CHOOSER_RESPONSE_H_
#define AQUTTER_CORE_PLUGIN_SHOW_FILE_CHOOSER_RESPONSE_H_

#include <flutter_linux/flutter_linux.h>

#include <optional>
#include <string>
#include <vector>

namespace aqutter_core_plugin {

class ShowFileChooserResponse {
 public:
  bool handledByClient;
  std::optional<std::vector<std::string>> filePaths;

  ShowFileChooserResponse();
  ShowFileChooserResponse(bool handledByClient,
                          std::optional<std::vector<std::string>> filePaths);
  ~ShowFileChooserResponse() = default;

  static ShowFileChooserResponse fromFlValue(FlValue* value);

  FlValue* toFlValue() const;
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_SHOW_FILE_CHOOSER_RESPONSE_H_
