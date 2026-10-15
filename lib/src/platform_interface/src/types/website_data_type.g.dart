// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'website_data_type.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents a website data type.
class AqutterWebsiteDataType {
  final String _value;
  final String? _nativeValue;
  const AqutterWebsiteDataType._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterWebsiteDataType._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterWebsiteDataType._internal(value, nativeValue());

  ///Returns a set of all available website data types.
  static final ALL = [
    AqutterWebsiteDataType.WKWebsiteDataTypeFetchCache,
    AqutterWebsiteDataType.WKWebsiteDataTypeDiskCache,
    AqutterWebsiteDataType.WKWebsiteDataTypeMemoryCache,
    AqutterWebsiteDataType.WKWebsiteDataTypeOfflineWebApplicationCache,
    AqutterWebsiteDataType.WKWebsiteDataTypeCookies,
    AqutterWebsiteDataType.WKWebsiteDataTypeSessionStorage,
    AqutterWebsiteDataType.WKWebsiteDataTypeLocalStorage,
    AqutterWebsiteDataType.WKWebsiteDataTypeWebSQLDatabases,
    AqutterWebsiteDataType.WKWebsiteDataTypeIndexedDBDatabases,
    AqutterWebsiteDataType.WKWebsiteDataTypeServiceWorkerRegistrations,
  ].toSet();

  ///Cookies.
  static const WKWebsiteDataTypeCookies = AqutterWebsiteDataType._internal(
    'WKWebsiteDataTypeCookies',
    'WKWebsiteDataTypeCookies',
  );

  ///On-disk caches.
  static const WKWebsiteDataTypeDiskCache = AqutterWebsiteDataType._internal(
    'WKWebsiteDataTypeDiskCache',
    'WKWebsiteDataTypeDiskCache',
  );

  ///On-disk Fetch caches.
  ///
  ///**NOTE**: available on iOS 11.3+.
  static const WKWebsiteDataTypeFetchCache = AqutterWebsiteDataType._internal(
    'WKWebsiteDataTypeFetchCache',
    'WKWebsiteDataTypeFetchCache',
  );

  ///IndexedDB databases.
  static const WKWebsiteDataTypeIndexedDBDatabases =
      AqutterWebsiteDataType._internal(
        'WKWebsiteDataTypeIndexedDBDatabases',
        'WKWebsiteDataTypeIndexedDBDatabases',
      );

  ///HTML local storage.
  static const WKWebsiteDataTypeLocalStorage = AqutterWebsiteDataType._internal(
    'WKWebsiteDataTypeLocalStorage',
    'WKWebsiteDataTypeLocalStorage',
  );

  ///In-memory caches.
  static const WKWebsiteDataTypeMemoryCache = AqutterWebsiteDataType._internal(
    'WKWebsiteDataTypeMemoryCache',
    'WKWebsiteDataTypeMemoryCache',
  );

  ///HTML offline web application caches.
  static const WKWebsiteDataTypeOfflineWebApplicationCache =
      AqutterWebsiteDataType._internal(
        'WKWebsiteDataTypeOfflineWebApplicationCache',
        'WKWebsiteDataTypeOfflineWebApplicationCache',
      );

  ///Service worker registrations.
  ///
  ///**NOTE**: available on iOS 11.3+.
  static const WKWebsiteDataTypeServiceWorkerRegistrations =
      AqutterWebsiteDataType._internal(
        'WKWebsiteDataTypeServiceWorkerRegistrations',
        'WKWebsiteDataTypeServiceWorkerRegistrations',
      );

  ///HTML session storage.
  static const WKWebsiteDataTypeSessionStorage =
      AqutterWebsiteDataType._internal(
        'WKWebsiteDataTypeSessionStorage',
        'WKWebsiteDataTypeSessionStorage',
      );

  ///WebSQL databases.
  static const WKWebsiteDataTypeWebSQLDatabases =
      AqutterWebsiteDataType._internal(
        'WKWebsiteDataTypeWebSQLDatabases',
        'WKWebsiteDataTypeWebSQLDatabases',
      );

  ///Set of all values of [AqutterWebsiteDataType].
  static final Set<AqutterWebsiteDataType> values = [
    AqutterWebsiteDataType.WKWebsiteDataTypeCookies,
    AqutterWebsiteDataType.WKWebsiteDataTypeDiskCache,
    AqutterWebsiteDataType.WKWebsiteDataTypeFetchCache,
    AqutterWebsiteDataType.WKWebsiteDataTypeIndexedDBDatabases,
    AqutterWebsiteDataType.WKWebsiteDataTypeLocalStorage,
    AqutterWebsiteDataType.WKWebsiteDataTypeMemoryCache,
    AqutterWebsiteDataType.WKWebsiteDataTypeOfflineWebApplicationCache,
    AqutterWebsiteDataType.WKWebsiteDataTypeServiceWorkerRegistrations,
    AqutterWebsiteDataType.WKWebsiteDataTypeSessionStorage,
    AqutterWebsiteDataType.WKWebsiteDataTypeWebSQLDatabases,
  ].toSet();

  ///Gets a possible [AqutterWebsiteDataType] instance from [String] value.
  static AqutterWebsiteDataType? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterWebsiteDataType.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterWebsiteDataType] instance from a native value.
  static AqutterWebsiteDataType? fromNativeValue(String? value) {
    if (value != null) {
      try {
        return AqutterWebsiteDataType.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterWebsiteDataType] instance value with name [name].
  ///
  /// Goes through [AqutterWebsiteDataType.values] looking for a value with
  /// name [name], as reported by [AqutterWebsiteDataType.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterWebsiteDataType? byName(String? name) {
    if (name != null) {
      try {
        return AqutterWebsiteDataType.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterWebsiteDataType] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterWebsiteDataType> asNameMap() =>
      <String, AqutterWebsiteDataType>{
        for (final value in AqutterWebsiteDataType.values) value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'WKWebsiteDataTypeCookies':
        return 'WKWebsiteDataTypeCookies';
      case 'WKWebsiteDataTypeDiskCache':
        return 'WKWebsiteDataTypeDiskCache';
      case 'WKWebsiteDataTypeFetchCache':
        return 'WKWebsiteDataTypeFetchCache';
      case 'WKWebsiteDataTypeIndexedDBDatabases':
        return 'WKWebsiteDataTypeIndexedDBDatabases';
      case 'WKWebsiteDataTypeLocalStorage':
        return 'WKWebsiteDataTypeLocalStorage';
      case 'WKWebsiteDataTypeMemoryCache':
        return 'WKWebsiteDataTypeMemoryCache';
      case 'WKWebsiteDataTypeOfflineWebApplicationCache':
        return 'WKWebsiteDataTypeOfflineWebApplicationCache';
      case 'WKWebsiteDataTypeServiceWorkerRegistrations':
        return 'WKWebsiteDataTypeServiceWorkerRegistrations';
      case 'WKWebsiteDataTypeSessionStorage':
        return 'WKWebsiteDataTypeSessionStorage';
      case 'WKWebsiteDataTypeWebSQLDatabases':
        return 'WKWebsiteDataTypeWebSQLDatabases';
    }
    return _value.toString();
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(value) => value == _value;

  ///Checks if the value is supported by the [defaultTargetPlatform].
  bool isSupported() {
    return _nativeValue != null;
  }

  @override
  String toString() {
    return _value;
  }
}

///Class that represents a website data type.
///
///**NOTE**: available on iOS 9.0+.
///
///Use [AqutterWebsiteDataType] instead.
@Deprecated('Use AqutterWebsiteDataType instead')
class AqutterIOSWKWebsiteDataType {
  final String _value;
  final String? _nativeValue;
  const AqutterIOSWKWebsiteDataType._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterIOSWKWebsiteDataType._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterIOSWKWebsiteDataType._internal(value, nativeValue());

  ///Returns a set of all available website data types.
  static final ALL = [
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeFetchCache,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeDiskCache,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeMemoryCache,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeOfflineWebApplicationCache,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeCookies,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeSessionStorage,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeLocalStorage,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeWebSQLDatabases,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeIndexedDBDatabases,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeServiceWorkerRegistrations,
  ].toSet();

  ///Cookies.
  static const WKWebsiteDataTypeCookies = AqutterIOSWKWebsiteDataType._internal(
    'WKWebsiteDataTypeCookies',
    'WKWebsiteDataTypeCookies',
  );

  ///On-disk caches.
  static const WKWebsiteDataTypeDiskCache =
      AqutterIOSWKWebsiteDataType._internal(
        'WKWebsiteDataTypeDiskCache',
        'WKWebsiteDataTypeDiskCache',
      );

  ///On-disk Fetch caches.
  ///
  ///**NOTE**: available on iOS 11.3+.
  static const WKWebsiteDataTypeFetchCache =
      AqutterIOSWKWebsiteDataType._internal(
        'WKWebsiteDataTypeFetchCache',
        'WKWebsiteDataTypeFetchCache',
      );

  ///IndexedDB databases.
  static const WKWebsiteDataTypeIndexedDBDatabases =
      AqutterIOSWKWebsiteDataType._internal(
        'WKWebsiteDataTypeIndexedDBDatabases',
        'WKWebsiteDataTypeIndexedDBDatabases',
      );

  ///HTML local storage.
  static const WKWebsiteDataTypeLocalStorage =
      AqutterIOSWKWebsiteDataType._internal(
        'WKWebsiteDataTypeLocalStorage',
        'WKWebsiteDataTypeLocalStorage',
      );

  ///In-memory caches.
  static const WKWebsiteDataTypeMemoryCache =
      AqutterIOSWKWebsiteDataType._internal(
        'WKWebsiteDataTypeMemoryCache',
        'WKWebsiteDataTypeMemoryCache',
      );

  ///HTML offline web application caches.
  static const WKWebsiteDataTypeOfflineWebApplicationCache =
      AqutterIOSWKWebsiteDataType._internal(
        'WKWebsiteDataTypeOfflineWebApplicationCache',
        'WKWebsiteDataTypeOfflineWebApplicationCache',
      );

  ///Service worker registrations.
  ///
  ///**NOTE**: available on iOS 11.3+.
  static const WKWebsiteDataTypeServiceWorkerRegistrations =
      AqutterIOSWKWebsiteDataType._internal(
        'WKWebsiteDataTypeServiceWorkerRegistrations',
        'WKWebsiteDataTypeServiceWorkerRegistrations',
      );

  ///HTML session storage.
  static const WKWebsiteDataTypeSessionStorage =
      AqutterIOSWKWebsiteDataType._internal(
        'WKWebsiteDataTypeSessionStorage',
        'WKWebsiteDataTypeSessionStorage',
      );

  ///WebSQL databases.
  static const WKWebsiteDataTypeWebSQLDatabases =
      AqutterIOSWKWebsiteDataType._internal(
        'WKWebsiteDataTypeWebSQLDatabases',
        'WKWebsiteDataTypeWebSQLDatabases',
      );

  ///Set of all values of [AqutterIOSWKWebsiteDataType].
  static final Set<AqutterIOSWKWebsiteDataType> values = [
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeCookies,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeDiskCache,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeFetchCache,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeIndexedDBDatabases,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeLocalStorage,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeMemoryCache,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeOfflineWebApplicationCache,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeServiceWorkerRegistrations,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeSessionStorage,
    AqutterIOSWKWebsiteDataType.WKWebsiteDataTypeWebSQLDatabases,
  ].toSet();

  ///Gets a possible [AqutterIOSWKWebsiteDataType] instance from [String] value.
  static AqutterIOSWKWebsiteDataType? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterIOSWKWebsiteDataType.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSWKWebsiteDataType] instance from a native value.
  static AqutterIOSWKWebsiteDataType? fromNativeValue(String? value) {
    if (value != null) {
      try {
        return AqutterIOSWKWebsiteDataType.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSWKWebsiteDataType] instance value with name [name].
  ///
  /// Goes through [AqutterIOSWKWebsiteDataType.values] looking for a value with
  /// name [name], as reported by [AqutterIOSWKWebsiteDataType.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSWKWebsiteDataType? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSWKWebsiteDataType.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSWKWebsiteDataType] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSWKWebsiteDataType> asNameMap() =>
      <String, AqutterIOSWKWebsiteDataType>{
        for (final value in AqutterIOSWKWebsiteDataType.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'WKWebsiteDataTypeCookies':
        return 'WKWebsiteDataTypeCookies';
      case 'WKWebsiteDataTypeDiskCache':
        return 'WKWebsiteDataTypeDiskCache';
      case 'WKWebsiteDataTypeFetchCache':
        return 'WKWebsiteDataTypeFetchCache';
      case 'WKWebsiteDataTypeIndexedDBDatabases':
        return 'WKWebsiteDataTypeIndexedDBDatabases';
      case 'WKWebsiteDataTypeLocalStorage':
        return 'WKWebsiteDataTypeLocalStorage';
      case 'WKWebsiteDataTypeMemoryCache':
        return 'WKWebsiteDataTypeMemoryCache';
      case 'WKWebsiteDataTypeOfflineWebApplicationCache':
        return 'WKWebsiteDataTypeOfflineWebApplicationCache';
      case 'WKWebsiteDataTypeServiceWorkerRegistrations':
        return 'WKWebsiteDataTypeServiceWorkerRegistrations';
      case 'WKWebsiteDataTypeSessionStorage':
        return 'WKWebsiteDataTypeSessionStorage';
      case 'WKWebsiteDataTypeWebSQLDatabases':
        return 'WKWebsiteDataTypeWebSQLDatabases';
    }
    return _value.toString();
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(value) => value == _value;

  ///Checks if the value is supported by the [defaultTargetPlatform].
  bool isSupported() {
    return _nativeValue != null;
  }

  @override
  String toString() {
    return _value;
  }
}
