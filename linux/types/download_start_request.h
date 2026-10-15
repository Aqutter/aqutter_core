#ifndef AQUTTER_CORE_PLUGIN_DOWNLOAD_START_REQUEST_H_
#define AQUTTER_CORE_PLUGIN_DOWNLOAD_START_REQUEST_H_

#include <flutter_linux/flutter_linux.h>
#include <wpe/webkit.h>

#include <optional>
#include <string>

namespace aqutter_core_plugin {

class DownloadStartRequest {
 public:
  std::optional<std::string> url;
  std::optional<std::string> suggestedFilename;
  std::optional<std::string> mimeType;
  int64_t contentLength;
  std::optional<std::string> contentDisposition;
  std::optional<std::string> userAgent;

  DownloadStartRequest();
  DownloadStartRequest(WebKitDownload* download);
  ~DownloadStartRequest() = default;

  FlValue* toFlValue() const;
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_DOWNLOAD_START_REQUEST_H_
