import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../webview_platform.dart';
import '../types/main.dart';

part 'platform_web_storage_manager.g.dart';

///{@template aqutter_core.AqutterPlatformWebStorageManagerCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformWebStorageManager].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebStorageManagerCreationParams.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(available: '9.0'),
    LinuxPlatform(),
    MacOSPlatform(),
  ],
)
@immutable
class AqutterPlatformWebStorageManagerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformWebStorageManager].
  const AqutterPlatformWebStorageManagerCreationParams();

  ///{@template aqutter_core.AqutterPlatformWebStorageManagerCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebStorageManagerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );
}

///{@template aqutter_core.AqutterPlatformWebStorageManager}
///Class that implements a singleton object (shared instance) which manages the web storage used by WebView instances.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformWebStorageManager.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(
      apiName: 'AqutterWebStorage',
      apiUrl:
          'https://developer.android.com/reference/android/webkit/AqutterWebStorage.html',
    ),
    IOSPlatform(
      apiName: 'WKWebsiteDataStore',
      apiUrl:
          'https://developer.apple.com/documentation/webkit/wkwebsitedatastore',
      available: '9.0',
    ),
    LinuxPlatform(
      apiName: 'WebKitWebsiteDataManager',
      apiUrl:
          'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.WebsiteDataManager.html',
    ),
    MacOSPlatform(
      apiName: 'WKWebsiteDataStore',
      apiUrl:
          'https://developer.apple.com/documentation/webkit/wkwebsitedatastore',
    ),
  ],
)
abstract class AqutterPlatformWebStorageManager extends PlatformInterface {
  /// Creates a new [AqutterPlatformWebStorageManager]
  factory AqutterPlatformWebStorageManager(
    AqutterPlatformWebStorageManagerCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebStorageManager webStorageManager = AqutterWebViewPlatform
        .instance!
        .createPlatformWebStorageManager(params);
    PlatformInterface.verify(webStorageManager, _token);
    return webStorageManager;
  }

  /// Creates a new [AqutterPlatformWebStorageManager] to access static methods.
  factory AqutterPlatformWebStorageManager.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebStorageManager webStorageManagerStatic =
        AqutterWebViewPlatform.instance!.createPlatformWebStorageManagerStatic();
    PlatformInterface.verify(webStorageManagerStatic, _token);
    return webStorageManagerStatic;
  }

  /// Used by the platform implementation to create a new
  /// [AqutterPlatformWebStorageManager].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformWebStorageManager.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformWebStorageManager].
  final AqutterPlatformWebStorageManagerCreationParams params;

  ///{@template aqutter_core.AqutterPlatformWebStorageManager.getOrigins}
  ///Gets the origins currently using either the Application Cache or Web SQL Database APIs.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.getOrigins.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'AqutterWebStorage.getOrigins',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/AqutterWebStorage#getOrigins(android.webkit.ValueCallback%3Cjava.util.Map%3E)',
      ),
    ],
  )
  Future<List<AqutterWebStorageOrigin>> getOrigins() {
    throw UnimplementedError(
      'getOrigins is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebStorageManager.deleteAllData}
  ///Clears all storage currently being used by the JavaScript storage APIs.
  ///This includes the Application Cache, Web SQL Database and the HTML5 Web AqutterStorage APIs.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.deleteAllData.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'AqutterWebStorage.deleteAllData',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/AqutterWebStorage#deleteAllData()',
      ),
    ],
  )
  Future<void> deleteAllData() {
    throw UnimplementedError(
      'deleteAllData is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebStorageManager.deleteOrigin}
  ///Clears the storage currently being used by both the Application Cache and Web SQL Database APIs by the given [origin].
  ///The origin is specified using its string representation.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.deleteOrigin.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'AqutterWebStorage.deleteOrigin',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/AqutterWebStorage#deleteOrigin(java.lang.String)',
      ),
    ],
  )
  Future<void> deleteOrigin({required String origin}) {
    throw UnimplementedError(
      'deleteOrigin is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebStorageManager.getQuotaForOrigin}
  ///Gets the storage quota for the Web SQL Database API for the given [origin].
  ///The quota is given in bytes and the origin is specified using its string representation.
  ///Note that a quota is not enforced on a per-origin basis for the Application Cache API.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.getQuotaForOrigin.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'AqutterWebStorage.getQuotaForOrigin',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/AqutterWebStorage#getQuotaForOrigin(java.lang.String,%20android.webkit.ValueCallback%3Cjava.lang.Long%3E)',
      ),
    ],
  )
  Future<int> getQuotaForOrigin({required String origin}) {
    throw UnimplementedError(
      'getQuotaForOrigin is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebStorageManager.getUsageForOrigin}
  ///Gets the amount of storage currently being used by both the Application Cache and Web SQL Database APIs by the given [origin].
  ///The amount is given in bytes and the origin is specified using its string representation.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.getUsageForOrigin.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'AqutterWebStorage.getUsageForOrigin',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/AqutterWebStorage#getUsageForOrigin(java.lang.String,%20android.webkit.ValueCallback%3Cjava.lang.Long%3E)',
      ),
    ],
  )
  Future<int> getUsageForOrigin({required String origin}) {
    throw UnimplementedError(
      'getUsageForOrigin is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebStorageManager.fetchDataRecords}
  ///Fetches data records containing the given website data types.
  ///
  ///[dataTypes] represents the website data types to fetch records for.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.fetchDataRecords.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        available: '9.0',
        apiName: 'WKWebsiteDataStore.fetchDataRecords',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532932-fetchdatarecords',
      ),
      LinuxPlatform(
        apiName: 'webkit_website_data_manager_fetch',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebsiteDataManager.fetch.html',
      ),
      MacOSPlatform(
        apiName: 'WKWebsiteDataStore.fetchDataRecords',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532932-fetchdatarecords',
      ),
    ],
  )
  Future<List<AqutterWebsiteDataRecord>> fetchDataRecords({
    required Set<AqutterWebsiteDataType> dataTypes,
  }) {
    throw UnimplementedError(
      'fetchDataRecords is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebStorageManager.removeDataFor}
  ///Removes website data of the given types for the given data records.
  ///
  ///[dataTypes] represents the website data types that should be removed.
  ///
  ///[dataRecords] represents the website data records to delete website data for.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.removeDataFor.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        available: '9.0',
        apiName: 'WKWebsiteDataStore.removeData',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532936-removedata',
      ),
      LinuxPlatform(
        apiName: 'webkit_website_data_manager_remove',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebsiteDataManager.remove.html',
      ),
      MacOSPlatform(
        apiName: 'WKWebsiteDataStore.removeData',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532936-removedata',
      ),
    ],
  )
  Future<void> removeDataFor({
    required Set<AqutterWebsiteDataType> dataTypes,
    required List<AqutterWebsiteDataRecord> dataRecords,
  }) {
    throw UnimplementedError(
      'removeDataFor is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebStorageManager.removeDataModifiedSince}
  ///Removes all website data of the given types that has been modified since the given date.
  ///
  ///[dataTypes] represents the website data types that should be removed.
  ///
  ///[date] represents a date. All website data modified after this date will be removed.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebStorageManager.removeDataModifiedSince.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        available: '9.0',
        apiName: 'WKWebsiteDataStore.removeData',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532938-removedata',
      ),
      LinuxPlatform(
        apiName: 'webkit_website_data_manager_clear',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebsiteDataManager.clear.html',
      ),
      MacOSPlatform(
        apiName: 'WKWebsiteDataStore.removeData',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkwebsitedatastore/1532938-removedata',
      ),
    ],
  )
  Future<void> removeDataModifiedSince({
    required Set<AqutterWebsiteDataType> dataTypes,
    required DateTime date,
  }) {
    throw UnimplementedError(
      'removeDataModifiedSince is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebStorageManager.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebStorageManagerClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformWebStorageManager.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformWebStorageManagerMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformWebStorageManagerMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}
