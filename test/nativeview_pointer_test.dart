import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// 連上工作階段，依序送出網頁端會送的 `pointer` 訊息（座標為 0..1 的正規化值）。
Future<void> _send(WidgetTester tester, String session, List<Map<String, Object>> messages, {Duration gap = const Duration(milliseconds: 20)}) async {
  await tester.runAsync(() async {
    final endpoint = await AqutterNativeHost.instance.ensureStarted();
    final socket = await WebSocket.connect('ws://127.0.0.1:${endpoint.port}/native/$session?token=${endpoint.token}');
    socket.listen((_) {});
    for (final message in messages) {
      socket.add(jsonEncode(message));
      await Future<void>.delayed(gap);
    }
    await Future<void>.delayed(const Duration(milliseconds: 200));
    await socket.close();
    await Future<void>.delayed(const Duration(milliseconds: 150));
  });
  await tester.pump();
}

Map<String, Object> _pointer(String phase, int id, double x, double y, [double t = 0]) =>
    {'type': 'pointer', 'phase': phase, 'id': id, 'x': x, 'y': y, 't': t, 'pointerType': 'touch'};

void main() {
  tearDown(() => AqutterNativeHost.instance.stop());

  Widget host(Widget child) => Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: SizedBox(width: 200, height: 100, child: child)),
      );

  testWidgets('a tap from the web triggers GestureDetector.onTap', (tester) async {
    var taps = 0;
    await tester.pumpWidget(host(AqutterNative(
      sessionId: 'tap',
      injectPointers: true,
      child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: () => taps++, child: const SizedBox.expand()),
    )));
    await _send(tester, 'tap', [_pointer('down', 1, 0.5, 0.5), _pointer('up', 1, 0.5, 0.5)]);
    expect(taps, 1);
  });

  testWidgets('does nothing unless injectPointers is on', (tester) async {
    var taps = 0;
    await tester.pumpWidget(host(AqutterNative(
      sessionId: 'off',
      child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: () => taps++, child: const SizedBox.expand()),
    )));
    await _send(tester, 'off', [_pointer('down', 1, 0.5, 0.5), _pointer('up', 1, 0.5, 0.5)]);
    expect(taps, 0);
  });

  testWidgets('a drag from the web delivers pan updates in app coordinates', (tester) async {
    var dx = 0.0;
    var started = false;
    await tester.pumpWidget(host(AqutterNative(
      sessionId: 'pan',
      injectPointers: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (_) => started = true,
        onPanUpdate: (details) => dx += details.delta.dx,
        child: const SizedBox.expand(),
      ),
    )));
    await _send(tester, 'pan', [
      _pointer('down', 1, 0.2, 0.5),
      for (var i = 1; i <= 10; i++) _pointer('move', 1, 0.2 + i * 0.05, 0.5),
      _pointer('up', 1, 0.7, 0.5),
    ]);
    expect(started, isTrue);
    // 移動 0.5 × 200 = 100 邏輯像素；扣掉拖曳判定的門檻後，剩下的位移都該送到
    expect(dx, inInclusiveRange(60, 100));
  });

  testWidgets('two quick taps are a double tap decided by Flutter', (tester) async {
    var taps = 0;
    var doubles = 0;
    await tester.pumpWidget(host(AqutterNative(
      sessionId: 'double',
      injectPointers: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => taps++,
        onDoubleTap: () => doubles++,
        child: const SizedBox.expand(),
      ),
    )));
    await _send(tester, 'double', [
      _pointer('down', 1, 0.5, 0.5), _pointer('up', 1, 0.5, 0.5),
      _pointer('down', 2, 0.5, 0.5), _pointer('up', 2, 0.5, 0.5),
    ], gap: const Duration(milliseconds: 40));
    expect(doubles, 1);
    expect(taps, 0); // 雙擊成立，單擊不會再觸發（Flutter 的標準行為）
  });

  testWidgets('two fingers apart scale up (multi-touch)', (tester) async {
    var scale = 1.0;
    await tester.pumpWidget(host(AqutterNative(
      sessionId: 'pinch',
      injectPointers: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onScaleUpdate: (details) => scale = details.scale,
        child: const SizedBox.expand(),
      ),
    )));
    await _send(tester, 'pinch', [
      _pointer('down', 1, 0.4, 0.5),
      _pointer('down', 2, 0.6, 0.5),
      for (var i = 1; i <= 10; i++) ...[
        _pointer('move', 1, 0.4 - i * 0.01, 0.5),
        _pointer('move', 2, 0.6 + i * 0.01, 0.5),
      ],
      _pointer('up', 1, 0.3, 0.5),
      _pointer('up', 2, 0.7, 0.5),
    ]);
    // 兩指間距從 0.2 變成 0.4（相對元件寬）→ 倍率約 2
    expect(scale, closeTo(2, 0.3));
  });

  testWidgets('the injector ignores malformed or unattached input', (tester) async {
    final injector = AqutterNativePointerInjector();
    injector.handle(const AqutterNativeMessage('pointer', {'phase': 'down'}), null);
    injector.handle(const AqutterNativeMessage('tap', {'x': 0.5, 'y': 0.5}), null);
    expect(injector.activeCount, 0);
  });
}
