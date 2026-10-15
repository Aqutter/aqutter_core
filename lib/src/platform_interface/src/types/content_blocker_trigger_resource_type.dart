import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../content_blocker.dart';

part 'content_blocker_trigger_resource_type.g.dart';

///Class that represents the possible resource type defined for a [AqutterContentBlockerTrigger].
@ExchangeableEnum()
class AqutterContentBlockerTriggerResourceType_ {
  // ignore: unused_field
  final String _value;
  const AqutterContentBlockerTriggerResourceType_._internal(this._value);

  static const DOCUMENT = const AqutterContentBlockerTriggerResourceType_._internal(
    'document',
  );
  static const IMAGE = const AqutterContentBlockerTriggerResourceType_._internal(
    'image',
  );
  static const STYLE_SHEET = const AqutterContentBlockerTriggerResourceType_._internal(
    'style-sheet',
  );
  static const SCRIPT = const AqutterContentBlockerTriggerResourceType_._internal(
    'script',
  );
  static const FONT = const AqutterContentBlockerTriggerResourceType_._internal(
    'font',
  );
  static const MEDIA = const AqutterContentBlockerTriggerResourceType_._internal(
    'media',
  );
  static const SVG_DOCUMENT =
      const AqutterContentBlockerTriggerResourceType_._internal('svg-document');

  ///Any untyped load
  static const RAW = const AqutterContentBlockerTriggerResourceType_._internal('raw');
}
