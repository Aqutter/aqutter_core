// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_process_info.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///An object that contains information for a process in the [AqutterPlatformWebViewEnvironment].
class AqutterBrowserProcessInfo {
  ///A list of associated [AqutterFrameInfo]s which are actively running
  ///(showing or hiding UI elements) in the renderer process.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.2210.55+
  List<AqutterFrameInfo>? frameInfos;

  ///The kind of the process.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  AqutterBrowserProcessKind kind;

  ///The process id of the process.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  int? processId;
  AqutterBrowserProcessInfo({
    this.frameInfos,
    required this.kind,
    this.processId,
  });

  ///Gets a possible [AqutterBrowserProcessInfo] instance from a [Map] value.
  static AqutterBrowserProcessInfo? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterBrowserProcessInfo(
      frameInfos: map['frameInfos'] != null
          ? List<AqutterFrameInfo>.from(
              map['frameInfos'].map(
                (e) => AqutterFrameInfo.fromMap(
                  e?.cast<String, dynamic>(),
                  enumMethod: enumMethod,
                )!,
              ),
            )
          : null,
      kind: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterBrowserProcessKind.fromNativeValue(map['kind']),
        AqutterEnumMethod.value => AqutterBrowserProcessKind.fromValue(
          map['kind'],
        ),
        AqutterEnumMethod.name => AqutterBrowserProcessKind.byName(map['kind']),
      }!,
      processId: map['processId'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "frameInfos": frameInfos
          ?.map((e) => e.toMap(enumMethod: enumMethod))
          .toList(),
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
    return 'AqutterBrowserProcessInfo{frameInfos: $frameInfos, kind: $kind, processId: $processId}';
  }
}
