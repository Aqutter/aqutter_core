#ifndef AQUTTER_CORE_PLUGIN_PRINT_JOB_MANAGER_H_
#define AQUTTER_CORE_PLUGIN_PRINT_JOB_MANAGER_H_

#include <flutter/binary_messenger.h>

#include <memory>
#include <string>

#include "print_job_settings.h"

namespace aqutter_core_plugin
{
  class AqutterWebView;
  class PrintJobController;

  class PrintJobManager
  {
  public:
    PrintJobManager(AqutterWebView* webView, flutter::BinaryMessenger* messenger);
    ~PrintJobManager();

    std::shared_ptr<PrintJobController> createPrintJobController(
      const std::string& id,
      std::shared_ptr<PrintJobSettings> settings);
    PrintJobController* getPrintJobController(const std::string& id) const;
    void addPrintJobController(const std::string& id, std::shared_ptr<PrintJobController> controller);
    void erasePrintJobController(const std::string& id);
    void dispose();

  private:
    AqutterWebView* webView_ = nullptr;
    flutter::BinaryMessenger* messenger_ = nullptr;
  };
}

#endif //AQUTTER_CORE_PLUGIN_PRINT_JOB_MANAGER_H_
