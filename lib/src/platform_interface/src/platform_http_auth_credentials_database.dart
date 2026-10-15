import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'webview_platform.dart';
import 'types/main.dart';

part 'platform_http_auth_credentials_database.g.dart';

///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabaseCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformHttpAuthCredentialDatabase].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabaseCreationParams.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    LinuxPlatform(),
  ],
)
@immutable
class AqutterPlatformHttpAuthCredentialDatabaseCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformHttpAuthCredentialDatabase].
  const AqutterPlatformHttpAuthCredentialDatabaseCreationParams();

  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabaseCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformHttpAuthCredentialDatabaseCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase}
///Class that implements a singleton object (shared instance) which manages the shared HTTP auth credentials cache.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(
      note:
          'It has a custom implementation using `android.database.sqlite.SQLiteDatabase` because [WebViewDatabase](https://developer.android.com/reference/android/webkit/WebViewDatabase) doesn\'t offer the same functionalities as iOS/macOS `URLCredentialStorage`.',
    ),
    IOSPlatform(
      note:
          'It is implemented using the [URLCredentialStorage](https://developer.apple.com/documentation/foundation/urlcredentialstorage) class.',
    ),
    MacOSPlatform(
      note:
          'It is implemented using the [URLCredentialStorage](https://developer.apple.com/documentation/foundation/urlcredentialstorage) class.',
    ),
    LinuxPlatform(
      note:
          'Implemented using libsecret for secure credential storage in the system keyring (gnome-keyring, KDE Wallet, etc.).',
    ),
  ],
)
abstract class AqutterPlatformHttpAuthCredentialDatabase extends PlatformInterface {
  /// Creates a new [AqutterPlatformHttpAuthCredentialDatabase]
  factory AqutterPlatformHttpAuthCredentialDatabase(
    AqutterPlatformHttpAuthCredentialDatabaseCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformHttpAuthCredentialDatabase cookieManager =
        AqutterWebViewPlatform.instance!.createPlatformHttpAuthCredentialDatabase(
          params,
        );
    PlatformInterface.verify(cookieManager, _token);
    return cookieManager;
  }

  /// Creates a new [AqutterPlatformHttpAuthCredentialDatabase] to access static methods.
  factory AqutterPlatformHttpAuthCredentialDatabase.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformHttpAuthCredentialDatabase httpAuthCredentialDatabaseStatic =
        AqutterWebViewPlatform.instance!
            .createPlatformHttpAuthCredentialDatabaseStatic();
    PlatformInterface.verify(httpAuthCredentialDatabaseStatic, _token);
    return httpAuthCredentialDatabaseStatic;
  }

  /// Used by the platform implementation to create a new
  /// [AqutterPlatformHttpAuthCredentialDatabase].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformHttpAuthCredentialDatabase.implementation(this.params)
    : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformHttpAuthCredentialDatabase].
  final AqutterPlatformHttpAuthCredentialDatabaseCreationParams params;

  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.getAllAuthCredentials}
  ///Gets a map list of all HTTP auth credentials saved.
  ///Each map contains the key `protectionSpace` of type [AqutterURLProtectionSpace]
  ///and the key `credentials` of type List<[AqutterURLCredential]> that contains all the HTTP auth credentials saved for that `protectionSpace`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.getAllAuthCredentials.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(
        apiName: 'URLCredentialStorage.allCredentials',
        apiUrl:
            'https://developer.apple.com/documentation/foundation/urlcredentialstorage/1413859-allcredentials',
      ),
      MacOSPlatform(
        apiName: 'URLCredentialStorage.allCredentials',
        apiUrl:
            'https://developer.apple.com/documentation/foundation/urlcredentialstorage/1413859-allcredentials',
      ),
      LinuxPlatform(note: 'Implemented using libsecret for secure storage.'),
    ],
  )
  Future<List<AqutterURLProtectionSpaceHttpAuthCredentials>> getAllAuthCredentials() {
    throw UnimplementedError(
      'getAllAuthCredentials is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.getHttpAuthCredentials}
  ///Gets all the HTTP auth credentials saved for that [protectionSpace].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.getHttpAuthCredentials.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<List<AqutterURLCredential>> getHttpAuthCredentials({
    required AqutterURLProtectionSpace protectionSpace,
  }) {
    throw UnimplementedError(
      'getHttpAuthCredentials is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.setHttpAuthCredential}
  ///Saves an HTTP auth [credential] for that [protectionSpace].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.setHttpAuthCredential.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(
        apiName: 'URLCredentialStorage.set',
        apiUrl:
            'https://developer.apple.com/documentation/foundation/urlcredentialstorage/1407227-set',
      ),
      MacOSPlatform(
        apiName: 'URLCredentialStorage.set',
        apiUrl:
            'https://developer.apple.com/documentation/foundation/urlcredentialstorage/1407227-set',
      ),
      LinuxPlatform(note: 'Implemented using libsecret for secure storage.'),
    ],
  )
  Future<void> setHttpAuthCredential({
    required AqutterURLProtectionSpace protectionSpace,
    required AqutterURLCredential credential,
  }) {
    throw UnimplementedError(
      'setHttpAuthCredential is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.removeHttpAuthCredential}
  ///Removes an HTTP auth [credential] for that [protectionSpace].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.removeHttpAuthCredential.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(
        apiName: 'URLCredentialStorage.remove',
        apiUrl:
            'https://developer.apple.com/documentation/foundation/urlcredentialstorage/1408664-remove',
      ),
      MacOSPlatform(
        apiName: 'URLCredentialStorage.remove',
        apiUrl:
            'https://developer.apple.com/documentation/foundation/urlcredentialstorage/1408664-remove',
      ),
      LinuxPlatform(note: 'Implemented using libsecret for secure storage.'),
    ],
  )
  Future<void> removeHttpAuthCredential({
    required AqutterURLProtectionSpace protectionSpace,
    required AqutterURLCredential credential,
  }) {
    throw UnimplementedError(
      'removeHttpAuthCredential is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.removeHttpAuthCredentials}
  ///Removes all the HTTP auth credentials saved for that [protectionSpace].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.removeHttpAuthCredentials.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> removeHttpAuthCredentials({
    required AqutterURLProtectionSpace protectionSpace,
  }) {
    throw UnimplementedError(
      'removeHttpAuthCredentials is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.clearAllAuthCredentials}
  ///Removes all the HTTP auth credentials saved in the database.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.clearAllAuthCredentials.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> clearAllAuthCredentials() {
    throw UnimplementedError(
      'clearAllAuthCredentials is not implemented on the current platform',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformHttpAuthCredentialDatabaseCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);

  ///{@template aqutter_core.AqutterPlatformHttpAuthCredentialDatabase.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformHttpAuthCredentialDatabaseMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformHttpAuthCredentialDatabaseMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}
