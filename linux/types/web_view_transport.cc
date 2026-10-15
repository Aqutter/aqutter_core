#include "web_view_transport.h"

#include "../webview/webview.h"

namespace aqutter_core_plugin {

WebKitWebView* WebViewTransport::getWebKitWebView() const {
  if (aqutterWebView) {
    return aqutterWebView->webview();
  }
  return nullptr;
}

}  // namespace aqutter_core_plugin
