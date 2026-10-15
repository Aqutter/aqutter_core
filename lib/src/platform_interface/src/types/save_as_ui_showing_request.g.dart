// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_as_ui_showing_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the request used by the [AqutterPlatformWebViewCreationParams.onSaveAsUIShowing] event.
class AqutterSaveAsUIShowingRequest {
  ///Whether the save operation may replace an existing file.
  bool? allowReplace;

  ///Whether to cancel the Save As action.
  bool? cancel;

  ///The MIME type of content to be saved.
  String? contentMimeType;

  ///The save-as kind for the operation.
  AqutterSaveAsKind? kind;

  ///The suggested save file path.
  String? saveAsFilePath;

  ///Whether to suppress the default dialog.
  bool? suppressDefaultDialog;
  AqutterSaveAsUIShowingRequest({
    this.allowReplace,
    this.cancel,
    this.contentMimeType,
    this.kind,
    this.saveAsFilePath,
    this.suppressDefaultDialog,
  });

  ///Gets a possible [AqutterSaveAsUIShowingRequest] instance from a [Map] value.
  static AqutterSaveAsUIShowingRequest? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterSaveAsUIShowingRequest(
      allowReplace: map['allowReplace'],
      cancel: map['cancel'],
      contentMimeType: map['contentMimeType'],
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
      "contentMimeType": contentMimeType,
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
    return 'AqutterSaveAsUIShowingRequest{allowReplace: $allowReplace, cancel: $cancel, contentMimeType: $contentMimeType, kind: $kind, saveAsFilePath: $saveAsFilePath, suppressDefaultDialog: $suppressDefaultDialog}';
  }
}
