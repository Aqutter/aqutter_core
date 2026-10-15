#ifndef AQUTTER_CORE_PLUGIN_PRINT_JOB_CONTROLLER_H_
#define AQUTTER_CORE_PLUGIN_PRINT_JOB_CONTROLLER_H_

#include <flutter/binary_messenger.h>
#include <flutter/encodable_value.h>

#include <memory>
#include <optional>
#include <string>

#include "print_job_settings.h"
#include "print_job_info.h"

namespace aqutter_core_plugin
{
  class AqutterWebView;
  class PrintJobChannelDelegate;

  class PrintJobController
  {
  public:
    static inline const std::string METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/webview_printjobcontroller_";

    const std::string id;
    std::unique_ptr<PrintJobChannelDelegate> channelDelegate;

    PrintJobController(const std::string& id,
      flutter::BinaryMessenger* messenger,
      AqutterWebView* aqutterWebView,
      std::shared_ptr<PrintJobSettings> settings);
    ~PrintJobController();

    std::unique_ptr<PrintJobInfo> getInfo() const;
    void markStarted();
    void onComplete(const bool completed, const std::optional<std::string>& error);
    void dispose();

    // Called by AqutterWebView before destruction to invalidate pointer
    void invalidateParentWebView();

    AqutterWebView* getParentWebView() const { return aqutterWebView_; }
    PrintJobState getState() const { return state_; }
    int64_t getCreationTime() const { return creationTime_; }
    std::optional<std::string> getLabel() const;
    std::shared_ptr<PrintJobSettings> getSettings() const { return settings_; }

  private:
    AqutterWebView* aqutterWebView_ = nullptr;
    std::shared_ptr<PrintJobSettings> settings_;
    int64_t creationTime_ = 0;
    PrintJobState state_ = PrintJobState::created;
    bool disposed_ = false;

    void eraseFromParentWebView();
  };
}

#endif //AQUTTER_CORE_PLUGIN_PRINT_JOB_CONTROLLER_H_
