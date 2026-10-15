// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accelerator_key_pressed_detail.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents details of the [AqutterPlatformWebViewCreationParams.onAcceleratorKeyPressed] event.
class AqutterAcceleratorKeyPressedDetail {
  int? keyEventKind;
  AqutterPhysicalKeyStatus? physicalKeyStatus;
  int? virtualKey;
  AqutterAcceleratorKeyPressedDetail({
    this.keyEventKind,
    this.physicalKeyStatus,
    this.virtualKey,
  });

  ///Gets a possible [AqutterAcceleratorKeyPressedDetail] instance from a [Map] value.
  static AqutterAcceleratorKeyPressedDetail? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterAcceleratorKeyPressedDetail(
      keyEventKind: map['keyEventKind'],
      physicalKeyStatus: AqutterPhysicalKeyStatus.fromMap(
        map['physicalKeyStatus']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      virtualKey: map['virtualKey'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "keyEventKind": keyEventKind,
      "physicalKeyStatus": physicalKeyStatus?.toMap(enumMethod: enumMethod),
      "virtualKey": virtualKey,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterAcceleratorKeyPressedDetail{keyEventKind: $keyEventKind, physicalKeyStatus: $physicalKeyStatus, virtualKey: $virtualKey}';
  }
}
