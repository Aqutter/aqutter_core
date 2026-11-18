import 'dart:ui' show Rect;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// 穿透時「觸控直接進原生」的區域（Flutter 邏輯座標，等同 UIKit 的 point）。
///
/// 每個 session 各報自己的區域；彙整後同步給 iOS 的 `NativeTouchRouter`，Dart 層的 [NativeTouchGate] 讀同一份。
/// 目前只有 iOS 需要（Android 的觸控路徑沒有這個問題），其他平台 [supported] 為 `false`，所有呼叫都是空操作。
class NativeTouchRegions {
  NativeTouchRegions._();

  static final NativeTouchRegions instance = NativeTouchRegions._();

  static const MethodChannel _channel = MethodChannel('aqutter_core/native_touch');

  final Map<Object, List<Rect>> _byOwner = <Object, List<Rect>>{};

  /// 彙整後的區域。
  final ValueNotifier<List<Rect>> regions = ValueNotifier<List<Rect>>(const <Rect>[]);

  bool get supported => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// [owner] 目前的區域；空清單等同 [clear]。
  void set(Object owner, List<Rect> next) {
    if (!supported) {
      return;
    }
    if (next.isEmpty) {
      clear(owner);
      return;
    }
    _byOwner[owner] = List<Rect>.unmodifiable(next);
    _publish();
  }

  void clear(Object owner) {
    if (_byOwner.remove(owner) != null) {
      _publish();
    }
  }

  void _publish() {
    final next = <Rect>[for (final rects in _byOwner.values) ...rects];
    if (listEquals(regions.value, next)) {
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

/// [rect] 扣掉 [holes]（座標與 [rect] 相同）之後剩下的區域，切成不重疊的矩形。
///
/// 以座標壓縮的格子切：每一橫列把連續的空格合成一段，再把上下相同的段合併。
List<Rect> subtractRects(Rect rect, List<Rect> holes) {
  if (rect.isEmpty) {
    return const <Rect>[];
  }
  final clipped = <Rect>[
    for (final hole in holes)
      if (hole.overlaps(rect)) hole.intersect(rect),
  ];
  if (clipped.isEmpty) {
    return <Rect>[rect];
  }
  final xs = <double>{rect.left, rect.right, for (final h in clipped) ...[h.left, h.right]}.toList()..sort();
  final ys = <double>{rect.top, rect.bottom, for (final h in clipped) ...[h.top, h.bottom]}.toList()..sort();
  final rows = <({double top, double bottom, List<(double, double)> runs})>[];
  for (var j = 0; j < ys.length - 1; j++) {
    final top = ys[j];
    final bottom = ys[j + 1];
    final runs = <(double, double)>[];
    for (var i = 0; i < xs.length - 1; i++) {
      final cell = Rect.fromLTRB(xs[i], top, xs[i + 1], bottom);
      final covered = clipped.any((h) => h.left <= cell.left && h.right >= cell.right && h.top <= cell.top && h.bottom >= cell.bottom);
      if (covered) {
        continue;
      }
      if (runs.isNotEmpty && runs.last.$2 == cell.left) {
        runs[runs.length - 1] = (runs.last.$1, cell.right);
      } else {
        runs.add((cell.left, cell.right));
      }
    }
    if (runs.isEmpty) {
      continue;
    }
    if (rows.isNotEmpty && rows.last.bottom == top && listEquals(rows.last.runs, runs)) {
      rows[rows.length - 1] = (top: rows.last.top, bottom: bottom, runs: runs);
    } else {
      rows.add((top: top, bottom: bottom, runs: runs));
    }
  }
  return <Rect>[
    for (final row in rows)
      for (final run in row.runs) Rect.fromLTRB(run.$1, row.top, run.$2, row.bottom),
  ];
}

/// 目前觸控是否直接進原生（給 `AqutterNative` 的 child 底下的 plugin 讀）。
///
/// 為 `true` 時，plugin 的原生 view 要在 Flutter 手勢競技場宣告自己要手勢（例如 `GoogleMap.gestureRecognizers` 放
/// `EagerGestureRecognizer`），否則上層 WebView 會贏走競技場、封鎖原生 view。
class AqutterNativeTouch extends InheritedNotifier<ValueNotifier<bool>> {
  const AqutterNativeTouch({super.key, required ValueNotifier<bool> super.notifier, required super.child});

  static final ValueNotifier<bool> _never = ValueNotifier<bool>(false);

  /// [context] 之上沒有 `AqutterNative` 時回傳恆為 `false` 的通知器。
  static ValueListenable<bool> of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<AqutterNativeTouch>()?.notifier ?? _never;
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
