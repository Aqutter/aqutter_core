import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../content_blocker.dart';

part 'content_blocker_trigger_load_context.g.dart';

///Class that represents the kind of load context that can be used with a [AqutterContentBlockerTrigger].
@ExchangeableEnum()
class AqutterContentBlockerTriggerLoadContext_ {
  // ignore: unused_field
  final String _value;

  const AqutterContentBlockerTriggerLoadContext_._internal(this._value);

  ///Top frame load context
  static const TOP_FRAME = const AqutterContentBlockerTriggerLoadContext_._internal(
    'top-frame',
  );

  ///Child frame load context
  static const CHILD_FRAME = const AqutterContentBlockerTriggerLoadContext_._internal(
    'child-frame',
  );
}
