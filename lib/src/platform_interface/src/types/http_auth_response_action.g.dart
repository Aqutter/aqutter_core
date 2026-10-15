// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_auth_response_action.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used by [AqutterHttpAuthResponse] class.
class AqutterHttpAuthResponseAction {
  final int _value;
  final int? _nativeValue;
  const AqutterHttpAuthResponseAction._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterHttpAuthResponseAction._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterHttpAuthResponseAction._internal(value, nativeValue());

  ///Instructs the WebView to cancel the authentication request.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  static final CANCEL = AqutterHttpAuthResponseAction._internalMultiPlatform(
    0,
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return 0;
        case TargetPlatform.iOS:
          return 0;
        case TargetPlatform.macOS:
          return 0;
        case TargetPlatform.windows:
          return 0;
        default:
          break;
      }
      return null;
    },
  );

  ///Instructs the WebView to proceed with the authentication with the given credentials.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  static final PROCEED = AqutterHttpAuthResponseAction._internalMultiPlatform(
    1,
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return 1;
        case TargetPlatform.iOS:
          return 1;
        case TargetPlatform.macOS:
          return 1;
        case TargetPlatform.windows:
          return 1;
        default:
          break;
      }
      return null;
    },
  );

  ///Uses the credentials stored for the current host.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  static final USE_SAVED_HTTP_AUTH_CREDENTIALS =
      AqutterHttpAuthResponseAction._internalMultiPlatform(2, () {
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            return 2;
          case TargetPlatform.iOS:
            return 2;
          case TargetPlatform.macOS:
            return 2;
          default:
            break;
        }
        return null;
      });

  ///Set of all values of [AqutterHttpAuthResponseAction].
  static final Set<AqutterHttpAuthResponseAction> values = [
    AqutterHttpAuthResponseAction.CANCEL,
    AqutterHttpAuthResponseAction.PROCEED,
    AqutterHttpAuthResponseAction.USE_SAVED_HTTP_AUTH_CREDENTIALS,
  ].toSet();

  ///Gets a possible [AqutterHttpAuthResponseAction] instance from [int] value.
  static AqutterHttpAuthResponseAction? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterHttpAuthResponseAction.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterHttpAuthResponseAction] instance from a native value.
  static AqutterHttpAuthResponseAction? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterHttpAuthResponseAction.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterHttpAuthResponseAction] instance value with name [name].
  ///
  /// Goes through [AqutterHttpAuthResponseAction.values] looking for a value with
  /// name [name], as reported by [AqutterHttpAuthResponseAction.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterHttpAuthResponseAction? byName(String? name) {
    if (name != null) {
      try {
        return AqutterHttpAuthResponseAction.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterHttpAuthResponseAction] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterHttpAuthResponseAction> asNameMap() =>
      <String, AqutterHttpAuthResponseAction>{
        for (final value in AqutterHttpAuthResponseAction.values)
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
      case 1:
        return 'PROCEED';
      case 2:
        return 'USE_SAVED_HTTP_AUTH_CREDENTIALS';
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
