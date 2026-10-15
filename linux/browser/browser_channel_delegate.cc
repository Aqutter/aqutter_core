#include "browser_channel_delegate.h"

#include <cstring>

#include "../utils/flutter.h"
#include "../utils/log.h"
#include "browser.h"

namespace aqutter_core_plugin {

AqutterBrowserChannelDelegate::AqutterBrowserChannelDelegate(AqutterBrowser* browser,
                                                         FlBinaryMessenger* messenger,
                                                         const std::string& channelName)
    : ChannelDelegate(messenger, channelName), browser_(browser) {}

AqutterBrowserChannelDelegate::~AqutterBrowserChannelDelegate() {
  debugLog("dealloc AqutterBrowserChannelDelegate");
  browser_ = nullptr;
}

void AqutterBrowserChannelDelegate::HandleMethodCall(FlMethodCall* method_call) {
  const gchar* methodName = fl_method_call_get_name(method_call);
  FlValue* args = fl_method_call_get_args(method_call);

  if (browser_ == nullptr) {
    fl_method_call_respond_error(method_call, "ERROR", "Browser instance is null", nullptr,
                                 nullptr);
    return;
  }

  if (strcmp(methodName, "show") == 0) {
    browser_->show();
    fl_method_call_respond_success(method_call, fl_value_new_bool(true), nullptr);
    return;
  }

  if (strcmp(methodName, "hide") == 0) {
    browser_->hide();
    fl_method_call_respond_success(method_call, fl_value_new_bool(true), nullptr);
    return;
  }

  if (strcmp(methodName, "close") == 0) {
    browser_->close();
    fl_method_call_respond_success(method_call, fl_value_new_bool(true), nullptr);
    return;
  }

  if (strcmp(methodName, "isHidden") == 0) {
    bool hidden = browser_->isHidden();
    fl_method_call_respond_success(method_call, fl_value_new_bool(hidden), nullptr);
    return;
  }

  if (strcmp(methodName, "setSettings") == 0) {
    FlValue* settingsValue = fl_value_lookup_string(args, "settings");
    if (settingsValue != nullptr && fl_value_get_type(settingsValue) == FL_VALUE_TYPE_MAP) {
      auto newSettings = std::make_shared<AqutterBrowserSettings>(settingsValue);
      browser_->setSettings(newSettings, settingsValue);
    }
    fl_method_call_respond_success(method_call, fl_value_new_bool(true), nullptr);
    return;
  }

  if (strcmp(methodName, "getSettings") == 0) {
    g_autoptr(FlValue) result = browser_->getSettings();
    fl_method_call_respond_success(method_call, result, nullptr);
    return;
  }

  fl_method_call_respond_not_implemented(method_call, nullptr);
}

void AqutterBrowserChannelDelegate::onBrowserCreated() const {
  if (channel_ == nullptr) {
    return;
  }
  invokeMethod("onBrowserCreated", nullptr);
}

void AqutterBrowserChannelDelegate::onMenuItemClicked(int32_t menuItemId) const {
  if (channel_ == nullptr) {
    return;
  }
  g_autoptr(FlValue) args = to_fl_map({
      {"id", make_fl_value(static_cast<int64_t>(menuItemId))},
  });
  invokeMethod("onMenuItemClicked", args);
}

void AqutterBrowserChannelDelegate::onExit() const {
  if (channel_ == nullptr) {
    return;
  }
  invokeMethod("onExit", nullptr);
}

}  // namespace aqutter_core_plugin
