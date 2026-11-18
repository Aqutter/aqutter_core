import 'dart:io' show Platform;
import 'dart:ui' show Rect;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// 穿透時「觸控直接進原生」的區域（Flutter 邏輯座標，等同 UIKit 的 point）。
///
/// 改變時同步給 iOS 的 `NativeTouchRouter`；Dart 層的 [NativeTouchGate] 讀同一份。
class NativeTouchRegions {
  NativeTouchRegions._();

  static final NativeTouchRegions instance = NativeTouchRegions._();

  static const MethodChannel _channel = MethodChannel('aqutter_core/native_touch');

  final ValueNotifier<List<Rect>> regions = ValueNotifier<List<Rect>>(const <Rect>[]);

  bool get supported => !kIsWeb && Platform.isIOS;

  void update(List<Rect> next) {
    if (!supported || listEquals(regions.value, next)) {
      return;
    }
    regions.value = List<Rect>.unmodifiable(next);
    _channel
        .invokeMethod<void>('setRegions', <List<double>>[
          for (final rect in next) <double>[rect.left, rect.top, rect.width, rect.height],
        ])
        .catchError((Object _) {});
  }
}

/// 在 [NativeTouchRegions] 內對 Flutter 的 hit test 透明，讓底下的原生 platform view（地圖）進手勢競技場。
class NativeTouchGate extends SingleChildRenderObjectWidget {
  const NativeTouchGate({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderNativeTouchGate();
}

class _RenderNativeTouchGate extends RenderProxyBox {
  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final global = localToGlobal(position);
    for (final rect in NativeTouchRegions.instance.regions.value) {
      if (rect.contains(global)) {
        return false;
      }
    }
    return super.hitTest(result, position: position);
  }
}
