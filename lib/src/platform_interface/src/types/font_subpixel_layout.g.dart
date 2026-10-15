// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'font_subpixel_layout.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Font subpixel layout order used for text rendering on Linux.
///This setting determines how subpixel rendering is performed based on
///the physical arrangement of the display's RGB subpixels.
class AqutterFontSubpixelLayout {
  final int _value;
  final int? _nativeValue;
  const AqutterFontSubpixelLayout._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterFontSubpixelLayout._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterFontSubpixelLayout._internal(value, nativeValue());

  ///BGR subpixel layout (horizontal BGR order).
  ///Used for LCD displays with horizontal BGR subpixel arrangement.
  static const BGR = AqutterFontSubpixelLayout._internal(1, 1);

  ///RGB subpixel layout (horizontal RGB order).
  ///Used for most LCD displays with horizontal RGB subpixel arrangement.
  static const RGB = AqutterFontSubpixelLayout._internal(0, 0);

  ///Vertical BGR subpixel layout.
  ///Used for displays with vertical BGR subpixel arrangement.
  static const VBGR = AqutterFontSubpixelLayout._internal(3, 3);

  ///Vertical RGB subpixel layout.
  ///Used for displays with vertical RGB subpixel arrangement.
  static const VRGB = AqutterFontSubpixelLayout._internal(2, 2);

  ///Set of all values of [AqutterFontSubpixelLayout].
  static final Set<AqutterFontSubpixelLayout> values = [
    AqutterFontSubpixelLayout.BGR,
    AqutterFontSubpixelLayout.RGB,
    AqutterFontSubpixelLayout.VBGR,
    AqutterFontSubpixelLayout.VRGB,
  ].toSet();

  ///Gets a possible [AqutterFontSubpixelLayout] instance from [int] value.
  static AqutterFontSubpixelLayout? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterFontSubpixelLayout.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterFontSubpixelLayout] instance from a native value.
  static AqutterFontSubpixelLayout? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterFontSubpixelLayout.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterFontSubpixelLayout] instance value with name [name].
  ///
  /// Goes through [AqutterFontSubpixelLayout.values] looking for a value with
  /// name [name], as reported by [AqutterFontSubpixelLayout.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterFontSubpixelLayout? byName(String? name) {
    if (name != null) {
      try {
        return AqutterFontSubpixelLayout.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterFontSubpixelLayout] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterFontSubpixelLayout> asNameMap() =>
      <String, AqutterFontSubpixelLayout>{
        for (final value in AqutterFontSubpixelLayout.values)
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
        return 'BGR';
      case 0:
        return 'RGB';
      case 3:
        return 'VBGR';
      case 2:
        return 'VRGB';
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
