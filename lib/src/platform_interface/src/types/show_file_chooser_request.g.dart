// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_file_chooser_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class used in the [AqutterPlatformWebViewCreationParams.onShowFileChooser] method.
class AqutterShowFileChooserRequest {
  ///An array of acceptable MIME types.
  ///The returned MIME type could be partial such as audio/*.
  ///The array will be empty if no acceptable types are specified.
  final List<String> acceptTypes;

  ///The file name of a default selection if specified, or `null`.
  final String? filenameHint;

  ///Preference for a live media captured value (e. g. Camera, Microphone).
  ///True indicates capture is enabled, false disabled.
  ///Use [acceptTypes] to determine suitable capture devices.
  final bool isCaptureEnabled;

  ///The file chooser mode.
  final AqutterShowFileChooserRequestMode mode;

  ///The title to use for this file selector.
  ///If `null` a default title should be used.
  final String? title;
  AqutterShowFileChooserRequest({
    required this.acceptTypes,
    this.filenameHint,
    required this.isCaptureEnabled,
    required this.mode,
    this.title,
  });

  ///Gets a possible [AqutterShowFileChooserRequest] instance from a [Map] value.
  static AqutterShowFileChooserRequest? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterShowFileChooserRequest(
      acceptTypes: List<String>.from(map['acceptTypes']!.cast<String>()),
      filenameHint: map['filenameHint'],
      isCaptureEnabled: map['isCaptureEnabled'],
      mode: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterShowFileChooserRequestMode.fromNativeValue(map['mode']),
        AqutterEnumMethod.value => AqutterShowFileChooserRequestMode.fromValue(
          map['mode'],
        ),
        AqutterEnumMethod.name => AqutterShowFileChooserRequestMode.byName(
          map['mode'],
        ),
      }!,
      title: map['title'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "acceptTypes": acceptTypes,
      "filenameHint": filenameHint,
      "isCaptureEnabled": isCaptureEnabled,
      "mode": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => mode.toNativeValue(),
        AqutterEnumMethod.value => mode.toValue(),
        AqutterEnumMethod.name => mode.name(),
      },
      "title": title,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterShowFileChooserRequest{acceptTypes: $acceptTypes, filenameHint: $filenameHint, isCaptureEnabled: $isCaptureEnabled, mode: $mode, title: $title}';
  }
}
