// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modal_presentation_style.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to specify the modal presentation style when presenting a view controller.
class AqutterModalPresentationStyle {
  final int _value;
  final int? _nativeValue;
  const AqutterModalPresentationStyle._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterModalPresentationStyle._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterModalPresentationStyle._internal(value, nativeValue());

  ///The default presentation style chosen by the system.
  ///
  ///**NOTE**: available on iOS 13.0+.
  static const AUTOMATIC = AqutterModalPresentationStyle._internal(9, 9);

  ///A presentation style where the content is displayed over another view controller’s content.
  static const CURRENT_CONTEXT = AqutterModalPresentationStyle._internal(3, 3);

  ///A custom view presentation style that is managed by a custom presentation controller and one or more custom animator objects.
  static const CUSTOM = AqutterModalPresentationStyle._internal(4, 4);

  ///A presentation style that displays the content centered in the screen.
  static const FORM_SHEET = AqutterModalPresentationStyle._internal(2, 2);

  ///A presentation style in which the presented view covers the screen.
  static const FULL_SCREEN = AqutterModalPresentationStyle._internal(0, 0);

  ///A presentation style that indicates no adaptations should be made.
  static const NONE = AqutterModalPresentationStyle._internal(8, 8);

  ///A presentation style where the content is displayed over another view controller’s content.
  static const OVER_CURRENT_CONTEXT = AqutterModalPresentationStyle._internal(
    6,
    6,
  );

  ///A view presentation style in which the presented view covers the screen.
  static const OVER_FULL_SCREEN = AqutterModalPresentationStyle._internal(5, 5);

  ///A presentation style that partially covers the underlying content.
  static const PAGE_SHEET = AqutterModalPresentationStyle._internal(1, 1);

  ///A presentation style where the content is displayed in a popover view.
  static const POPOVER = AqutterModalPresentationStyle._internal(7, 7);

  ///Set of all values of [AqutterModalPresentationStyle].
  static final Set<AqutterModalPresentationStyle> values = [
    AqutterModalPresentationStyle.AUTOMATIC,
    AqutterModalPresentationStyle.CURRENT_CONTEXT,
    AqutterModalPresentationStyle.CUSTOM,
    AqutterModalPresentationStyle.FORM_SHEET,
    AqutterModalPresentationStyle.FULL_SCREEN,
    AqutterModalPresentationStyle.NONE,
    AqutterModalPresentationStyle.OVER_CURRENT_CONTEXT,
    AqutterModalPresentationStyle.OVER_FULL_SCREEN,
    AqutterModalPresentationStyle.PAGE_SHEET,
    AqutterModalPresentationStyle.POPOVER,
  ].toSet();

  ///Gets a possible [AqutterModalPresentationStyle] instance from [int] value.
  static AqutterModalPresentationStyle? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterModalPresentationStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterModalPresentationStyle] instance from a native value.
  static AqutterModalPresentationStyle? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterModalPresentationStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterModalPresentationStyle] instance value with name [name].
  ///
  /// Goes through [AqutterModalPresentationStyle.values] looking for a value with
  /// name [name], as reported by [AqutterModalPresentationStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterModalPresentationStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterModalPresentationStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterModalPresentationStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterModalPresentationStyle> asNameMap() =>
      <String, AqutterModalPresentationStyle>{
        for (final value in AqutterModalPresentationStyle.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 9:
        return 'AUTOMATIC';
      case 3:
        return 'CURRENT_CONTEXT';
      case 4:
        return 'CUSTOM';
      case 2:
        return 'FORM_SHEET';
      case 0:
        return 'FULL_SCREEN';
      case 8:
        return 'NONE';
      case 6:
        return 'OVER_CURRENT_CONTEXT';
      case 5:
        return 'OVER_FULL_SCREEN';
      case 1:
        return 'PAGE_SHEET';
      case 7:
        return 'POPOVER';
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

///An iOS-specific class used to specify the modal presentation style when presenting a view controller.
///Use [AqutterModalPresentationStyle] instead.
@Deprecated('Use AqutterModalPresentationStyle instead')
class AqutterIOSUIModalPresentationStyle {
  final int _value;
  final int? _nativeValue;
  const AqutterIOSUIModalPresentationStyle._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSUIModalPresentationStyle._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterIOSUIModalPresentationStyle._internal(value, nativeValue());

  ///The default presentation style chosen by the system.
  ///
  ///**NOTE**: available on iOS 13.0+.
  static const AUTOMATIC = AqutterIOSUIModalPresentationStyle._internal(9, 9);

  ///A presentation style where the content is displayed over another view controller’s content.
  static const CURRENT_CONTEXT = AqutterIOSUIModalPresentationStyle._internal(
    3,
    3,
  );

  ///A custom view presentation style that is managed by a custom presentation controller and one or more custom animator objects.
  static const CUSTOM = AqutterIOSUIModalPresentationStyle._internal(4, 4);

  ///A presentation style that displays the content centered in the screen.
  static const FORM_SHEET = AqutterIOSUIModalPresentationStyle._internal(2, 2);

  ///A presentation style in which the presented view covers the screen.
  static const FULL_SCREEN = AqutterIOSUIModalPresentationStyle._internal(0, 0);

  ///A presentation style that indicates no adaptations should be made.
  static const NONE = AqutterIOSUIModalPresentationStyle._internal(8, 8);

  ///A presentation style where the content is displayed over another view controller’s content.
  static const OVER_CURRENT_CONTEXT =
      AqutterIOSUIModalPresentationStyle._internal(6, 6);

  ///A view presentation style in which the presented view covers the screen.
  static const OVER_FULL_SCREEN = AqutterIOSUIModalPresentationStyle._internal(
    5,
    5,
  );

  ///A presentation style that partially covers the underlying content.
  static const PAGE_SHEET = AqutterIOSUIModalPresentationStyle._internal(1, 1);

  ///A presentation style where the content is displayed in a popover view.
  static const POPOVER = AqutterIOSUIModalPresentationStyle._internal(7, 7);

  ///Set of all values of [AqutterIOSUIModalPresentationStyle].
  static final Set<AqutterIOSUIModalPresentationStyle> values = [
    AqutterIOSUIModalPresentationStyle.AUTOMATIC,
    AqutterIOSUIModalPresentationStyle.CURRENT_CONTEXT,
    AqutterIOSUIModalPresentationStyle.CUSTOM,
    AqutterIOSUIModalPresentationStyle.FORM_SHEET,
    AqutterIOSUIModalPresentationStyle.FULL_SCREEN,
    AqutterIOSUIModalPresentationStyle.NONE,
    AqutterIOSUIModalPresentationStyle.OVER_CURRENT_CONTEXT,
    AqutterIOSUIModalPresentationStyle.OVER_FULL_SCREEN,
    AqutterIOSUIModalPresentationStyle.PAGE_SHEET,
    AqutterIOSUIModalPresentationStyle.POPOVER,
  ].toSet();

  ///Gets a possible [AqutterIOSUIModalPresentationStyle] instance from [int] value.
  static AqutterIOSUIModalPresentationStyle? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSUIModalPresentationStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSUIModalPresentationStyle] instance from a native value.
  static AqutterIOSUIModalPresentationStyle? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSUIModalPresentationStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSUIModalPresentationStyle] instance value with name [name].
  ///
  /// Goes through [AqutterIOSUIModalPresentationStyle.values] looking for a value with
  /// name [name], as reported by [AqutterIOSUIModalPresentationStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSUIModalPresentationStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSUIModalPresentationStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSUIModalPresentationStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSUIModalPresentationStyle> asNameMap() =>
      <String, AqutterIOSUIModalPresentationStyle>{
        for (final value in AqutterIOSUIModalPresentationStyle.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 9:
        return 'AUTOMATIC';
      case 3:
        return 'CURRENT_CONTEXT';
      case 4:
        return 'CUSTOM';
      case 2:
        return 'FORM_SHEET';
      case 0:
        return 'FULL_SCREEN';
      case 8:
        return 'NONE';
      case 6:
        return 'OVER_CURRENT_CONTEXT';
      case 5:
        return 'OVER_FULL_SCREEN';
      case 1:
        return 'PAGE_SHEET';
      case 7:
        return 'POPOVER';
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
