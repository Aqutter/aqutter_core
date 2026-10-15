// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_capture_state.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that describes whether a media device, like a camera or microphone, is currently capturing audio or video.
class AqutterMediaCaptureState {
  final int _value;
  final int? _nativeValue;
  const AqutterMediaCaptureState._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterMediaCaptureState._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterMediaCaptureState._internal(value, nativeValue());

  ///The media device is actively capturing audio or video.
  static const ACTIVE = AqutterMediaCaptureState._internal(1, 1);

  ///The media device is muted, and not actively capturing audio or video.
  static const MUTED = AqutterMediaCaptureState._internal(2, 2);

  ///The media device is off.
  static const NONE = AqutterMediaCaptureState._internal(0, 0);

  ///Set of all values of [AqutterMediaCaptureState].
  static final Set<AqutterMediaCaptureState> values = [
    AqutterMediaCaptureState.ACTIVE,
    AqutterMediaCaptureState.MUTED,
    AqutterMediaCaptureState.NONE,
  ].toSet();

  ///Gets a possible [AqutterMediaCaptureState] instance from [int] value.
  static AqutterMediaCaptureState? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterMediaCaptureState.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterMediaCaptureState] instance from a native value.
  static AqutterMediaCaptureState? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterMediaCaptureState.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterMediaCaptureState] instance value with name [name].
  ///
  /// Goes through [AqutterMediaCaptureState.values] looking for a value with
  /// name [name], as reported by [AqutterMediaCaptureState.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterMediaCaptureState? byName(String? name) {
    if (name != null) {
      try {
        return AqutterMediaCaptureState.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterMediaCaptureState] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterMediaCaptureState> asNameMap() =>
      <String, AqutterMediaCaptureState>{
        for (final value in AqutterMediaCaptureState.values)
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
        return 'ACTIVE';
      case 2:
        return 'MUTED';
      case 0:
        return 'NONE';
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
