import 'dart:ui' show Offset;

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

import 'native_frame.dart';

/// 把網頁轉送來的原始指標事件（`type == 'pointer'`）注入被鏡像的子樹。
///
/// 只對 [box]（被鏡像的 `RepaintBoundary`）及其子孫做 hit test，不經過整個 App 的 hit test：
/// 鏡像通常墊在 WebView 之下，全域 hit test 會先撞到上面的 WebView，事件到不了子樹。
/// 每個指標在按下時 hit test 一次並記住結果，移動與放開沿用同一條路徑，與 Flutter 自己的行為一致，
/// 所以 `GestureDetector`、`ScaleGestureRecognizer`、地圖手勢都能照常運作，多指也成立。
///
/// 網頁的 pointerId 會對應成不會與真實觸控衝突的內部 id；滑鼠與觸控筆都以觸控注入（主要按鍵）。
class AqutterNativePointerInjector {
  /// 內部 id 從這個值起算，避開真實觸控的小整數 id。
  static const int _firstPointerId = 1 << 30;
  static int _nextPointerId = _firstPointerId;

  final Map<int, _Tracked> _active = <int, _Tracked>{};

  /// 目前注入中（尚未放開）的指標數。
  int get activeCount => _active.length;

  /// 處理一則 `pointer` 訊息。[box] 尚未排版或未掛上時忽略。
  void handle(AqutterNativeMessage message, RenderBox? box) {
    if (message.type != 'pointer' || box == null || !box.attached || !box.hasSize) {
      return;
    }
    final phase = message.data['phase'];
    final id = message.data['id'];
    final x = message.number('x');
    final y = message.number('y');
    if (phase is! String || id is! int || x == null || y == null) {
      return;
    }
    final size = box.size;
    final global = box.localToGlobal(Offset(x * size.width, y * size.height));
    final time = Duration(microseconds: ((message.number('t') ?? 0) * 1000).round());
    switch (phase) {
      case 'down':
        _down(id, box, global, time);
      case 'move':
        _move(id, global, time);
      case 'up':
        _end(id, global, time, cancel: false);
      case 'cancel':
        _end(id, global, time, cancel: true);
    }
  }

  /// 取消所有進行中的指標（元素被移除、換工作階段時呼叫），避免手勢卡在半途。
  void cancelAll() {
    for (final id in _active.keys.toList()) {
      final tracked = _active[id]!;
      _end(id, tracked.last, tracked.time, cancel: true);
    }
  }

  void _down(int id, RenderBox box, Offset global, Duration time) {
    if (_active.containsKey(id)) {
      _end(id, global, time, cancel: true); // 同 id 又按下：先收掉上一個
    }
    final result = HitTestResult();
    // 以全域座標做 hit test：box 視為畫在 origin 位置的子節點，這樣路徑上的轉換矩陣是「全域 → 各層本地」，
    // 之後派送的事件用全域座標即可。
    final origin = box.localToGlobal(Offset.zero);
    BoxHitTestResult.wrap(result).addWithPaintOffset(
      offset: origin,
      position: global,
      hitTest: (BoxHitTestResult hit, Offset local) => box.hitTest(hit, position: local),
    );
    result.add(HitTestEntry(GestureBinding.instance)); // 讓 GestureBinding 關閉／清掃手勢競技場
    final pointer = _nextPointerId++;
    final tracked = _Tracked(pointer, result, global, time);
    _active[id] = tracked;
    GestureBinding.instance.dispatchEvent(
      PointerDownEvent(
        timeStamp: time,
        pointer: pointer,
        device: pointer,
        kind: PointerDeviceKind.touch,
        position: global,
        buttons: kPrimaryButton,
      ),
      result,
    );
  }

  void _move(int id, Offset global, Duration time) {
    final tracked = _active[id];
    if (tracked == null) {
      return;
    }
    final delta = global - tracked.last;
    tracked
      ..last = global
      ..time = time;
    GestureBinding.instance.dispatchEvent(
      PointerMoveEvent(
        timeStamp: time,
        pointer: tracked.pointer,
        device: tracked.pointer,
        kind: PointerDeviceKind.touch,
        position: global,
        delta: delta,
        buttons: kPrimaryButton,
      ),
      tracked.result,
    );
  }

  void _end(int id, Offset global, Duration time, {required bool cancel}) {
    final tracked = _active.remove(id);
    if (tracked == null) {
      return;
    }
    final PointerEvent event = cancel
        ? PointerCancelEvent(timeStamp: time, pointer: tracked.pointer, device: tracked.pointer, kind: PointerDeviceKind.touch, position: global)
        : PointerUpEvent(timeStamp: time, pointer: tracked.pointer, device: tracked.pointer, kind: PointerDeviceKind.touch, position: global);
    GestureBinding.instance.dispatchEvent(event, tracked.result);
  }
}

class _Tracked {
  _Tracked(this.pointer, this.result, this.last, this.time);

  final int pointer;
  final HitTestResult result;
  Offset last;
  Duration time;
}
