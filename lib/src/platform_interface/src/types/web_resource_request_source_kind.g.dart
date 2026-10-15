// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_resource_request_source_kind.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Constants that describe the source kinds for web resource requests.
class AqutterWebResourceRequestSourceKind {
  final int _value;
  final int? _nativeValue;
  const AqutterWebResourceRequestSourceKind._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterWebResourceRequestSourceKind._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterWebResourceRequestSourceKind._internal(value, nativeValue());

  ///All request source kinds.
  static const ALL = AqutterWebResourceRequestSourceKind._internal(
    4294967295,
    4294967295,
  );

  ///Request originated from a document.
  static const DOCUMENT = AqutterWebResourceRequestSourceKind._internal(1, 1);

  ///No request source kind.
  static const NONE = AqutterWebResourceRequestSourceKind._internal(0, 0);

  ///Request originated from a service worker.
  static const SERVICE_WORKER = AqutterWebResourceRequestSourceKind._internal(
    4,
    4,
  );

  ///Request originated from a shared worker.
  static const SHARED_WORKER = AqutterWebResourceRequestSourceKind._internal(
    2,
    2,
  );

  ///Set of all values of [AqutterWebResourceRequestSourceKind].
  static final Set<AqutterWebResourceRequestSourceKind> values = [
    AqutterWebResourceRequestSourceKind.ALL,
    AqutterWebResourceRequestSourceKind.DOCUMENT,
    AqutterWebResourceRequestSourceKind.NONE,
    AqutterWebResourceRequestSourceKind.SERVICE_WORKER,
    AqutterWebResourceRequestSourceKind.SHARED_WORKER,
  ].toSet();

  ///Gets a possible [AqutterWebResourceRequestSourceKind] instance from [int] value.
  static AqutterWebResourceRequestSourceKind? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterWebResourceRequestSourceKind.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterWebResourceRequestSourceKind] instance from a native value.
  static AqutterWebResourceRequestSourceKind? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterWebResourceRequestSourceKind.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterWebResourceRequestSourceKind] instance value with name [name].
  ///
  /// Goes through [AqutterWebResourceRequestSourceKind.values] looking for a value with
  /// name [name], as reported by [AqutterWebResourceRequestSourceKind.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterWebResourceRequestSourceKind? byName(String? name) {
    if (name != null) {
      try {
        return AqutterWebResourceRequestSourceKind.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterWebResourceRequestSourceKind] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterWebResourceRequestSourceKind> asNameMap() =>
      <String, AqutterWebResourceRequestSourceKind>{
        for (final value in AqutterWebResourceRequestSourceKind.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 4294967295:
        return 'ALL';
      case 1:
        return 'DOCUMENT';
      case 0:
        return 'NONE';
      case 4:
        return 'SERVICE_WORKER';
      case 2:
        return 'SHARED_WORKER';
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
