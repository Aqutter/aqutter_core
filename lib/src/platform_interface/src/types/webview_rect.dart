import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'enum_method.dart';

part 'webview_rect.g.dart';

///A class that represents a structure that contains the location and dimensions of a rectangle.
@ExchangeableObject()
class AqutterWebViewRect_ {
  ///x position
  double x;

  ///y position
  double y;

  ///rect width
  double width;

  ///rect height
  double height;

  @ExchangeableObjectConstructor()
  AqutterWebViewRect_({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  }) {
    assert(this.width >= 0 && this.height >= 0);
  }
}
