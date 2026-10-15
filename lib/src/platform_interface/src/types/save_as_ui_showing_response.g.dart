// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_as_ui_showing_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onSaveAsUIShowing] event.
class AqutterSaveAsUIShowingResponse {
  ///Whether the save operation may replace an existing file.
  bool? allowReplace;

  ///Whether to cancel the Save As action.
  bool? cancel;

  ///The save-as kind for the operation.
  AqutterSaveAsKind? kind;

  ///The save file path to use.
  String? saveAsFilePath;

  ///Whether to suppress the default dialog.
  bool? suppressDefaultDialog;
  AqutterSaveAsUIShowingResponse({
    this.allowReplace,
    this.cancel,
    this.kind,
    this.saveAsFilePath,
    this.suppressDefaultDialog,
  });

  ///Gets a possible [AqutterSaveAsUIShowingResponse] instance from a [Map] value.
  static AqutterSaveAsUIShowingResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterSaveAsUIShowingResponse(
      allowReplace: map['allowReplace'],
      cancel: map['cancel'],
      kind: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterSaveAsKind.fromNativeValue(
          map['kind'],
        ),
        AqutterEnumMethod.value => AqutterSaveAsKind.fromValue(map['kind']),
        AqutterEnumMethod.name => AqutterSaveAsKind.byName(map['kind']),
      },
      saveAsFilePath: map['saveAsFilePath'],
      suppressDefaultDialog: map['suppressDefaultDialog'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "allowReplace": allowReplace,
      "cancel": cancel,
      "kind": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => kind?.toNativeValue(),
        AqutterEnumMethod.value => kind?.toValue(),
        AqutterEnumMethod.name => kind?.name(),
      },
      "saveAsFilePath": saveAsFilePath,
      "suppressDefaultDialog": suppressDefaultDialog,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterSaveAsUIShowingResponse{allowReplace: $allowReplace, cancel: $cancel, kind: $kind, saveAsFilePath: $saveAsFilePath, suppressDefaultDialog: $suppressDefaultDialog}';
  }
}
