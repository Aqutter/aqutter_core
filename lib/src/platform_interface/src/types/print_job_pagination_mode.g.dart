// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_job_pagination_mode.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class representing the constants that specify the different ways in which an image is divided into pages of a [AqutterPlatformPrintJobController].
class AqutterPrintJobPaginationMode {
  final String _value;
  final int? _nativeValue;
  const AqutterPrintJobPaginationMode._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterPrintJobPaginationMode._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterPrintJobPaginationMode._internal(value, nativeValue());

  ///
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  static final AUTOMATIC = AqutterPrintJobPaginationMode._internalMultiPlatform(
    'AUTOMATIC',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.macOS:
          return 0;
        default:
          break;
      }
      return null;
    },
  );

  ///
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  static final CLIP = AqutterPrintJobPaginationMode._internalMultiPlatform(
    'CLIP',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.macOS:
          return 2;
        default:
          break;
      }
      return null;
    },
  );

  ///
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  static final FIT = AqutterPrintJobPaginationMode._internalMultiPlatform(
    'FIT',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.macOS:
          return 1;
        default:
          break;
      }
      return null;
    },
  );

  ///Set of all values of [AqutterPrintJobPaginationMode].
  static final Set<AqutterPrintJobPaginationMode> values = [
    AqutterPrintJobPaginationMode.AUTOMATIC,
    AqutterPrintJobPaginationMode.CLIP,
    AqutterPrintJobPaginationMode.FIT,
  ].toSet();

  ///Gets a possible [AqutterPrintJobPaginationMode] instance from [String] value.
  static AqutterPrintJobPaginationMode? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterPrintJobPaginationMode.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterPrintJobPaginationMode] instance from a native value.
  static AqutterPrintJobPaginationMode? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterPrintJobPaginationMode.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterPrintJobPaginationMode] instance value with name [name].
  ///
  /// Goes through [AqutterPrintJobPaginationMode.values] looking for a value with
  /// name [name], as reported by [AqutterPrintJobPaginationMode.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterPrintJobPaginationMode? byName(String? name) {
    if (name != null) {
      try {
        return AqutterPrintJobPaginationMode.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterPrintJobPaginationMode] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterPrintJobPaginationMode> asNameMap() =>
      <String, AqutterPrintJobPaginationMode>{
        for (final value in AqutterPrintJobPaginationMode.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'AUTOMATIC':
        return 'AUTOMATIC';
      case 'CLIP':
        return 'CLIP';
      case 'FIT':
        return 'FIT';
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
