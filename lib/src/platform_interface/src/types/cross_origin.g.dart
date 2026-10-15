// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cross_origin.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the `crossorigin` content attribute on media elements, which is a CORS settings attribute.
///It could be used with [AqutterScriptHtmlTagAttributes] and [AqutterCSSLinkHtmlTagAttributes]
///when fetching a resource `<link>` or a `<script>` (or resources fetched by the `<script>`).
class AqutterCrossOrigin {
  final String _value;
  final String? _nativeValue;
  const AqutterCrossOrigin._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterCrossOrigin._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterCrossOrigin._internal(value, nativeValue());

  ///CORS requests for this element will have the credentials flag set to 'same-origin'.
  static const ANONYMOUS = AqutterCrossOrigin._internal(
    'anonymous',
    'anonymous',
  );

  ///CORS requests for this element will have the credentials flag set to 'include'.
  static const USE_CREDENTIALS = AqutterCrossOrigin._internal(
    'use-credentials',
    'use-credentials',
  );

  ///Set of all values of [AqutterCrossOrigin].
  static final Set<AqutterCrossOrigin> values = [
    AqutterCrossOrigin.ANONYMOUS,
    AqutterCrossOrigin.USE_CREDENTIALS,
  ].toSet();

  ///Gets a possible [AqutterCrossOrigin] instance from [String] value.
  static AqutterCrossOrigin? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterCrossOrigin.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterCrossOrigin] instance from a native value.
  static AqutterCrossOrigin? fromNativeValue(String? value) {
    if (value != null) {
      try {
        return AqutterCrossOrigin.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterCrossOrigin] instance value with name [name].
  ///
  /// Goes through [AqutterCrossOrigin.values] looking for a value with
  /// name [name], as reported by [AqutterCrossOrigin.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterCrossOrigin? byName(String? name) {
    if (name != null) {
      try {
        return AqutterCrossOrigin.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterCrossOrigin] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterCrossOrigin> asNameMap() =>
      <String, AqutterCrossOrigin>{
        for (final value in AqutterCrossOrigin.values) value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'anonymous':
        return 'ANONYMOUS';
      case 'use-credentials':
        return 'USE_CREDENTIALS';
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
