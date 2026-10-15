#include "../utils/log.h"
#include "headless_webview.h"

namespace aqutter_core_plugin
{
  using namespace Microsoft::WRL;

  AqutterHeadlessWebView::AqutterHeadlessWebView(const AqutterCorePlugin* plugin, const AqutterHeadlessWebViewCreationParams& params, const HWND parentWindow, std::unique_ptr<AqutterWebView> webView)
    : plugin(plugin), id(params.id),
    webView(std::move(webView)),
    channelDelegate(std::make_unique<HeadlessWebViewChannelDelegate>(this, plugin->registrar->messenger()))
  {
    prepare(params);
    ShowWindow(parentWindow, SW_HIDE);
  }

  void AqutterHeadlessWebView::prepare(const AqutterHeadlessWebViewCreationParams& params)
  {
    if (!webView) {
      return;
    }
  }

  void AqutterHeadlessWebView::setSize(const std::shared_ptr<Size2D> size) const
  {
    if (!webView) {
      return;
    }
    RECT rect = {
      0, 0, (LONG)size->width, (LONG)size->height
    };
    webView->webViewController->put_Bounds(rect);
  }

  std::shared_ptr<Size2D> AqutterHeadlessWebView::getSize() const
  {
    if (!webView) {
      return std::make_shared<Size2D>(-1.0, -1.0);
    }
    RECT rect;
    webView->webViewController->get_Bounds(&rect);
    auto width = rect.right - rect.left;
    auto height = rect.bottom - rect.top;
    return std::make_shared<Size2D>((double)width, (double)height);
  }

  AqutterHeadlessWebView::~AqutterHeadlessWebView()
  {
    debugLog("dealloc AqutterHeadlessWebView");
    HWND parentWindow = nullptr;
    if (webView && webView->webViewController) {
      webView->webViewController->get_ParentWindow(&parentWindow);
    }
    webView = nullptr;
    if (parentWindow) {
      DestroyWindow(parentWindow);
    }
  }
}