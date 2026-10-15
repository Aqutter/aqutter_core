// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_job_duplex_mode.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class representing the orientation of a [AqutterPlatformPrintJobController].
class AqutterPrintJobDuplexMode {
  final String _value;
  final int? _nativeValue;
  const AqutterPrintJobDuplexMode._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterPrintJobDuplexMode._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterPrintJobDuplexMode._internal(value, nativeValue());

  ///Duplex printing that flips the back page along the long edge of the paper.
  ///Pages are turned sideways along the long edge - like a book.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  static final LONG_EDGE = AqutterPrintJobDuplexMode._internalMultiPlatform(
    'LONG_EDGE',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return 2;
        case TargetPlatform.iOS:
          return 1;
        case TargetPlatform.macOS:
          return 2;
        case TargetPlatform.windows:
          return 2;
        default:
          break;
      }
      return null;
    },
  );

  ///No double-sided (duplex) printing; single-sided printing only.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  static final NONE = AqutterPrintJobDuplexMode._internalMultiPlatform(
    'NONE',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return 1;
        case TargetPlatform.iOS:
          return 0;
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

  ///Duplex print that flips the back page along the short edge of the paper.
  ///Pages are turned upwards along the short edge - like a notepad.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  static final SHORT_EDGE = AqutterPrintJobDuplexMode._internalMultiPlatform(
    'SHORT_EDGE',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return 4;
        case TargetPlatform.iOS:
          return 2;
        case TargetPlatform.macOS:
          return 3;
        case TargetPlatform.windows:
          return 3;
        default:
          break;
      }
      return null;
    },
  );

  ///Set of all values of [AqutterPrintJobDuplexMode].
  static final Set<AqutterPrintJobDuplexMode> values = [
    AqutterPrintJobDuplexMode.LONG_EDGE,
    AqutterPrintJobDuplexMode.NONE,
    AqutterPrintJobDuplexMode.SHORT_EDGE,
  ].toSet();

  ///Gets a possible [AqutterPrintJobDuplexMode] instance from [String] value.
  static AqutterPrintJobDuplexMode? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterPrintJobDuplexMode.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterPrintJobDuplexMode] instance from a native value.
  static AqutterPrintJobDuplexMode? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterPrintJobDuplexMode.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterPrintJobDuplexMode] instance value with name [name].
  ///
  /// Goes through [AqutterPrintJobDuplexMode.values] looking for a value with
  /// name [name], as reported by [AqutterPrintJobDuplexMode.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterPrintJobDuplexMode? byName(String? name) {
    if (name != null) {
      try {
        return AqutterPrintJobDuplexMode.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterPrintJobDuplexMode] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterPrintJobDuplexMode> asNameMap() =>
      <String, AqutterPrintJobDuplexMode>{
        for (final value in AqutterPrintJobDuplexMode.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'LONG_EDGE':
        return 'LONG_EDGE';
      case 'NONE':
        return 'NONE';
      case 'SHORT_EDGE':
        return 'SHORT_EDGE';
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
