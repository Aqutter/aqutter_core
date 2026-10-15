// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_webview_environment.dart';

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformWebViewEnvironmentCreationParamsClassSupported
    on AqutterPlatformWebViewEnvironmentCreationParams {
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironmentCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebViewEnvironmentCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.windows,
          TargetPlatform.linux,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformWebViewEnvironmentCreationParams]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformWebViewEnvironmentCreationParamsProperty {
  ///Can be used to check if the [AqutterPlatformWebViewEnvironmentCreationParams.settings] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironmentCreationParams.settings.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPlatformWebViewEnvironmentCreationParams.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  settings,
}

extension _AqutterPlatformWebViewEnvironmentCreationParamsPropertySupported
    on AqutterPlatformWebViewEnvironmentCreationParams {
  static bool isPropertySupported(
    AqutterPlatformWebViewEnvironmentCreationParamsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformWebViewEnvironmentCreationParamsProperty.settings:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

extension _AqutterPlatformWebViewEnvironmentClassSupported
    on AqutterPlatformWebViewEnvironment {
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.windows,
          TargetPlatform.linux,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformWebViewEnvironment]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPlatformWebViewEnvironmentProperty {
  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.id] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.id.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  id,

  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.onBrowserProcessExited] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.onBrowserProcessExited.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.992.28++ ([Official API - ICoreWebView2Environment5.add_BrowserProcessExited](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment5?view=webview2-1.0.2849.39#add_browserprocessexited))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [detail]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onBrowserProcessExited,

  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.onNewBrowserVersionAvailable] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.onNewBrowserVersionAvailable.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2Environment.add_NewBrowserVersionAvailable](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment?view=webview2-1.0.2849.39#add_newbrowserversionavailable))
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onNewBrowserVersionAvailable,

  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.onProcessInfosChanged] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.onProcessInfosChanged.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.1108.44++ ([Official API - ICoreWebView2Environment8.add_ProcessInfosChanged](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment8?view=webview2-1.0.2849.39#add_processinfoschanged))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [detail]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  onProcessInfosChanged,
}

extension _AqutterPlatformWebViewEnvironmentPropertySupported
    on AqutterPlatformWebViewEnvironment {
  static bool isPropertySupported(
    AqutterPlatformWebViewEnvironmentProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPlatformWebViewEnvironmentProperty.id:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewEnvironmentProperty.onBrowserProcessExited:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewEnvironmentProperty
          .onNewBrowserVersionAvailable:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewEnvironmentProperty.onProcessInfosChanged:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

///List of [AqutterPlatformWebViewEnvironment]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformWebViewEnvironmentMethod {
  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.compareBrowserVersions] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.compareBrowserVersions.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - CompareBrowserVersions](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2210.55#comparebrowserversions))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [version1]: all platforms
  ///- [version2]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  compareBrowserVersions,

  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.create] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.create.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - CreateCoreWebView2EnvironmentWithOptions](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2210.55#createcorewebview2environmentwithoptions))
  ///- Linux WPE WebKit ([Official API - WebKitWebContext](https://webkitgtk.org/reference/webkit2gtk/stable/class.WebContext.html)):
  ///    - Creates a new WebKitWebContext for shared WebView configuration.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [settings]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  create,

  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.dispose] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.dispose.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  dispose,

  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.getAvailableVersion] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.getAvailableVersion.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - GetAvailableCoreWebView2BrowserVersionString](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2849.39#getavailablecorewebview2browserversionstring))
  ///- Linux WPE WebKit ([Official API - webkit_get_major_version](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/func.get_major_version.html)):
  ///    - Returns WPE WebKit version string composed of major.minor.micro versions.
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [browserExecutableFolder]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getAvailableVersion,

  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.getCacheModel] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.getCacheModel.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_get_cache_model](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.get_cache_model.html))
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getCacheModel,

  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.getFailureReportFolderPath] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.getFailureReportFolderPath.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.1518.46++ ([Official API - ICoreWebView2Environment11.get_FailureReportFolderPath](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment11?view=webview2-1.0.2849.39#get_failurereportfolderpath))
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getFailureReportFolderPath,

  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.getProcessInfos] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.getProcessInfos.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.1108.44++ ([Official API - ICoreWebView2Environment8.GetProcessInfos](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment8?view=webview2-1.0.2849.39#getprocessinfos))
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getProcessInfos,

  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.getSpellCheckingLanguages] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.getSpellCheckingLanguages.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_get_spell_checking_languages](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.get_spell_checking_languages.html))
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  getSpellCheckingLanguages,

  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.isAutomationAllowed] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.isAutomationAllowed.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_is_automation_allowed](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.is_automation_allowed.html))
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isAutomationAllowed,

  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.isInterfaceSupported] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.isInterfaceSupported.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [interface]: all platforms
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isInterfaceSupported,

  ///Can be used to check if the [AqutterPlatformWebViewEnvironment.isSpellCheckingEnabled] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.isSpellCheckingEnabled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_get_spell_checking_enabled](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.get_spell_checking_enabled.html))
  ///
  ///Use the [AqutterPlatformWebViewEnvironment.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  isSpellCheckingEnabled,
}

extension _AqutterPlatformWebViewEnvironmentMethodSupported
    on AqutterPlatformWebViewEnvironment {
  static bool isMethodSupported(
    AqutterPlatformWebViewEnvironmentMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformWebViewEnvironmentMethod.compareBrowserVersions:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewEnvironmentMethod.create:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewEnvironmentMethod.dispose:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewEnvironmentMethod.getAvailableVersion:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewEnvironmentMethod.getCacheModel:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.linux].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewEnvironmentMethod.getFailureReportFolderPath:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewEnvironmentMethod.getProcessInfos:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewEnvironmentMethod.getSpellCheckingLanguages:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.linux].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewEnvironmentMethod.isAutomationAllowed:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.linux].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewEnvironmentMethod.isInterfaceSupported:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformWebViewEnvironmentMethod.isSpellCheckingEnabled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.linux].contains(platform ?? defaultTargetPlatform);
    }
  }
}
