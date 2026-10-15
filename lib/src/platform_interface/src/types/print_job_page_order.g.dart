// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_job_page_order.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class representing the page order that will be used to generate the pages of a [AqutterPlatformPrintJobController].
class AqutterPrintJobPageOrder {
  final int _value;
  final int? _nativeValue;
  const AqutterPrintJobPageOrder._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterPrintJobPageOrder._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterPrintJobPageOrder._internal(value, nativeValue());

  ///Ascending (back to front) page order.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  static final ASCENDING = AqutterPrintJobPageOrder._internalMultiPlatform(
    1,
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

  ///Descending (front to back) page order.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  static final DESCENDING = AqutterPrintJobPageOrder._internalMultiPlatform(
    -1,
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.macOS:
          return -1;
        default:
          break;
      }
      return null;
    },
  );

  ///The spooler does not rearrange pages—they are printed in the order received by the spooler.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  static final SPECIAL = AqutterPrintJobPageOrder._internalMultiPlatform(0, () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
        return 0;
      default:
        break;
    }
    return null;
  });

  ///No page order specified.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  static final UNKNOWN = AqutterPrintJobPageOrder._internalMultiPlatform(2, () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
        return 2;
      default:
        break;
    }
    return null;
  });

  ///Set of all values of [AqutterPrintJobPageOrder].
  static final Set<AqutterPrintJobPageOrder> values = [
    AqutterPrintJobPageOrder.ASCENDING,
    AqutterPrintJobPageOrder.DESCENDING,
    AqutterPrintJobPageOrder.SPECIAL,
    AqutterPrintJobPageOrder.UNKNOWN,
  ].toSet();

  ///Gets a possible [AqutterPrintJobPageOrder] instance from [int] value.
  static AqutterPrintJobPageOrder? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterPrintJobPageOrder.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterPrintJobPageOrder] instance from a native value.
  static AqutterPrintJobPageOrder? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterPrintJobPageOrder.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterPrintJobPageOrder] instance value with name [name].
  ///
  /// Goes through [AqutterPrintJobPageOrder.values] looking for a value with
  /// name [name], as reported by [AqutterPrintJobPageOrder.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterPrintJobPageOrder? byName(String? name) {
    if (name != null) {
      try {
        return AqutterPrintJobPageOrder.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterPrintJobPageOrder] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterPrintJobPageOrder> asNameMap() =>
      <String, AqutterPrintJobPageOrder>{
        for (final value in AqutterPrintJobPageOrder.values)
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
        return 'ASCENDING';
      case -1:
        return 'DESCENDING';
      case 0:
        return 'SPECIAL';
      case 2:
        return 'UNKNOWN';
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
