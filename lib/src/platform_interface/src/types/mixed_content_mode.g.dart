// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mixed_content_mode.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to configure the WebView's behavior when a secure origin attempts to load a resource from an insecure origin.
class AqutterMixedContentMode {
  final int _value;
  final int? _nativeValue;
  const AqutterMixedContentMode._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterMixedContentMode._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterMixedContentMode._internal(value, nativeValue());

  ///In this mode, the WebView will allow a secure origin to load content from any other origin, even if that origin is insecure.
  ///This is the least secure mode of operation for the WebView, and where possible apps should not set this mode.
  static const MIXED_CONTENT_ALWAYS_ALLOW = AqutterMixedContentMode._internal(
    0,
    0,
  );

  ///In this mode, the WebView will attempt to be compatible with the approach of a modern web browser with regard to mixed content.
  ///Some insecure content may be allowed to be loaded by a secure origin and other types of content will be blocked.
  ///The types of content are allowed or blocked may change release to release and are not explicitly defined.
  ///This mode is intended to be used by apps that are not in control of the content that they render but desire to operate in a reasonably secure environment.
  ///For highest security, apps are recommended to use [AqutterMixedContentMode.MIXED_CONTENT_NEVER_ALLOW].
  static const MIXED_CONTENT_COMPATIBILITY_MODE =
      AqutterMixedContentMode._internal(2, 2);

  ///In this mode, the WebView will not allow a secure origin to load content from an insecure origin.
  ///This is the preferred and most secure mode of operation for the WebView and apps are strongly advised to use this mode.
  static const MIXED_CONTENT_NEVER_ALLOW = AqutterMixedContentMode._internal(
    1,
    1,
  );

  ///Set of all values of [AqutterMixedContentMode].
  static final Set<AqutterMixedContentMode> values = [
    AqutterMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
    AqutterMixedContentMode.MIXED_CONTENT_COMPATIBILITY_MODE,
    AqutterMixedContentMode.MIXED_CONTENT_NEVER_ALLOW,
  ].toSet();

  ///Gets a possible [AqutterMixedContentMode] instance from [int] value.
  static AqutterMixedContentMode? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterMixedContentMode.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterMixedContentMode] instance from a native value.
  static AqutterMixedContentMode? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterMixedContentMode.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterMixedContentMode] instance value with name [name].
  ///
  /// Goes through [AqutterMixedContentMode.values] looking for a value with
  /// name [name], as reported by [AqutterMixedContentMode.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterMixedContentMode? byName(String? name) {
    if (name != null) {
      try {
        return AqutterMixedContentMode.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterMixedContentMode] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterMixedContentMode> asNameMap() =>
      <String, AqutterMixedContentMode>{
        for (final value in AqutterMixedContentMode.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 0:
        return 'MIXED_CONTENT_ALWAYS_ALLOW';
      case 2:
        return 'MIXED_CONTENT_COMPATIBILITY_MODE';
      case 1:
        return 'MIXED_CONTENT_NEVER_ALLOW';
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

///An Android-specific class used to configure the WebView's behavior when a secure origin attempts to load a resource from an insecure origin.
///
///**NOTE**: available on Android 21+.
///
///Use [AqutterMixedContentMode] instead.
@Deprecated('Use AqutterMixedContentMode instead')
class AqutterAndroidMixedContentMode {
  final int _value;
  final int? _nativeValue;
  const AqutterAndroidMixedContentMode._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterAndroidMixedContentMode._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterAndroidMixedContentMode._internal(value, nativeValue());

  ///In this mode, the WebView will allow a secure origin to load content from any other origin, even if that origin is insecure.
  ///This is the least secure mode of operation for the WebView, and where possible apps should not set this mode.
  static const MIXED_CONTENT_ALWAYS_ALLOW =
      AqutterAndroidMixedContentMode._internal(0, 0);

  ///In this mode, the WebView will attempt to be compatible with the approach of a modern web browser with regard to mixed content.
  ///Some insecure content may be allowed to be loaded by a secure origin and other types of content will be blocked.
  ///The types of content are allowed or blocked may change release to release and are not explicitly defined.
  ///This mode is intended to be used by apps that are not in control of the content that they render but desire to operate in a reasonably secure environment.
  ///For highest security, apps are recommended to use [AqutterAndroidMixedContentMode.MIXED_CONTENT_NEVER_ALLOW].
  static const MIXED_CONTENT_COMPATIBILITY_MODE =
      AqutterAndroidMixedContentMode._internal(2, 2);

  ///In this mode, the WebView will not allow a secure origin to load content from an insecure origin.
  ///This is the preferred and most secure mode of operation for the WebView and apps are strongly advised to use this mode.
  static const MIXED_CONTENT_NEVER_ALLOW =
      AqutterAndroidMixedContentMode._internal(1, 1);

  ///Set of all values of [AqutterAndroidMixedContentMode].
  static final Set<AqutterAndroidMixedContentMode> values = [
    AqutterAndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
    AqutterAndroidMixedContentMode.MIXED_CONTENT_COMPATIBILITY_MODE,
    AqutterAndroidMixedContentMode.MIXED_CONTENT_NEVER_ALLOW,
  ].toSet();

  ///Gets a possible [AqutterAndroidMixedContentMode] instance from [int] value.
  static AqutterAndroidMixedContentMode? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidMixedContentMode.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAndroidMixedContentMode] instance from a native value.
  static AqutterAndroidMixedContentMode? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidMixedContentMode.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAndroidMixedContentMode] instance value with name [name].
  ///
  /// Goes through [AqutterAndroidMixedContentMode.values] looking for a value with
  /// name [name], as reported by [AqutterAndroidMixedContentMode.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAndroidMixedContentMode? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAndroidMixedContentMode.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAndroidMixedContentMode] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAndroidMixedContentMode> asNameMap() =>
      <String, AqutterAndroidMixedContentMode>{
        for (final value in AqutterAndroidMixedContentMode.values)
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
        return 'MIXED_CONTENT_ALWAYS_ALLOW';
      case 2:
        return 'MIXED_CONTENT_COMPATIBILITY_MODE';
      case 1:
        return 'MIXED_CONTENT_NEVER_ALLOW';
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
