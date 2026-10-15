// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webview_package_info.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents a `WebView` package info.
class AqutterWebViewPackageInfo {
  ///The name of this WebView package.
  String? packageName;

  ///The version name of this WebView package.
  String? versionName;
  AqutterWebViewPackageInfo({this.packageName, this.versionName});

  ///Gets a possible [AqutterWebViewPackageInfo] instance from a [Map] value.
  static AqutterWebViewPackageInfo? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebViewPackageInfo(
      packageName: map['packageName'],
      versionName: map['versionName'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"packageName": packageName, "versionName": versionName};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterWebViewPackageInfo{packageName: $packageName, versionName: $versionName}';
  }
}

///Class that represents an Android `WebView` package info.
///Use [AqutterWebViewPackageInfo] instead.
@Deprecated('Use AqutterWebViewPackageInfo instead')
class AqutterAndroidWebViewPackageInfo {
  ///The name of this WebView package.
  String? packageName;

  ///The version name of this WebView package.
  String? versionName;
  AqutterAndroidWebViewPackageInfo({this.packageName, this.versionName});

  ///Gets a possible [AqutterAndroidWebViewPackageInfo] instance from a [Map] value.
  static AqutterAndroidWebViewPackageInfo? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterAndroidWebViewPackageInfo(
      packageName: map['packageName'],
      versionName: map['versionName'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"packageName": packageName, "versionName": versionName};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterAndroidWebViewPackageInfo{packageName: $packageName, versionName: $versionName}';
  }
}
