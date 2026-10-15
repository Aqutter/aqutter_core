// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_detector_types.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to specify a `dataDetectoryTypes` value that adds interactivity to web content that matches the value.
class AqutterDataDetectorTypes {
  final String _value;
  final String? _nativeValue;
  const AqutterDataDetectorTypes._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterDataDetectorTypes._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterDataDetectorTypes._internal(value, nativeValue());

  ///Addresses are detected and turned into links.
  static const ADDRESS = AqutterDataDetectorTypes._internal(
    'ADDRESS',
    'ADDRESS',
  );

  ///All of the above data types are turned into links when detected. Choosing this value will automatically include any new detection type that is added.
  static const ALL = AqutterDataDetectorTypes._internal('ALL', 'ALL');

  ///Dates and times that are in the future are detected and turned into links.
  static const CALENDAR_EVENT = AqutterDataDetectorTypes._internal(
    'CALENDAR_EVENT',
    'CALENDAR_EVENT',
  );

  ///Flight numbers are detected and turned into links.
  static const FLIGHT_NUMBER = AqutterDataDetectorTypes._internal(
    'FLIGHT_NUMBER',
    'FLIGHT_NUMBER',
  );

  ///URLs in text are detected and turned into links.
  static const LINK = AqutterDataDetectorTypes._internal('LINK', 'LINK');

  ///Lookup suggestions are detected and turned into links.
  static const LOOKUP_SUGGESTION = AqutterDataDetectorTypes._internal(
    'LOOKUP_SUGGESTION',
    'LOOKUP_SUGGESTION',
  );

  ///No detection is performed.
  static const NONE = AqutterDataDetectorTypes._internal('NONE', 'NONE');

  ///Phone numbers are detected and turned into links.
  static const PHONE_NUMBER = AqutterDataDetectorTypes._internal(
    'PHONE_NUMBER',
    'PHONE_NUMBER',
  );

  ///Spotlight suggestions are detected and turned into links.
  static const SPOTLIGHT_SUGGESTION = AqutterDataDetectorTypes._internal(
    'SPOTLIGHT_SUGGESTION',
    'SPOTLIGHT_SUGGESTION',
  );

  ///Tracking numbers are detected and turned into links.
  static const TRACKING_NUMBER = AqutterDataDetectorTypes._internal(
    'TRACKING_NUMBER',
    'TRACKING_NUMBER',
  );

  ///Set of all values of [AqutterDataDetectorTypes].
  static final Set<AqutterDataDetectorTypes> values = [
    AqutterDataDetectorTypes.ADDRESS,
    AqutterDataDetectorTypes.ALL,
    AqutterDataDetectorTypes.CALENDAR_EVENT,
    AqutterDataDetectorTypes.FLIGHT_NUMBER,
    AqutterDataDetectorTypes.LINK,
    AqutterDataDetectorTypes.LOOKUP_SUGGESTION,
    AqutterDataDetectorTypes.NONE,
    AqutterDataDetectorTypes.PHONE_NUMBER,
    AqutterDataDetectorTypes.SPOTLIGHT_SUGGESTION,
    AqutterDataDetectorTypes.TRACKING_NUMBER,
  ].toSet();

  ///Gets a possible [AqutterDataDetectorTypes] instance from [String] value.
  static AqutterDataDetectorTypes? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterDataDetectorTypes.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterDataDetectorTypes] instance from a native value.
  static AqutterDataDetectorTypes? fromNativeValue(String? value) {
    if (value != null) {
      try {
        return AqutterDataDetectorTypes.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterDataDetectorTypes] instance value with name [name].
  ///
  /// Goes through [AqutterDataDetectorTypes.values] looking for a value with
  /// name [name], as reported by [AqutterDataDetectorTypes.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterDataDetectorTypes? byName(String? name) {
    if (name != null) {
      try {
        return AqutterDataDetectorTypes.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterDataDetectorTypes] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterDataDetectorTypes> asNameMap() =>
      <String, AqutterDataDetectorTypes>{
        for (final value in AqutterDataDetectorTypes.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'ADDRESS':
        return 'ADDRESS';
      case 'ALL':
        return 'ALL';
      case 'CALENDAR_EVENT':
        return 'CALENDAR_EVENT';
      case 'FLIGHT_NUMBER':
        return 'FLIGHT_NUMBER';
      case 'LINK':
        return 'LINK';
      case 'LOOKUP_SUGGESTION':
        return 'LOOKUP_SUGGESTION';
      case 'NONE':
        return 'NONE';
      case 'PHONE_NUMBER':
        return 'PHONE_NUMBER';
      case 'SPOTLIGHT_SUGGESTION':
        return 'SPOTLIGHT_SUGGESTION';
      case 'TRACKING_NUMBER':
        return 'TRACKING_NUMBER';
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

///An iOS-specific class used to specify a `dataDetectoryTypes` value that adds interactivity to web content that matches the value.
///
///**NOTE**: available on iOS 10.0+.
///
///Use [AqutterDataDetectorTypes] instead.
@Deprecated('Use AqutterDataDetectorTypes instead')
class AqutterIOSWKDataDetectorTypes {
  final String _value;
  final String? _nativeValue;
  const AqutterIOSWKDataDetectorTypes._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterIOSWKDataDetectorTypes._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterIOSWKDataDetectorTypes._internal(value, nativeValue());

  ///Addresses are detected and turned into links.
  static const ADDRESS = AqutterIOSWKDataDetectorTypes._internal(
    'ADDRESS',
    'ADDRESS',
  );

  ///All of the above data types are turned into links when detected. Choosing this value will automatically include any new detection type that is added.
  static const ALL = AqutterIOSWKDataDetectorTypes._internal('ALL', 'ALL');

  ///Dates and times that are in the future are detected and turned into links.
  static const CALENDAR_EVENT = AqutterIOSWKDataDetectorTypes._internal(
    'CALENDAR_EVENT',
    'CALENDAR_EVENT',
  );

  ///Flight numbers are detected and turned into links.
  static const FLIGHT_NUMBER = AqutterIOSWKDataDetectorTypes._internal(
    'FLIGHT_NUMBER',
    'FLIGHT_NUMBER',
  );

  ///URLs in text are detected and turned into links.
  static const LINK = AqutterIOSWKDataDetectorTypes._internal('LINK', 'LINK');

  ///Lookup suggestions are detected and turned into links.
  static const LOOKUP_SUGGESTION = AqutterIOSWKDataDetectorTypes._internal(
    'LOOKUP_SUGGESTION',
    'LOOKUP_SUGGESTION',
  );

  ///No detection is performed.
  static const NONE = AqutterIOSWKDataDetectorTypes._internal('NONE', 'NONE');

  ///Phone numbers are detected and turned into links.
  static const PHONE_NUMBER = AqutterIOSWKDataDetectorTypes._internal(
    'PHONE_NUMBER',
    'PHONE_NUMBER',
  );

  ///Spotlight suggestions are detected and turned into links.
  static const SPOTLIGHT_SUGGESTION = AqutterIOSWKDataDetectorTypes._internal(
    'SPOTLIGHT_SUGGESTION',
    'SPOTLIGHT_SUGGESTION',
  );

  ///Tracking numbers are detected and turned into links.
  static const TRACKING_NUMBER = AqutterIOSWKDataDetectorTypes._internal(
    'TRACKING_NUMBER',
    'TRACKING_NUMBER',
  );

  ///Set of all values of [AqutterIOSWKDataDetectorTypes].
  static final Set<AqutterIOSWKDataDetectorTypes> values = [
    AqutterIOSWKDataDetectorTypes.ADDRESS,
    AqutterIOSWKDataDetectorTypes.ALL,
    AqutterIOSWKDataDetectorTypes.CALENDAR_EVENT,
    AqutterIOSWKDataDetectorTypes.FLIGHT_NUMBER,
    AqutterIOSWKDataDetectorTypes.LINK,
    AqutterIOSWKDataDetectorTypes.LOOKUP_SUGGESTION,
    AqutterIOSWKDataDetectorTypes.NONE,
    AqutterIOSWKDataDetectorTypes.PHONE_NUMBER,
    AqutterIOSWKDataDetectorTypes.SPOTLIGHT_SUGGESTION,
    AqutterIOSWKDataDetectorTypes.TRACKING_NUMBER,
  ].toSet();

  ///Gets a possible [AqutterIOSWKDataDetectorTypes] instance from [String] value.
  static AqutterIOSWKDataDetectorTypes? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterIOSWKDataDetectorTypes.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSWKDataDetectorTypes] instance from a native value.
  static AqutterIOSWKDataDetectorTypes? fromNativeValue(String? value) {
    if (value != null) {
      try {
        return AqutterIOSWKDataDetectorTypes.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSWKDataDetectorTypes] instance value with name [name].
  ///
  /// Goes through [AqutterIOSWKDataDetectorTypes.values] looking for a value with
  /// name [name], as reported by [AqutterIOSWKDataDetectorTypes.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSWKDataDetectorTypes? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSWKDataDetectorTypes.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSWKDataDetectorTypes] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSWKDataDetectorTypes> asNameMap() =>
      <String, AqutterIOSWKDataDetectorTypes>{
        for (final value in AqutterIOSWKDataDetectorTypes.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'ADDRESS':
        return 'ADDRESS';
      case 'ALL':
        return 'ALL';
      case 'CALENDAR_EVENT':
        return 'CALENDAR_EVENT';
      case 'FLIGHT_NUMBER':
        return 'FLIGHT_NUMBER';
      case 'LINK':
        return 'LINK';
      case 'LOOKUP_SUGGESTION':
        return 'LOOKUP_SUGGESTION';
      case 'NONE':
        return 'NONE';
      case 'PHONE_NUMBER':
        return 'PHONE_NUMBER';
      case 'SPOTLIGHT_SUGGESTION':
        return 'SPOTLIGHT_SUGGESTION';
      case 'TRACKING_NUMBER':
        return 'TRACKING_NUMBER';
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
