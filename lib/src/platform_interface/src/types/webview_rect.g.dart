// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webview_rect.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///A class that represents a structure that contains the location and dimensions of a rectangle.
class AqutterWebViewRect {
  ///rect height
  double height;

  ///rect width
  double width;

  ///x position
  double x;

  ///y position
  double y;
  AqutterWebViewRect({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  }) {
    assert(this.width >= 0 && this.height >= 0);
  }

  ///Gets a possible [AqutterWebViewRect] instance from a [Map] value.
  static AqutterWebViewRect? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebViewRect(
      height: map['height'],
      width: map['width'],
      x: map['x'],
      y: map['y'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"height": height, "width": width, "x": x, "y": y};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterWebViewRect{height: $height, width: $width, x: $x, y: $y}';
  }
}
