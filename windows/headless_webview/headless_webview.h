#ifndef AQUTTER_CORE_PLUGIN_HEADLESS_AQUTTER_WEBVIEW_H_
#define AQUTTER_CORE_PLUGIN_HEADLESS_AQUTTER_WEBVIEW_H_

#include "../aqutter_core_plugin.h"
#include "../webview/webview.h"
#include "../types/size_2d.h"
#include "headless_webview_channel_delegate.h"

namespace aqutter_core_plugin
{
  struct AqutterHeadlessWebViewCreationParams {
    const std::string id;
    const std::shared_ptr<Size2D> initialSize;
  };

  class AqutterHeadlessWebView
  {
  public:
    static inline const wchar_t* CLASS_NAME = L"AqutterHeadlessWebView";
    static inline const std::string METHOD_CHANNEL_NAME_PREFIX = "com.github.aqutter/headless_webview_";

    const AqutterCorePlugin* plugin;
    std::string id;
    std::unique_ptr<AqutterWebView> webView;
    std::unique_ptr<HeadlessWebViewChannelDelegate> channelDelegate;

    AqutterHeadlessWebView(const AqutterCorePlugin* plugin, const AqutterHeadlessWebViewCreationParams& params, const HWND parentWindow, std::unique_ptr<AqutterWebView> webView);
    ~AqutterHeadlessWebView();

    void prepare(const AqutterHeadlessWebViewCreationParams& params);
    void setSize(const std::shared_ptr<Size2D> size) const;
    std::shared_ptr<Size2D> getSize() const;
  };
}
#endif //AQUTTER_CORE_PLUGIN_HEADLESS_AQUTTER_WEBVIEW_H_