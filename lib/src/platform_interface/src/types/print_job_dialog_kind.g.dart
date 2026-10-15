// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_job_dialog_kind.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class representing the print dialog kind used by a [AqutterPlatformPrintJobController].
class AqutterPrintJobDialogKind {
  final int _value;
  final int? _nativeValue;
  const AqutterPrintJobDialogKind._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterPrintJobDialogKind._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterPrintJobDialogKind._internal(value, nativeValue());

  ///Use the browser print dialog UI.
  static const BROWSER = AqutterPrintJobDialogKind._internal(0, 0);

  ///Use the system print dialog UI.
  static const SYSTEM = AqutterPrintJobDialogKind._internal(1, 1);

  ///Set of all values of [AqutterPrintJobDialogKind].
  static final Set<AqutterPrintJobDialogKind> values = [
    AqutterPrintJobDialogKind.BROWSER,
    AqutterPrintJobDialogKind.SYSTEM,
  ].toSet();

  ///Gets a possible [AqutterPrintJobDialogKind] instance from [int] value.
  static AqutterPrintJobDialogKind? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterPrintJobDialogKind.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterPrintJobDialogKind] instance from a native value.
  static AqutterPrintJobDialogKind? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterPrintJobDialogKind.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterPrintJobDialogKind] instance value with name [name].
  ///
  /// Goes through [AqutterPrintJobDialogKind.values] looking for a value with
  /// name [name], as reported by [AqutterPrintJobDialogKind.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterPrintJobDialogKind? byName(String? name) {
    if (name != null) {
      try {
        return AqutterPrintJobDialogKind.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterPrintJobDialogKind] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterPrintJobDialogKind> asNameMap() =>
      <String, AqutterPrintJobDialogKind>{
        for (final value in AqutterPrintJobDialogKind.values)
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
        return 'BROWSER';
      case 1:
        return 'SYSTEM';
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
