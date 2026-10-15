import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import 'url_response.dart';
import 'enum_method.dart';

part 'navigation_response.g.dart';

///Class that represents the navigation response used by the [AqutterPlatformWebViewCreationParams.onNavigationResponse] event.
@ExchangeableObject()
class AqutterNavigationResponse_ {
  ///The URL for the response.
  AqutterURLResponse_? response;

  ///A Boolean value that indicates whether the response targets the web view’s main frame.
  bool isForMainFrame;

  ///A Boolean value that indicates whether WebKit is capable of displaying the response’s MIME type natively.
  bool canShowMIMEType;

  AqutterNavigationResponse_({
    this.response,
    required this.isForMainFrame,
    required this.canShowMIMEType,
  });
}

///An iOS-specific Class that represents the navigation response used by the [AqutterPlatformWebViewCreationParams.onNavigationResponse] event.
///Use [AqutterNavigationResponse] instead.
@Deprecated("Use AqutterNavigationResponse instead")
@ExchangeableObject()
class AqutterIOSWKNavigationResponse_ {
  ///The URL for the response.
  AqutterIOSURLResponse_? response;

  ///A Boolean value that indicates whether the response targets the web view’s main frame.
  bool isForMainFrame;

  ///A Boolean value that indicates whether WebKit is capable of displaying the response’s MIME type natively.
  bool canShowMIMEType;

  AqutterIOSWKNavigationResponse_({
    this.response,
    required this.isForMainFrame,
    required this.canShowMIMEType,
  });
}
