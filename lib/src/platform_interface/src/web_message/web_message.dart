import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../platform_webview_feature.dart';
import 'platform_web_message_port.dart';
import '../types/enum_method.dart';

part 'web_message.g.dart';

///The Dart representation of the HTML5 PostMessage event.
///See https://html.spec.whatwg.org/multipage/comms.html#the-messageevent-interfaces for definition of a MessageEvent in HTML5.
@ExchangeableObject(fromMapForceAllInline: true)
class AqutterWebMessage_ {
  ///The data of the message.
  dynamic data;

  ///The payload type of the message.
  AqutterWebMessageType_ type;

  ///The ports that are sent with the message.
  List<AqutterIWebMessagePort>? ports;

  @ExchangeableObjectConstructor()
  AqutterWebMessage_({this.data, this.type = AqutterWebMessageType_.STRING, this.ports}) {
    assert(
      ((this.data == null || this.data is String) &&
              this.type == AqutterWebMessageType_.STRING) ||
          (this.data != null &&
              this.data is Uint8List &&
              this.type == AqutterWebMessageType_.ARRAY_BUFFER),
    );
  }
}

///The type corresponding to the [AqutterWebMessage].
@ExchangeableEnum()
class AqutterWebMessageType_ {
  // ignore: unused_field
  final int _value;

  const AqutterWebMessageType_._internal(this._value);

  ///Indicates the payload of WebMessageCompat is String.
  static const STRING = const AqutterWebMessageType_._internal(0);

  ///Indicates the payload of WebMessageCompat is JavaScript ArrayBuffer.
  ///
  ///**NOTE**: available only if [AqutterWebViewFeature.WEB_MESSAGE_ARRAY_BUFFER] feature is supported.
  static const ARRAY_BUFFER = const AqutterWebMessageType_._internal(1);
}
