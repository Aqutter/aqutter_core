#ifndef AQUTTER_CORE_PLUGIN_HEADLESS_AQUTTER_WEBVIEW_H_
#define AQUTTER_CORE_PLUGIN_HEADLESS_AQUTTER_WEBVIEW_H_

#include <flutter_linux/flutter_linux.h>

#include <memory>
#include <string>

#include "../webview/webview.h"
#include "headless_webview_channel_delegate.h"

namespace aqutter_core_plugin {

class AqutterHeadlessWebViewManager;

struct AqutterHeadlessWebViewCreationParams {
  std::string id;
  double initialWidth = -1;
  double initialHeight = -1;
};

/// AqutterHeadlessWebView - A WebView without visual output
///
/// This class wraps AqutterWebView for headless operation.
/// Since WPE WebKit is inherently headless (it renders to offscreen buffers),
/// this is essentially AqutterWebView without texture registration.
class AqutterHeadlessWebView {
 public:

  AqutterHeadlessWebView(AqutterHeadlessWebViewManager* manager,
                       const AqutterHeadlessWebViewCreationParams& params,
                       const AqutterWebViewCreationParams& webviewParams);
  ~AqutterHeadlessWebView();

  const std::string& id() const { return id_; }
  AqutterWebView* webview() const { return webview_.get(); }
  AqutterHeadlessWebViewManager* manager() const { return manager_; }

  // Size management
  void setSize(double width, double height);
  void getSize(double* width, double* height) const;

  // Get the channel delegate
  HeadlessWebViewChannelDelegate* channelDelegate() const { return channelDelegate_.get(); }

  // Dispose this headless webview (called by channel delegate)
  void dispose();

 private:
  AqutterHeadlessWebViewManager* manager_ = nullptr;
  std::string id_;
  double width_ = -1;
  double height_ = -1;

  // The underlying AqutterWebView
  std::shared_ptr<AqutterWebView> webview_;

  // Channel delegate for this headless webview
  std::unique_ptr<HeadlessWebViewChannelDelegate> channelDelegate_;
};

}  // namespace aqutter_core_plugin

#endif  // AQUTTER_CORE_PLUGIN_HEADLESS_AQUTTER_WEBVIEW_H_
