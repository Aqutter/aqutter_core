import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// 連上工作階段並對每幀回 ack，統計一段時間內收到幾幀、各幀大小與最後一幀的像素寬。
Future<({int frames, int bytes, int width})> _measure(WidgetTester tester, String id, Duration window, {Map<String, Object>? resize, ValueNotifier<int>? animate}) async {
  var frames = 0;
  var bytes = 0;
  var width = 0;
  await tester.runAsync(() async {
    final endpoint = await AqutterNativeHost.instance.ensureStarted();
    final socket = await WebSocket.connect('ws://127.0.0.1:${endpoint.port}/native/$id?token=${endpoint.token}');
    var isHeader = true; // 一幀 = 標頭 + 像素兩則訊息
    var closing = false; // 關閉連線後不能再回 ack
    socket.listen((data) {
      final list = data as List<int>;
      bytes += list.length;
      if (isHeader) {
        frames += 1;
        width = (list[0]) | (list[1] << 8) | (list[2] << 16) | (list[3] << 24);
        if (!closing) {
          socket.add(jsonEncode({'type': 'ack'}));
        }
      }
      isHeader = !isHeader;
    });
    if (resize != null) {
      socket.add(jsonEncode({'type': 'resize', ...resize}));
    }
    final end = DateTime.now().add(window);
    while (DateTime.now().isBefore(end)) {
      if (animate != null) {
        animate.value += 1; // 內容每 16ms 改變一次，並驅動一幀
        await tester.pump();
      }
      await Future<void>.delayed(const Duration(milliseconds: 16));
    }
    closing = true;
    await socket.close();
    // 等伺服器端處理完斷線：否則 widget dispose 時 host 還會去關這個連線，在 fake async 下留下計時器
    await Future<void>.delayed(const Duration(milliseconds: 150));
  });
  return (frames: frames, bytes: bytes, width: width);
}

class _Painter extends StatelessWidget {
  const _Painter(this.counter);

  final ValueNotifier<int> counter;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<int>(
        valueListenable: counter,
        builder: (context, n, _) => ColoredBox(color: Color(0xFF000000 + (n * 7919) % 0xFFFFFF), child: const SizedBox.expand()),
      );
}

void main() {
  tearDown(() => AqutterNativeHost.instance.stop());

  Widget host(Widget child) => Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: SizedBox(width: 200, height: 100, child: child)),
      );

  testWidgets('static content is captured once, not on every tick', (tester) async {
    await tester.pumpWidget(host(const AqutterNative(sessionId: 'static', fps: 60, child: ColoredBox(color: Color(0xFF3366FF), child: SizedBox.expand()))));
    final result = await _measure(tester, 'static', const Duration(milliseconds: 600));
    expect(result.frames, inInclusiveRange(1, 2));
  });

  testWidgets('skipUnchanged: false keeps streaming the same picture (baseline)', (tester) async {
    await tester.pumpWidget(host(const AqutterNative(sessionId: 'baseline', fps: 60, skipUnchanged: false, child: ColoredBox(color: Color(0xFF3366FF), child: SizedBox.expand()))));
    final result = await _measure(tester, 'baseline', const Duration(milliseconds: 600));
    expect(result.frames, greaterThan(5));
  });

  testWidgets('changing content keeps streaming', (tester) async {
    final counter = ValueNotifier<int>(0);
    addTearDown(counter.dispose);
    await tester.pumpWidget(host(AqutterNative(sessionId: 'moving', fps: 60, child: _Painter(counter))));
    final result = await _measure(tester, 'moving', const Duration(milliseconds: 600), animate: counter);
    expect(result.frames, greaterThan(5));
  });

  testWidgets('captures at the resolution the web reported', (tester) async {
    await tester.pumpWidget(host(const AqutterNative(sessionId: 'sized', fps: 60, pixelRatio: 3, child: ColoredBox(color: Color(0xFF3366FF), child: SizedBox.expand()))));
    // 元件 200x100 logical；網頁顯示 100x50 CSS px、dpr 2 → 只需要 200x100 像素（倍率 1），不是 pixelRatio 3 的 600 寬
    final result = await _measure(tester, 'sized', const Duration(milliseconds: 600), resize: {'width': 100, 'height': 50, 'dpr': 2});
    expect(result.width, 200);
  });

  testWidgets('matchViewportAspect lays the child out with the web element aspect', (tester) async {
    await tester.pumpWidget(host(const AqutterNative(sessionId: 'aspect', fps: 60, matchViewportAspect: true, child: ColoredBox(color: Color(0xFF3366FF), child: SizedBox.expand()))));
    // 元件 200x100；網頁元素 1:1（100x100、dpr 1）→ 子畫面縮成 100x100，剛好 1:1 擷取成 100 像素寬
    final tick = ValueNotifier<int>(0); // 只用來讓測試每 16ms pump 一次，好讓回報尺寸後的重新排版發生
    addTearDown(tick.dispose);
    final result = await _measure(tester, 'aspect', const Duration(milliseconds: 600), resize: {'width': 100, 'height': 100, 'dpr': 1}, animate: tick);
    expect(result.width, 100);
  });

  testWidgets('captureOverride supplies the frames instead of the RepaintBoundary', (tester) async {
    var calls = 0;
    Future<AqutterNativeFrame?> snapshot() async {
      calls += 1;
      return AqutterNativeFrame(width: 2, height: 2, format: AqutterNativeFormat.rgba, payload: Uint8List.fromList(const [1, 2, 3]));
    }

    await tester.pumpWidget(host(AqutterNative(
      sessionId: 'override',
      fps: 60,
      captureOverride: snapshot,
      child: const ColoredBox(color: Color(0xFF3366FF), child: SizedBox.expand()),
    )));
    final result = await _measure(tester, 'override', const Duration(milliseconds: 600));
    expect(calls, greaterThan(3)); // 沒有「重繪計數沒變就跳過」：靠輪詢持續取畫面
    expect(result.frames, greaterThan(3));
  });
}
