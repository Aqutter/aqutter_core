// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_proxy_controller.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///{@template aqutter_core.AqutterProxySettings}
///Class that represents the settings used to configure the [AqutterPlatformProxyController].
///{@endtemplate}
///
///{@macro aqutter_core.AqutterProxySettings.supported_platforms}
///
///**Officially Supported Platforms/Implementations**:
///- Android WebView ([Official API - ProxyConfig](https://developer.android.com/reference/androidx/webkit/ProxyConfig))
///- iOS WKWebView 17.0+ ([Official API - ProxyConfiguration](https://developer.apple.com/documentation/network/proxyconfiguration))
///- macOS WKWebView 14.0+ ([Official API - ProxyConfiguration](https://developer.apple.com/documentation/network/proxyconfiguration))
///- Linux WPE WebKit ([Official API - WebKitNetworkProxySettings](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/struct.NetworkProxySettings.html))
class AqutterProxySettings {
  ///List of bypass rules.
  ///
  ///A bypass rule describes URLs that should skip proxy override settings and make a direct connection instead. These can be URLs or IP addresses. Wildcards are accepted.
  ///For instance, the rule "*example.com" would mean that requests to "http://example.com" and "www.example.com" would not be directed to any proxy,
  ///instead, would be made directly to the origin specified by the URL.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- Linux WPE WebKit ([Official API - webkit_network_proxy_settings_new (ignore_hosts)](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/ctor.NetworkProxySettings.new.html)):
  ///    - Mapped to ignore_hosts; bypass rules are passed as host patterns to WebKitNetworkProxySettings.
  List<String> bypassRules;

  ///Hostnames without a period in them (and that are not IP literals) will skip proxy settings and be connected to directly instead. Examples: `"abc"`, `"local"`, `"some-domain"`.
  ///
  ///Hostnames with a trailing dot are not considered simple by this definition.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  bool? bypassSimpleHostnames;

  ///List of scheme filters.
  ///
  ///URLs that match these scheme filters are connected to directly instead of using a proxy server.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  List<String> directs;

  ///List of proxy rules to be used for all URLs. Additional rules have decreasing precedence.
  ///
  ///Proxy is a string in the format `[scheme://]host[:port]`.
  ///Scheme is optional, if present must be `HTTP`, `HTTPS` or [SOCKS](https://tools.ietf.org/html/rfc1928) and defaults to `HTTP`.
  ///Host is one of an IPv6 literal with brackets, an IPv4 literal or one or more labels separated by a period.
  ///Port number is optional and defaults to `80` for `HTTP`, `443` for `HTTPS` and `1080` for `SOCKS`.
  ///
  ///The correct syntax for hosts is defined by [RFC 3986](https://tools.ietf.org/html/rfc3986#section-3.2.2).
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  List<AqutterProxyRule> proxyRules;

  ///By default, certain hostnames implicitly bypass the proxy if they are link-local IPs, or localhost addresses.
  ///For instance hostnames matching any of (non-exhaustive list):
  ///- localhost
  ///- *.localhost
  ///- [::1]
  ///- 127.0.0.1/8
  ///- 169.254/16
  ///- [FE80::]/10
  ///Set this to `true` to override the default behavior and force localhost and link-local URLs to be sent through the proxy.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  bool? removeImplicitRules;

  ///Reverse the bypass list.
  ///
  ///The default value is `false`, in which case all URLs will use proxy settings except the ones in the bypass list, which will be connected to directly instead.
  ///
  ///If set to `true`, then only URLs in the bypass list will use these proxy settings, and all other URLs will be connected to directly.
  ///
  ///Use [bypassRules] to add bypass rules.
  ///
  ///**NOTE**: available only if [AqutterWebViewFeature.PROXY_OVERRIDE_REVERSE_BYPASS] feature is supported.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  bool reverseBypassEnabled;

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ProxyConfig](https://developer.android.com/reference/androidx/webkit/ProxyConfig))
  ///- iOS WKWebView 17.0+ ([Official API - ProxyConfiguration](https://developer.apple.com/documentation/network/proxyconfiguration))
  ///- macOS WKWebView 14.0+ ([Official API - ProxyConfiguration](https://developer.apple.com/documentation/network/proxyconfiguration))
  ///- Linux WPE WebKit ([Official API - WebKitNetworkProxySettings](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/struct.NetworkProxySettings.html))
  AqutterProxySettings({
    this.bypassRules = const [],
    this.bypassSimpleHostnames,
    this.directs = const [],
    this.proxyRules = const [],
    this.removeImplicitRules,
    this.reverseBypassEnabled = false,
  });

  ///Gets a possible [AqutterProxySettings] instance from a [Map] value.
  static AqutterProxySettings? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterProxySettings(
      bypassSimpleHostnames: map['bypassSimpleHostnames'],
      removeImplicitRules: map['removeImplicitRules'],
    );
    if (map['bypassRules'] != null) {
      instance.bypassRules = List<String>.from(
        map['bypassRules']!.cast<String>(),
      );
    }
    if (map['directs'] != null) {
      instance.directs = List<String>.from(map['directs']!.cast<String>());
    }
    if (map['proxyRules'] != null) {
      instance.proxyRules = List<AqutterProxyRule>.from(
        map['proxyRules'].map(
          (e) => AqutterProxyRule.fromMap(
            e?.cast<String, dynamic>(),
            enumMethod: enumMethod,
          )!,
        ),
      );
    }
    if (map['reverseBypassEnabled'] != null) {
      instance.reverseBypassEnabled = map['reverseBypassEnabled'];
    }
    return instance;
  }

  ///{@template aqutter_core.AqutterProxySettings.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterProxySettingsClassSupported.isClassSupported(platform: platform);

  ///{@template aqutter_core.AqutterProxySettings.isPropertySupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  static bool isPropertySupported(
    AqutterProxySettingsProperty property, {
    TargetPlatform? platform,
  }) => _AqutterProxySettingsPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "bypassRules": bypassRules,
      "bypassSimpleHostnames": bypassSimpleHostnames,
      "directs": directs,
      "proxyRules": proxyRules
          .map((e) => e.toMap(enumMethod: enumMethod))
          .toList(),
      "removeImplicitRules": removeImplicitRules,
      "reverseBypassEnabled": reverseBypassEnabled,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  ///Returns a copy of AqutterProxySettings.
  AqutterProxySettings copy() {
    return AqutterProxySettings.fromMap(toMap()) ?? AqutterProxySettings();
  }

  @override
  String toString() {
    return 'AqutterProxySettings{bypassRules: $bypassRules, bypassSimpleHostnames: $bypassSimpleHostnames, directs: $directs, proxyRules: $proxyRules, removeImplicitRules: $removeImplicitRules, reverseBypassEnabled: $reverseBypassEnabled}';
  }
}

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

extension _AqutterPlatformProxyControllerCreationParamsClassSupported
    on AqutterPlatformProxyControllerCreationParams {
  ///{@template aqutter_core.AqutterPlatformProxyControllerCreationParams.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterPlatformProxyControllerCreationParams.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.linux,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

extension _AqutterPlatformProxyControllerClassSupported
    on AqutterPlatformProxyController {
  ///{@template aqutter_core.AqutterPlatformProxyController.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterProxyController](https://developer.android.com/reference/androidx/webkit/AqutterProxyController))
  ///- iOS WKWebView 17.0+ ([Official API - WKWebsiteDataStore.proxyConfigurations](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/4264546-proxyconfigurations))
  ///- macOS WKWebView 14.0+ ([Official API - WKWebsiteDataStore.proxyConfigurations](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/4264546-proxyconfigurations))
  ///- Linux WPE WebKit ([Official API - WebKitNetworkProxySettings](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/struct.NetworkProxySettings.html))
  ///
  ///Use the [AqutterPlatformProxyController.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.linux,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterPlatformProxyController]'s methods that can be used to check if they are supported or not by the current platform.
enum AqutterPlatformProxyControllerMethod {
  ///Can be used to check if the [AqutterPlatformProxyController.clearProxyOverride] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformProxyController.clearProxyOverride.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterProxyController.clearProxyOverride](https://developer.android.com/reference/androidx/webkit/AqutterProxyController#clearProxyOverride(java.util.concurrent.Executor,%20java.lang.Runnable)))
  ///- iOS WKWebView 17.0+ ([Official API - WKWebsiteDataStore.proxyConfigurations](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/4264546-proxyconfigurations))
  ///- macOS WKWebView 14.0+ ([Official API - WKWebsiteDataStore.proxyConfigurations](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/4264546-proxyconfigurations))
  ///- Linux WPE WebKit ([Official API - webkit_network_session_set_proxy_settings](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.NetworkSession.set_proxy_settings.html))
  ///
  ///Use the [AqutterPlatformProxyController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  clearProxyOverride,

  ///Can be used to check if the [AqutterPlatformProxyController.setProxyOverride] method is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPlatformProxyController.setProxyOverride.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterProxyController.setProxyOverride](https://developer.android.com/reference/androidx/webkit/AqutterProxyController#setProxyOverride(androidx.webkit.ProxyConfig,%20java.util.concurrent.Executor,%20java.lang.Runnable)))
  ///- iOS WKWebView 17.0+ ([Official API - WKWebsiteDataStore.proxyConfigurations](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/4264546-proxyconfigurations))
  ///- macOS WKWebView 14.0+ ([Official API - WKWebsiteDataStore.proxyConfigurations](https://developer.apple.com/documentation/webkit/wkwebsitedatastore/4264546-proxyconfigurations))
  ///- Linux WPE WebKit ([Official API - webkit_network_session_set_proxy_settings](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.NetworkSession.set_proxy_settings.html))
  ///
  ///**Parameters - Officially Supported Platforms/Implementations**:
  ///- [settings]: all platforms
  ///
  ///Use the [AqutterPlatformProxyController.isMethodSupported] method to check if this method is supported at runtime.
  ///{@endtemplate}
  setProxyOverride,
}

extension _AqutterPlatformProxyControllerMethodSupported
    on AqutterPlatformProxyController {
  static bool isMethodSupported(
    AqutterPlatformProxyControllerMethod method, {
    TargetPlatform? platform,
  }) {
    switch (method) {
      case AqutterPlatformProxyControllerMethod.clearProxyOverride:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPlatformProxyControllerMethod.setProxyOverride:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}

extension _AqutterProxySettingsClassSupported on AqutterProxySettings {
  ///{@template aqutter_core.AqutterProxySettings.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - ProxyConfig](https://developer.android.com/reference/androidx/webkit/ProxyConfig))
  ///- iOS WKWebView 17.0+ ([Official API - ProxyConfiguration](https://developer.apple.com/documentation/network/proxyconfiguration))
  ///- macOS WKWebView 14.0+ ([Official API - ProxyConfiguration](https://developer.apple.com/documentation/network/proxyconfiguration))
  ///- Linux WPE WebKit ([Official API - WebKitNetworkProxySettings](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/struct.NetworkProxySettings.html))
  ///
  ///Use the [AqutterProxySettings.isClassSupported] method to check if this class is supported at runtime.
  ///{@endtemplate}
  static bool isClassSupported({TargetPlatform? platform}) {
    return ((kIsWeb && platform != null) || !kIsWeb) &&
        [
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.macOS,
          TargetPlatform.linux,
        ].contains(platform ?? defaultTargetPlatform);
  }
}

///List of [AqutterProxySettings]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterProxySettingsProperty {
  ///Can be used to check if the [AqutterProxySettings.bypassRules] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterProxySettings.bypassRules.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- Linux WPE WebKit ([Official API - webkit_network_proxy_settings_new (ignore_hosts)](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/ctor.NetworkProxySettings.new.html)):
  ///    - Mapped to ignore_hosts; bypass rules are passed as host patterns to WebKitNetworkProxySettings.
  ///
  ///Use the [AqutterProxySettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  bypassRules,

  ///Can be used to check if the [AqutterProxySettings.bypassSimpleHostnames] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterProxySettings.bypassSimpleHostnames.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterProxySettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  bypassSimpleHostnames,

  ///Can be used to check if the [AqutterProxySettings.directs] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterProxySettings.directs.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterProxySettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  directs,

  ///Can be used to check if the [AqutterProxySettings.proxyRules] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterProxySettings.proxyRules.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  ///
  ///Use the [AqutterProxySettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  proxyRules,

  ///Can be used to check if the [AqutterProxySettings.removeImplicitRules] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterProxySettings.removeImplicitRules.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterProxySettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  removeImplicitRules,

  ///Can be used to check if the [AqutterProxySettings.reverseBypassEnabled] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterProxySettings.reverseBypassEnabled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterProxySettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  reverseBypassEnabled,
}

extension _AqutterProxySettingsPropertySupported on AqutterProxySettings {
  static bool isPropertySupported(
    AqutterProxySettingsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterProxySettingsProperty.bypassRules:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterProxySettingsProperty.bypassSimpleHostnames:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterProxySettingsProperty.directs:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterProxySettingsProperty.proxyRules:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.linux,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterProxySettingsProperty.removeImplicitRules:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterProxySettingsProperty.reverseBypassEnabled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
    }
  }
}
