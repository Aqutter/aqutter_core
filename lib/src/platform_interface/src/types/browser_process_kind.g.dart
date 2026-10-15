// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_process_kind.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Indicates the process type used in the [AqutterBrowserProcessInfo] interface.
class AqutterBrowserProcessKind {
  final int _value;
  final int? _nativeValue;
  const AqutterBrowserProcessKind._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterBrowserProcessKind._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterBrowserProcessKind._internal(value, nativeValue());

  ///Indicates the browser process kind.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  static final BROWSER = AqutterBrowserProcessKind._internalMultiPlatform(
    0,
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.windows:
          return 0;
        default:
          break;
      }
      return null;
    },
  );

  ///Indicates the GPU process kind.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  static final GPU = AqutterBrowserProcessKind._internalMultiPlatform(4, () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.windows:
        return 4;
      default:
        break;
    }
    return null;
  });

  ///Indicates the PPAPI plugin broker process kind.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  static final PPAPI_BROKER = AqutterBrowserProcessKind._internalMultiPlatform(
    6,
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.windows:
          return 6;
        default:
          break;
      }
      return null;
    },
  );

  ///Indicates the PPAPI plugin process kind.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  static final PPAPI_PLUGIN = AqutterBrowserProcessKind._internalMultiPlatform(
    5,
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.windows:
          return 5;
        default:
          break;
      }
      return null;
    },
  );

  ///Indicates the render process kind.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  static final RENDERER = AqutterBrowserProcessKind._internalMultiPlatform(
    1,
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

  ///Indicates the sandbox helper process kind.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  static final SANDBOX_HELPER =
      AqutterBrowserProcessKind._internalMultiPlatform(3, () {
        switch (defaultTargetPlatform) {
          case TargetPlatform.windows:
            return 3;
          default:
            break;
        }
        return null;
      });

  ///Indicates the utility process kind.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  static final UTILITY = AqutterBrowserProcessKind._internalMultiPlatform(
    2,
    () {
      switch (defaultTargetPlatform) {
        case TargetPlatform.windows:
          return 2;
        default:
          break;
      }
      return null;
    },
  );

  ///Set of all values of [AqutterBrowserProcessKind].
  static final Set<AqutterBrowserProcessKind> values = [
    AqutterBrowserProcessKind.BROWSER,
    AqutterBrowserProcessKind.GPU,
    AqutterBrowserProcessKind.PPAPI_BROKER,
    AqutterBrowserProcessKind.PPAPI_PLUGIN,
    AqutterBrowserProcessKind.RENDERER,
    AqutterBrowserProcessKind.SANDBOX_HELPER,
    AqutterBrowserProcessKind.UTILITY,
  ].toSet();

  ///Gets a possible [AqutterBrowserProcessKind] instance from [int] value.
  static AqutterBrowserProcessKind? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterBrowserProcessKind.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return AqutterBrowserProcessKind._internal(value, value);
      }
    }
    return null;
  }

  ///Gets a possible [AqutterBrowserProcessKind] instance from a native value.
  static AqutterBrowserProcessKind? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterBrowserProcessKind.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterBrowserProcessKind] instance value with name [name].
  ///
  /// Goes through [AqutterBrowserProcessKind.values] looking for a value with
  /// name [name], as reported by [AqutterBrowserProcessKind.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterBrowserProcessKind? byName(String? name) {
    if (name != null) {
      try {
        return AqutterBrowserProcessKind.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterBrowserProcessKind] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterBrowserProcessKind> asNameMap() =>
      <String, AqutterBrowserProcessKind>{
        for (final value in AqutterBrowserProcessKind.values)
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
        return 'BROWSER';
      case 4:
        return 'GPU';
      case 6:
        return 'PPAPI_BROKER';
      case 5:
        return 'PPAPI_PLUGIN';
      case 1:
        return 'RENDERER';
      case 3:
        return 'SANDBOX_HELPER';
      case 2:
        return 'UTILITY';
    }
    return _value.toString();
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(value) => value == _value;

  AqutterBrowserProcessKind operator |(AqutterBrowserProcessKind value) =>
      AqutterBrowserProcessKind._internal(
        value.toValue() | _value,
        value.toNativeValue() != null && _nativeValue != null
            ? value.toNativeValue()! | _nativeValue!
            : null,
      );

  ///Checks if the value is supported by the [defaultTargetPlatform].
  bool isSupported() {
    return _nativeValue != null;
  }

  @override
  String toString() {
    return name();
  }
}
