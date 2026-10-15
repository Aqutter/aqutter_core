// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_direction.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to indicate the force dark mode.
class AqutterFocusDirection {
  final String _value;
  final int? _nativeValue;
  const AqutterFocusDirection._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterFocusDirection._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterFocusDirection._internal(value, nativeValue());

  ///Move focus down.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - FOCUS_DOWN](https://developer.android.com/reference/android/view/View#FOCUS_DOWN))
  static final DOWN = AqutterFocusDirection._internalMultiPlatform('DOWN', () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 130;
      default:
        break;
    }
    return null;
  });

  ///Move focus to the left.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - FOCUS_LEFT](https://developer.android.com/reference/android/view/View#FOCUS_LEFT))
  static final LEFT = AqutterFocusDirection._internalMultiPlatform('LEFT', () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 130;
      default:
        break;
    }
    return null;
  });

  ///Move focus to the right.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - FOCUS_RIGHT](https://developer.android.com/reference/android/view/View#FOCUS_RIGHT))
  static final RIGHT = AqutterFocusDirection._internalMultiPlatform(
    'RIGHT',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return 130;
        default:
          break;
      }
      return null;
    },
  );

  ///Move focus up.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - FOCUS_UP](https://developer.android.com/reference/android/view/View#FOCUS_UP))
  static final UP = AqutterFocusDirection._internalMultiPlatform('UP', () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 33;
      default:
        break;
    }
    return null;
  });

  ///Set of all values of [AqutterFocusDirection].
  static final Set<AqutterFocusDirection> values = [
    AqutterFocusDirection.DOWN,
    AqutterFocusDirection.LEFT,
    AqutterFocusDirection.RIGHT,
    AqutterFocusDirection.UP,
  ].toSet();

  ///Gets a possible [AqutterFocusDirection] instance from [String] value.
  static AqutterFocusDirection? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterFocusDirection.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterFocusDirection] instance from a native value.
  static AqutterFocusDirection? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterFocusDirection.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterFocusDirection] instance value with name [name].
  ///
  /// Goes through [AqutterFocusDirection.values] looking for a value with
  /// name [name], as reported by [AqutterFocusDirection.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterFocusDirection? byName(String? name) {
    if (name != null) {
      try {
        return AqutterFocusDirection.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterFocusDirection] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterFocusDirection> asNameMap() =>
      <String, AqutterFocusDirection>{
        for (final value in AqutterFocusDirection.values) value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'DOWN':
        return 'DOWN';
      case 'LEFT':
        return 'LEFT';
      case 'RIGHT':
        return 'RIGHT';
      case 'UP':
        return 'UP';
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
