import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'memory_usage_target_level.g.dart';

///Constants that describe memory usage target levels.
@ExchangeableEnum()
class AqutterMemoryUsageTargetLevel_ {
  // ignore: unused_field
  final int _value;
  const AqutterMemoryUsageTargetLevel_._internal(this._value);

  ///Normal memory usage target level.
  static const NORMAL = AqutterMemoryUsageTargetLevel_._internal(0);

  ///Low memory usage target level.
  static const LOW = AqutterMemoryUsageTargetLevel_._internal(1);
}
