import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'data_detector_types.g.dart';

///Class used to specify a `dataDetectoryTypes` value that adds interactivity to web content that matches the value.
@ExchangeableEnum()
class AqutterDataDetectorTypes_ {
  // ignore: unused_field
  final String _value;
  const AqutterDataDetectorTypes_._internal(this._value);

  ///No detection is performed.
  static const NONE = const AqutterDataDetectorTypes_._internal("NONE");

  ///Phone numbers are detected and turned into links.
  static const PHONE_NUMBER = const AqutterDataDetectorTypes_._internal(
    "PHONE_NUMBER",
  );

  ///URLs in text are detected and turned into links.
  static const LINK = const AqutterDataDetectorTypes_._internal("LINK");

  ///Addresses are detected and turned into links.
  static const ADDRESS = const AqutterDataDetectorTypes_._internal("ADDRESS");

  ///Dates and times that are in the future are detected and turned into links.
  static const CALENDAR_EVENT = const AqutterDataDetectorTypes_._internal(
    "CALENDAR_EVENT",
  );

  ///Tracking numbers are detected and turned into links.
  static const TRACKING_NUMBER = const AqutterDataDetectorTypes_._internal(
    "TRACKING_NUMBER",
  );

  ///Flight numbers are detected and turned into links.
  static const FLIGHT_NUMBER = const AqutterDataDetectorTypes_._internal(
    "FLIGHT_NUMBER",
  );

  ///Lookup suggestions are detected and turned into links.
  static const LOOKUP_SUGGESTION = const AqutterDataDetectorTypes_._internal(
    "LOOKUP_SUGGESTION",
  );

  ///Spotlight suggestions are detected and turned into links.
  static const SPOTLIGHT_SUGGESTION = const AqutterDataDetectorTypes_._internal(
    "SPOTLIGHT_SUGGESTION",
  );

  ///All of the above data types are turned into links when detected. Choosing this value will automatically include any new detection type that is added.
  static const ALL = const AqutterDataDetectorTypes_._internal("ALL");
}

///An iOS-specific class used to specify a `dataDetectoryTypes` value that adds interactivity to web content that matches the value.
///
///**NOTE**: available on iOS 10.0+.
///
///Use [AqutterDataDetectorTypes] instead.
@Deprecated("Use AqutterDataDetectorTypes instead")
@ExchangeableEnum()
class AqutterIOSWKDataDetectorTypes_ {
  // ignore: unused_field
  final String _value;
  const AqutterIOSWKDataDetectorTypes_._internal(this._value);

  ///No detection is performed.
  static const NONE = const AqutterIOSWKDataDetectorTypes_._internal("NONE");

  ///Phone numbers are detected and turned into links.
  static const PHONE_NUMBER = const AqutterIOSWKDataDetectorTypes_._internal(
    "PHONE_NUMBER",
  );

  ///URLs in text are detected and turned into links.
  static const LINK = const AqutterIOSWKDataDetectorTypes_._internal("LINK");

  ///Addresses are detected and turned into links.
  static const ADDRESS = const AqutterIOSWKDataDetectorTypes_._internal("ADDRESS");

  ///Dates and times that are in the future are detected and turned into links.
  static const CALENDAR_EVENT = const AqutterIOSWKDataDetectorTypes_._internal(
    "CALENDAR_EVENT",
  );

  ///Tracking numbers are detected and turned into links.
  static const TRACKING_NUMBER = const AqutterIOSWKDataDetectorTypes_._internal(
    "TRACKING_NUMBER",
  );

  ///Flight numbers are detected and turned into links.
  static const FLIGHT_NUMBER = const AqutterIOSWKDataDetectorTypes_._internal(
    "FLIGHT_NUMBER",
  );

  ///Lookup suggestions are detected and turned into links.
  static const LOOKUP_SUGGESTION = const AqutterIOSWKDataDetectorTypes_._internal(
    "LOOKUP_SUGGESTION",
  );

  ///Spotlight suggestions are detected and turned into links.
  static const SPOTLIGHT_SUGGESTION = const AqutterIOSWKDataDetectorTypes_._internal(
    "SPOTLIGHT_SUGGESTION",
  );

  ///All of the above data types are turned into links when detected. Choosing this value will automatically include any new detection type that is added.
  static const ALL = const AqutterIOSWKDataDetectorTypes_._internal("ALL");
}
