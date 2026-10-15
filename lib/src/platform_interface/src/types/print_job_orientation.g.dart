// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_job_orientation.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class representing the orientation of a [AqutterPlatformPrintJobController].
class AqutterPrintJobOrientation {
  final int _value;
  final int? _nativeValue;
  const AqutterPrintJobOrientation._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterPrintJobOrientation._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterPrintJobOrientation._internal(value, nativeValue());

  ///Pages are printed in landscape orientation.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  static final LANDSCAPE = AqutterPrintJobOrientation._internalMultiPlatform(
    1,
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return 1;
        case TargetPlatform.iOS:
          return 1;
        case TargetPlatform.macOS:
          return 1;
        case TargetPlatform.windows:
          return 1;
        default:
          break;
      }
      return null;
    },
  );

  ///Pages are printed in portrait orientation.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  static final PORTRAIT = AqutterPrintJobOrientation._internalMultiPlatform(
    0,
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return 0;
        case TargetPlatform.iOS:
          return 0;
        case TargetPlatform.macOS:
          return 0;
        case TargetPlatform.windows:
          return 0;
        default:
          break;
      }
      return null;
    },
  );

  ///Set of all values of [AqutterPrintJobOrientation].
  static final Set<AqutterPrintJobOrientation> values = [
    AqutterPrintJobOrientation.LANDSCAPE,
    AqutterPrintJobOrientation.PORTRAIT,
  ].toSet();

  ///Gets a possible [AqutterPrintJobOrientation] instance from [int] value.
  static AqutterPrintJobOrientation? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterPrintJobOrientation.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterPrintJobOrientation] instance from a native value.
  static AqutterPrintJobOrientation? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterPrintJobOrientation.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterPrintJobOrientation] instance value with name [name].
  ///
  /// Goes through [AqutterPrintJobOrientation.values] looking for a value with
  /// name [name], as reported by [AqutterPrintJobOrientation.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterPrintJobOrientation? byName(String? name) {
    if (name != null) {
      try {
        return AqutterPrintJobOrientation.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterPrintJobOrientation] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterPrintJobOrientation> asNameMap() =>
      <String, AqutterPrintJobOrientation>{
        for (final value in AqutterPrintJobOrientation.values)
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
        return 'LANDSCAPE';
      case 0:
        return 'PORTRAIT';
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
