#include "include/aqutter_core/aqutter_core_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "aqutter_core_plugin.h"

void AqutterCorePluginCApiRegisterWithRegistrar(
  FlutterDesktopPluginRegistrarRef registrar)
{
  aqutter_core_plugin::AqutterCorePlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarManager::GetInstance()
    ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
