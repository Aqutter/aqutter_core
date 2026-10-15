// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modal_transition_style.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to specify the transition style when presenting a view controller.
class AqutterModalTransitionStyle {
  final int _value;
  final int? _nativeValue;
  const AqutterModalTransitionStyle._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterModalTransitionStyle._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterModalTransitionStyle._internal(value, nativeValue());

  ///When the view controller is presented, its view slides up from the bottom of the screen.
  ///On dismissal, the view slides back down. This is the default transition style.
  static const COVER_VERTICAL = AqutterModalTransitionStyle._internal(0, 0);

  ///When the view controller is presented, the current view fades out while the new view fades in at the same time.
  ///On dismissal, a similar type of cross-fade is used to return to the original view.
  static const CROSS_DISSOLVE = AqutterModalTransitionStyle._internal(2, 2);

  ///When the view controller is presented, the current view initiates a horizontal 3D flip from right-to-left,
  ///resulting in the revealing of the new view as if it were on the back of the previous view.
  ///On dismissal, the flip occurs from left-to-right, returning to the original view.
  static const FLIP_HORIZONTAL = AqutterModalTransitionStyle._internal(1, 1);

  ///When the view controller is presented, one corner of the current view curls up to reveal the presented view underneath.
  ///On dismissal, the curled up page unfurls itself back on top of the presented view.
  ///A view controller presented using this transition is itself prevented from presenting any additional view controllers.
  static const PARTIAL_CURL = AqutterModalTransitionStyle._internal(3, 3);

  ///Set of all values of [AqutterModalTransitionStyle].
  static final Set<AqutterModalTransitionStyle> values = [
    AqutterModalTransitionStyle.COVER_VERTICAL,
    AqutterModalTransitionStyle.CROSS_DISSOLVE,
    AqutterModalTransitionStyle.FLIP_HORIZONTAL,
    AqutterModalTransitionStyle.PARTIAL_CURL,
  ].toSet();

  ///Gets a possible [AqutterModalTransitionStyle] instance from [int] value.
  static AqutterModalTransitionStyle? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterModalTransitionStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterModalTransitionStyle] instance from a native value.
  static AqutterModalTransitionStyle? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterModalTransitionStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterModalTransitionStyle] instance value with name [name].
  ///
  /// Goes through [AqutterModalTransitionStyle.values] looking for a value with
  /// name [name], as reported by [AqutterModalTransitionStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterModalTransitionStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterModalTransitionStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterModalTransitionStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterModalTransitionStyle> asNameMap() =>
      <String, AqutterModalTransitionStyle>{
        for (final value in AqutterModalTransitionStyle.values)
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
        return 'COVER_VERTICAL';
      case 2:
        return 'CROSS_DISSOLVE';
      case 1:
        return 'FLIP_HORIZONTAL';
      case 3:
        return 'PARTIAL_CURL';
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

///An iOS-specific class used to specify the transition style when presenting a view controller.
///Use [AqutterModalTransitionStyle] instead.
@Deprecated('Use AqutterModalTransitionStyle instead')
class AqutterIOSUIModalTransitionStyle {
  final int _value;
  final int? _nativeValue;
  const AqutterIOSUIModalTransitionStyle._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterIOSUIModalTransitionStyle._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterIOSUIModalTransitionStyle._internal(value, nativeValue());

  ///When the view controller is presented, its view slides up from the bottom of the screen.
  ///On dismissal, the view slides back down. This is the default transition style.
  static const COVER_VERTICAL = AqutterIOSUIModalTransitionStyle._internal(
    0,
    0,
  );

  ///When the view controller is presented, the current view fades out while the new view fades in at the same time.
  ///On dismissal, a similar type of cross-fade is used to return to the original view.
  static const CROSS_DISSOLVE = AqutterIOSUIModalTransitionStyle._internal(
    2,
    2,
  );

  ///When the view controller is presented, the current view initiates a horizontal 3D flip from right-to-left,
  ///resulting in the revealing of the new view as if it were on the back of the previous view.
  ///On dismissal, the flip occurs from left-to-right, returning to the original view.
  static const FLIP_HORIZONTAL = AqutterIOSUIModalTransitionStyle._internal(
    1,
    1,
  );

  ///When the view controller is presented, one corner of the current view curls up to reveal the presented view underneath.
  ///On dismissal, the curled up page unfurls itself back on top of the presented view.
  ///A view controller presented using this transition is itself prevented from presenting any additional view controllers.
  static const PARTIAL_CURL = AqutterIOSUIModalTransitionStyle._internal(3, 3);

  ///Set of all values of [AqutterIOSUIModalTransitionStyle].
  static final Set<AqutterIOSUIModalTransitionStyle> values = [
    AqutterIOSUIModalTransitionStyle.COVER_VERTICAL,
    AqutterIOSUIModalTransitionStyle.CROSS_DISSOLVE,
    AqutterIOSUIModalTransitionStyle.FLIP_HORIZONTAL,
    AqutterIOSUIModalTransitionStyle.PARTIAL_CURL,
  ].toSet();

  ///Gets a possible [AqutterIOSUIModalTransitionStyle] instance from [int] value.
  static AqutterIOSUIModalTransitionStyle? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSUIModalTransitionStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSUIModalTransitionStyle] instance from a native value.
  static AqutterIOSUIModalTransitionStyle? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSUIModalTransitionStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSUIModalTransitionStyle] instance value with name [name].
  ///
  /// Goes through [AqutterIOSUIModalTransitionStyle.values] looking for a value with
  /// name [name], as reported by [AqutterIOSUIModalTransitionStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSUIModalTransitionStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSUIModalTransitionStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSUIModalTransitionStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSUIModalTransitionStyle> asNameMap() =>
      <String, AqutterIOSUIModalTransitionStyle>{
        for (final value in AqutterIOSUIModalTransitionStyle.values)
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
        return 'COVER_VERTICAL';
      case 2:
        return 'CROSS_DISSOLVE';
      case 1:
        return 'FLIP_HORIZONTAL';
      case 3:
        return 'PARTIAL_CURL';
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
