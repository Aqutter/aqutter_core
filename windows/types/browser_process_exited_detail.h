#ifndef AQUTTER_CORE_PLUGIN_BROWSER_PROCESS_EXITED_DETAIL_H_
#define AQUTTER_CORE_PLUGIN_BROWSER_PROCESS_EXITED_DETAIL_H_

#include <flutter/standard_method_codec.h>
#include <optional>

namespace aqutter_core_plugin
{
  class BrowserProcessExitedDetail
  {
  public:
    const std::optional<int64_t> kind;
    const std::optional<int64_t> processId;

    BrowserProcessExitedDetail(const std::optional<int64_t>& kind,
      const std::optional<int64_t>& processId);
    ~BrowserProcessExitedDetail() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_BROWSER_PROCESS_EXITED_DETAIL_H_