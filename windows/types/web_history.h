#ifndef AQUTTER_CORE_PLUGIN_WEB_HISTORY_H_
#define AQUTTER_CORE_PLUGIN_WEB_HISTORY_H_

#include <flutter/standard_method_codec.h>
#include <optional>

#include "../utils/flutter.h"
#include "web_history_item.h"

namespace aqutter_core_plugin
{
  class WebHistory
  {
  public:
    const std::optional<int64_t> currentIndex;
    const std::optional<std::vector<std::shared_ptr<WebHistoryItem>>> list;

    WebHistory(const std::optional<int64_t> currentIndex, const std::optional<std::vector<std::shared_ptr<WebHistoryItem>>>& list);
    WebHistory(const flutter::EncodableMap& map);
    ~WebHistory() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //AQUTTER_CORE_PLUGIN_WEB_HISTORY_H_