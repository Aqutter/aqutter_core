// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favicon_image_format.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Constants that describe the favicon image format.
class AqutterFaviconImageFormat {
  final int _value;
  final int? _nativeValue;
  const AqutterFaviconImageFormat._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterFaviconImageFormat._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterFaviconImageFormat._internal(value, nativeValue());

  ///JPEG image format.
  static const JPEG = AqutterFaviconImageFormat._internal(1, 1);

  ///PNG image format.
  static const PNG = AqutterFaviconImageFormat._internal(0, 0);

  ///Set of all values of [AqutterFaviconImageFormat].
  static final Set<AqutterFaviconImageFormat> values = [
    AqutterFaviconImageFormat.JPEG,
    AqutterFaviconImageFormat.PNG,
  ].toSet();

  ///Gets a possible [AqutterFaviconImageFormat] instance from [int] value.
  static AqutterFaviconImageFormat? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterFaviconImageFormat.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterFaviconImageFormat] instance from a native value.
  static AqutterFaviconImageFormat? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterFaviconImageFormat.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterFaviconImageFormat] instance value with name [name].
  ///
  /// Goes through [AqutterFaviconImageFormat.values] looking for a value with
  /// name [name], as reported by [AqutterFaviconImageFormat.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterFaviconImageFormat? byName(String? name) {
    if (name != null) {
      try {
        return AqutterFaviconImageFormat.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterFaviconImageFormat] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterFaviconImageFormat> asNameMap() =>
      <String, AqutterFaviconImageFormat>{
        for (final value in AqutterFaviconImageFormat.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 1:
        return 'JPEG';
      case 0:
        return 'PNG';
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
