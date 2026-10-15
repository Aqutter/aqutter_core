#ifndef AQUTTER_CORE_PLUGIN_PROCESS_FAILED_DETAIL_H_
#define AQUTTER_CORE_PLUGIN_PROCESS_FAILED_DETAIL_H_

#include <flutter/standard_method_codec.h>
#include <optional>
#include <string>
#include <vector>

#include "frame_info.h"

namespace aqutter_core_plugin
{

  class ProcessFailedDetail
  {
  public:
    const int64_t kind;
    const std::optional<int64_t> exitCode;
    const std::optional<std::string> processDescription;
    const std::optional<int64_t> reason;
    const std::optional<std::string> failureSourceModulePath;
    const std::optional<std::vector<std::shared_ptr<FrameInfo>>> frameInfos;

    ProcessFailedDetail(const int64_t& kind,
      const std::optional<int64_t>& exitCode,
      const std::optional<std::string>& processDescription,
      const std::optional<int64_t>& reason,
      const std::optional<std::string>& failureSourceModulePath,
      const std::optional<std::vector<std::shared_ptr<FrameInfo>>>& frameInfos);
    ~ProcessFailedDetail() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_PROCESS_FAILED_DETAIL_H_