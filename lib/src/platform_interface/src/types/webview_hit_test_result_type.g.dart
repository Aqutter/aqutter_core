// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webview_hit_test_result_type.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class representing the [AqutterWebViewHitTestResult] type.
class AqutterWebViewHitTestResultType {
  final int _value;
  final int? _nativeValue;
  const AqutterWebViewHitTestResultType._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterWebViewHitTestResultType._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterWebViewHitTestResultType._internal(value, nativeValue());

  ///[AqutterWebViewHitTestResult] for hitting an edit text area.
  static const EDIT_TEXT_TYPE = AqutterWebViewHitTestResultType._internal(9, 9);

  ///[AqutterWebViewHitTestResult] for hitting an email address.
  static const EMAIL_TYPE = AqutterWebViewHitTestResultType._internal(4, 4);

  ///[AqutterWebViewHitTestResult] for hitting a map address.
  static const GEO_TYPE = AqutterWebViewHitTestResultType._internal(3, 3);

  ///[AqutterWebViewHitTestResult] for hitting an HTML::img tag.
  static const IMAGE_TYPE = AqutterWebViewHitTestResultType._internal(5, 5);

  ///[AqutterWebViewHitTestResult] for hitting a phone number.
  static const PHONE_TYPE = AqutterWebViewHitTestResultType._internal(2, 2);

  ///[AqutterWebViewHitTestResult] for hitting a HTML::a tag with src=http.
  static const SRC_ANCHOR_TYPE = AqutterWebViewHitTestResultType._internal(
    7,
    7,
  );

  ///[AqutterWebViewHitTestResult] for hitting a HTML::a tag with src=http + HTML::img.
  static const SRC_IMAGE_ANCHOR_TYPE =
      AqutterWebViewHitTestResultType._internal(8, 8);

  ///Default [AqutterWebViewHitTestResult], where the target is unknown.
  static const UNKNOWN_TYPE = AqutterWebViewHitTestResultType._internal(0, 0);

  ///Set of all values of [AqutterWebViewHitTestResultType].
  static final Set<AqutterWebViewHitTestResultType> values = [
    AqutterWebViewHitTestResultType.EDIT_TEXT_TYPE,
    AqutterWebViewHitTestResultType.EMAIL_TYPE,
    AqutterWebViewHitTestResultType.GEO_TYPE,
    AqutterWebViewHitTestResultType.IMAGE_TYPE,
    AqutterWebViewHitTestResultType.PHONE_TYPE,
    AqutterWebViewHitTestResultType.SRC_ANCHOR_TYPE,
    AqutterWebViewHitTestResultType.SRC_IMAGE_ANCHOR_TYPE,
    AqutterWebViewHitTestResultType.UNKNOWN_TYPE,
  ].toSet();

  ///Gets a possible [AqutterWebViewHitTestResultType] instance from [int] value.
  static AqutterWebViewHitTestResultType? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterWebViewHitTestResultType.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterWebViewHitTestResultType] instance from a native value.
  static AqutterWebViewHitTestResultType? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterWebViewHitTestResultType.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterWebViewHitTestResultType] instance value with name [name].
  ///
  /// Goes through [AqutterWebViewHitTestResultType.values] looking for a value with
  /// name [name], as reported by [AqutterWebViewHitTestResultType.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterWebViewHitTestResultType? byName(String? name) {
    if (name != null) {
      try {
        return AqutterWebViewHitTestResultType.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterWebViewHitTestResultType] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterWebViewHitTestResultType> asNameMap() =>
      <String, AqutterWebViewHitTestResultType>{
        for (final value in AqutterWebViewHitTestResultType.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 9:
        return 'EDIT_TEXT_TYPE';
      case 4:
        return 'EMAIL_TYPE';
      case 3:
        return 'GEO_TYPE';
      case 5:
        return 'IMAGE_TYPE';
      case 2:
        return 'PHONE_TYPE';
      case 7:
        return 'SRC_ANCHOR_TYPE';
      case 8:
        return 'SRC_IMAGE_ANCHOR_TYPE';
      case 0:
        return 'UNKNOWN_TYPE';
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
