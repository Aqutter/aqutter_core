#ifndef AQUTTER_CORE_PLUGIN_DOWNLOAD_START_RESPONSE_H_
#define AQUTTER_CORE_PLUGIN_DOWNLOAD_START_RESPONSE_H_

#include <flutter_linux/flutter_linux.h>

#include <optional>
#include <string>

namespace aqutter_core_plugin {

enum class DownloadStartResponseAction { CANCEL = 0, ALLOW = 1 };

class DownloadStartResponse {
 public:
  DownloadStartResponseAction action;
  std::optional<std::string> destinationPath;

  DownloadStartResponse();
  DownloadStartResponse(FlValue* map);
  ~DownloadStartResponse() = default;
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_DOWNLOAD_START_RESPONSE_H_
