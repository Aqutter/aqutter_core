import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'selection_granularity.g.dart';

///Class used to set the level of granularity with which the user can interactively select content in the web view.
@ExchangeableEnum()
class AqutterSelectionGranularity_ {
  // ignore: unused_field
  final int _value;
  const AqutterSelectionGranularity_._internal(this._value);

  ///Selection granularity varies automatically based on the selection.
  static const DYNAMIC = const AqutterSelectionGranularity_._internal(0);

  ///Selection endpoints can be placed at any character boundary.
  static const CHARACTER = const AqutterSelectionGranularity_._internal(1);
}

///An iOS-specific class used to set the level of granularity with which the user can interactively select content in the web view.
///Use [AqutterSelectionGranularity] instead.
@Deprecated("Use AqutterSelectionGranularity instead")
@ExchangeableEnum()
class AqutterIOSWKSelectionGranularity_ {
  // ignore: unused_field
  final int _value;
  const AqutterIOSWKSelectionGranularity_._internal(this._value);

  ///Selection granularity varies automatically based on the selection.
  static const DYNAMIC = const AqutterIOSWKSelectionGranularity_._internal(0);

  ///Selection endpoints can be placed at any character boundary.
  static const CHARACTER = const AqutterIOSWKSelectionGranularity_._internal(1);
}
