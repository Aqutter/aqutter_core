// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_file_security_check_starting_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the request used by the [AqutterPlatformWebViewCreationParams.onSaveFileSecurityCheckStarting] event.
class AqutterSaveFileSecurityCheckStartingRequest {
  ///Whether to cancel the save operation.
  bool? cancelSave;

  ///The document origin URI of the file save operation.
  AqutterWebUri? documentOriginUri;

  ///The file extension to be saved.
  String? fileExtension;

  ///The full file path of the file to be saved.
  String? filePath;

  ///Whether to suppress the default policy check.
  bool? suppressDefaultPolicy;
  AqutterSaveFileSecurityCheckStartingRequest({
    this.cancelSave,
    this.documentOriginUri,
    this.fileExtension,
    this.filePath,
    this.suppressDefaultPolicy,
  });

  ///Gets a possible [AqutterSaveFileSecurityCheckStartingRequest] instance from a [Map] value.
  static AqutterSaveFileSecurityCheckStartingRequest? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterSaveFileSecurityCheckStartingRequest(
      cancelSave: map['cancelSave'],
      documentOriginUri: map['documentOriginUri'] != null
          ? AqutterWebUri(map['documentOriginUri'])
          : null,
      fileExtension: map['fileExtension'],
      filePath: map['filePath'],
      suppressDefaultPolicy: map['suppressDefaultPolicy'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "cancelSave": cancelSave,
      "documentOriginUri": documentOriginUri?.toString(),
      "fileExtension": fileExtension,
      "filePath": filePath,
      "suppressDefaultPolicy": suppressDefaultPolicy,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterSaveFileSecurityCheckStartingRequest{cancelSave: $cancelSave, documentOriginUri: $documentOriginUri, fileExtension: $fileExtension, filePath: $filePath, suppressDefaultPolicy: $suppressDefaultPolicy}';
  }
}
