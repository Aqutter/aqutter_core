// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment_scrollbar_style.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///The ScrollBar style used during [AqutterPlatformWebViewEnvironment] creation.
class AqutterEnvironmentScrollbarStyle {
  final int _value;
  final int? _nativeValue;
  const AqutterEnvironmentScrollbarStyle._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterEnvironmentScrollbarStyle._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterEnvironmentScrollbarStyle._internal(value, nativeValue());

  ///Browser default ScrollBar style.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  static final DEFAULT =
      AqutterEnvironmentScrollbarStyle._internalMultiPlatform(0, () {
        switch (defaultTargetPlatform) {
          case TargetPlatform.windows:
            return 0;
          default:
            break;
        }
        return null;
      });

  ///Window style fluent overlay scroll bar.
  ///Please see [Fluent UI](https://developer.microsoft.com/fluentui#/) for more details on fluent UI.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  static final FLUENT_OVERLAY =
      AqutterEnvironmentScrollbarStyle._internalMultiPlatform(1, () {
        switch (defaultTargetPlatform) {
          case TargetPlatform.windows:
            return 1;
          default:
            break;
        }
        return null;
      });

  ///Set of all values of [AqutterEnvironmentScrollbarStyle].
  static final Set<AqutterEnvironmentScrollbarStyle> values = [
    AqutterEnvironmentScrollbarStyle.DEFAULT,
    AqutterEnvironmentScrollbarStyle.FLUENT_OVERLAY,
  ].toSet();

  ///Gets a possible [AqutterEnvironmentScrollbarStyle] instance from [int] value.
  static AqutterEnvironmentScrollbarStyle? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterEnvironmentScrollbarStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterEnvironmentScrollbarStyle] instance from a native value.
  static AqutterEnvironmentScrollbarStyle? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterEnvironmentScrollbarStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterEnvironmentScrollbarStyle] instance value with name [name].
  ///
  /// Goes through [AqutterEnvironmentScrollbarStyle.values] looking for a value with
  /// name [name], as reported by [AqutterEnvironmentScrollbarStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterEnvironmentScrollbarStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterEnvironmentScrollbarStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterEnvironmentScrollbarStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterEnvironmentScrollbarStyle> asNameMap() =>
      <String, AqutterEnvironmentScrollbarStyle>{
        for (final value in AqutterEnvironmentScrollbarStyle.values)
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
        return 'DEFAULT';
      case 1:
        return 'FLUENT_OVERLAY';
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
