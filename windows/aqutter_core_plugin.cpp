#include "aqutter_core_plugin.h"

#include <flutter/plugin_registrar_windows.h>

#include "cookie_manager.h"
#include "headless_webview/headless_webview_manager.h"
#include "browser/browser_manager.h"
#include "webview/webview_manager.h"
#include "platform_util.h"
#include "webview_environment/webview_environment_manager.h"


#pragma comment(lib, "Shlwapi.lib")
#pragma comment(lib, "dxgi.lib")
#pragma comment(lib, "d3d11.lib")
#pragma comment(lib, "rpcrt4.lib")  // UuidCreate - Minimum supported OS Win 2000
#pragma comment(lib, "WindowsApp.lib")

namespace aqutter_core_plugin
{
  // static
  void AqutterCorePlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows* registrar)
  {
    auto plugin = std::make_unique<AqutterCorePlugin>(registrar);
    registrar->AddPlugin(std::move(plugin));
  }

  AqutterCorePlugin::AqutterCorePlugin(flutter::PluginRegistrarWindows* registrar)
    : registrar(registrar)
  {
    webViewEnvironmentManager = std::make_unique<WebViewEnvironmentManager>(this);
    aqutterWebViewManager = std::make_unique<AqutterWebViewManager>(this);
    aqutterBrowserManager = std::make_unique<AqutterBrowserManager>(this);
    headlessAqutterWebViewManager = std::make_unique<AqutterHeadlessWebViewManager>(this);
    cookieManager = std::make_unique<CookieManager>(this);
    platformUtil = std::make_unique<PlatformUtil>(this);

    window_proc_id = registrar->RegisterTopLevelWindowProcDelegate(
      [this](HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
      {
        return HandleWindowProc(hWnd, message, wParam, lParam);
      });
  }

  AqutterCorePlugin::~AqutterCorePlugin()
  {
    if (registrar) {
      registrar->UnregisterTopLevelWindowProcDelegate(window_proc_id);
    }
    webViewEnvironmentManager = nullptr;
    aqutterWebViewManager = nullptr;
    aqutterBrowserManager = nullptr;
    headlessAqutterWebViewManager = nullptr;
    cookieManager = nullptr;
    platformUtil = nullptr;
  }


  std::optional<LRESULT> AqutterCorePlugin::HandleWindowProc(
    HWND hWnd,
    UINT message,
    WPARAM wParam,
    LPARAM lParam)
  {
    std::optional<LRESULT> result = std::nullopt;

    if (platformUtil) {
      result = platformUtil->HandleWindowProc(hWnd, message, wParam, lParam);
    }

    return result;
  }
}