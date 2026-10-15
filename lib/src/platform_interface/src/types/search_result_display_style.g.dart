// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_display_style.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Constants that describe the results summary the find panel UI includes.
class AqutterSearchResultDisplayStyle {
  final int _value;
  final int? _nativeValue;
  const AqutterSearchResultDisplayStyle._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterSearchResultDisplayStyle._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterSearchResultDisplayStyle._internal(value, nativeValue());

  ///The find panel includes the total number of results the session reports and the index of the target result.
  static const CURRENT_AND_TOTAL = AqutterSearchResultDisplayStyle._internal(
    0,
    0,
  );

  ///The find panel doesn’t include the number of results the session reports.
  static const NONE = AqutterSearchResultDisplayStyle._internal(2, 2);

  ///The find panel includes the total number of results the session reports.
  static const TOTAL = AqutterSearchResultDisplayStyle._internal(1, 1);

  ///Set of all values of [AqutterSearchResultDisplayStyle].
  static final Set<AqutterSearchResultDisplayStyle> values = [
    AqutterSearchResultDisplayStyle.CURRENT_AND_TOTAL,
    AqutterSearchResultDisplayStyle.NONE,
    AqutterSearchResultDisplayStyle.TOTAL,
  ].toSet();

  ///Gets a possible [AqutterSearchResultDisplayStyle] instance from [int] value.
  static AqutterSearchResultDisplayStyle? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterSearchResultDisplayStyle.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterSearchResultDisplayStyle] instance from a native value.
  static AqutterSearchResultDisplayStyle? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterSearchResultDisplayStyle.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterSearchResultDisplayStyle] instance value with name [name].
  ///
  /// Goes through [AqutterSearchResultDisplayStyle.values] looking for a value with
  /// name [name], as reported by [AqutterSearchResultDisplayStyle.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterSearchResultDisplayStyle? byName(String? name) {
    if (name != null) {
      try {
        return AqutterSearchResultDisplayStyle.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterSearchResultDisplayStyle] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterSearchResultDisplayStyle> asNameMap() =>
      <String, AqutterSearchResultDisplayStyle>{
        for (final value in AqutterSearchResultDisplayStyle.values)
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
        return 'CURRENT_AND_TOTAL';
      case 2:
        return 'NONE';
      case 1:
        return 'TOTAL';
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
