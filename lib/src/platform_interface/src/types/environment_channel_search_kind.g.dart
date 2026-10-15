// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment_channel_search_kind.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///The channel search kind determines the order that release
///channels are searched for during [AqutterPlatformWebViewEnvironment] creation.
class AqutterEnvironmentChannelSearchKind {
  final int _value;
  final int? _nativeValue;
  const AqutterEnvironmentChannelSearchKind._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterEnvironmentChannelSearchKind._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterEnvironmentChannelSearchKind._internal(value, nativeValue());

  ///Search for a release channel from least to most stable: Canary -> Dev -> Beta -> WebView2 Runtime.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  static final LEAST_STABLE =
      AqutterEnvironmentChannelSearchKind._internalMultiPlatform(1, () {
        switch (defaultTargetPlatform) {
          case TargetPlatform.windows:
            return 1;
          default:
            break;
        }
        return null;
      });

  ///Search for a release channel from most to least stable: WebView2 Runtime -> Beta -> Dev -> Canary. This is the default behavior.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  static final MOST_STABLE =
      AqutterEnvironmentChannelSearchKind._internalMultiPlatform(0, () {
        switch (defaultTargetPlatform) {
          case TargetPlatform.windows:
            return 0;
          default:
            break;
        }
        return null;
      });

  ///Set of all values of [AqutterEnvironmentChannelSearchKind].
  static final Set<AqutterEnvironmentChannelSearchKind> values = [
    AqutterEnvironmentChannelSearchKind.LEAST_STABLE,
    AqutterEnvironmentChannelSearchKind.MOST_STABLE,
  ].toSet();

  ///Gets a possible [AqutterEnvironmentChannelSearchKind] instance from [int] value.
  static AqutterEnvironmentChannelSearchKind? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterEnvironmentChannelSearchKind.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterEnvironmentChannelSearchKind] instance from a native value.
  static AqutterEnvironmentChannelSearchKind? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterEnvironmentChannelSearchKind.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterEnvironmentChannelSearchKind] instance value with name [name].
  ///
  /// Goes through [AqutterEnvironmentChannelSearchKind.values] looking for a value with
  /// name [name], as reported by [AqutterEnvironmentChannelSearchKind.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterEnvironmentChannelSearchKind? byName(String? name) {
    if (name != null) {
      try {
        return AqutterEnvironmentChannelSearchKind.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterEnvironmentChannelSearchKind] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterEnvironmentChannelSearchKind> asNameMap() =>
      <String, AqutterEnvironmentChannelSearchKind>{
        for (final value in AqutterEnvironmentChannelSearchKind.values)
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
        return 'LEAST_STABLE';
      case 0:
        return 'MOST_STABLE';
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
