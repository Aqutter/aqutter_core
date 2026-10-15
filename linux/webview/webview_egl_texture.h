#ifndef AQUTTER_CORE_PLUGIN_AQUTTER_WEBVIEW_EGL_TEXTURE_H_
#define AQUTTER_CORE_PLUGIN_AQUTTER_WEBVIEW_EGL_TEXTURE_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

/**
 * Zero-copy EGL Image texture for AqutterWebView.
 *
 * This implementation provides maximum performance by directly using the
 * EGL image exported from WPE WebKit without any CPU readback.
 *
 * The key insight is that FlTextureGL::populate() receives the GL texture ID
 * that we've already bound to the EGL image - no pixel copy needed!
 *
 * Performance benefits:
 * - Zero GPU → CPU → GPU round-trip
 * - Direct DMA-BUF sharing between WPE WebKit and Flutter
 * - Minimal latency for large textures
 */

#define AQUTTER_WEBVIEW_TYPE_EGL_TEXTURE (aqutter_webview_egl_texture_get_type())

G_DECLARE_FINAL_TYPE(AqutterWebViewEGLTexture, aqutter_webview_egl_texture, AQUTTER_WEBVIEW, EGL_TEXTURE,
                     FlTextureGL)

// Forward declaration
namespace aqutter_core_plugin {
class AqutterWebView;
using WebViewType = AqutterWebView;
}  // namespace aqutter_core_plugin

/**
 * Creates a new AqutterWebViewEGLTexture.
 *
 * This texture implementation directly uses EGL images from WPE WebKit,
 * avoiding expensive pixel readback operations.
 *
 * @param webview The webview to get frames from.
 * @return A new AqutterWebViewEGLTexture instance.
 */
AqutterWebViewEGLTexture* aqutter_webview_egl_texture_new(
    aqutter_core_plugin::WebViewType* webview);

/**
 * Updates the texture with a new EGL image.
 *
 * Call this from the WPE export callback when a new frame is available.
 * The texture will bind the EGL image to a GL texture without readback.
 *
 * @param self The texture instance.
 * @param egl_image The EGL image handle (EGLImageKHR).
 * @param width The image width.
 * @param height The image height.
 */
void aqutter_webview_egl_texture_set_egl_image(AqutterWebViewEGLTexture* self,
                                            void* egl_image,
                                            uint32_t width,
                                            uint32_t height);

G_END_DECLS

#endif  // AQUTTER_CORE_PLUGIN_AQUTTER_WEBVIEW_EGL_TEXTURE_H_
