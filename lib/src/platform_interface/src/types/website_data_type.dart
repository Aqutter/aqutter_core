import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'website_data_type.g.dart';

///Class that represents a website data type.
@ExchangeableEnum()
class AqutterWebsiteDataType_ {
  // ignore: unused_field
  final String _value;
  const AqutterWebsiteDataType_._internal(this._value);

  ///On-disk Fetch caches.
  ///
  ///**NOTE**: available on iOS 11.3+.
  static const WKWebsiteDataTypeFetchCache = const AqutterWebsiteDataType_._internal(
    "WKWebsiteDataTypeFetchCache",
  );

  ///On-disk caches.
  static const WKWebsiteDataTypeDiskCache = const AqutterWebsiteDataType_._internal(
    "WKWebsiteDataTypeDiskCache",
  );

  ///In-memory caches.
  static const WKWebsiteDataTypeMemoryCache = const AqutterWebsiteDataType_._internal(
    "WKWebsiteDataTypeMemoryCache",
  );

  ///HTML offline web application caches.
  static const WKWebsiteDataTypeOfflineWebApplicationCache =
      const AqutterWebsiteDataType_._internal(
        "WKWebsiteDataTypeOfflineWebApplicationCache",
      );

  ///Cookies.
  static const WKWebsiteDataTypeCookies = const AqutterWebsiteDataType_._internal(
    "WKWebsiteDataTypeCookies",
  );

  ///HTML session storage.
  static const WKWebsiteDataTypeSessionStorage =
      const AqutterWebsiteDataType_._internal("WKWebsiteDataTypeSessionStorage");

  ///HTML local storage.
  static const WKWebsiteDataTypeLocalStorage = const AqutterWebsiteDataType_._internal(
    "WKWebsiteDataTypeLocalStorage",
  );

  ///WebSQL databases.
  static const WKWebsiteDataTypeWebSQLDatabases =
      const AqutterWebsiteDataType_._internal("WKWebsiteDataTypeWebSQLDatabases");

  ///IndexedDB databases.
  static const WKWebsiteDataTypeIndexedDBDatabases =
      const AqutterWebsiteDataType_._internal("WKWebsiteDataTypeIndexedDBDatabases");

  ///Service worker registrations.
  ///
  ///**NOTE**: available on iOS 11.3+.
  static const WKWebsiteDataTypeServiceWorkerRegistrations =
      const AqutterWebsiteDataType_._internal(
        "WKWebsiteDataTypeServiceWorkerRegistrations",
      );

  ///Returns a set of all available website data types.
  @ExchangeableEnumCustomValue()
  // ignore: non_constant_identifier_names
  static final Set<AqutterWebsiteDataType_> ALL = [
    AqutterWebsiteDataType_.WKWebsiteDataTypeFetchCache,
    AqutterWebsiteDataType_.WKWebsiteDataTypeDiskCache,
    AqutterWebsiteDataType_.WKWebsiteDataTypeMemoryCache,
    AqutterWebsiteDataType_.WKWebsiteDataTypeOfflineWebApplicationCache,
    AqutterWebsiteDataType_.WKWebsiteDataTypeCookies,
    AqutterWebsiteDataType_.WKWebsiteDataTypeSessionStorage,
    AqutterWebsiteDataType_.WKWebsiteDataTypeLocalStorage,
    AqutterWebsiteDataType_.WKWebsiteDataTypeWebSQLDatabases,
    AqutterWebsiteDataType_.WKWebsiteDataTypeIndexedDBDatabases,
    AqutterWebsiteDataType_.WKWebsiteDataTypeServiceWorkerRegistrations,
  ].toSet();
}

///Class that represents a website data type.
///
///**NOTE**: available on iOS 9.0+.
///
///Use [AqutterWebsiteDataType] instead.
@Deprecated("Use AqutterWebsiteDataType instead")
@ExchangeableEnum()
class AqutterIOSWKWebsiteDataType_ {
  // ignore: unused_field
  final String _value;
  const AqutterIOSWKWebsiteDataType_._internal(this._value);

  ///On-disk Fetch caches.
  ///
  ///**NOTE**: available on iOS 11.3+.
  static const WKWebsiteDataTypeFetchCache =
      const AqutterIOSWKWebsiteDataType_._internal("WKWebsiteDataTypeFetchCache");

  ///On-disk caches.
  static const WKWebsiteDataTypeDiskCache =
      const AqutterIOSWKWebsiteDataType_._internal("WKWebsiteDataTypeDiskCache");

  ///In-memory caches.
  static const WKWebsiteDataTypeMemoryCache =
      const AqutterIOSWKWebsiteDataType_._internal("WKWebsiteDataTypeMemoryCache");

  ///HTML offline web application caches.
  static const WKWebsiteDataTypeOfflineWebApplicationCache =
      const AqutterIOSWKWebsiteDataType_._internal(
        "WKWebsiteDataTypeOfflineWebApplicationCache",
      );

  ///Cookies.
  static const WKWebsiteDataTypeCookies = const AqutterIOSWKWebsiteDataType_._internal(
    "WKWebsiteDataTypeCookies",
  );

  ///HTML session storage.
  static const WKWebsiteDataTypeSessionStorage =
      const AqutterIOSWKWebsiteDataType_._internal("WKWebsiteDataTypeSessionStorage");

  ///HTML local storage.
  static const WKWebsiteDataTypeLocalStorage =
      const AqutterIOSWKWebsiteDataType_._internal("WKWebsiteDataTypeLocalStorage");

  ///WebSQL databases.
  static const WKWebsiteDataTypeWebSQLDatabases =
      const AqutterIOSWKWebsiteDataType_._internal("WKWebsiteDataTypeWebSQLDatabases");

  ///IndexedDB databases.
  static const WKWebsiteDataTypeIndexedDBDatabases =
      const AqutterIOSWKWebsiteDataType_._internal(
        "WKWebsiteDataTypeIndexedDBDatabases",
      );

  ///Service worker registrations.
  ///
  ///**NOTE**: available on iOS 11.3+.
  static const WKWebsiteDataTypeServiceWorkerRegistrations =
      const AqutterIOSWKWebsiteDataType_._internal(
        "WKWebsiteDataTypeServiceWorkerRegistrations",
      );

  ///Returns a set of all available website data types.
  @ExchangeableEnumCustomValue()
  // ignore: non_constant_identifier_names
  static final Set<AqutterIOSWKWebsiteDataType_> ALL = [
    AqutterIOSWKWebsiteDataType_.WKWebsiteDataTypeFetchCache,
    AqutterIOSWKWebsiteDataType_.WKWebsiteDataTypeDiskCache,
    AqutterIOSWKWebsiteDataType_.WKWebsiteDataTypeMemoryCache,
    AqutterIOSWKWebsiteDataType_.WKWebsiteDataTypeOfflineWebApplicationCache,
    AqutterIOSWKWebsiteDataType_.WKWebsiteDataTypeCookies,
    AqutterIOSWKWebsiteDataType_.WKWebsiteDataTypeSessionStorage,
    AqutterIOSWKWebsiteDataType_.WKWebsiteDataTypeLocalStorage,
    AqutterIOSWKWebsiteDataType_.WKWebsiteDataTypeWebSQLDatabases,
    AqutterIOSWKWebsiteDataType_.WKWebsiteDataTypeIndexedDBDatabases,
    AqutterIOSWKWebsiteDataType_.WKWebsiteDataTypeServiceWorkerRegistrations,
  ].toSet();
}
