import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'enum_method.dart';

part 'webview_package_info.g.dart';

///Class that represents a `WebView` package info.
@ExchangeableObject()
class AqutterWebViewPackageInfo_ {
  ///The version name of this WebView package.
  String? versionName;

  ///The name of this WebView package.
  String? packageName;

  AqutterWebViewPackageInfo_({this.versionName, this.packageName});
}

///Class that represents an Android `WebView` package info.
///Use [AqutterWebViewPackageInfo] instead.
@Deprecated("Use AqutterWebViewPackageInfo instead")
@ExchangeableObject()
class AqutterAndroidWebViewPackageInfo_ {
  ///The version name of this WebView package.
  String? versionName;

  ///The name of this WebView package.
  String? packageName;

  AqutterAndroidWebViewPackageInfo_({this.versionName, this.packageName});
}
