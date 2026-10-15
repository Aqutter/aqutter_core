#ifndef AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_H_
#define AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_H_

#include <optional>
#include <string>
#include <Windows.h>

#include "../aqutter_core_plugin.h"
#include "../webview/webview.h"
#include "../webview/webview_settings.h"
#include "../types/url_request.h"
#include "browser_channel_delegate.h"
#include "browser_settings.h"

namespace aqutter_core_plugin
{
  struct AqutterBrowserCreationParams
  {
    const std::string id;
    const std::optional<std::shared_ptr<URLRequest>> urlRequest;
    const std::optional<std::string> assetFilePath;
    const std::optional<std::string> data;
    const std::shared_ptr<AqutterBrowserSettings> initialSettings;
    const std::shared_ptr<AqutterWebViewSettings> initialWebViewSettings;
    const std::optional<std::vector<std::shared_ptr<UserScript>>> initialUserScripts;
    const std::optional<std::string> webViewEnvironmentId;
  };

  class AqutterBrowser {
  public:
    static inline const std::string METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/browser_";
    static inline const wchar_t* CLASS_NAME = L"AqutterBrowser";

    static LRESULT CALLBACK WndProc(HWND window,
      UINT message,
      WPARAM wparam,
      LPARAM lparam) noexcept;

    const AqutterCorePlugin* plugin;
    const std::string id;
    std::unique_ptr<AqutterWebView> webView;
    std::unique_ptr<AqutterBrowserChannelDelegate> channelDelegate;
    std::shared_ptr<AqutterBrowserSettings> settings;

    AqutterBrowser(const AqutterCorePlugin* plugin, const AqutterBrowserCreationParams& params);
    ~AqutterBrowser();

    void close() const;
    void show() const;
    void hide() const;
    bool isHidden() const;
    void setSettings(const std::shared_ptr<AqutterBrowserSettings> newSettings, const flutter::EncodableMap& newSettingsMap);
    flutter::EncodableValue getSettings() const;

    void didChangeTitle(const std::optional<std::string>& title) const;
    HWND getHWND() const
    {
      return m_hWnd;
    }
  private:
    const HINSTANCE m_hInstance;
    HWND m_hWnd;
    bool destroyed_ = false;
    static AqutterBrowser* GetThisFromHandle(HWND window) noexcept;
    LRESULT MessageHandler(HWND window,
      UINT message,
      WPARAM wparam,
      LPARAM lparam) noexcept;
  };
}
#endif //AQUTTER_CORE_PLUGIN_AQUTTER_BROWSER_H_