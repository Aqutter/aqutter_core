// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_file_chooser_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class used in the [AqutterPlatformWebViewCreationParams.onShowFileChooser] method.
class AqutterShowFileChooserResponse {
  ///The file paths of the selected files or `null` to cancel the request.
  ///Each file path must be a valid file URI using the "file:" scheme.
  final List<String>? filePaths;

  ///Whether the file chooser request was handled by the client.
  final bool handledByClient;
  AqutterShowFileChooserResponse({
    this.filePaths,
    required this.handledByClient,
  });

  ///Gets a possible [AqutterShowFileChooserResponse] instance from a [Map] value.
  static AqutterShowFileChooserResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterShowFileChooserResponse(
      filePaths: map['filePaths'] != null
          ? List<String>.from(map['filePaths']!.cast<String>())
          : null,
      handledByClient: map['handledByClient'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"filePaths": filePaths, "handledByClient": handledByClient};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterShowFileChooserResponse{filePaths: $filePaths, handledByClient: $handledByClient}';
  }
}
