// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_process_exited_detail.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///An object that contains information for the [AqutterPlatformWebViewEnvironment.onBrowserProcessExited] event.
class AqutterBrowserProcessExitedDetail {
  ///The kind of browser process exit that has occurred.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  AqutterBrowserProcessExitKind kind;

  ///The process ID of the browser process that has exited.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  int? processId;
  AqutterBrowserProcessExitedDetail({required this.kind, this.processId});

  ///Gets a possible [AqutterBrowserProcessExitedDetail] instance from a [Map] value.
  static AqutterBrowserProcessExitedDetail? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterBrowserProcessExitedDetail(
      kind: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterBrowserProcessExitKind.fromNativeValue(map['kind']),
        AqutterEnumMethod.value => AqutterBrowserProcessExitKind.fromValue(
          map['kind'],
        ),
        AqutterEnumMethod.name => AqutterBrowserProcessExitKind.byName(
          map['kind'],
        ),
      }!,
      processId: map['processId'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "kind": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => kind.toNativeValue(),
        AqutterEnumMethod.value => kind.toValue(),
        AqutterEnumMethod.name => kind.name(),
      },
      "processId": processId,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterBrowserProcessExitedDetail{kind: $kind, processId: $processId}';
  }
}
