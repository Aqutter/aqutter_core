// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'over_scroll_mode.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to configure the `WebView`'s over-scroll mode.
///Setting the over-scroll mode of a WebView will have an effect only if the `WebView` is capable of scrolling.
class AqutterOverScrollMode {
  final int _value;
  final int? _nativeValue;
  const AqutterOverScrollMode._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterOverScrollMode._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterOverScrollMode._internal(value, nativeValue());

  ///Always allow a user to over-scroll this view, provided it is a view that can scroll.
  static const ALWAYS = AqutterOverScrollMode._internal(0, 0);

  ///Allow a user to over-scroll this view only if the content is large enough to meaningfully scroll, provided it is a view that can scroll.
  static const IF_CONTENT_SCROLLS = AqutterOverScrollMode._internal(1, 1);

  ///Never allow a user to over-scroll this view.
  static const NEVER = AqutterOverScrollMode._internal(2, 2);

  ///Set of all values of [AqutterOverScrollMode].
  static final Set<AqutterOverScrollMode> values = [
    AqutterOverScrollMode.ALWAYS,
    AqutterOverScrollMode.IF_CONTENT_SCROLLS,
    AqutterOverScrollMode.NEVER,
  ].toSet();

  ///Gets a possible [AqutterOverScrollMode] instance from [int] value.
  static AqutterOverScrollMode? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterOverScrollMode.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterOverScrollMode] instance from a native value.
  static AqutterOverScrollMode? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterOverScrollMode.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterOverScrollMode] instance value with name [name].
  ///
  /// Goes through [AqutterOverScrollMode.values] looking for a value with
  /// name [name], as reported by [AqutterOverScrollMode.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterOverScrollMode? byName(String? name) {
    if (name != null) {
      try {
        return AqutterOverScrollMode.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterOverScrollMode] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterOverScrollMode> asNameMap() =>
      <String, AqutterOverScrollMode>{
        for (final value in AqutterOverScrollMode.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 0:
        return 'ALWAYS';
      case 1:
        return 'IF_CONTENT_SCROLLS';
      case 2:
        return 'NEVER';
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

///An Android-specific class used to configure the `WebView`'s over-scroll mode.
///Setting the over-scroll mode of a WebView will have an effect only if the `WebView` is capable of scrolling.
///Use [AqutterOverScrollMode] instead.
@Deprecated('Use AqutterOverScrollMode instead')
class AqutterAndroidOverScrollMode {
  final int _value;
  final int? _nativeValue;
  const AqutterAndroidOverScrollMode._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterAndroidOverScrollMode._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterAndroidOverScrollMode._internal(value, nativeValue());

  ///Always allow a user to over-scroll this view, provided it is a view that can scroll.
  static const OVER_SCROLL_ALWAYS = AqutterAndroidOverScrollMode._internal(
    0,
    0,
  );

  ///Allow a user to over-scroll this view only if the content is large enough to meaningfully scroll, provided it is a view that can scroll.
  static const OVER_SCROLL_IF_CONTENT_SCROLLS =
      AqutterAndroidOverScrollMode._internal(1, 1);

  ///Never allow a user to over-scroll this view.
  static const OVER_SCROLL_NEVER = AqutterAndroidOverScrollMode._internal(2, 2);

  ///Set of all values of [AqutterAndroidOverScrollMode].
  static final Set<AqutterAndroidOverScrollMode> values = [
    AqutterAndroidOverScrollMode.OVER_SCROLL_ALWAYS,
    AqutterAndroidOverScrollMode.OVER_SCROLL_IF_CONTENT_SCROLLS,
    AqutterAndroidOverScrollMode.OVER_SCROLL_NEVER,
  ].toSet();

  ///Gets a possible [AqutterAndroidOverScrollMode] instance from [int] value.
  static AqutterAndroidOverScrollMode? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidOverScrollMode.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAndroidOverScrollMode] instance from a native value.
  static AqutterAndroidOverScrollMode? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidOverScrollMode.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAndroidOverScrollMode] instance value with name [name].
  ///
  /// Goes through [AqutterAndroidOverScrollMode.values] looking for a value with
  /// name [name], as reported by [AqutterAndroidOverScrollMode.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAndroidOverScrollMode? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAndroidOverScrollMode.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAndroidOverScrollMode] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAndroidOverScrollMode> asNameMap() =>
      <String, AqutterAndroidOverScrollMode>{
        for (final value in AqutterAndroidOverScrollMode.values)
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
        return 'OVER_SCROLL_ALWAYS';
      case 1:
        return 'OVER_SCROLL_IF_CONTENT_SCROLLS';
      case 2:
        return 'OVER_SCROLL_NEVER';
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
