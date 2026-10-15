#ifndef AQUTTER_CORE_PLUGIN_FIND_SESSION_H_
#define AQUTTER_CORE_PLUGIN_FIND_SESSION_H_

#include <flutter_linux/flutter_linux.h>
#include <string>

namespace aqutter_core_plugin {

class FindSession {
 public:
  int resultCount;
  int highlightedResultIndex;

  FindSession(int resultCount, int highlightedResultIndex);
  explicit FindSession(FlValue* value);
  ~FindSession() = default;

  FlValue* toFlValue() const;
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_FIND_SESSION_H_
