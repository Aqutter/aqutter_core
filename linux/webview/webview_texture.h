#ifndef AQUTTER_CORE_PLUGIN_AQUTTER_WEBVIEW_TEXTURE_H_
#define AQUTTER_CORE_PLUGIN_AQUTTER_WEBVIEW_TEXTURE_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

// Declare the custom texture type
#define AQUTTER_WEBVIEW_TYPE_TEXTURE (aqutter_webview_texture_get_type())

G_DECLARE_FINAL_TYPE(AqutterWebViewTexture, aqutter_webview_texture, AQUTTER_WEBVIEW, TEXTURE,
                     FlPixelBufferTexture)

// Forward declaration
namespace aqutter_core_plugin {
class AqutterWebView;
using WebViewType = AqutterWebView;
}  // namespace aqutter_core_plugin

// Create a new AqutterWebViewTexture
AqutterWebViewTexture* aqutter_webview_texture_new(aqutter_core_plugin::WebViewType* webview);

G_END_DECLS

#endif  // AQUTTER_CORE_PLUGIN_AQUTTER_WEBVIEW_TEXTURE_H_
