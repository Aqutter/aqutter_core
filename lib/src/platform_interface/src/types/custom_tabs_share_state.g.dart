// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_tabs_share_state.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class representing the share state that should be applied to the custom tab.
class AqutterCustomTabsShareState {
  final int _value;
  final int? _nativeValue;
  const AqutterCustomTabsShareState._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterCustomTabsShareState._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterCustomTabsShareState._internal(value, nativeValue());

  ///Applies the default share settings depending on the browser.
  static const SHARE_STATE_DEFAULT = AqutterCustomTabsShareState._internal(
    0,
    0,
  );

  ///Explicitly does not show a share option in the tab.
  static const SHARE_STATE_OFF = AqutterCustomTabsShareState._internal(2, 2);

  ///Shows a share option in the tab.
  static const SHARE_STATE_ON = AqutterCustomTabsShareState._internal(1, 1);

  ///Set of all values of [AqutterCustomTabsShareState].
  static final Set<AqutterCustomTabsShareState> values = [
    AqutterCustomTabsShareState.SHARE_STATE_DEFAULT,
    AqutterCustomTabsShareState.SHARE_STATE_OFF,
    AqutterCustomTabsShareState.SHARE_STATE_ON,
  ].toSet();

  ///Gets a possible [AqutterCustomTabsShareState] instance from [int] value.
  static AqutterCustomTabsShareState? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterCustomTabsShareState.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterCustomTabsShareState] instance from a native value.
  static AqutterCustomTabsShareState? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterCustomTabsShareState.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterCustomTabsShareState] instance value with name [name].
  ///
  /// Goes through [AqutterCustomTabsShareState.values] looking for a value with
  /// name [name], as reported by [AqutterCustomTabsShareState.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterCustomTabsShareState? byName(String? name) {
    if (name != null) {
      try {
        return AqutterCustomTabsShareState.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterCustomTabsShareState] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterCustomTabsShareState> asNameMap() =>
      <String, AqutterCustomTabsShareState>{
        for (final value in AqutterCustomTabsShareState.values)
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
        return 'SHARE_STATE_DEFAULT';
      case 2:
        return 'SHARE_STATE_OFF';
      case 1:
        return 'SHARE_STATE_ON';
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
