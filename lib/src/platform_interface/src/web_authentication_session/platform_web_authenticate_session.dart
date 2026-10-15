import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import '../debug_logging_settings.dart';
import '../webview_platform.dart';
import '../types/main.dart';
import '../web_uri.dart';
import 'web_authenticate_session_settings.dart';

// ignore: uri_has_not_been_generated
part 'platform_web_authenticate_session.g.dart';

///A completion handler for the [AqutterPlatformWebAuthenticationSession].
typedef AqutterWebAuthenticationSessionCompletionHandler =
    Future<void> Function(AqutterWebUri? url, AqutterWebAuthenticationSessionError? error)?;

///{@template aqutter_core.AqutterPlatformWebAuthenticationSessionCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformWebAuthenticationSession].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebAuthenticationSessionCreationParams.supported_platforms}
@SupportedPlatforms(
  platforms: [
    IOSPlatform(available: '11.0'),
    MacOSPlatform(available: '10.15'),
  ],
)
@immutable
class AqutterPlatformWebAuthenticationSessionCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformWebAuthenticationSession].
  const AqutterPlatformWebAuthenticationSessionCreationParams();

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSessionCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebAuthenticationSessionCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformWebAuthenticationSession}
///A session that an app uses to authenticate a user through a web service.
///
///It is implemented using [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession) on iOS 12.0+ and MacOS 10.15+
///and [SFAuthenticationSession](https://developer.apple.com/documentation/safariservices/sfauthenticationsession) on iOS 11.0.
///
///Use an [AqutterPlatformWebAuthenticationSession] instance to authenticate a user through a web service, including one run by a third party.
///Initialize the session with a URL that points to the authentication webpage.
///A browser loads and displays the page, from which the user can authenticate.
///In iOS, the browser is a secure, embedded web view.
///In macOS, the system opens the user's default browser if it supports web authentication sessions, or Safari otherwise.
///
///On completion, the service sends a callback URL to the session with an authentication token, and the session passes this URL back to the app through a completion handler.
///[AqutterPlatformWebAuthenticationSession] ensures that only the calling app's session receives the authentication callback, even when more than one app registers the same callback URL scheme.
///
///**NOTE**: Remember to dispose it when you don't need it anymore.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.supported_platforms}
@SupportedPlatforms(
  platforms: [
    IOSPlatform(available: '11.0'),
    MacOSPlatform(available: '10.15'),
  ],
)
abstract class AqutterPlatformWebAuthenticationSession extends PlatformInterface
    implements AqutterDisposable {
  ///Debug settings.
  static AqutterDebugLoggingSettings debugLoggingSettings = AqutterDebugLoggingSettings();

  /// Creates a new [AqutterPlatformWebAuthenticationSession]
  factory AqutterPlatformWebAuthenticationSession(
    AqutterPlatformWebAuthenticationSessionCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebAuthenticationSession webAuthenticationSession =
        AqutterWebViewPlatform.instance!.createPlatformWebAuthenticationSession(
          params,
        );
    PlatformInterface.verify(webAuthenticationSession, _token);
    return webAuthenticationSession;
  }

  /// Creates a new [AqutterPlatformWebAuthenticationSession] to access static methods.
  factory AqutterPlatformWebAuthenticationSession.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebAuthenticationSession webAuthenticationSessionStatic =
        AqutterWebViewPlatform.instance!
            .createPlatformWebAuthenticationSessionStatic();
    PlatformInterface.verify(webAuthenticationSessionStatic, _token);
    return webAuthenticationSessionStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformWebAuthenticationSession].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformWebAuthenticationSession.implementation(this.params)
    : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformWebAuthenticationSession].
  final AqutterPlatformWebAuthenticationSessionCreationParams params;

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.id}
  ///ID used internally.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.id.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform(), MacOSPlatform()])
  String get id =>
      throw UnimplementedError('id is not implemented on the current platform');

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.url}
  ///A URL with the `http` or `https` scheme pointing to the authentication webpage.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.url.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform(), MacOSPlatform()])
  AqutterWebUri get url => throw UnimplementedError(
    'url is not implemented on the current platform',
  );

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.callbackURLScheme}
  ///The custom URL scheme that the app expects in the callback URL.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.callbackURLScheme.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform(), MacOSPlatform()])
  String? get callbackURLScheme => throw UnimplementedError(
    'callbackURLScheme is not implemented on the current platform',
  );

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.initialSettings}
  ///Initial settings.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.initialSettings.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform(), MacOSPlatform()])
  AqutterWebAuthenticationSessionSettings? get initialSettings =>
      throw UnimplementedError(
        'initialSettings is not implemented on the current platform',
      );

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.onComplete}
  ///A completion handler the session calls when it completes successfully, or when the user cancels the session.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.onComplete.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform(), MacOSPlatform()])
  AqutterWebAuthenticationSessionCompletionHandler get onComplete =>
      throw UnimplementedError(
        'onComplete is not implemented on the current platform',
      );

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.create}
  ///Used to create and initialize a session.
  ///
  ///[url] represents a URL with the `http` or `https` scheme pointing to the authentication webpage.
  ///
  ///[callbackURLScheme] represents the custom URL scheme that the app expects in the callback URL.
  ///
  ///[onComplete] represents a completion handler the session calls when it completes successfully, or when the user cancels the session.
  ///
  ///[initialSettings] represents initial settings.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.create.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform(), MacOSPlatform()])
  Future<AqutterPlatformWebAuthenticationSession> create({
    required AqutterWebUri url,
    String? callbackURLScheme,
    AqutterWebAuthenticationSessionCompletionHandler onComplete,
    AqutterWebAuthenticationSessionSettings? initialSettings,
  }) {
    throw UnimplementedError(
      'create is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.canStart}
  ///Indicates whether the session can begin.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.canStart.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'ASWebAuthenticationSession.canStart',
        apiUrl:
            'https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/3516277-canstart',
      ),
      MacOSPlatform(
        apiName: 'ASWebAuthenticationSession.canStart',
        apiUrl:
            'https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/3516277-canstart',
      ),
    ],
  )
  Future<bool> canStart() {
    throw UnimplementedError(
      'canStart is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.start}
  ///Starts the web authentication session.
  ///
  ///Returns a boolean value indicating whether the web authentication session started successfully.
  ///
  ///Only call this method once for a given [AqutterPlatformWebAuthenticationSession] instance after initialization.
  ///Calling the [start] method on a canceled session results in a failure.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.start.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'ASWebAuthenticationSession.start',
        apiUrl:
            'https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/2990953-start',
      ),
      MacOSPlatform(
        apiName: 'ASWebAuthenticationSession.start',
        apiUrl:
            'https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/2990953-start',
      ),
    ],
  )
  Future<bool> start() {
    throw UnimplementedError(
      'start is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.cancel}
  ///Cancels the web authentication session.
  ///
  ///If the session has already presented a view with the authentication webpage, calling this method dismisses that view.
  ///Calling [cancel] on an already canceled session has no effect.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.cancel.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'ASWebAuthenticationSession.cancel',
        apiUrl:
            'https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/2990951-cancel',
      ),
      MacOSPlatform(
        apiName: 'ASWebAuthenticationSession.cancel',
        apiUrl:
            'https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/2990951-cancel',
      ),
    ],
  )
  Future<void> cancel() {
    throw UnimplementedError(
      'cancel is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.dispose}
  ///Disposes the web authentication session.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.dispose.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform(), MacOSPlatform()])
  @override
  Future<void> dispose() {
    throw UnimplementedError(
      'dispose is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.isAvailable}
  ///Returns `true` if [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession)
  ///or [SFAuthenticationSession](https://developer.apple.com/documentation/safariservices/sfauthenticationsession) is available.
  ///Otherwise returns `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSession.isAvailable.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform(), MacOSPlatform()])
  Future<bool> isAvailable() {
    throw UnimplementedError(
      'isAvailable is not implemented on the current platform',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformWebAuthenticationSessionCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebAuthenticationSessionClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformWebAuthenticationSessionProperty property, {
    TargetPlatform? platform,
  }) => _AqutterPlatformWebAuthenticationSessionPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );

  ///{@template aqutter_core.AqutterPlatformWebAuthenticationSession.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformWebAuthenticationSessionMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformWebAuthenticationSessionMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}
