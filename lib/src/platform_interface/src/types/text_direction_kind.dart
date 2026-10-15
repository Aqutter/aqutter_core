import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'text_direction_kind.g.dart';

///Constants that describe the text direction.
///
///This corresponds to [COREWEBVIEW2_TEXT_DIRECTION_KIND](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.3595.46#corewebview2_text_direction_kind).
@ExchangeableEnum()
class AqutterTextDirectionKind_ {
  // ignore: unused_field
  final int _value;
  const AqutterTextDirectionKind_._internal(this._value);

  ///Default text direction.
  static const DEFAULT = AqutterTextDirectionKind_._internal(0);

  ///Left-to-right text direction.
  static const LEFT_TO_RIGHT = AqutterTextDirectionKind_._internal(1);

  ///Right-to-left text direction.
  static const RIGHT_TO_LEFT = AqutterTextDirectionKind_._internal(2);
}
