#ifndef FLUTTER_PLUGIN_AQUTTER_CORE_PLUGIN_PLUGIN_H_
#define FLUTTER_PLUGIN_AQUTTER_CORE_PLUGIN_PLUGIN_H_

#include <flutter/plugin_registrar_windows.h>

namespace aqutter_core_plugin
{
  class WebViewEnvironmentManager;
  class AqutterWebViewManager;
  class AqutterBrowserManager;
  class AqutterHeadlessWebViewManager;
  class CookieManager;
  class PlatformUtil;

  class AqutterCorePlugin : public flutter::Plugin {
  public:
    flutter::PluginRegistrarWindows* registrar;
    std::unique_ptr<WebViewEnvironmentManager> webViewEnvironmentManager;
    std::unique_ptr<AqutterWebViewManager> aqutterWebViewManager;
    std::unique_ptr<AqutterBrowserManager> aqutterBrowserManager;
    std::unique_ptr<AqutterHeadlessWebViewManager> headlessAqutterWebViewManager;
    std::unique_ptr<CookieManager> cookieManager;
    std::unique_ptr<PlatformUtil> platformUtil;

    static void RegisterWithRegistrar(flutter::PluginRegistrarWindows* registrar);

    AqutterCorePlugin(flutter::PluginRegistrarWindows* registrar);

    virtual ~AqutterCorePlugin();

    // Disallow copy and assign.
    AqutterCorePlugin(const AqutterCorePlugin&) = delete;
    AqutterCorePlugin& operator=(const AqutterCorePlugin&) = delete;
  private:
    // The ID of the WindowProc delegate registration.
    int window_proc_id = -1;
    std::optional<LRESULT> AqutterCorePlugin::HandleWindowProc(
      HWND hWnd,
      UINT message,
      WPARAM wParam,
      LPARAM lParam);
  };
}
#endif  // FLUTTER_PLUGIN_AQUTTER_CORE_PLUGIN_PLUGIN_H_
