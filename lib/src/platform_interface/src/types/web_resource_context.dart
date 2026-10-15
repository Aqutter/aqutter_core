import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'web_resource_context.g.dart';

///Constants that describe the web resource request contexts.
@ExchangeableEnum()
class AqutterWebResourceContext_ {
  // ignore: unused_field
  final int _value;
  const AqutterWebResourceContext_._internal(this._value);

  ///All resources.
  static const ALL = AqutterWebResourceContext_._internal(0);

  ///Document resource.
  static const DOCUMENT = AqutterWebResourceContext_._internal(1);

  ///CSS resource.
  static const STYLESHEET = AqutterWebResourceContext_._internal(2);

  ///Image resource.
  static const IMAGE = AqutterWebResourceContext_._internal(3);

  ///Media resource.
  static const MEDIA = AqutterWebResourceContext_._internal(4);

  ///Font resource.
  static const FONT = AqutterWebResourceContext_._internal(5);

  ///Script resource.
  static const SCRIPT = AqutterWebResourceContext_._internal(6);

  ///XML HTTP request resource.
  static const XML_HTTP_REQUEST = AqutterWebResourceContext_._internal(7);

  ///Fetch API resource.
  static const FETCH = AqutterWebResourceContext_._internal(8);

  ///TextTrack resource.
  static const TEXT_TRACK = AqutterWebResourceContext_._internal(9);

  ///EventSource resource.
  static const EVENT_SOURCE = AqutterWebResourceContext_._internal(10);

  ///WebSocket resource.
  static const WEBSOCKET = AqutterWebResourceContext_._internal(11);

  ///Web App Manifest resource.
  static const MANIFEST = AqutterWebResourceContext_._internal(12);

  ///Signed HTTP Exchange resource.
  static const SIGNED_EXCHANGE = AqutterWebResourceContext_._internal(13);

  ///Ping request.
  static const PING = AqutterWebResourceContext_._internal(14);

  ///CSP Violation Report resource.
  static const CSP_VIOLATION_REPORT = AqutterWebResourceContext_._internal(15);

  ///Other resource.
  static const OTHER = AqutterWebResourceContext_._internal(16);
}
