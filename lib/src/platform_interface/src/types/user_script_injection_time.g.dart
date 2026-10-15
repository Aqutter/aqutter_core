// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_script_injection_time.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents contains the constants for the times at which to inject script content into a `WebView` used by an [AqutterUserScript].
class AqutterUserScriptInjectionTime {
  final int _value;
  final int? _nativeValue;
  const AqutterUserScriptInjectionTime._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterUserScriptInjectionTime._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterUserScriptInjectionTime._internal(value, nativeValue());

  ///**NOTE for iOS**: A constant to inject the script after the document finishes loading, but before loading any other subresources.
  ///
  ///**NOTE for Android**: A constant to inject the script as soon as the page finishes loading.
  static const AT_DOCUMENT_END = AqutterUserScriptInjectionTime._internal(1, 1);

  ///**NOTE for iOS**: A constant to inject the script after the creation of the webpage’s document element, but before loading any other content.
  ///
  ///**NOTE for Android**: A constant to try to inject the script as soon as the page starts loading.
  static const AT_DOCUMENT_START = AqutterUserScriptInjectionTime._internal(
    0,
    0,
  );

  ///Set of all values of [AqutterUserScriptInjectionTime].
  static final Set<AqutterUserScriptInjectionTime> values = [
    AqutterUserScriptInjectionTime.AT_DOCUMENT_END,
    AqutterUserScriptInjectionTime.AT_DOCUMENT_START,
  ].toSet();

  ///Gets a possible [AqutterUserScriptInjectionTime] instance from [int] value.
  static AqutterUserScriptInjectionTime? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterUserScriptInjectionTime.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterUserScriptInjectionTime] instance from a native value.
  static AqutterUserScriptInjectionTime? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterUserScriptInjectionTime.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterUserScriptInjectionTime] instance value with name [name].
  ///
  /// Goes through [AqutterUserScriptInjectionTime.values] looking for a value with
  /// name [name], as reported by [AqutterUserScriptInjectionTime.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterUserScriptInjectionTime? byName(String? name) {
    if (name != null) {
      try {
        return AqutterUserScriptInjectionTime.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterUserScriptInjectionTime] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterUserScriptInjectionTime> asNameMap() =>
      <String, AqutterUserScriptInjectionTime>{
        for (final value in AqutterUserScriptInjectionTime.values)
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
        return 'AT_DOCUMENT_END';
      case 0:
        return 'AT_DOCUMENT_START';
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
