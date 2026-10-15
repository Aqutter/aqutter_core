#include "print_job_controller.h"

#include "print_job_channel_delegate.h"
#include "print_job_info.h"
#include "../webview/webview.h"
#include "../utils/flutter.h"
#include "../utils/log.h"

#include <chrono>

namespace aqutter_core_plugin
{
  PrintJobController::PrintJobController(const std::string& id,
    flutter::BinaryMessenger* messenger,
    AqutterWebView* aqutterWebView,
    std::shared_ptr<PrintJobSettings> settings)
    : id(id), aqutterWebView_(aqutterWebView), settings_(settings)
  {
    creationTime_ = std::chrono::duration_cast<std::chrono::milliseconds>(
      std::chrono::system_clock::now().time_since_epoch()).count();
    channelDelegate = std::make_unique<PrintJobChannelDelegate>(
      this, messenger, METHOD_CHANNEL_NAME_PREFIX + id);
  }

  std::unique_ptr<PrintJobInfo> PrintJobController::getInfo() const
  {
    return std::make_unique<PrintJobInfo>(this);
  }

  std::optional<std::string> PrintJobController::getLabel() const
  {
    if (settings_ && settings_->jobName.has_value()) {
      return settings_->jobName;
    }
    return std::nullopt;
  }

  void PrintJobController::markStarted()
  {
    if (state_ == PrintJobState::created) {
      state_ = PrintJobState::started;
    }
  }

  void PrintJobController::onComplete(const bool completed, const std::optional<std::string>& error)
  {
    if (completed) {
      state_ = PrintJobState::completed;
    }
    else if (error.has_value()) {
      state_ = PrintJobState::failed;
    }
    else {
      state_ = PrintJobState::canceled;
    }

    if (channelDelegate) {
      channelDelegate->onComplete(completed, error);
    }
  }

  void PrintJobController::dispose()
  {
    if (disposed_) {
      return;
    }
    disposed_ = true;

    if (state_ == PrintJobState::created || state_ == PrintJobState::started) {
      onComplete(false, std::nullopt);
    }

    if (channelDelegate) {
      channelDelegate->dispose();
      channelDelegate.reset();
    }
    eraseFromParentWebView();
  }

  void PrintJobController::invalidateParentWebView()
  {
    aqutterWebView_ = nullptr;
  }

  void PrintJobController::eraseFromParentWebView()
  {
    // Only erase if parent webview is still valid (not being destroyed)
    if (aqutterWebView_) {
      aqutterWebView_->erasePrintJobController(id);
      aqutterWebView_ = nullptr;
    }
  }

  PrintJobController::~PrintJobController()
  {
    debugLog("dealloc PrintJobController");
    dispose();
  }
}
