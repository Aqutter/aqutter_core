import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import '../web_uri.dart';
import 'enum_method.dart';

part 'loaded_resource.g.dart';

///Class representing a resource response of the `WebView`.
///It is used by the method [AqutterPlatformWebViewCreationParams.onLoadResource].
@ExchangeableObject()
class AqutterLoadedResource_ {
  ///A string representing the type of resource.
  String? initiatorType;

  ///Resource URL.
  AqutterWebUri? url;

  ///Returns the [DOMHighResTimeStamp](https://developer.mozilla.org/en-US/docs/Web/API/DOMHighResTimeStamp) for the time a resource fetch started.
  double? startTime;

  ///Returns the [DOMHighResTimeStamp](https://developer.mozilla.org/en-US/docs/Web/API/DOMHighResTimeStamp) duration to fetch a resource.
  double? duration;

  AqutterLoadedResource_({
    this.initiatorType,
    this.url,
    this.startTime,
    this.duration,
  });
}
