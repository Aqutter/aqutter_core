#include <DispatcherQueue.h>
#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>
#include <shlobj.h>
#include <windows.graphics.capture.h>

#include "../webview/webview_settings.h"
#include "../types/size_2d.h"
#include "../types/url_request.h"
#include "../types/user_script.h"
#include "../utils/flutter.h"
#include "../utils/log.h"
#include "../utils/map.h"
#include "../utils/string.h"
#include "../utils/vector.h"
#include "../webview_environment/webview_environment_manager.h"
#include "headless_webview_manager.h"

namespace aqutter_core_plugin
{
  AqutterHeadlessWebViewManager::AqutterHeadlessWebViewManager(const AqutterCorePlugin* plugin)
    : plugin(plugin),
    ChannelDelegate(plugin->registrar->messenger(), AqutterHeadlessWebViewManager::METHOD_CHANNEL_NAME)
  {
    windowClass_.lpszClassName = AqutterHeadlessWebView::CLASS_NAME;
    windowClass_.lpfnWndProc = &DefWindowProc;

    RegisterClass(&windowClass_);
  }

  void AqutterHeadlessWebViewManager::HandleMethodCall(const flutter::MethodCall<flutter::EncodableValue>& method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
    auto& methodName = method_call.method_name();

    if (string_equals(methodName, "run")) {
      run(arguments, std::move(result));
    }
    else {
      result->NotImplemented();
    }
  }

  void AqutterHeadlessWebViewManager::run(const flutter::EncodableMap* arguments, std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    auto result_ = std::shared_ptr<flutter::MethodResult<flutter::EncodableValue>>(std::move(result));

    if (!plugin) {
      result_->Error("0", "Cannot create the AqutterHeadlessWebView instance!");
      return;
    }

    auto id = get_fl_map_value<std::string>(*arguments, "id");
    auto params = get_fl_map_value<flutter::EncodableMap>(*arguments, "params");

    auto initialSize = std::make_shared<Size2D>(get_fl_map_value<flutter::EncodableMap>(params, "initialSize"));

    auto settingsMap = get_fl_map_value<flutter::EncodableMap>(params, "initialSettings");
    auto urlRequestMap = get_optional_fl_map_value<flutter::EncodableMap>(params, "initialUrlRequest");
    auto initialFile = get_optional_fl_map_value<std::string>(params, "initialFile");
    auto initialDataMap = get_optional_fl_map_value<flutter::EncodableMap>(params, "initialData");
    auto initialUserScriptList = get_optional_fl_map_value<flutter::EncodableList>(params, "initialUserScripts");
    auto webViewEnvironmentId = get_optional_fl_map_value<std::string>(params, "webViewEnvironmentId");

    RECT bounds;
    GetClientRect(plugin->registrar->GetView()->GetNativeWindow(), &bounds);

    auto initialWidth = initialSize->width >= 0 ? initialSize->width : bounds.right - bounds.left;
    auto initialHeight = initialSize->height >= 0 ? initialSize->height : bounds.bottom - bounds.top;

    auto hwnd = CreateWindowEx(0, windowClass_.lpszClassName, L"", 0, 0,
      0, (int)initialWidth, (int)initialHeight,
      plugin->registrar->GetView()->GetNativeWindow(),
      nullptr,
      windowClass_.hInstance, nullptr);

    auto webViewEnvironment = webViewEnvironmentId.has_value() && map_contains(plugin->webViewEnvironmentManager->webViewEnvironments, webViewEnvironmentId.value())
      ? plugin->webViewEnvironmentManager->webViewEnvironments.at(webViewEnvironmentId.value()).get() : nullptr;

    auto initialSettings = std::make_shared<AqutterWebViewSettings>(settingsMap);

    AqutterWebView::createAqutterWebViewEnv(hwnd, false, webViewEnvironment, initialSettings,
      [=](wil::com_ptr<ICoreWebView2Environment> webViewEnv,
        wil::com_ptr<ICoreWebView2Controller> webViewController,
        wil::com_ptr<ICoreWebView2CompositionController> webViewCompositionController)
      {
        if (plugin && webViewEnv && webViewController) {
          std::optional<std::vector<std::shared_ptr<UserScript>>> initialUserScripts = initialUserScriptList.has_value() ?
            functional_map(initialUserScriptList.value(), [](const flutter::EncodableValue& map) { return std::make_shared<UserScript>(std::get<flutter::EncodableMap>(map)); }) :
            std::optional<std::vector<std::shared_ptr<UserScript>>>{};

          AqutterWebViewCreationParams params = {
            id,
            std::move(initialSettings),
            initialUserScripts
          };

          auto aqutterWebView = std::make_unique<AqutterWebView>(plugin, params, hwnd,
            std::move(webViewEnv), std::move(webViewController), nullptr
          );

          AqutterHeadlessWebViewCreationParams headlessParams = {
            id,
            std::move(initialSize)
          };

          auto headlessAqutterWebView = std::make_unique<AqutterHeadlessWebView>(plugin,
            headlessParams,
            hwnd,
            std::move(aqutterWebView));

          headlessAqutterWebView->webView->initChannel(std::nullopt, std::nullopt);

          if (headlessAqutterWebView->channelDelegate) {
            headlessAqutterWebView->channelDelegate->onWebViewCreated();
          }

          std::optional<std::shared_ptr<URLRequest>> urlRequest = urlRequestMap.has_value() ? std::make_shared<URLRequest>(urlRequestMap.value()) : std::optional<std::shared_ptr<URLRequest>>{};
          if (urlRequest.has_value()) {
            headlessAqutterWebView->webView->loadUrl(urlRequest.value());
          }
          else if (initialFile.has_value()) {
            headlessAqutterWebView->webView->loadFile(initialFile.value());
          }
          else if (initialDataMap.has_value()) {
            headlessAqutterWebView->webView->loadData(get_fl_map_value<std::string>(initialDataMap.value(), "data"));
          }

          webViews.insert({ id, std::move(headlessAqutterWebView) });

          result_->Success(true);
        }
        else {
          result_->Error("0", "Cannot create the AqutterHeadlessWebView instance!");
        }
      }
    );
  }

  AqutterHeadlessWebViewManager::~AqutterHeadlessWebViewManager()
  {
    debugLog("dealloc AqutterHeadlessWebViewManager");
    webViews.clear();
    UnregisterClass(windowClass_.lpszClassName, nullptr);
    plugin = nullptr;
  }
}