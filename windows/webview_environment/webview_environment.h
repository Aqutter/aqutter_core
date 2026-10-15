#ifndef AQUTTER_CORE_PLUGIN_WEBVIEW_ENVIRONMENT_H_
#define AQUTTER_CORE_PLUGIN_WEBVIEW_ENVIRONMENT_H_

#include <functional>
#include <string>
#include <vector>
#include <WebView2.h>
#include <wil/com.h>

#include "../aqutter_core_plugin.h"
#include "webview_environment_channel_delegate.h"
#include "webview_environment_settings.h"

namespace aqutter_core_plugin
{
  class WebViewEnvironment
  {
  public:
    static inline const wchar_t* CLASS_NAME = L"WebViewEnvironment";
    static inline const std::string METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/webview_environment_";

    const AqutterCorePlugin* plugin;
    std::string id;

    std::unique_ptr<WebViewEnvironmentChannelDelegate> channelDelegate;

    WebViewEnvironment(const AqutterCorePlugin* plugin, const std::string& id);
    ~WebViewEnvironment();

    void create(const std::unique_ptr<WebViewEnvironmentSettings> settings, const std::function<void(HRESULT)> completionHandler);
    wil::com_ptr<ICoreWebView2Environment> getEnvironment()
    {
      return environment_;
    }
    // without using a "temp" ICoreWebView2 for CookieManager and other possible usage, the onBrowserProcessExited event will never be called
    void useTempWebView(const std::function<void(wil::com_ptr<ICoreWebView2Controller>, wil::com_ptr<ICoreWebView2>)> completionHandler) const;
    bool isInterfaceSupported(const std::string& interfaceName) const;
    void getProcessInfos(const std::function<void(std::vector<std::shared_ptr<BrowserProcessInfo>>)> completionHandler) const;
    std::optional<std::string> getFailureReportFolderPath() const;

  private:
    wil::com_ptr<ICoreWebView2Environment> environment_;
    EventRegistrationToken processInfosChangedToken_ = { 0 };
    EventRegistrationToken browserProcessExitedToken_ = { 0 };
    EventRegistrationToken newBrowserVersionAvailableToken_ = { 0 };
    WNDCLASS windowClass_ = {};
  };
}
#endif //AQUTTER_CORE_PLUGIN_WEBVIEW_ENVIRONMENT_H_