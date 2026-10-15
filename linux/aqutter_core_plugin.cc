#include "include/aqutter_core/aqutter_core_plugin.h"

#include "aqutter_core_plugin_private.h"
#include "plugin_instance.h"

#include <flutter_linux/flutter_linux.h>
#include <gdk/gdk.h>
#include <gtk/gtk.h>

#include <cstring>
#include <memory>

#include "cookie_manager.h"
#include "credential_database.h"
#include "headless_webview/headless_webview_manager.h"
#include "browser/browser_manager.h"
#include "webview/webview_manager.h"
#include "proxy_manager.h"
#include "utils/software_rendering.h"
#include "web_storage_manager.h"
#include "webview_environment.h"

#define AQUTTER_CORE_PLUGIN(obj)                                     \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), aqutter_core_plugin_get_type(), \
                              AqutterCorePlugin))

struct _AqutterCorePlugin {
  GObject parent_instance;
  FlPluginRegistrar* registrar;
  
  // C++ plugin instance for passing to managers
  std::unique_ptr<aqutter_core_plugin::PluginInstance> plugin_instance;
  
  // Managers are owned by the GObject
  std::unique_ptr<aqutter_core_plugin::AqutterWebViewManager> aqutter_webview_manager;
  std::unique_ptr<aqutter_core_plugin::AqutterHeadlessWebViewManager> headless_aqutter_webview_manager;
  std::unique_ptr<aqutter_core_plugin::AqutterBrowserManager> aqutter_browser_manager;
  std::unique_ptr<aqutter_core_plugin::CookieManager> cookie_manager;
  std::unique_ptr<aqutter_core_plugin::CredentialDatabase> credential_database;
  std::unique_ptr<aqutter_core_plugin::ProxyManager> proxy_manager;
  std::unique_ptr<aqutter_core_plugin::WebStorageManager> web_storage_manager;
  std::unique_ptr<aqutter_core_plugin::WebViewEnvironment> webview_environment;
};

G_DEFINE_TYPE(AqutterCorePlugin, aqutter_core_plugin,
              g_object_get_type())

static void aqutter_core_plugin_dispose(GObject* object) {
  AqutterCorePlugin* self = AQUTTER_CORE_PLUGIN(object);

  // Clean up the managers
  self->aqutter_webview_manager.reset();
  self->headless_aqutter_webview_manager.reset();
  self->aqutter_browser_manager.reset();
  self->cookie_manager.reset();
  self->credential_database.reset();
  self->proxy_manager.reset();
  self->web_storage_manager.reset();
  self->webview_environment.reset();
  
  // Clean up the plugin instance last (after managers are gone)
  self->plugin_instance.reset();

  G_OBJECT_CLASS(aqutter_core_plugin_parent_class)->dispose(object);
}

static void aqutter_core_plugin_class_init(
    AqutterCorePluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = aqutter_core_plugin_dispose;
}

static void aqutter_core_plugin_init(AqutterCorePlugin* self) {
  self->registrar = nullptr;
  // Note: aqutter_webview_manager is initialized by its default constructor
}

void aqutter_core_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  // === CRITICAL: Check for VM/problematic GPU BEFORE any WebKit initialization ===
  // This must happen before any WPEDisplay is created, because WebKit's WebProcess
  // inherits environment variables at spawn time. Setting LIBGL_ALWAYS_SOFTWARE
  // after WebProcess starts has no effect.
  aqutter_core_plugin::ApplySoftwareRenderingIfNeeded();

  AqutterCorePlugin* plugin = AQUTTER_CORE_PLUGIN(
      g_object_new(aqutter_core_plugin_get_type(), nullptr));

  plugin->registrar = registrar;

  plugin->plugin_instance = std::make_unique<aqutter_core_plugin::PluginInstance>(registrar);
  auto* pluginInstance = plugin->plugin_instance.get();

  plugin->aqutter_webview_manager =
      std::make_unique<aqutter_core_plugin::AqutterWebViewManager>(pluginInstance);
  pluginInstance->aqutterWebViewManager = plugin->aqutter_webview_manager.get();

  plugin->headless_aqutter_webview_manager =
      std::make_unique<aqutter_core_plugin::AqutterHeadlessWebViewManager>(pluginInstance);
  pluginInstance->headlessAqutterWebViewManager = plugin->headless_aqutter_webview_manager.get();

  plugin->aqutter_browser_manager =
      std::make_unique<aqutter_core_plugin::AqutterBrowserManager>(pluginInstance);
  pluginInstance->aqutterBrowserManager = plugin->aqutter_browser_manager.get();

  plugin->cookie_manager = std::make_unique<aqutter_core_plugin::CookieManager>(pluginInstance);
  pluginInstance->cookieManager = plugin->cookie_manager.get();

  plugin->credential_database =
      std::make_unique<aqutter_core_plugin::CredentialDatabase>(pluginInstance);
  pluginInstance->credentialDatabase = plugin->credential_database.get();

  plugin->proxy_manager = std::make_unique<aqutter_core_plugin::ProxyManager>(pluginInstance);
  pluginInstance->proxyManager = plugin->proxy_manager.get();

  plugin->web_storage_manager = std::make_unique<aqutter_core_plugin::WebStorageManager>(pluginInstance);
  pluginInstance->webStorageManager = plugin->web_storage_manager.get();

  plugin->webview_environment = std::make_unique<aqutter_core_plugin::WebViewEnvironment>(pluginInstance);
  pluginInstance->webViewEnvironment = plugin->webview_environment.get();

  // Note: We don't unref the plugin here as it needs to stay alive
  // for the lifetime of the application
  g_object_ref(plugin);
}

// === Helper functions for accessing Flutter view and window ===

FlView* aqutter_core_plugin_get_view(FlPluginRegistrar* registrar) {
  if (registrar == nullptr) {
    return nullptr;
  }
  return fl_plugin_registrar_get_view(registrar);
}

GtkWindow* aqutter_core_plugin_get_window(FlPluginRegistrar* registrar) {
  FlView* view = aqutter_core_plugin_get_view(registrar);
  if (view == nullptr) {
    return nullptr;
  }

  GtkWidget* widget = GTK_WIDGET(view);
  if (widget == nullptr) {
    return nullptr;
  }

  GtkWidget* toplevel = gtk_widget_get_toplevel(widget);
  if (toplevel == nullptr || !GTK_IS_WINDOW(toplevel)) {
    return nullptr;
  }

  return GTK_WINDOW(toplevel);
}

int aqutter_core_plugin_get_monitor_refresh_rate(FlPluginRegistrar* registrar) {
  GtkWindow* window = aqutter_core_plugin_get_window(registrar);
  return aqutter_core_plugin_get_monitor_refresh_rate_for_window(window);
}

int aqutter_core_plugin_get_monitor_refresh_rate_for_window(GtkWindow* window) {
  if (window == nullptr) {
    return 0;
  }

  GdkWindow* gdk_window = gtk_widget_get_window(GTK_WIDGET(window));
  if (gdk_window == nullptr) {
    return 0;
  }

  GdkDisplay* display = gdk_display_get_default();
  if (display == nullptr) {
    return 0;
  }

  GdkMonitor* monitor = gdk_display_get_monitor_at_window(display, gdk_window);
  if (monitor == nullptr) {
    return 0;
  }

  // gdk_monitor_get_refresh_rate returns the refresh rate in millihertz
  // (e.g., 60000 for 60 Hz)
  return gdk_monitor_get_refresh_rate(monitor);
}

