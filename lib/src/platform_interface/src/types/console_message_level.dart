import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'console_message_level.g.dart';

///Class representing the level of a console message.
@ExchangeableEnum()
class AqutterConsoleMessageLevel_ {
  // ignore: unused_field
  final int _value;
  const AqutterConsoleMessageLevel_._internal(this._value);

  ///Console TIP level
  static const TIP = const AqutterConsoleMessageLevel_._internal(0);

  ///Console LOG level
  static const LOG = const AqutterConsoleMessageLevel_._internal(1);

  ///Console WARNING level
  static const WARNING = const AqutterConsoleMessageLevel_._internal(2);

  ///Console ERROR level
  static const ERROR = const AqutterConsoleMessageLevel_._internal(3);

  ///Console DEBUG level
  static const DEBUG = const AqutterConsoleMessageLevel_._internal(4);
}
