#ifndef AQUTTER_CORE_PLUGIN_WEB_VIEW_TRANSPORT_H_
#define AQUTTER_CORE_PLUGIN_WEB_VIEW_TRANSPORT_H_

#include <wpe/webkit.h>

#include <memory>
#include <optional>
#include <string>

namespace aqutter_core_plugin {

class AqutterWebView;

/**
 * Holds a WebView created for a new window (via onCreateWindow)
 * along with the initial URL request that triggered it.
 */
struct WebViewTransport {
  // The AqutterWebView wrapper that owns the WebKitWebView
  std::unique_ptr<AqutterWebView> aqutterWebView;
  
  // The initial URL request that triggered the window creation
  std::optional<std::string> url;
  
  WebViewTransport(std::unique_ptr<AqutterWebView> webView, const std::optional<std::string>& url)
      : aqutterWebView(std::move(webView)), url(url) {}
  
  // Get the internal WebKitWebView* (for returning to WebKit create signal)
  WebKitWebView* getWebKitWebView() const;
  
  ~WebViewTransport() = default;
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_WEB_VIEW_TRANSPORT_H_
