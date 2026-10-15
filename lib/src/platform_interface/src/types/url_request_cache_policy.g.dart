// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_request_cache_policy.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the constants used to specify interaction with the cached responses.
class AqutterURLRequestCachePolicy {
  final int _value;
  final int? _nativeValue;
  const AqutterURLRequestCachePolicy._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterURLRequestCachePolicy._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterURLRequestCachePolicy._internal(value, nativeValue());

  ///Ignore local cache data, and instruct proxies and other intermediates to disregard their caches so far as the protocol allows.
  ///
  ///**NOTE**: Versions earlier than macOS 15, iOS 13, watchOS 6, and tvOS 13 don’t implement this constant.
  static const RELOAD_IGNORING_LOCAL_AND_REMOTE_CACHE_DATA =
      AqutterURLRequestCachePolicy._internal(4, 4);

  ///The URL load should be loaded only from the originating source.
  ///This policy specifies that no existing cache data should be used to satisfy a URL load request.
  ///
  ///**NOTE**: Always use this policy if you are making HTTP or HTTPS byte-range requests.
  static const RELOAD_IGNORING_LOCAL_CACHE_DATA =
      AqutterURLRequestCachePolicy._internal(1, 1);

  ///Use cache data if the origin source can validate it; otherwise, load from the origin.
  ///
  ///**NOTE**: Versions earlier than macOS 15, iOS 13, watchOS 6, and tvOS 13 don’t implement this constant.
  static const RELOAD_REVALIDATING_CACHE_DATA =
      AqutterURLRequestCachePolicy._internal(5, 5);

  ///Use existing cache data, regardless or age or expiration date, and fail if no cached data is available.
  ///
  ///If there is no existing data in the cache corresponding to a URL load request,
  ///no attempt is made to load the data from the originating source, and the load is considered to have failed.
  ///This constant specifies a behavior that is similar to an “offline” mode.
  static const RETURN_CACHE_DATA_DONT_LOAD =
      AqutterURLRequestCachePolicy._internal(3, 3);

  ///Use existing cache data, regardless or age or expiration date, loading from originating source only if there is no cached data.
  static const RETURN_CACHE_DATA_ELSE_LOAD =
      AqutterURLRequestCachePolicy._internal(2, 2);

  ///Use the caching logic defined in the protocol implementation, if any, for a particular URL load request.
  ///This is the default policy for URL load requests.
  static const USE_PROTOCOL_CACHE_POLICY =
      AqutterURLRequestCachePolicy._internal(0, 0);

  ///Set of all values of [AqutterURLRequestCachePolicy].
  static final Set<AqutterURLRequestCachePolicy> values = [
    AqutterURLRequestCachePolicy.RELOAD_IGNORING_LOCAL_AND_REMOTE_CACHE_DATA,
    AqutterURLRequestCachePolicy.RELOAD_IGNORING_LOCAL_CACHE_DATA,
    AqutterURLRequestCachePolicy.RELOAD_REVALIDATING_CACHE_DATA,
    AqutterURLRequestCachePolicy.RETURN_CACHE_DATA_DONT_LOAD,
    AqutterURLRequestCachePolicy.RETURN_CACHE_DATA_ELSE_LOAD,
    AqutterURLRequestCachePolicy.USE_PROTOCOL_CACHE_POLICY,
  ].toSet();

  ///Gets a possible [AqutterURLRequestCachePolicy] instance from [int] value.
  static AqutterURLRequestCachePolicy? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterURLRequestCachePolicy.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterURLRequestCachePolicy] instance from a native value.
  static AqutterURLRequestCachePolicy? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterURLRequestCachePolicy.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterURLRequestCachePolicy] instance value with name [name].
  ///
  /// Goes through [AqutterURLRequestCachePolicy.values] looking for a value with
  /// name [name], as reported by [AqutterURLRequestCachePolicy.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterURLRequestCachePolicy? byName(String? name) {
    if (name != null) {
      try {
        return AqutterURLRequestCachePolicy.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterURLRequestCachePolicy] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterURLRequestCachePolicy> asNameMap() =>
      <String, AqutterURLRequestCachePolicy>{
        for (final value in AqutterURLRequestCachePolicy.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 4:
        return 'RELOAD_IGNORING_LOCAL_AND_REMOTE_CACHE_DATA';
      case 1:
        return 'RELOAD_IGNORING_LOCAL_CACHE_DATA';
      case 5:
        return 'RELOAD_REVALIDATING_CACHE_DATA';
      case 3:
        return 'RETURN_CACHE_DATA_DONT_LOAD';
      case 2:
        return 'RETURN_CACHE_DATA_ELSE_LOAD';
      case 0:
        return 'USE_PROTOCOL_CACHE_POLICY';
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
    return name();
  }
}

///An iOS-specific Class that represents the constants used to specify interaction with the cached responses.
///Use [AqutterURLRequestCachePolicy] instead.
@Deprecated('Use AqutterURLRequestCachePolicy instead')
class AqutterIOSURLRequestCachePolicy {
  final int _value;
  final int? _nativeValue;
  const AqutterIOSURLRequestCachePolicy._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSURLRequestCachePolicy._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterIOSURLRequestCachePolicy._internal(value, nativeValue());

  ///Ignore local cache data, and instruct proxies and other intermediates to disregard their caches so far as the protocol allows.
  ///
  ///**NOTE**: Versions earlier than macOS 15, iOS 13, watchOS 6, and tvOS 13 don’t implement this constant.
  static const RELOAD_IGNORING_LOCAL_AND_REMOTE_CACHE_DATA =
      AqutterIOSURLRequestCachePolicy._internal(4, 4);

  ///The URL load should be loaded only from the originating source.
  ///This policy specifies that no existing cache data should be used to satisfy a URL load request.
  ///
  ///**NOTE**: Always use this policy if you are making HTTP or HTTPS byte-range requests.
  static const RELOAD_IGNORING_LOCAL_CACHE_DATA =
      AqutterIOSURLRequestCachePolicy._internal(1, 1);

  ///Use cache data if the origin source can validate it; otherwise, load from the origin.
  ///
  ///**NOTE**: Versions earlier than macOS 15, iOS 13, watchOS 6, and tvOS 13 don’t implement this constant.
  static const RELOAD_REVALIDATING_CACHE_DATA =
      AqutterIOSURLRequestCachePolicy._internal(5, 5);

  ///Use existing cache data, regardless or age or expiration date, and fail if no cached data is available.
  ///
  ///If there is no existing data in the cache corresponding to a URL load request,
  ///no attempt is made to load the data from the originating source, and the load is considered to have failed.
  ///This constant specifies a behavior that is similar to an “offline” mode.
  static const RETURN_CACHE_DATA_DONT_LOAD =
      AqutterIOSURLRequestCachePolicy._internal(3, 3);

  ///Use existing cache data, regardless or age or expiration date, loading from originating source only if there is no cached data.
  static const RETURN_CACHE_DATA_ELSE_LOAD =
      AqutterIOSURLRequestCachePolicy._internal(2, 2);

  ///Use the caching logic defined in the protocol implementation, if any, for a particular URL load request.
  ///This is the default policy for URL load requests.
  static const USE_PROTOCOL_CACHE_POLICY =
      AqutterIOSURLRequestCachePolicy._internal(0, 0);

  ///Set of all values of [AqutterIOSURLRequestCachePolicy].
  static final Set<AqutterIOSURLRequestCachePolicy> values = [
    AqutterIOSURLRequestCachePolicy.RELOAD_IGNORING_LOCAL_AND_REMOTE_CACHE_DATA,
    AqutterIOSURLRequestCachePolicy.RELOAD_IGNORING_LOCAL_CACHE_DATA,
    AqutterIOSURLRequestCachePolicy.RELOAD_REVALIDATING_CACHE_DATA,
    AqutterIOSURLRequestCachePolicy.RETURN_CACHE_DATA_DONT_LOAD,
    AqutterIOSURLRequestCachePolicy.RETURN_CACHE_DATA_ELSE_LOAD,
    AqutterIOSURLRequestCachePolicy.USE_PROTOCOL_CACHE_POLICY,
  ].toSet();

  ///Gets a possible [AqutterIOSURLRequestCachePolicy] instance from [int] value.
  static AqutterIOSURLRequestCachePolicy? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSURLRequestCachePolicy.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSURLRequestCachePolicy] instance from a native value.
  static AqutterIOSURLRequestCachePolicy? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSURLRequestCachePolicy.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSURLRequestCachePolicy] instance value with name [name].
  ///
  /// Goes through [AqutterIOSURLRequestCachePolicy.values] looking for a value with
  /// name [name], as reported by [AqutterIOSURLRequestCachePolicy.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSURLRequestCachePolicy? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSURLRequestCachePolicy.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSURLRequestCachePolicy] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSURLRequestCachePolicy> asNameMap() =>
      <String, AqutterIOSURLRequestCachePolicy>{
        for (final value in AqutterIOSURLRequestCachePolicy.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 4:
        return 'RELOAD_IGNORING_LOCAL_AND_REMOTE_CACHE_DATA';
      case 1:
        return 'RELOAD_IGNORING_LOCAL_CACHE_DATA';
      case 5:
        return 'RELOAD_REVALIDATING_CACHE_DATA';
      case 3:
        return 'RETURN_CACHE_DATA_DONT_LOAD';
      case 2:
        return 'RETURN_CACHE_DATA_ELSE_LOAD';
      case 0:
        return 'USE_PROTOCOL_CACHE_POLICY';
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
    return name();
  }
}
