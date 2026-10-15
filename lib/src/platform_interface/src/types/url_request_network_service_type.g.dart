// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_request_network_service_type.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the constants that specify how a request uses network resources.
class AqutterURLRequestNetworkServiceType {
  final int _value;
  final int? _nativeValue;
  const AqutterURLRequestNetworkServiceType._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterURLRequestNetworkServiceType._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterURLRequestNetworkServiceType._internal(value, nativeValue());

  ///A service type for streaming audio/video data.
  static const AV_STREAMING = AqutterURLRequestNetworkServiceType._internal(
    8,
    8,
  );

  ///A service type for background traffic.
  ///
  ///You should specify this type if your app is performing a download that was not requested by the user—for example,
  ///prefetching content so that it will be available when the user chooses to view it.
  static const BACKGROUND = AqutterURLRequestNetworkServiceType._internal(3, 3);

  ///A service type for call signaling.
  ///
  ///Use this service type with network traffic that establishes, maintains, or tears down a VoIP call.
  static const CALL_SIGNALING = AqutterURLRequestNetworkServiceType._internal(
    11,
    11,
  );

  ///A service type for standard network traffic.
  static const DEFAULT = AqutterURLRequestNetworkServiceType._internal(0, 0);

  ///A service type for responsive (time-sensitive) audio/video data.
  static const RESPONSIVE_AV = AqutterURLRequestNetworkServiceType._internal(
    9,
    9,
  );

  ///A service type for data that the user is actively waiting for.
  ///
  ///Use this service type for interactive situations where the user is anticipating a quick response, like instant messaging or completing a purchase.
  static const RESPONSIVE_DATA = AqutterURLRequestNetworkServiceType._internal(
    6,
    6,
  );

  ///A service type for video traffic.
  static const VIDEO = AqutterURLRequestNetworkServiceType._internal(2, 2);

  ///A service type for voice traffic.
  static const VOICE = AqutterURLRequestNetworkServiceType._internal(4, 4);

  ///Set of all values of [AqutterURLRequestNetworkServiceType].
  static final Set<AqutterURLRequestNetworkServiceType> values = [
    AqutterURLRequestNetworkServiceType.AV_STREAMING,
    AqutterURLRequestNetworkServiceType.BACKGROUND,
    AqutterURLRequestNetworkServiceType.CALL_SIGNALING,
    AqutterURLRequestNetworkServiceType.DEFAULT,
    AqutterURLRequestNetworkServiceType.RESPONSIVE_AV,
    AqutterURLRequestNetworkServiceType.RESPONSIVE_DATA,
    AqutterURLRequestNetworkServiceType.VIDEO,
    AqutterURLRequestNetworkServiceType.VOICE,
  ].toSet();

  ///Gets a possible [AqutterURLRequestNetworkServiceType] instance from [int] value.
  static AqutterURLRequestNetworkServiceType? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterURLRequestNetworkServiceType.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterURLRequestNetworkServiceType] instance from a native value.
  static AqutterURLRequestNetworkServiceType? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterURLRequestNetworkServiceType.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterURLRequestNetworkServiceType] instance value with name [name].
  ///
  /// Goes through [AqutterURLRequestNetworkServiceType.values] looking for a value with
  /// name [name], as reported by [AqutterURLRequestNetworkServiceType.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterURLRequestNetworkServiceType? byName(String? name) {
    if (name != null) {
      try {
        return AqutterURLRequestNetworkServiceType.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterURLRequestNetworkServiceType] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterURLRequestNetworkServiceType> asNameMap() =>
      <String, AqutterURLRequestNetworkServiceType>{
        for (final value in AqutterURLRequestNetworkServiceType.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 8:
        return 'AV_STREAMING';
      case 3:
        return 'BACKGROUND';
      case 11:
        return 'CALL_SIGNALING';
      case 0:
        return 'DEFAULT';
      case 9:
        return 'RESPONSIVE_AV';
      case 6:
        return 'RESPONSIVE_DATA';
      case 2:
        return 'VIDEO';
      case 4:
        return 'VOICE';
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

///An iOS-specific Class that represents the constants that specify how a request uses network resources.
///Use [AqutterURLRequestNetworkServiceType] instead.
@Deprecated('Use AqutterURLRequestNetworkServiceType instead')
class AqutterIOSURLRequestNetworkServiceType {
  final int _value;
  final int? _nativeValue;
  const AqutterIOSURLRequestNetworkServiceType._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSURLRequestNetworkServiceType._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterIOSURLRequestNetworkServiceType._internal(value, nativeValue());

  ///A service type for streaming audio/video data.
  static const AV_STREAMING = AqutterIOSURLRequestNetworkServiceType._internal(
    8,
    8,
  );

  ///A service type for background traffic.
  ///
  ///You should specify this type if your app is performing a download that was not requested by the user—for example,
  ///prefetching content so that it will be available when the user chooses to view it.
  static const BACKGROUND = AqutterIOSURLRequestNetworkServiceType._internal(
    3,
    3,
  );

  ///A service type for call signaling.
  ///
  ///Use this service type with network traffic that establishes, maintains, or tears down a VoIP call.
  static const CALL_SIGNALING =
      AqutterIOSURLRequestNetworkServiceType._internal(11, 11);

  ///A service type for standard network traffic.
  static const DEFAULT = AqutterIOSURLRequestNetworkServiceType._internal(0, 0);

  ///A service type for responsive (time-sensitive) audio/video data.
  static const RESPONSIVE_AV = AqutterIOSURLRequestNetworkServiceType._internal(
    9,
    9,
  );

  ///A service type for data that the user is actively waiting for.
  ///
  ///Use this service type for interactive situations where the user is anticipating a quick response, like instant messaging or completing a purchase.
  static const RESPONSIVE_DATA =
      AqutterIOSURLRequestNetworkServiceType._internal(6, 6);

  ///A service type for video traffic.
  static const VIDEO = AqutterIOSURLRequestNetworkServiceType._internal(2, 2);

  ///A service type for voice traffic.
  static const VOICE = AqutterIOSURLRequestNetworkServiceType._internal(4, 4);

  ///Set of all values of [AqutterIOSURLRequestNetworkServiceType].
  static final Set<AqutterIOSURLRequestNetworkServiceType> values = [
    AqutterIOSURLRequestNetworkServiceType.AV_STREAMING,
    AqutterIOSURLRequestNetworkServiceType.BACKGROUND,
    AqutterIOSURLRequestNetworkServiceType.CALL_SIGNALING,
    AqutterIOSURLRequestNetworkServiceType.DEFAULT,
    AqutterIOSURLRequestNetworkServiceType.RESPONSIVE_AV,
    AqutterIOSURLRequestNetworkServiceType.RESPONSIVE_DATA,
    AqutterIOSURLRequestNetworkServiceType.VIDEO,
    AqutterIOSURLRequestNetworkServiceType.VOICE,
  ].toSet();

  ///Gets a possible [AqutterIOSURLRequestNetworkServiceType] instance from [int] value.
  static AqutterIOSURLRequestNetworkServiceType? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSURLRequestNetworkServiceType.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSURLRequestNetworkServiceType] instance from a native value.
  static AqutterIOSURLRequestNetworkServiceType? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSURLRequestNetworkServiceType.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSURLRequestNetworkServiceType] instance value with name [name].
  ///
  /// Goes through [AqutterIOSURLRequestNetworkServiceType.values] looking for a value with
  /// name [name], as reported by [AqutterIOSURLRequestNetworkServiceType.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSURLRequestNetworkServiceType? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSURLRequestNetworkServiceType.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSURLRequestNetworkServiceType] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSURLRequestNetworkServiceType> asNameMap() =>
      <String, AqutterIOSURLRequestNetworkServiceType>{
        for (final value in AqutterIOSURLRequestNetworkServiceType.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 8:
        return 'AV_STREAMING';
      case 3:
        return 'BACKGROUND';
      case 11:
        return 'CALL_SIGNALING';
      case 0:
        return 'DEFAULT';
      case 9:
        return 'RESPONSIVE_AV';
      case 6:
        return 'RESPONSIVE_DATA';
      case 2:
        return 'VIDEO';
      case 4:
        return 'VOICE';
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
