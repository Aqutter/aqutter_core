// Drives the real Windows WebView2 through the custom platform view and has the page report
// what it actually received. Run with:
//   flutter test integration_test/windows_input_test.dart -d windows
import 'dart:async';
import 'dart:convert';

import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

const _html = '''<!doctype html><html><body style="margin:0;height:6000px">
<script>
window.__s = {moves:0,lastX:-1,lastY:-1,wheelEvents:0,wheel:0,down:0,up:0,
  downX:-1,downY:-1,resizes:0,w:innerWidth,h:innerHeight};
addEventListener('mousemove', e => {__s.moves++; __s.lastX=e.clientX; __s.lastY=e.clientY;});
addEventListener('wheel', e => {__s.wheelEvents++; __s.wheel+=e.deltaY;}, {passive:true});
addEventListener('mousedown', e => {__s.down++; __s.downX=e.clientX; __s.downY=e.clientY;});
addEventListener('mouseup', e => {__s.up++;});
addEventListener('resize', () => {__s.resizes++; __s.w=innerWidth; __s.h=innerHeight;});
</script></body></html>''';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('input reaches WebView2 correctly and is coalesced', (tester) async {
    final controllerC = Completer<AqutterWebViewController>();
    final loaded = Completer<void>();
    final size = ValueNotifier<Size>(const Size(400, 400));

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Align(
          alignment: Alignment.topLeft,
          child: ValueListenableBuilder<Size>(
            valueListenable: size,
            builder: (context, s, _) => SizedBox(
              width: s.width,
              height: s.height,
              child: AqutterWebView(
                initialData: AqutterWebViewInitialData(data: _html),
                onWebViewCreated: (c) {
                  if (!controllerC.isCompleted) controllerC.complete(c);
                },
                onLoadStop: (c, url) {
                  if (!loaded.isCompleted) loaded.complete();
                },
              ),
            ),
          ),
        ),
      ),
    );

    final controller = await tester.runAsync(() => controllerC.future.timeout(const Duration(seconds: 60)));
    await tester.runAsync(() => loaded.future.timeout(const Duration(seconds: 60)));
    // Let the first size/position reports reach WebView2 and the page settle.
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.runAsync(() => Future<void>.delayed(const Duration(seconds: 1)));

    Future<Map<String, dynamic>> stats() async {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 500)));
      final raw = await tester.runAsync(() => controller!.evaluateJavascript(source: 'JSON.stringify(window.__s)'));
      return jsonDecode(raw as String) as Map<String, dynamic>;
    }

    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: const Offset(5, 5));
    await tester.pump();

    // --- 1. many moves inside ONE frame -> newest position wins, far fewer events -------------
    final before = await stats();
    const sent = 200;
    for (var i = 1; i <= sent; i++) {
      await mouse.moveTo(Offset(10.0 + i, 100)); // ends at (210, 100)
    }
    await tester.pump(); // the single frame that flushes the coalescer
    await tester.pump(const Duration(milliseconds: 50));
    final afterMoves = await stats();
    final jsMoves = (afterMoves['moves'] as int) - (before['moves'] as int);
    debugPrint('MOVES sent=$sent receivedByPage=$jsMoves last=(${afterMoves['lastX']}, ${afterMoves['lastY']})');
    expect(jsMoves, greaterThan(0), reason: 'page must see the pointer');
    expect(jsMoves, lessThan(sent ~/ 4), reason: 'moves of one frame must be merged');
    final ratio = (afterMoves['lastX'] as num) / (afterMoves['lastY'] as num);
    expect(ratio, closeTo(2.1, 0.15), reason: 'last position must be the newest one (210,100)');

    // calibration: what the page reports for ONE wheel event of 10 logical px
    final wheelCal0 = (await stats())['wheel'] as num;
    await tester.sendEventToBinding(PointerScrollEvent(
      position: const Offset(200, 200),
      scrollDelta: const Offset(0, 10),
      kind: PointerDeviceKind.mouse,
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    final perEvent = ((await stats())['wheel'] as num) - wheelCal0;
    debugPrint('WHEEL calibration: one event of 10px -> page deltaY=$perEvent');
    expect(perEvent, greaterThan(0));

    // --- 2. wheel deltas are summed, not dropped ---------------------------------------------
    final wheelBase = (await stats());
    for (var i = 0; i < 20; i++) {
      await tester.sendEventToBinding(PointerScrollEvent(
        position: const Offset(200, 200),
        scrollDelta: const Offset(0, 10),
        kind: PointerDeviceKind.mouse,
      ));
    }
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    final afterWheel = await stats();
    debugPrint('WHEEL sent=20 receivedByPage=${(afterWheel['wheelEvents'] as int)} totalDeltaY=${afterWheel['wheel']}');
    final gotEvents = (afterWheel['wheelEvents'] as int) - (wheelBase['wheelEvents'] as int);
    final gotDelta = (afterWheel['wheel'] as num) - (wheelBase['wheel'] as num);
    debugPrint('WHEEL merged: events=$gotEvents delta=$gotDelta expected=${perEvent * 20}');
    expect(gotEvents, greaterThan(0));
    expect(gotEvents, lessThan(20), reason: '20 wheel events of one frame must be merged');
    expect(gotDelta, closeTo(perEvent * 20, perEvent), reason: 'summed delta must equal 20 single events');

    // --- 3. click happens at the position just moved to (ordering preserved) ---------------
    await mouse.moveTo(const Offset(50, 50));
    await mouse.down(const Offset(50, 50)); // same frame: pending move must be flushed first
    await mouse.up();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    final afterClick = await stats();
    debugPrint('CLICK down=${afterClick['down']} up=${afterClick['up']} at=(${afterClick['downX']}, ${afterClick['downY']})');
    expect(afterClick['down'], 1);
    expect(afterClick['up'], 1);
    expect((afterClick['downX'] as num) / (afterClick['downY'] as num), closeTo(1.0, 0.1),
        reason: 'click must land on (50,50), not on an older hover position');

    // --- 4. resize -> page viewport follows, with a bounded number of resize events --------
    final w0 = afterClick['w'] as num;
    final r0 = afterClick['resizes'] as int;
    for (final s in const [Size(450, 450), Size(500, 500), Size(560, 540), Size(640, 600)]) {
      size.value = s;
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 16));
    }
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    final afterResize = await stats();
    debugPrint('RESIZE innerWidth $w0 -> ${afterResize['w']} x ${afterResize['h']}, resizeEvents=${(afterResize['resizes'] as int) - r0}');
    expect(afterResize['w'] as num, greaterThan(w0 * 1.4), reason: 'page viewport must grow with the widget');
    expect((afterResize['w'] as num) / (afterResize['h'] as num), closeTo(640 / 600, 0.1));

    // Unmount and let native focus callbacks drain before the harness tears the binding down.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 500)));
  });
}
