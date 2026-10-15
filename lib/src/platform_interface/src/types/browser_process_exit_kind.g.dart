// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_process_exit_kind.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///The kind of browser process exit that has occurred.
class AqutterBrowserProcessExitKind {
  final int _value;
  final int? _nativeValue;
  const AqutterBrowserProcessExitKind._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterBrowserProcessExitKind._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterBrowserProcessExitKind._internal(value, nativeValue());

  ///Indicates that the browser process ended unexpectedly.
  ///A [AqutterPlatformWebViewCreationParams.onProcessFailed] event will also be
  ///raised to listening WebViews from the [AqutterPlatformWebViewEnvironment] associated to the failed process.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  static final FAILED = AqutterBrowserProcessExitKind._internalMultiPlatform(
    1,
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.windows:
          return 1;
        default:
          break;
      }
      return null;
    },
  );

  ///Indicates that the browser process ended normally.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  static final NORMAL = AqutterBrowserProcessExitKind._internalMultiPlatform(
    0,
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.windows:
          return 0;
        default:
          break;
      }
      return null;
    },
  );

  ///Set of all values of [AqutterBrowserProcessExitKind].
  static final Set<AqutterBrowserProcessExitKind> values = [
    AqutterBrowserProcessExitKind.FAILED,
    AqutterBrowserProcessExitKind.NORMAL,
  ].toSet();

  ///Gets a possible [AqutterBrowserProcessExitKind] instance from [int] value.
  static AqutterBrowserProcessExitKind? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterBrowserProcessExitKind.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return AqutterBrowserProcessExitKind._internal(value, value);
      }
    }
    return null;
  }

  ///Gets a possible [AqutterBrowserProcessExitKind] instance from a native value.
  static AqutterBrowserProcessExitKind? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterBrowserProcessExitKind.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterBrowserProcessExitKind] instance value with name [name].
  ///
  /// Goes through [AqutterBrowserProcessExitKind.values] looking for a value with
  /// name [name], as reported by [AqutterBrowserProcessExitKind.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterBrowserProcessExitKind? byName(String? name) {
    if (name != null) {
      try {
        return AqutterBrowserProcessExitKind.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterBrowserProcessExitKind] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterBrowserProcessExitKind> asNameMap() =>
      <String, AqutterBrowserProcessExitKind>{
        for (final value in AqutterBrowserProcessExitKind.values)
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
        return 'FAILED';
      case 0:
        return 'NORMAL';
    }
    return _value.toString();
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(value) => value == _value;

  AqutterBrowserProcessExitKind operator |(
    AqutterBrowserProcessExitKind value,
  ) => AqutterBrowserProcessExitKind._internal(
    value.toValue() | _value,
    value.toNativeValue() != null && _nativeValue != null
        ? value.toNativeValue()! | _nativeValue!
        : null,
  );

  ///Checks if the value is supported by the [defaultTargetPlatform].
  bool isSupported() {
    return _nativeValue != null;
  }

  @override
  String toString() {
    return name();
  }
}
