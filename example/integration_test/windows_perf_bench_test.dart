// Frame-time + CPU benchmark for the Windows custom platform view.
//   flutter test integration_test/windows_perf_bench_test.dart -d windows
// Prints one line per scenario: frames, build/raster ms (avg, p90, worst) and the CPU time the
// app process spent (the test runs inside the app process, so dart:io `pid` is the app).
import 'dart:async';
import 'dart:io';

import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// requestAnimationFrame keeps WebView2 producing a new frame every vsync.
const _html = '''<!doctype html><html><body style="margin:0;height:6000px">
<canvas id="c" width="64" height="64" style="width:100%;height:100%"></canvas>
<script>
const c=document.getElementById('c').getContext('2d');let t=0;
function f(){t++;c.fillStyle='hsl('+(t*3%360)+',80%,50%)';c.fillRect(0,0,64,64);requestAnimationFrame(f);}
f();
</script></body></html>''';

Future<double> _cpuMs(WidgetTester tester) async {
  final out = await tester.runAsync(() => Process.run('powershell', [
        '-NoProfile',
        '-Command',
        '(Get-Process -Id $pid).TotalProcessorTime.TotalMilliseconds',
      ]));
  return double.parse((out!.stdout as String).trim());
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('bench', (tester) async {
    final controllerC = Completer<AqutterWebViewController>();
    final loaded = Completer<void>();
    final size = ValueNotifier<Size>(const Size(500, 400));

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
    await tester.runAsync(() => controllerC.future.timeout(const Duration(seconds: 60)));
    await tester.runAsync(() => loaded.future.timeout(const Duration(seconds: 60)));
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    await tester.runAsync(() => Future<void>.delayed(const Duration(seconds: 2)));

    Future<void> scenario(String name, Future<void> Function() body) async {
      final cpu0 = await _cpuMs(tester);
      final wall = Stopwatch()..start();
      await binding.watchPerformance(body, reportKey: name);
      wall.stop();
      final cpu1 = await _cpuMs(tester);
      final r = binding.reportData?[name] as Map?;
      String f(String k) => (r?[k] is num) ? (r![k] as num).toStringAsFixed(2) : 'n/a';
      debugPrint('BENCH $name wall=${wall.elapsedMilliseconds}ms cpu=${(cpu1 - cpu0).toStringAsFixed(0)}ms '
          'frames=${r?['frame_count']} '
          'build avg=${f('average_frame_build_time_millis')} p90=${f('90th_percentile_frame_build_time_millis')} worst=${f('worst_frame_build_time_millis')} | '
          'raster avg=${f('average_frame_rasterizer_time_millis')} p90=${f('90th_percentile_frame_rasterizer_time_millis')} worst=${f('worst_frame_rasterizer_time_millis')}');
    }

    // A. steady state: page animates every vsync, Flutter does nothing -> capture/copy cost
    await scenario('steady_animation_3s', () async {
      final end = DateTime.now().add(const Duration(seconds: 3));
      while (DateTime.now().isBefore(end)) {
        await tester.pump(const Duration(milliseconds: 16));
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 8)));
      }
    });

    // B. resize sweep: a different size on every frame, like dragging a window edge
    await scenario('resize_sweep_150_frames', () async {
      for (var i = 0; i < 150; i++) {
        final t = i / 149.0;
        size.value = Size(500 + 400 * (t < 0.5 ? t * 2 : (1 - t) * 2), 400 + 250 * (t < 0.5 ? t * 2 : (1 - t) * 2));
        await tester.pump(const Duration(milliseconds: 16));
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 8)));
      }
    });

    // C. input storm: 1000 moves + 100 wheel events per frame, 60 frames
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: const Offset(5, 5));
    await scenario('input_storm_60_frames', () async {
      for (var f = 0; f < 60; f++) {
        for (var i = 0; i < 100; i++) {
          await mouse.moveTo(Offset(20.0 + (f * 7 + i) % 400, 20.0 + (i * 3) % 300));
        }
        for (var i = 0; i < 10; i++) {
          await tester.sendEventToBinding(PointerScrollEvent(
            position: const Offset(200, 200),
            scrollDelta: const Offset(0, 4),
            kind: PointerDeviceKind.mouse,
          ));
        }
        await tester.pump(const Duration(milliseconds: 16));
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 8)));
      }
    });

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 500)));
  });
}
