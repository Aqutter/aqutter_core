import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'webview_platform.dart';

part 'platform_webview_feature.g.dart';

///{@template aqutter_core.AqutterPlatformWebViewFeatureCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformWebViewFeature].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebViewFeatureCreationParams.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
@immutable
class AqutterPlatformWebViewFeatureCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformWebViewFeature].
  const AqutterPlatformWebViewFeatureCreationParams();

  ///{@template aqutter_core.AqutterPlatformWebViewFeatureCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebViewFeatureCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformWebViewFeature}
///Class that represents an Android-specific utility class for checking which WebView Support Library features are supported on the device.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebViewFeature.supported_platforms}
@SupportedPlatforms(platforms: [AndroidPlatform()])
abstract class AqutterPlatformWebViewFeature extends PlatformInterface {
  /// Creates a new [AqutterPlatformWebViewFeature]
  factory AqutterPlatformWebViewFeature(AqutterPlatformWebViewFeatureCreationParams params) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebViewFeature webViewFeature = AqutterWebViewPlatform.instance!
        .createPlatformWebViewFeature(params);
    PlatformInterface.verify(webViewFeature, _token);
    return webViewFeature;
  }

  /// Creates a new empty [AqutterPlatformWebViewFeature] to access static methods.
  factory AqutterPlatformWebViewFeature.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebViewFeature webViewFeatureStatic = AqutterWebViewPlatform
        .instance!
        .createPlatformWebViewFeatureStatic();
    PlatformInterface.verify(webViewFeatureStatic, _token);
    return webViewFeatureStatic;
  }

  /// Used by the platform implementation to create a new
  /// [AqutterPlatformWebViewFeature].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformWebViewFeature.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformWebViewFeature].
  final AqutterPlatformWebViewFeatureCreationParams params;

  ///{@template aqutter_core.AqutterPlatformWebViewFeature.isFeatureSupported}
  ///Return whether a feature is supported at run-time. On devices running Android version `Build.VERSION_CODES.LOLLIPOP` and higher,
  ///this will check whether a feature is supported, depending on the combination of the desired feature, the Android version of device,
  ///and the WebView APK on the device. If running on a device with a lower API level, this will always return `false`.
  ///
  ///**Note**: This method is different from [isStartupFeatureSupported] and this
  ///method only accepts certain features.
  ///Please verify that the correct feature checking method is used for a particular feature.
  ///
  ///**Note**: If this method returns `false`, it is not safe to invoke the methods
  ///requiring the desired feature.
  ///Furthermore, if this method returns `false` for a particular feature, any callback guarded by that feature will not be invoked.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewFeature.isFeatureSupported.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'AqutterWebViewFeature.isFeatureSupported',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/AqutterWebViewFeature#isFeatureSupported(java.lang.String)',
      ),
    ],
  )
  Future<bool> isFeatureSupported(AqutterWebViewFeature feature) {
    throw UnimplementedError(
      'isFeatureSupported is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewFeature.isStartupFeatureSupported}
  ///Return whether a startup feature is supported at run-time.
  ///On devices running Android version `Build.VERSION_CODES.LOLLIPOP` and higher,
  ///this will check whether a startup feature is supported,
  ///depending on the combination of the desired feature,
  ///the Android version of device, and the WebView APK on the device.
  ///If running on a device with a lower API level, this will always return `false`.
  ///
  ///**Note**: This method is different from [isFeatureSupported] and this method only accepts startup features.
  ///Please verify that the correct feature checking method is used for a particular feature.
  ///
  ///**Note**: If this method returns `false`, it is not safe to invoke the methods requiring the desired feature.
  ///Furthermore, if this method returns `false` for a particular feature,
  ///any callback guarded by that feature will not be invoked.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewFeature.isStartupFeatureSupported.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'AqutterWebViewFeature.isStartupFeatureSupported',
        apiUrl:
            'https://developer.android.com/reference/androidx/webkit/AqutterWebViewFeature#isStartupFeatureSupported(android.content.Context,java.lang.String)',
      ),
    ],
  )
  Future<bool> isStartupFeatureSupported(AqutterWebViewFeature startupFeature) {
    throw UnimplementedError(
      'isStartupFeatureSupported is not implemented on the current platform',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewFeatureCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);

  ///{@template aqutter_core.AqutterPlatformWebViewFeature.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformWebViewFeatureMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformWebViewFeatureMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}

///{@macro aqutter_core.AqutterPlatformWebViewFeature}
@ExchangeableEnum()
class AqutterWebViewFeature_ {
  // ignore: unused_field
  final String _value;

  const AqutterWebViewFeature_._internal(this._value);

  @ExchangeableObjectMethod(ignore: true)
  String toNativeValue() => _value;

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewController.createWebMessageChannel].
  static const CREATE_WEB_MESSAGE_CHANNEL = const AqutterWebViewFeature_._internal(
    "CREATE_WEB_MESSAGE_CHANNEL",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewSettings.disabledActionModeMenuItems].
  static const DISABLED_ACTION_MODE_MENU_ITEMS =
      const AqutterWebViewFeature_._internal("DISABLED_ACTION_MODE_MENU_ITEMS");

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewSettings.forceDark].
  static const FORCE_DARK = const AqutterWebViewFeature_._internal("FORCE_DARK");

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewSettings.forceDarkStrategy].
  static const FORCE_DARK_STRATEGY = const AqutterWebViewFeature_._internal(
    "FORCE_DARK_STRATEGY",
  );

  ///
  static const GET_WEB_CHROME_CLIENT = const AqutterWebViewFeature_._internal(
    "GET_WEB_CHROME_CLIENT",
  );

  ///
  static const GET_WEB_VIEW_CLIENT = const AqutterWebViewFeature_._internal(
    "GET_WEB_VIEW_CLIENT",
  );

  ///
  static const GET_WEB_VIEW_RENDERER = const AqutterWebViewFeature_._internal(
    "GET_WEB_VIEW_RENDERER",
  );

  ///
  static const MULTI_PROCESS = const AqutterWebViewFeature_._internal("MULTI_PROCESS");

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewSettings.offscreenPreRaster].
  static const OFF_SCREEN_PRERASTER = const AqutterWebViewFeature_._internal(
    "OFF_SCREEN_PRERASTER",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewController.postWebMessage].
  static const POST_WEB_MESSAGE = const AqutterWebViewFeature_._internal(
    "POST_WEB_MESSAGE",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterProxyController.setProxyOverride] and [AqutterProxyController.clearProxyOverride].
  static const PROXY_OVERRIDE = const AqutterWebViewFeature_._internal(
    "PROXY_OVERRIDE",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterProxySettings.reverseBypassEnabled].
  static const PROXY_OVERRIDE_REVERSE_BYPASS = const AqutterWebViewFeature_._internal(
    "PROXY_OVERRIDE_REVERSE_BYPASS",
  );

  ///
  static const RECEIVE_HTTP_ERROR = const AqutterWebViewFeature_._internal(
    "RECEIVE_HTTP_ERROR",
  );

  ///
  static const RECEIVE_WEB_RESOURCE_ERROR = const AqutterWebViewFeature_._internal(
    "RECEIVE_WEB_RESOURCE_ERROR",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewController.setSafeBrowsingAllowlist].
  static const SAFE_BROWSING_ALLOWLIST = const AqutterWebViewFeature_._internal(
    "SAFE_BROWSING_ALLOWLIST",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewSettings.safeBrowsingEnabled].
  static const SAFE_BROWSING_ENABLE = const AqutterWebViewFeature_._internal(
    "SAFE_BROWSING_ENABLE",
  );

  ///
  static const SAFE_BROWSING_HIT = const AqutterWebViewFeature_._internal(
    "SAFE_BROWSING_HIT",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewController.getSafeBrowsingPrivacyPolicyUrl].
  static const SAFE_BROWSING_PRIVACY_POLICY_URL =
      const AqutterWebViewFeature_._internal("SAFE_BROWSING_PRIVACY_POLICY_URL");

  ///
  static const SAFE_BROWSING_RESPONSE_BACK_TO_SAFETY =
      const AqutterWebViewFeature_._internal("SAFE_BROWSING_RESPONSE_BACK_TO_SAFETY");

  ///
  static const SAFE_BROWSING_RESPONSE_PROCEED = const AqutterWebViewFeature_._internal(
    "SAFE_BROWSING_RESPONSE_PROCEED",
  );

  ///
  static const SAFE_BROWSING_RESPONSE_SHOW_INTERSTITIAL =
      const AqutterWebViewFeature_._internal(
        "SAFE_BROWSING_RESPONSE_SHOW_INTERSTITIAL",
      );

  ///Use [SAFE_BROWSING_ALLOWLIST] instead.
  @Deprecated('Use SAFE_BROWSING_ALLOWLIST instead')
  static const SAFE_BROWSING_WHITELIST = const AqutterWebViewFeature_._internal(
    "SAFE_BROWSING_WHITELIST",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterServiceWorkerController].
  static const SERVICE_WORKER_BASIC_USAGE = const AqutterWebViewFeature_._internal(
    "SERVICE_WORKER_BASIC_USAGE",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterServiceWorkerController.setBlockNetworkLoads] and [AqutterServiceWorkerController.getBlockNetworkLoads].
  static const SERVICE_WORKER_BLOCK_NETWORK_LOADS =
      const AqutterWebViewFeature_._internal("SERVICE_WORKER_BLOCK_NETWORK_LOADS");

  ///Feature for [isFeatureSupported]. This feature covers [AqutterServiceWorkerController.setCacheMode] and [AqutterServiceWorkerController.getCacheMode].
  static const SERVICE_WORKER_CACHE_MODE = const AqutterWebViewFeature_._internal(
    "SERVICE_WORKER_CACHE_MODE",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterServiceWorkerController.setAllowContentAccess] and [AqutterServiceWorkerController.getAllowContentAccess].
  static const SERVICE_WORKER_CONTENT_ACCESS = const AqutterWebViewFeature_._internal(
    "SERVICE_WORKER_CONTENT_ACCESS",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterServiceWorkerController.setAllowFileAccess] and [AqutterServiceWorkerController.getAllowFileAccess].
  static const SERVICE_WORKER_FILE_ACCESS = const AqutterWebViewFeature_._internal(
    "SERVICE_WORKER_FILE_ACCESS",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterServiceWorkerClient.shouldInterceptRequest].
  static const SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST =
      const AqutterWebViewFeature_._internal(
        "SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST",
      );

  ///
  static const SHOULD_OVERRIDE_WITH_REDIRECTS = const AqutterWebViewFeature_._internal(
    "SHOULD_OVERRIDE_WITH_REDIRECTS",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewController.startSafeBrowsing].
  static const START_SAFE_BROWSING = const AqutterWebViewFeature_._internal(
    "START_SAFE_BROWSING",
  );

  ///
  static const TRACING_CONTROLLER_BASIC_USAGE = const AqutterWebViewFeature_._internal(
    "TRACING_CONTROLLER_BASIC_USAGE",
  );

  ///
  static const VISUAL_STATE_CALLBACK = const AqutterWebViewFeature_._internal(
    "VISUAL_STATE_CALLBACK",
  );

  ///
  static const WEB_MESSAGE_CALLBACK_ON_MESSAGE =
      const AqutterWebViewFeature_._internal("WEB_MESSAGE_CALLBACK_ON_MESSAGE");

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebMessageListener].
  static const WEB_MESSAGE_LISTENER = const AqutterWebViewFeature_._internal(
    "WEB_MESSAGE_LISTENER",
  );

  ///
  static const WEB_MESSAGE_PORT_CLOSE = const AqutterWebViewFeature_._internal(
    "WEB_MESSAGE_PORT_CLOSE",
  );

  ///
  static const WEB_MESSAGE_PORT_POST_MESSAGE = const AqutterWebViewFeature_._internal(
    "WEB_MESSAGE_PORT_POST_MESSAGE",
  );

  ///
  static const WEB_MESSAGE_PORT_SET_MESSAGE_CALLBACK =
      const AqutterWebViewFeature_._internal("WEB_MESSAGE_PORT_SET_MESSAGE_CALLBACK");

  ///
  static const WEB_RESOURCE_ERROR_GET_CODE = const AqutterWebViewFeature_._internal(
    "WEB_RESOURCE_ERROR_GET_CODE",
  );

  ///
  static const WEB_RESOURCE_ERROR_GET_DESCRIPTION =
      const AqutterWebViewFeature_._internal("WEB_RESOURCE_ERROR_GET_DESCRIPTION");

  ///
  static const WEB_RESOURCE_REQUEST_IS_REDIRECT =
      const AqutterWebViewFeature_._internal("WEB_RESOURCE_REQUEST_IS_REDIRECT");

  ///
  static const WEB_VIEW_RENDERER_CLIENT_BASIC_USAGE =
      const AqutterWebViewFeature_._internal("WEB_VIEW_RENDERER_CLIENT_BASIC_USAGE");

  ///
  static const WEB_VIEW_RENDERER_TERMINATE = const AqutterWebViewFeature_._internal(
    "WEB_VIEW_RENDERER_TERMINATE",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterUserScriptInjectionTime.AT_DOCUMENT_START].
  static const DOCUMENT_START_SCRIPT = const AqutterWebViewFeature_._internal(
    "DOCUMENT_START_SCRIPT",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewSettings.algorithmicDarkeningAllowed].
  static const ALGORITHMIC_DARKENING = const AqutterWebViewFeature_._internal(
    "ALGORITHMIC_DARKENING",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewSettings.enterpriseAuthenticationAppLinkPolicyEnabled].
  static const ENTERPRISE_AUTHENTICATION_APP_LINK_POLICY =
      const AqutterWebViewFeature_._internal(
        "ENTERPRISE_AUTHENTICATION_APP_LINK_POLICY",
      );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewController.getVariationsHeader].
  static const GET_VARIATIONS_HEADER = const AqutterWebViewFeature_._internal(
    "GET_VARIATIONS_HEADER",
  );

  ///Feature for [isFeatureSupported]. This feature covers cookie attributes of [AqutterCookieManager.getCookie] and [AqutterCookieManager.getCookies] methods.
  static const GET_COOKIE_INFO = const AqutterWebViewFeature_._internal(
    "GET_COOKIE_INFO",
  );

  ///Feature for [isFeatureSupported]. This feature covers cookie attributes of [AqutterCookieManager.getCookie] and [AqutterCookieManager.getCookies] methods.
  static const REQUESTED_WITH_HEADER_ALLOW_LIST =
      const AqutterWebViewFeature_._internal("REQUESTED_WITH_HEADER_ALLOW_LIST");

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebMessagePort.postMessage] with `ArrayBuffer` type,
  ///[AqutterWebViewController.postWebMessage] with `ArrayBuffer` type, and [AqutterJavaScriptReplyProxy.postMessage] with `ArrayBuffer` type.
  static const WEB_MESSAGE_ARRAY_BUFFER = const AqutterWebViewFeature_._internal(
    "WEB_MESSAGE_ARRAY_BUFFER",
  );

  ///Feature for [isStartupFeatureSupported]. This feature covers [AqutterProcessGlobalConfigSettings.dataDirectorySuffix].
  static const STARTUP_FEATURE_SET_DATA_DIRECTORY_SUFFIX =
      const AqutterWebViewFeature_._internal(
        "STARTUP_FEATURE_SET_DATA_DIRECTORY_SUFFIX",
      );

  ///Feature for [isStartupFeatureSupported]. This feature covers [AqutterProcessGlobalConfigSettings.directoryBasePaths].
  static const STARTUP_FEATURE_SET_DIRECTORY_BASE_PATHS =
      const AqutterWebViewFeature_._internal(
        "STARTUP_FEATURE_SET_DIRECTORY_BASE_PATHS",
      );

  ///{@macro aqutter_core.AqutterPlatformWebViewFeature.isFeatureSupported}
  static Future<bool> isFeatureSupported(AqutterWebViewFeature feature) =>
      AqutterPlatformWebViewFeature.static().isFeatureSupported(feature);

  ///{@macro aqutter_core.AqutterPlatformWebViewFeature.isStartupFeatureSupported}
  static Future<bool> isStartupFeatureSupported(
    AqutterWebViewFeature startupFeature,
  ) =>
      AqutterPlatformWebViewFeature.static().isStartupFeatureSupported(startupFeature);
}

///Class that represents an Android-specific utility class for checking which WebView Support Library features are supported on the device.
///Use [AqutterWebViewFeature] instead.
@Deprecated("Use AqutterWebViewFeature instead")
@ExchangeableEnum()
class AqutterAndroidWebViewFeature_ {
  // ignore: unused_field
  final String _value;

  const AqutterAndroidWebViewFeature_._internal(this._value);

  @ExchangeableObjectMethod(ignore: true)
  String toNativeValue() => _value;

  ///
  static const CREATE_WEB_MESSAGE_CHANNEL =
      const AqutterAndroidWebViewFeature_._internal("CREATE_WEB_MESSAGE_CHANNEL");

  ///
  static const DISABLED_ACTION_MODE_MENU_ITEMS =
      const AqutterAndroidWebViewFeature_._internal("DISABLED_ACTION_MODE_MENU_ITEMS");

  ///
  static const FORCE_DARK = const AqutterAndroidWebViewFeature_._internal(
    "FORCE_DARK",
  );

  ///
  static const FORCE_DARK_STRATEGY = const AqutterAndroidWebViewFeature_._internal(
    "FORCE_DARK_STRATEGY",
  );

  ///
  static const GET_WEB_CHROME_CLIENT = const AqutterAndroidWebViewFeature_._internal(
    "GET_WEB_CHROME_CLIENT",
  );

  ///
  static const GET_WEB_VIEW_CLIENT = const AqutterAndroidWebViewFeature_._internal(
    "GET_WEB_VIEW_CLIENT",
  );

  ///
  static const GET_WEB_VIEW_RENDERER = const AqutterAndroidWebViewFeature_._internal(
    "GET_WEB_VIEW_RENDERER",
  );

  ///
  static const MULTI_PROCESS = const AqutterAndroidWebViewFeature_._internal(
    "MULTI_PROCESS",
  );

  ///
  static const OFF_SCREEN_PRERASTER = const AqutterAndroidWebViewFeature_._internal(
    "OFF_SCREEN_PRERASTER",
  );

  ///
  static const POST_WEB_MESSAGE = const AqutterAndroidWebViewFeature_._internal(
    "POST_WEB_MESSAGE",
  );

  ///
  static const PROXY_OVERRIDE = const AqutterAndroidWebViewFeature_._internal(
    "PROXY_OVERRIDE",
  );

  ///
  static const RECEIVE_HTTP_ERROR = const AqutterAndroidWebViewFeature_._internal(
    "RECEIVE_HTTP_ERROR",
  );

  ///
  static const RECEIVE_WEB_RESOURCE_ERROR =
      const AqutterAndroidWebViewFeature_._internal("RECEIVE_WEB_RESOURCE_ERROR");

  ///
  static const SAFE_BROWSING_ALLOWLIST = const AqutterAndroidWebViewFeature_._internal(
    "SAFE_BROWSING_ALLOWLIST",
  );

  ///
  static const SAFE_BROWSING_ENABLE = const AqutterAndroidWebViewFeature_._internal(
    "SAFE_BROWSING_ENABLE",
  );

  ///
  static const SAFE_BROWSING_HIT = const AqutterAndroidWebViewFeature_._internal(
    "SAFE_BROWSING_HIT",
  );

  ///
  static const SAFE_BROWSING_PRIVACY_POLICY_URL =
      const AqutterAndroidWebViewFeature_._internal(
        "SAFE_BROWSING_PRIVACY_POLICY_URL",
      );

  ///
  static const SAFE_BROWSING_RESPONSE_BACK_TO_SAFETY =
      const AqutterAndroidWebViewFeature_._internal(
        "SAFE_BROWSING_RESPONSE_BACK_TO_SAFETY",
      );

  ///
  static const SAFE_BROWSING_RESPONSE_PROCEED =
      const AqutterAndroidWebViewFeature_._internal("SAFE_BROWSING_RESPONSE_PROCEED");

  ///
  static const SAFE_BROWSING_RESPONSE_SHOW_INTERSTITIAL =
      const AqutterAndroidWebViewFeature_._internal(
        "SAFE_BROWSING_RESPONSE_SHOW_INTERSTITIAL",
      );

  ///Use [SAFE_BROWSING_ALLOWLIST] instead.
  @Deprecated('Use SAFE_BROWSING_ALLOWLIST instead')
  static const SAFE_BROWSING_WHITELIST = const AqutterAndroidWebViewFeature_._internal(
    "SAFE_BROWSING_WHITELIST",
  );

  ///
  static const SERVICE_WORKER_BASIC_USAGE =
      const AqutterAndroidWebViewFeature_._internal("SERVICE_WORKER_BASIC_USAGE");

  ///
  static const SERVICE_WORKER_BLOCK_NETWORK_LOADS =
      const AqutterAndroidWebViewFeature_._internal(
        "SERVICE_WORKER_BLOCK_NETWORK_LOADS",
      );

  ///
  static const SERVICE_WORKER_CACHE_MODE =
      const AqutterAndroidWebViewFeature_._internal("SERVICE_WORKER_CACHE_MODE");

  ///
  static const SERVICE_WORKER_CONTENT_ACCESS =
      const AqutterAndroidWebViewFeature_._internal("SERVICE_WORKER_CONTENT_ACCESS");

  ///
  static const SERVICE_WORKER_FILE_ACCESS =
      const AqutterAndroidWebViewFeature_._internal("SERVICE_WORKER_FILE_ACCESS");

  ///
  static const SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST =
      const AqutterAndroidWebViewFeature_._internal(
        "SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST",
      );

  ///
  static const SHOULD_OVERRIDE_WITH_REDIRECTS =
      const AqutterAndroidWebViewFeature_._internal("SHOULD_OVERRIDE_WITH_REDIRECTS");

  ///
  static const START_SAFE_BROWSING = const AqutterAndroidWebViewFeature_._internal(
    "START_SAFE_BROWSING",
  );

  ///
  static const TRACING_CONTROLLER_BASIC_USAGE =
      const AqutterAndroidWebViewFeature_._internal("TRACING_CONTROLLER_BASIC_USAGE");

  ///
  static const VISUAL_STATE_CALLBACK = const AqutterAndroidWebViewFeature_._internal(
    "VISUAL_STATE_CALLBACK",
  );

  ///
  static const WEB_MESSAGE_CALLBACK_ON_MESSAGE =
      const AqutterAndroidWebViewFeature_._internal("WEB_MESSAGE_CALLBACK_ON_MESSAGE");

  ///
  static const WEB_MESSAGE_LISTENER = const AqutterAndroidWebViewFeature_._internal(
    "WEB_MESSAGE_LISTENER",
  );

  ///
  static const WEB_MESSAGE_PORT_CLOSE = const AqutterAndroidWebViewFeature_._internal(
    "WEB_MESSAGE_PORT_CLOSE",
  );

  ///
  static const WEB_MESSAGE_PORT_POST_MESSAGE =
      const AqutterAndroidWebViewFeature_._internal("WEB_MESSAGE_PORT_POST_MESSAGE");

  ///
  static const WEB_MESSAGE_PORT_SET_MESSAGE_CALLBACK =
      const AqutterAndroidWebViewFeature_._internal(
        "WEB_MESSAGE_PORT_SET_MESSAGE_CALLBACK",
      );

  ///
  static const WEB_RESOURCE_ERROR_GET_CODE =
      const AqutterAndroidWebViewFeature_._internal("WEB_RESOURCE_ERROR_GET_CODE");

  ///
  static const WEB_RESOURCE_ERROR_GET_DESCRIPTION =
      const AqutterAndroidWebViewFeature_._internal(
        "WEB_RESOURCE_ERROR_GET_DESCRIPTION",
      );

  ///
  static const WEB_RESOURCE_REQUEST_IS_REDIRECT =
      const AqutterAndroidWebViewFeature_._internal(
        "WEB_RESOURCE_REQUEST_IS_REDIRECT",
      );

  ///
  static const WEB_VIEW_RENDERER_CLIENT_BASIC_USAGE =
      const AqutterAndroidWebViewFeature_._internal(
        "WEB_VIEW_RENDERER_CLIENT_BASIC_USAGE",
      );

  ///
  static const WEB_VIEW_RENDERER_TERMINATE =
      const AqutterAndroidWebViewFeature_._internal("WEB_VIEW_RENDERER_TERMINATE");

  ///Feature for [isFeatureSupported]. This feature covers [AqutterUserScriptInjectionTime.AT_DOCUMENT_START].
  static const DOCUMENT_START_SCRIPT = const AqutterAndroidWebViewFeature_._internal(
    "DOCUMENT_START_SCRIPT",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewSettings.willSuppressErrorPage].
  static const SUPPRESS_ERROR_PAGE = const AqutterAndroidWebViewFeature_._internal(
    "SUPPRESS_ERROR_PAGE",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewSettings.algorithmicDarkeningAllowed].
  static const ALGORITHMIC_DARKENING = const AqutterAndroidWebViewFeature_._internal(
    "ALGORITHMIC_DARKENING",
  );

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewSettings.requestedWithHeaderMode].
  static const REQUESTED_WITH_HEADER_CONTROL =
      const AqutterAndroidWebViewFeature_._internal("REQUESTED_WITH_HEADER_CONTROL");

  ///Feature for [isFeatureSupported]. This feature covers [AqutterWebViewSettings.enterpriseAuthenticationAppLinkPolicyEnabled].
  static const ENTERPRISE_AUTHENTICATION_APP_LINK_POLICY =
      const AqutterAndroidWebViewFeature_._internal(
        "ENTERPRISE_AUTHENTICATION_APP_LINK_POLICY",
      );

  ///Return whether a feature is supported at run-time. On devices running Android version `Build.VERSION_CODES.LOLLIPOP` and higher,
  ///this will check whether a feature is supported, depending on the combination of the desired feature, the Android version of device,
  ///and the WebView APK on the device. If running on a device with a lower API level, this will always return `false`.
  ///
  ///**Official Android API**: https://developer.android.com/reference/androidx/webkit/AqutterWebViewFeature#isFeatureSupported(java.lang.String)
  static Future<bool> isFeatureSupported(AqutterAndroidWebViewFeature feature) =>
      AqutterPlatformWebViewFeature.static().isFeatureSupported(
        AqutterWebViewFeature.fromNativeValue(feature.toNativeValue())!,
      );
}
