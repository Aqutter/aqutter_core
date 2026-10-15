import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'renderer_priority_policy.dart';

part 'renderer_priority.g.dart';

///Class used by [AqutterRendererPriorityPolicy] class.
@ExchangeableEnum()
class AqutterRendererPriority_ {
  // ignore: unused_field
  final int _value;
  const AqutterRendererPriority_._internal(this._value);

  ///The renderer associated with this WebView is bound with Android `Context#BIND_WAIVE_PRIORITY`.
  ///At this priority level WebView renderers will be strong targets for out of memory killing.
  static const RENDERER_PRIORITY_WAIVED = const AqutterRendererPriority_._internal(0);

  ///The renderer associated with this WebView is bound with the default priority for services.
  static const RENDERER_PRIORITY_BOUND = const AqutterRendererPriority_._internal(1);

  ///The renderer associated with this WebView is bound with Android `Context#BIND_IMPORTANT`.
  static const RENDERER_PRIORITY_IMPORTANT = const AqutterRendererPriority_._internal(
    2,
  );
}
