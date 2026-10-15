// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_process_infos_changed_detail.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///An object that contains information for the [AqutterPlatformWebViewEnvironment.onProcessInfosChanged] event.
class AqutterBrowserProcessInfosChangedDetail {
  ///The kind of the process.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  List<AqutterBrowserProcessInfo> infos;
  AqutterBrowserProcessInfosChangedDetail({this.infos = const []});

  ///Gets a possible [AqutterBrowserProcessInfosChangedDetail] instance from a [Map] value.
  static AqutterBrowserProcessInfosChangedDetail? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterBrowserProcessInfosChangedDetail();
    if (map['infos'] != null) {
      instance.infos = List<AqutterBrowserProcessInfo>.from(
        map['infos'].map(
          (e) => AqutterBrowserProcessInfo.fromMap(
            e?.cast<String, dynamic>(),
            enumMethod: enumMethod,
          )!,
        ),
      );
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "infos": infos.map((e) => e.toMap(enumMethod: enumMethod)).toList(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterBrowserProcessInfosChangedDetail{infos: $infos}';
  }
}
