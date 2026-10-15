// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_type.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the type of action triggering a navigation for the [AqutterPlatformWebViewCreationParams.shouldOverrideUrlLoading] event.
class AqutterNavigationType {
  final String _value;
  final int? _nativeValue;
  const AqutterNavigationType._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterNavigationType._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterNavigationType._internal(value, nativeValue());

  ///An item from the back-forward list was requested.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationType.formSubmitted](https://developer.apple.com/documentation/webkit/wknavigationtype/formsubmitted))
  ///- macOS WKWebView ([Official API - WKNavigationType.formSubmitted](https://developer.apple.com/documentation/webkit/wknavigationtype/formsubmitted))
  ///- Windows WebView2 ([Official API - COREWEBVIEW2_NAVIGATION_KIND_BACK_OR_FORWARD](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2210.55#corewebview2_navigation_kind))
  static final BACK_FORWARD = AqutterNavigationType._internalMultiPlatform(
    'BACK_FORWARD',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          return 2;
        case TargetPlatform.macOS:
          return 2;
        case TargetPlatform.windows:
          return 1;
        default:
          break;
      }
      return null;
    },
  );

  ///A form was resubmitted (for example by going back, going forward, or reloading).
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationType.formSubmitted](https://developer.apple.com/documentation/webkit/wknavigationtype/formresubmitted))
  ///- macOS WKWebView ([Official API - WKNavigationType.formSubmitted](https://developer.apple.com/documentation/webkit/wknavigationtype/formresubmitted))
  static final FORM_RESUBMITTED = AqutterNavigationType._internalMultiPlatform(
    'FORM_RESUBMITTED',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          return 4;
        case TargetPlatform.macOS:
          return 4;
        default:
          break;
      }
      return null;
    },
  );

  ///A form was submitted.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationType.formSubmitted](https://developer.apple.com/documentation/webkit/wknavigationtype/formsubmitted))
  ///- macOS WKWebView ([Official API - WKNavigationType.formSubmitted](https://developer.apple.com/documentation/webkit/wknavigationtype/formsubmitted))
  static final FORM_SUBMITTED = AqutterNavigationType._internalMultiPlatform(
    'FORM_SUBMITTED',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          return 1;
        case TargetPlatform.macOS:
          return 1;
        default:
          break;
      }
      return null;
    },
  );

  ///A link with an href attribute was activated by the user.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationType.linkActivated](https://developer.apple.com/documentation/webkit/wknavigationtype/linkactivated))
  ///- macOS WKWebView ([Official API - WKNavigationType.linkActivated](https://developer.apple.com/documentation/webkit/wknavigationtype/linkactivated))
  ///- Windows WebView2
  static final LINK_ACTIVATED = AqutterNavigationType._internalMultiPlatform(
    'LINK_ACTIVATED',
    () {
      switch (defaultTargetPlatform) {
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

  ///Navigation is taking place for some other reason.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationType.other](https://developer.apple.com/documentation/webkit/wknavigationtype/other))
  ///- macOS WKWebView ([Official API - WKNavigationType.other](https://developer.apple.com/documentation/webkit/wknavigationtype/other))
  ///- Windows WebView2
  static final OTHER = AqutterNavigationType._internalMultiPlatform(
    'OTHER',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          return -1;
        case TargetPlatform.macOS:
          return -1;
        case TargetPlatform.windows:
          return 3;
        default:
          break;
      }
      return null;
    },
  );

  ///The webpage was reloaded.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView ([Official API - WKNavigationType.reload](https://developer.apple.com/documentation/webkit/wknavigationtype/reload))
  ///- macOS WKWebView ([Official API - WKNavigationType.reload](https://developer.apple.com/documentation/webkit/wknavigationtype/reload))
  ///- Windows WebView2 ([Official API - COREWEBVIEW2_NAVIGATION_KIND_RELOAD](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2210.55#corewebview2_navigation_kind))
  static final RELOAD = AqutterNavigationType._internalMultiPlatform(
    'RELOAD',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          return 3;
        case TargetPlatform.macOS:
          return 3;
        case TargetPlatform.windows:
          return 2;
        default:
          break;
      }
      return null;
    },
  );

  ///Set of all values of [AqutterNavigationType].
  static final Set<AqutterNavigationType> values = [
    AqutterNavigationType.BACK_FORWARD,
    AqutterNavigationType.FORM_RESUBMITTED,
    AqutterNavigationType.FORM_SUBMITTED,
    AqutterNavigationType.LINK_ACTIVATED,
    AqutterNavigationType.OTHER,
    AqutterNavigationType.RELOAD,
  ].toSet();

  ///Gets a possible [AqutterNavigationType] instance from [String] value.
  static AqutterNavigationType? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterNavigationType.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterNavigationType] instance from a native value.
  static AqutterNavigationType? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterNavigationType.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterNavigationType] instance value with name [name].
  ///
  /// Goes through [AqutterNavigationType.values] looking for a value with
  /// name [name], as reported by [AqutterNavigationType.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterNavigationType? byName(String? name) {
    if (name != null) {
      try {
        return AqutterNavigationType.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterNavigationType] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterNavigationType> asNameMap() =>
      <String, AqutterNavigationType>{
        for (final value in AqutterNavigationType.values) value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'BACK_FORWARD':
        return 'BACK_FORWARD';
      case 'FORM_RESUBMITTED':
        return 'FORM_RESUBMITTED';
      case 'FORM_SUBMITTED':
        return 'FORM_SUBMITTED';
      case 'LINK_ACTIVATED':
        return 'LINK_ACTIVATED';
      case 'OTHER':
        return 'OTHER';
      case 'RELOAD':
        return 'RELOAD';
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

///Class that represents the type of action triggering a navigation on iOS for the [AqutterPlatformWebViewCreationParams.shouldOverrideUrlLoading] event.
///Use [AqutterNavigationType] instead.
@Deprecated('Use AqutterNavigationType instead')
class AqutterIOSWKNavigationType {
  final int _value;
  final int? _nativeValue;
  const AqutterIOSWKNavigationType._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterIOSWKNavigationType._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterIOSWKNavigationType._internal(value, nativeValue());

  ///An item from the back-forward list was requested.
  static const BACK_FORWARD = AqutterIOSWKNavigationType._internal(2, 2);

  ///A form was resubmitted (for example by going back, going forward, or reloading).
  static const FORM_RESUBMITTED = AqutterIOSWKNavigationType._internal(4, 4);

  ///A form was submitted.
  static const FORM_SUBMITTED = AqutterIOSWKNavigationType._internal(1, 1);

  ///A link with an href attribute was activated by the user.
  static const LINK_ACTIVATED = AqutterIOSWKNavigationType._internal(0, 0);

  ///Navigation is taking place for some other reason.
  static const OTHER = AqutterIOSWKNavigationType._internal(-1, -1);

  ///The webpage was reloaded.
  static const RELOAD = AqutterIOSWKNavigationType._internal(3, 3);

  ///Set of all values of [AqutterIOSWKNavigationType].
  static final Set<AqutterIOSWKNavigationType> values = [
    AqutterIOSWKNavigationType.BACK_FORWARD,
    AqutterIOSWKNavigationType.FORM_RESUBMITTED,
    AqutterIOSWKNavigationType.FORM_SUBMITTED,
    AqutterIOSWKNavigationType.LINK_ACTIVATED,
    AqutterIOSWKNavigationType.OTHER,
    AqutterIOSWKNavigationType.RELOAD,
  ].toSet();

  ///Gets a possible [AqutterIOSWKNavigationType] instance from [int] value.
  static AqutterIOSWKNavigationType? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSWKNavigationType.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterIOSWKNavigationType] instance from a native value.
  static AqutterIOSWKNavigationType? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterIOSWKNavigationType.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterIOSWKNavigationType] instance value with name [name].
  ///
  /// Goes through [AqutterIOSWKNavigationType.values] looking for a value with
  /// name [name], as reported by [AqutterIOSWKNavigationType.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterIOSWKNavigationType? byName(String? name) {
    if (name != null) {
      try {
        return AqutterIOSWKNavigationType.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterIOSWKNavigationType] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterIOSWKNavigationType> asNameMap() =>
      <String, AqutterIOSWKNavigationType>{
        for (final value in AqutterIOSWKNavigationType.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 2:
        return 'BACK_FORWARD';
      case 4:
        return 'FORM_RESUBMITTED';
      case 1:
        return 'FORM_SUBMITTED';
      case 0:
        return 'LINK_ACTIVATED';
      case -1:
        return 'OTHER';
      case 3:
        return 'RELOAD';
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
