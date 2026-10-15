// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trusted_web_activity_immersive_display_mode.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the default display mode of a Trusted Web Activity.
///The system UI (status bar, navigation bar) is shown, and the browser toolbar is hidden while the user is on a verified origin.
class AqutterTrustedWebActivityImmersiveDisplayMode
    implements AqutterTrustedWebActivityDisplayMode {
  static final String _type = "IMMERSIVE_MODE";

  ///The constant defining how to deal with display cutouts.
  AqutterLayoutInDisplayCutoutMode displayCutoutMode;

  ///Whether the Trusted Web Activity should be in sticky immersive mode.
  bool isSticky;

  ///Use [displayCutoutMode] instead.
  @Deprecated('Use displayCutoutMode instead')
  AqutterAndroidLayoutInDisplayCutoutMode? layoutInDisplayCutoutMode;
  AqutterTrustedWebActivityImmersiveDisplayMode({
    required this.isSticky,
    this.displayCutoutMode = AqutterLayoutInDisplayCutoutMode.DEFAULT,
    this.layoutInDisplayCutoutMode,
  }) {
    this.displayCutoutMode = this.layoutInDisplayCutoutMode != null
        ? AqutterLayoutInDisplayCutoutMode.fromNativeValue(
            layoutInDisplayCutoutMode?.toNativeValue(),
          )!
        : this.displayCutoutMode;
  }

  ///Gets a possible [AqutterTrustedWebActivityImmersiveDisplayMode] instance from a [Map] value.
  static AqutterTrustedWebActivityImmersiveDisplayMode? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterTrustedWebActivityImmersiveDisplayMode(
      isSticky: map['isSticky'],
      layoutInDisplayCutoutMode: switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterAndroidLayoutInDisplayCutoutMode.fromNativeValue(
            map['displayCutoutMode'],
          ),
        AqutterEnumMethod.value =>
          AqutterAndroidLayoutInDisplayCutoutMode.fromValue(
            map['displayCutoutMode'],
          ),
        AqutterEnumMethod.name =>
          AqutterAndroidLayoutInDisplayCutoutMode.byName(
            map['displayCutoutMode'],
          ),
      },
    );
    if (map['displayCutoutMode'] != null) {
      instance.displayCutoutMode = switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterLayoutInDisplayCutoutMode.fromNativeValue(
            map['displayCutoutMode'],
          ),
        AqutterEnumMethod.value => AqutterLayoutInDisplayCutoutMode.fromValue(
          map['displayCutoutMode'],
        ),
        AqutterEnumMethod.name => AqutterLayoutInDisplayCutoutMode.byName(
          map['displayCutoutMode'],
        ),
      }!;
    }
    return instance;
  }

  @ExchangeableObjectMethod(toMapMergeWith: true)
  Map<String, dynamic> _toMapMergeWith({AqutterEnumMethod? enumMethod}) {
    return {"type": _type};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "displayCutoutMode": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => displayCutoutMode.toNativeValue(),
        AqutterEnumMethod.value => displayCutoutMode.toValue(),
        AqutterEnumMethod.name => displayCutoutMode.name(),
      },
      "isSticky": isSticky,
      ..._toMapMergeWith(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterTrustedWebActivityImmersiveDisplayMode{displayCutoutMode: $displayCutoutMode, isSticky: $isSticky}';
  }
}
