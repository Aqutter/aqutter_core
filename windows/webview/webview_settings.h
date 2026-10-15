#ifndef AQUTTER_CORE_PLUGIN_AQUTTER_WEBVIEW_SETTINGS_H_
#define AQUTTER_CORE_PLUGIN_AQUTTER_WEBVIEW_SETTINGS_H_

#include <optional>
#include <string>
#include <WebView2.h>

namespace aqutter_core_plugin
{
  class AqutterWebView;

  class AqutterWebViewSettings
  {
  public:
    bool useShouldOverrideUrlLoading = false;
    bool useOnLoadResource = false;
    bool useOnDownloadStart = false;
    bool useShouldInterceptRequest = false;
    std::string userAgent;
    bool javaScriptEnabled = true;
    bool transparentBackground = false;
    bool supportZoom = true;
    bool isInspectable = true;
    bool disableContextMenu = false;
    bool incognito = false;
    std::optional<std::vector<std::string>> javaScriptHandlersOriginAllowList = std::optional<std::vector<std::string>>{};
    bool javaScriptHandlersForMainFrameOnly = false;
    bool javaScriptBridgeEnabled = true;
    std::optional<std::vector<std::string>> javaScriptBridgeOriginAllowList = std::optional<std::vector<std::string>>{};
    std::optional<bool> javaScriptBridgeForMainFrameOnly = std::optional<bool>{};
    std::optional<std::vector<std::string>> pluginScriptsOriginAllowList = std::optional<std::vector<std::string>>{};
    bool pluginScriptsForMainFrameOnly = false;
    int64_t scrollMultiplier = 1;
    bool disableDefaultErrorPage = false;
    bool statusBarEnabled = true;
    bool browserAcceleratorKeysEnabled = true;
    bool generalAutofillEnabled = true;
    bool passwordAutosaveEnabled = false;
    bool pinchZoomEnabled = true;
    bool allowsBackForwardNavigationGestures = true;
    int64_t hiddenPdfToolbarItems = COREWEBVIEW2_PDF_TOOLBAR_ITEMS::COREWEBVIEW2_PDF_TOOLBAR_ITEMS_NONE;
    bool reputationCheckingRequired = true;
    bool nonClientRegionSupportEnabled = false;
    bool handleAcceleratorKeyPressed = false;

    AqutterWebViewSettings();
    AqutterWebViewSettings(const flutter::EncodableMap& encodableMap);
    ~AqutterWebViewSettings();

    flutter::EncodableMap toEncodableMap() const;
    flutter::EncodableMap getRealSettings(const AqutterWebView* aqutterWebView) const;
  };
}
#endif //AQUTTER_CORE_PLUGIN_AQUTTER_WEBVIEW_SETTINGS_H_