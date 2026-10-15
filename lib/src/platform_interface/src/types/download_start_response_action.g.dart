// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_start_response_action.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class representing the action of a [AqutterDownloadStartResponse].
class AqutterDownloadStartResponseAction {
  final int _value;
  final int? _nativeValue;
  const AqutterDownloadStartResponseAction._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterDownloadStartResponseAction._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterDownloadStartResponseAction._internal(value, nativeValue());

  ///Cancel the download.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///- Linux WPE WebKit
  static final CANCEL =
      AqutterDownloadStartResponseAction._internalMultiPlatform(0, () {
        switch (defaultTargetPlatform) {
          case TargetPlatform.windows:
            return 0;
          case TargetPlatform.linux:
            return 0;
          default:
            break;
        }
        return null;
      });

  ///Set of all values of [AqutterDownloadStartResponseAction].
  static final Set<AqutterDownloadStartResponseAction> values = [
    AqutterDownloadStartResponseAction.CANCEL,
  ].toSet();

  ///Gets a possible [AqutterDownloadStartResponseAction] instance from [int] value.
  static AqutterDownloadStartResponseAction? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterDownloadStartResponseAction.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterDownloadStartResponseAction] instance from a native value.
  static AqutterDownloadStartResponseAction? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterDownloadStartResponseAction.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterDownloadStartResponseAction] instance value with name [name].
  ///
  /// Goes through [AqutterDownloadStartResponseAction.values] looking for a value with
  /// name [name], as reported by [AqutterDownloadStartResponseAction.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterDownloadStartResponseAction? byName(String? name) {
    if (name != null) {
      try {
        return AqutterDownloadStartResponseAction.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterDownloadStartResponseAction] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterDownloadStartResponseAction> asNameMap() =>
      <String, AqutterDownloadStartResponseAction>{
        for (final value in AqutterDownloadStartResponseAction.values)
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
        return 'CANCEL';
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
