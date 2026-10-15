// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_blocker_action_type.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the kind of action that can be used with a [AqutterContentBlockerTrigger].
class AqutterContentBlockerActionType {
  final String _value;
  final String? _nativeValue;
  const AqutterContentBlockerActionType._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterContentBlockerActionType._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterContentBlockerActionType._internal(value, nativeValue());

  ///Stops loading of the resource. If the resource was cached, the cache is ignored.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  static final BLOCK = AqutterContentBlockerActionType._internalMultiPlatform(
    'block',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return 'block';
        case TargetPlatform.iOS:
          return 'block';
        case TargetPlatform.macOS:
          return 'block';
        case TargetPlatform.linux:
          return 'block';
        default:
          break;
      }
      return null;
    },
  );

  ///Strips cookies from the header before sending it to the server.
  ///This only blocks cookies otherwise acceptable to WebView's privacy policy.
  ///Combining with [IGNORE_PREVIOUS_RULES] doesn't override the browser’s privacy settings.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  static final BLOCK_COOKIES =
      AqutterContentBlockerActionType._internalMultiPlatform(
        'block-cookies',
        () {
          switch (defaultTargetPlatform) {
            case TargetPlatform.iOS:
              return 'block-cookies';
            case TargetPlatform.macOS:
              return 'block-cookies';
            case TargetPlatform.linux:
              return 'block-cookies';
            default:
              break;
          }
          return null;
        },
      );

  ///Hides elements of the page based on a CSS selector.
  ///A selector field contains the selector list.
  ///Any matching element has its display property set to none, which hides it.
  ///
  ///**NOTE**: on Android, JavaScript must be enabled.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  static final CSS_DISPLAY_NONE =
      AqutterContentBlockerActionType._internalMultiPlatform(
        'css-display-none',
        () {
          switch (defaultTargetPlatform) {
            case TargetPlatform.android:
              return 'css-display-none';
            case TargetPlatform.iOS:
              return 'css-display-none';
            case TargetPlatform.macOS:
              return 'css-display-none';
            case TargetPlatform.linux:
              return 'css-display-none';
            default:
              break;
          }
          return null;
        },
      );

  ///Ignores previously triggered actions.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  static final IGNORE_PREVIOUS_RULES =
      AqutterContentBlockerActionType._internalMultiPlatform(
        'ignore-previous-rules',
        () {
          switch (defaultTargetPlatform) {
            case TargetPlatform.iOS:
              return 'ignore-previous-rules';
            case TargetPlatform.macOS:
              return 'ignore-previous-rules';
            case TargetPlatform.linux:
              return 'ignore-previous-rules';
            default:
              break;
          }
          return null;
        },
      );

  ///Changes a URL from http to https.
  ///URLs with a specified (nondefault) port and links using other protocols are unaffected.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Linux WPE WebKit
  static final MAKE_HTTPS =
      AqutterContentBlockerActionType._internalMultiPlatform('make-https', () {
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            return 'make-https';
          case TargetPlatform.iOS:
            return 'make-https';
          case TargetPlatform.macOS:
            return 'make-https';
          case TargetPlatform.linux:
            return 'make-https';
          default:
            break;
        }
        return null;
      });

  ///Set of all values of [AqutterContentBlockerActionType].
  static final Set<AqutterContentBlockerActionType> values = [
    AqutterContentBlockerActionType.BLOCK,
    AqutterContentBlockerActionType.BLOCK_COOKIES,
    AqutterContentBlockerActionType.CSS_DISPLAY_NONE,
    AqutterContentBlockerActionType.IGNORE_PREVIOUS_RULES,
    AqutterContentBlockerActionType.MAKE_HTTPS,
  ].toSet();

  ///Gets a possible [AqutterContentBlockerActionType] instance from [String] value.
  static AqutterContentBlockerActionType? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterContentBlockerActionType.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterContentBlockerActionType] instance from a native value.
  static AqutterContentBlockerActionType? fromNativeValue(String? value) {
    if (value != null) {
      try {
        return AqutterContentBlockerActionType.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterContentBlockerActionType] instance value with name [name].
  ///
  /// Goes through [AqutterContentBlockerActionType.values] looking for a value with
  /// name [name], as reported by [AqutterContentBlockerActionType.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterContentBlockerActionType? byName(String? name) {
    if (name != null) {
      try {
        return AqutterContentBlockerActionType.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterContentBlockerActionType] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterContentBlockerActionType> asNameMap() =>
      <String, AqutterContentBlockerActionType>{
        for (final value in AqutterContentBlockerActionType.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'block':
        return 'BLOCK';
      case 'block-cookies':
        return 'BLOCK_COOKIES';
      case 'css-display-none':
        return 'CSS_DISPLAY_NONE';
      case 'ignore-previous-rules':
        return 'IGNORE_PREVIOUS_RULES';
      case 'make-https':
        return 'MAKE_HTTPS';
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
