// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_resubmission_action.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the action to take used by the [AqutterPlatformWebViewCreationParams.onFormResubmission] event.
class AqutterFormResubmissionAction {
  final int _value;
  final int? _nativeValue;
  const AqutterFormResubmissionAction._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterFormResubmissionAction._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterFormResubmissionAction._internal(value, nativeValue());

  ///Don't resend data
  static const DONT_RESEND = AqutterFormResubmissionAction._internal(1, 1);

  ///Resend data
  static const RESEND = AqutterFormResubmissionAction._internal(0, 0);

  ///Set of all values of [AqutterFormResubmissionAction].
  static final Set<AqutterFormResubmissionAction> values = [
    AqutterFormResubmissionAction.DONT_RESEND,
    AqutterFormResubmissionAction.RESEND,
  ].toSet();

  ///Gets a possible [AqutterFormResubmissionAction] instance from [int] value.
  static AqutterFormResubmissionAction? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterFormResubmissionAction.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterFormResubmissionAction] instance from a native value.
  static AqutterFormResubmissionAction? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterFormResubmissionAction.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterFormResubmissionAction] instance value with name [name].
  ///
  /// Goes through [AqutterFormResubmissionAction.values] looking for a value with
  /// name [name], as reported by [AqutterFormResubmissionAction.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterFormResubmissionAction? byName(String? name) {
    if (name != null) {
      try {
        return AqutterFormResubmissionAction.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterFormResubmissionAction] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterFormResubmissionAction> asNameMap() =>
      <String, AqutterFormResubmissionAction>{
        for (final value in AqutterFormResubmissionAction.values)
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
        return 'DONT_RESEND';
      case 0:
        return 'RESEND';
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
