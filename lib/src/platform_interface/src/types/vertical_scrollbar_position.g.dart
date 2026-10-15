// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vertical_scrollbar_position.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to configure the position of the vertical scroll bar.
class AqutterVerticalScrollbarPosition {
  final int _value;
  final int? _nativeValue;
  const AqutterVerticalScrollbarPosition._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterVerticalScrollbarPosition._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterVerticalScrollbarPosition._internal(value, nativeValue());

  ///Position the scroll bar at the default position as determined by the system.
  static const SCROLLBAR_POSITION_DEFAULT =
      AqutterVerticalScrollbarPosition._internal(0, 0);

  ///Position the scroll bar along the left edge.
  static const SCROLLBAR_POSITION_LEFT =
      AqutterVerticalScrollbarPosition._internal(1, 1);

  ///Position the scroll bar along the right edge.
  static const SCROLLBAR_POSITION_RIGHT =
      AqutterVerticalScrollbarPosition._internal(2, 2);

  ///Set of all values of [AqutterVerticalScrollbarPosition].
  static final Set<AqutterVerticalScrollbarPosition> values = [
    AqutterVerticalScrollbarPosition.SCROLLBAR_POSITION_DEFAULT,
    AqutterVerticalScrollbarPosition.SCROLLBAR_POSITION_LEFT,
    AqutterVerticalScrollbarPosition.SCROLLBAR_POSITION_RIGHT,
  ].toSet();

  ///Gets a possible [AqutterVerticalScrollbarPosition] instance from [int] value.
  static AqutterVerticalScrollbarPosition? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterVerticalScrollbarPosition.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterVerticalScrollbarPosition] instance from a native value.
  static AqutterVerticalScrollbarPosition? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterVerticalScrollbarPosition.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterVerticalScrollbarPosition] instance value with name [name].
  ///
  /// Goes through [AqutterVerticalScrollbarPosition.values] looking for a value with
  /// name [name], as reported by [AqutterVerticalScrollbarPosition.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterVerticalScrollbarPosition? byName(String? name) {
    if (name != null) {
      try {
        return AqutterVerticalScrollbarPosition.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterVerticalScrollbarPosition] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterVerticalScrollbarPosition> asNameMap() =>
      <String, AqutterVerticalScrollbarPosition>{
        for (final value in AqutterVerticalScrollbarPosition.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 0:
        return 'SCROLLBAR_POSITION_DEFAULT';
      case 1:
        return 'SCROLLBAR_POSITION_LEFT';
      case 2:
        return 'SCROLLBAR_POSITION_RIGHT';
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

///An Android-specific class used to configure the position of the vertical scroll bar.
///Use [AqutterVerticalScrollbarPosition] instead.
@Deprecated('Use AqutterVerticalScrollbarPosition instead')
class AqutterAndroidVerticalScrollbarPosition {
  final int _value;
  final int? _nativeValue;
  const AqutterAndroidVerticalScrollbarPosition._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterAndroidVerticalScrollbarPosition._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterAndroidVerticalScrollbarPosition._internal(value, nativeValue());

  ///Position the scroll bar at the default position as determined by the system.
  static const SCROLLBAR_POSITION_DEFAULT =
      AqutterAndroidVerticalScrollbarPosition._internal(0, 0);

  ///Position the scroll bar along the left edge.
  static const SCROLLBAR_POSITION_LEFT =
      AqutterAndroidVerticalScrollbarPosition._internal(1, 1);

  ///Position the scroll bar along the right edge.
  static const SCROLLBAR_POSITION_RIGHT =
      AqutterAndroidVerticalScrollbarPosition._internal(2, 2);

  ///Set of all values of [AqutterAndroidVerticalScrollbarPosition].
  static final Set<AqutterAndroidVerticalScrollbarPosition> values = [
    AqutterAndroidVerticalScrollbarPosition.SCROLLBAR_POSITION_DEFAULT,
    AqutterAndroidVerticalScrollbarPosition.SCROLLBAR_POSITION_LEFT,
    AqutterAndroidVerticalScrollbarPosition.SCROLLBAR_POSITION_RIGHT,
  ].toSet();

  ///Gets a possible [AqutterAndroidVerticalScrollbarPosition] instance from [int] value.
  static AqutterAndroidVerticalScrollbarPosition? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidVerticalScrollbarPosition.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAndroidVerticalScrollbarPosition] instance from a native value.
  static AqutterAndroidVerticalScrollbarPosition? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidVerticalScrollbarPosition.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAndroidVerticalScrollbarPosition] instance value with name [name].
  ///
  /// Goes through [AqutterAndroidVerticalScrollbarPosition.values] looking for a value with
  /// name [name], as reported by [AqutterAndroidVerticalScrollbarPosition.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAndroidVerticalScrollbarPosition? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAndroidVerticalScrollbarPosition.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAndroidVerticalScrollbarPosition] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAndroidVerticalScrollbarPosition> asNameMap() =>
      <String, AqutterAndroidVerticalScrollbarPosition>{
        for (final value in AqutterAndroidVerticalScrollbarPosition.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 0:
        return 'SCROLLBAR_POSITION_DEFAULT';
      case 1:
        return 'SCROLLBAR_POSITION_LEFT';
      case 2:
        return 'SCROLLBAR_POSITION_RIGHT';
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
