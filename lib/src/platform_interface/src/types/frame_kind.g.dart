// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame_kind.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to indicate the the frame kind.
class AqutterFrameKind {
  final String _value;
  final int? _nativeValue;
  const AqutterFrameKind._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterFrameKind._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterFrameKind._internal(value, nativeValue());

  ///Indicates that the frame is an embed element.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - COREWEBVIEW2_FRAME_KIND_EMBED](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2849.39#corewebview2_frame_kind))
  static final EMBED = AqutterFrameKind._internalMultiPlatform('EMBED', () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.windows:
        return 3;
      default:
        break;
    }
    return null;
  });

  ///Indicates that the frame is an iframe.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - COREWEBVIEW2_FRAME_KIND_IFRAME](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2849.39#corewebview2_frame_kind))
  static final IFRAME = AqutterFrameKind._internalMultiPlatform('IFRAME', () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.windows:
        return 2;
      default:
        break;
    }
    return null;
  });

  ///Indicates that the frame is a primary main frame(webview).
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - COREWEBVIEW2_FRAME_KIND_MAIN_FRAME](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2849.39#corewebview2_frame_kind))
  static final MAIN_FRAME = AqutterFrameKind._internalMultiPlatform(
    'MAIN_FRAME',
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.windows:
          return 1;
        default:
          break;
      }
      return null;
    },
  );

  ///Indicates that the frame is an object element.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - COREWEBVIEW2_FRAME_KIND_OBJECT](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2849.39#corewebview2_frame_kind))
  static final OBJECT = AqutterFrameKind._internalMultiPlatform('OBJECT', () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.windows:
        return 4;
      default:
        break;
    }
    return null;
  });

  ///Indicates that the frame is an unknown type frame. We may extend this enum type to identify more frame kinds in the future.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - COREWEBVIEW2_FRAME_KIND_UNKNOWN](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2849.39#corewebview2_frame_kind))
  static final UNKNOWN = AqutterFrameKind._internalMultiPlatform('UNKNOWN', () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.windows:
        return 0;
      default:
        break;
    }
    return null;
  });

  ///Set of all values of [AqutterFrameKind].
  static final Set<AqutterFrameKind> values = [
    AqutterFrameKind.EMBED,
    AqutterFrameKind.IFRAME,
    AqutterFrameKind.MAIN_FRAME,
    AqutterFrameKind.OBJECT,
    AqutterFrameKind.UNKNOWN,
  ].toSet();

  ///Gets a possible [AqutterFrameKind] instance from [String] value.
  static AqutterFrameKind? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterFrameKind.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterFrameKind] instance from a native value.
  static AqutterFrameKind? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterFrameKind.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterFrameKind] instance value with name [name].
  ///
  /// Goes through [AqutterFrameKind.values] looking for a value with
  /// name [name], as reported by [AqutterFrameKind.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterFrameKind? byName(String? name) {
    if (name != null) {
      try {
        return AqutterFrameKind.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterFrameKind] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterFrameKind> asNameMap() =>
      <String, AqutterFrameKind>{
        for (final value in AqutterFrameKind.values) value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'EMBED':
        return 'EMBED';
      case 'IFRAME':
        return 'IFRAME';
      case 'MAIN_FRAME':
        return 'MAIN_FRAME';
      case 'OBJECT':
        return 'OBJECT';
      case 'UNKNOWN':
        return 'UNKNOWN';
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
