// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrollbar_style.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to configure the style of the scrollbars.
///The scrollbars can be overlaid or inset.
///When inset, they add to the padding of the view. And the scrollbars can be drawn inside the padding area or on the edge of the view.
///For example, if a view has a background drawable and you want to draw the scrollbars inside the padding specified by the drawable,
///you can use [AqutterScrollBarStyle.SCROLLBARS_INSIDE_OVERLAY] or [AqutterScrollBarStyle.SCROLLBARS_INSIDE_INSET].
///If you want them to appear at the edge of the view, ignoring the padding,
///then you can use [AqutterScrollBarStyle.SCROLLBARS_OUTSIDE_OVERLAY] or [AqutterScrollBarStyle.SCROLLBARS_OUTSIDE_INSET].
class AqutterScrollBarStyle {
  final int _value;
  final int? _nativeValue;
  const AqutterScrollBarStyle._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterScrollBarStyle._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterScrollBarStyle._internal(value, nativeValue());

  ///The scrollbar style to display the scrollbars inside the padded area, increasing the padding of the view.
  ///The scrollbars will not overlap the content area of the view.
  static const SCROLLBARS_INSIDE_INSET = AqutterScrollBarStyle._internal(
    16777216,
    16777216,
  );

  ///The scrollbar style to display the scrollbars inside the content area, without increasing the padding.
  ///The scrollbars will be overlaid with translucency on the view's content.
  static const SCROLLBARS_INSIDE_OVERLAY = AqutterScrollBarStyle._internal(
    0,
    0,
  );

  ///The scrollbar style to display the scrollbars at the edge of the view, increasing the padding of the view.
  ///The scrollbars will only overlap the background, if any.
  static const SCROLLBARS_OUTSIDE_INSET = AqutterScrollBarStyle._internal(
    50331648,
    50331648,
  );

  ///The scrollbar style to display the scrollbars at the edge of the view, without increasing the padding.
  ///The scrollbars will be overlaid with translucency.
  static const SCROLLBARS_OUTSIDE_OVERLAY = AqutterScrollBarStyle._internal(
    33554432,
    33554432,
  );

  ///Set of all values of [AqutterScrollBarStyle].
  static final Set<AqutterScrollBarStyle> values = [
    AqutterScrollBarStyle.SCROLLBARS_INSIDE_INSET,
    AqutterScrollBarStyle.SCROLLBARS_INSIDE_OVERLAY,
    AqutterScrollBarStyle.SCROLLBARS_OUTSIDE_INSET,
    AqutterScrollBarStyle.SCROLLBARS_OUTSIDE_OVERLAY,
  ].toSet();

  ///Gets a possible [AqutterScrollBarStyle] instance from [int] value.
  static AqutterScrollBarStyle? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterScrollBarStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterScrollBarStyle] instance from a native value.
  static AqutterScrollBarStyle? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterScrollBarStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterScrollBarStyle] instance value with name [name].
  ///
  /// Goes through [AqutterScrollBarStyle.values] looking for a value with
  /// name [name], as reported by [AqutterScrollBarStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterScrollBarStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterScrollBarStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterScrollBarStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterScrollBarStyle> asNameMap() =>
      <String, AqutterScrollBarStyle>{
        for (final value in AqutterScrollBarStyle.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 16777216:
        return 'SCROLLBARS_INSIDE_INSET';
      case 0:
        return 'SCROLLBARS_INSIDE_OVERLAY';
      case 50331648:
        return 'SCROLLBARS_OUTSIDE_INSET';
      case 33554432:
        return 'SCROLLBARS_OUTSIDE_OVERLAY';
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

///An Android-specific class used to configure the style of the scrollbars.
///The scrollbars can be overlaid or inset.
///When inset, they add to the padding of the view. And the scrollbars can be drawn inside the padding area or on the edge of the view.
///For example, if a view has a background drawable and you want to draw the scrollbars inside the padding specified by the drawable,
///you can use [AqutterAndroidScrollBarStyle.SCROLLBARS_INSIDE_OVERLAY] or [AqutterAndroidScrollBarStyle.SCROLLBARS_INSIDE_INSET].
///If you want them to appear at the edge of the view, ignoring the padding,
///then you can use [AqutterAndroidScrollBarStyle.SCROLLBARS_OUTSIDE_OVERLAY] or [AqutterAndroidScrollBarStyle.SCROLLBARS_OUTSIDE_INSET].
///
///Use [AqutterScrollBarStyle] instead.
@Deprecated('Use AqutterScrollBarStyle instead')
class AqutterAndroidScrollBarStyle {
  final int _value;
  final int? _nativeValue;
  const AqutterAndroidScrollBarStyle._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterAndroidScrollBarStyle._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterAndroidScrollBarStyle._internal(value, nativeValue());

  ///The scrollbar style to display the scrollbars inside the padded area, increasing the padding of the view.
  ///The scrollbars will not overlap the content area of the view.
  static const SCROLLBARS_INSIDE_INSET = AqutterAndroidScrollBarStyle._internal(
    16777216,
    16777216,
  );

  ///The scrollbar style to display the scrollbars inside the content area, without increasing the padding.
  ///The scrollbars will be overlaid with translucency on the view's content.
  static const SCROLLBARS_INSIDE_OVERLAY =
      AqutterAndroidScrollBarStyle._internal(0, 0);

  ///The scrollbar style to display the scrollbars at the edge of the view, increasing the padding of the view.
  ///The scrollbars will only overlap the background, if any.
  static const SCROLLBARS_OUTSIDE_INSET =
      AqutterAndroidScrollBarStyle._internal(50331648, 50331648);

  ///The scrollbar style to display the scrollbars at the edge of the view, without increasing the padding.
  ///The scrollbars will be overlaid with translucency.
  static const SCROLLBARS_OUTSIDE_OVERLAY =
      AqutterAndroidScrollBarStyle._internal(33554432, 33554432);

  ///Set of all values of [AqutterAndroidScrollBarStyle].
  static final Set<AqutterAndroidScrollBarStyle> values = [
    AqutterAndroidScrollBarStyle.SCROLLBARS_INSIDE_INSET,
    AqutterAndroidScrollBarStyle.SCROLLBARS_INSIDE_OVERLAY,
    AqutterAndroidScrollBarStyle.SCROLLBARS_OUTSIDE_INSET,
    AqutterAndroidScrollBarStyle.SCROLLBARS_OUTSIDE_OVERLAY,
  ].toSet();

  ///Gets a possible [AqutterAndroidScrollBarStyle] instance from [int] value.
  static AqutterAndroidScrollBarStyle? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidScrollBarStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAndroidScrollBarStyle] instance from a native value.
  static AqutterAndroidScrollBarStyle? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidScrollBarStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAndroidScrollBarStyle] instance value with name [name].
  ///
  /// Goes through [AqutterAndroidScrollBarStyle.values] looking for a value with
  /// name [name], as reported by [AqutterAndroidScrollBarStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAndroidScrollBarStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAndroidScrollBarStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAndroidScrollBarStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAndroidScrollBarStyle> asNameMap() =>
      <String, AqutterAndroidScrollBarStyle>{
        for (final value in AqutterAndroidScrollBarStyle.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 16777216:
        return 'SCROLLBARS_INSIDE_INSET';
      case 0:
        return 'SCROLLBARS_INSIDE_OVERLAY';
      case 50331648:
        return 'SCROLLBARS_OUTSIDE_INSET';
      case 33554432:
        return 'SCROLLBARS_OUTSIDE_OVERLAY';
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
