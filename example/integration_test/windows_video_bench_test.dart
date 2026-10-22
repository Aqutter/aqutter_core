// Heavy-page benchmark: a full-size looping H.264 video plus an animated overlay and a
// CSS-animated grid. A local HTTP server (with Range support) serves the file named by the
// BENCH_VIDEO environment variable.
//   BENCH_VIDEO=C:\path\bench.mp4 flutter test integration_test/windows_video_bench_test.dart -d windows
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

const _html = r'''<!doctype html><html><head><meta charset="utf-8"><style>
body{margin:0;background:#111;color:#fff;font:14px sans-serif}
#v{position:fixed;inset:0;width:100vw;height:100vh;object-fit:cover}
#ov{position:fixed;top:12px;left:12px;padding:8px 12px;background:rgba(0,0,0,.55);border-radius:8px}
.sp{width:28px;height:28px;border:4px solid #fff;border-top-color:transparent;border-radius:50%;animation:r 1s linear infinite;display:inline-block;vertical-align:middle}
@keyframes r{to{transform:rotate(360deg)}}
#grid{position:fixed;right:12px;top:12px;display:grid;grid-template-columns:repeat(8,20px);gap:4px}
#grid i{width:20px;height:20px;background:#0af;animation:p 1.2s ease-in-out infinite alternate}
@keyframes p{to{transform:scale(.4);background:#f0a}}
</style></head><body>
<video id="v" src="/bench.mp4" muted loop autoplay playsinline></video>
<div id="ov"><span class="sp"></span> <b id="t">0</b></div>
<div id="grid"></div>
<script>
const g=document.getElementById('grid');
for(let i=0;i<64;i++){const e=document.createElement('i');e.style.animationDelay=(i*37%1200)+'ms';g.appendChild(e);}
setInterval(()=>{document.getElementById('t').textContent=document.getElementById('v').currentTime.toFixed(2);},100);
window.__q=()=>{const v=document.getElementById('v'),q=v.getVideoPlaybackQuality();
 return JSON.stringify({total:q.totalVideoFrames,dropped:q.droppedVideoFrames,paused:v.paused,t:v.currentTime,rs:v.readyState,w:innerWidth,h:innerHeight});};
</script></body></html>''';

Future<HttpServer> _serve(File video) async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  final len = await video.length();
  server.listen((req) async {
    final res = req.response;
    if (req.uri.path == '/') {
      res.headers.contentType = ContentType.html;
      res.write(_html);
    } else if (req.uri.path == '/bench.mp4') {
      res.headers.set('Accept-Ranges', 'bytes');
      res.headers.contentType = ContentType('video', 'mp4');
      final range = req.headers.value('range');
      var start = 0, end = len - 1;
      if (range != null) {
        final m = RegExp(r'bytes=(\d*)-(\d*)').firstMatch(range)!;
        if (m.group(1)!.isNotEmpty) start = int.parse(m.group(1)!);
        if (m.group(2)!.isNotEmpty) end = int.parse(m.group(2)!);
        res.statusCode = HttpStatus.partialContent;
        res.headers.set('Content-Range', 'bytes $start-$end/$len');
      }
      res.contentLength = end - start + 1;
      await res.addStream(video.openRead(start, end + 1));
    } else {
      res.statusCode = HttpStatus.notFound;
    }
    await res.close();
  });
  return server;
}

Future<double> _cpuMs(WidgetTester tester) async {
  final out = await tester.runAsync(
    () => Process.run('powershell', [
      '-NoProfile',
      '-Command',
      '(Get-Process -Id $pid).TotalProcessorTime.TotalMilliseconds',
    ]),
  );
  return double.parse((out!.stdout as String).trim());
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('video bench', (tester) async {
    final path = Platform.environment['BENCH_VIDEO'];
    expect(path, isNotNull, reason: 'set BENCH_VIDEO to an mp4 file');
    final server = (await tester.runAsync(() => _serve(File(path!))))!;
    addTearDown(() => server.close(force: true));

    final controllerC = Completer<AqutterWebViewController>();
    final loaded = Completer<void>();
    final size = ValueNotifier<Size>(const Size(1280, 720));

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
                initialUrlRequest: AqutterURLRequest(
                  url: AqutterWebUri('http://127.0.0.1:${server.port}/'),
                ),
                initialSettings: AqutterWebViewSettings(
                  mediaPlaybackRequiresUserGesture: false,
                ),
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
    final controller = (await tester.runAsync(
      () => controllerC.future.timeout(const Duration(seconds: 60)),
    ))!;
    await tester.runAsync(
      () => loaded.future.timeout(const Duration(seconds: 60)),
    );
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    Future<Map<String, dynamic>> quality() async {
      final raw = await tester.runAsync(
        () => controller.evaluateJavascript(source: 'window.__q()'),
      );
      return jsonDecode(raw as String) as Map<String, dynamic>;
    }

    // wait until the video is really playing
    var q = await quality();
    for (var i = 0; i < 40 && (q['paused'] == true || (q['total'] as int) < 10); i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 250)),
      );
      await tester.pump();
      q = await quality();
    }
    debugPrint('VIDEO ready: $q');
    expect(q['paused'], false, reason: 'video must be playing');

    Future<void> scenario(String name, Future<void> Function() body) async {
      final q0 = await quality();
      final cpu0 = await _cpuMs(tester);
      final wall = Stopwatch()..start();
      await binding.watchPerformance(body, reportKey: name);
      wall.stop();
      final cpu1 = await _cpuMs(tester);
      final q1 = await quality();
      final r = binding.reportData?[name] as Map?;
      String f(String k) =>
          (r?[k] is num) ? (r![k] as num).toStringAsFixed(2) : 'n/a';
      final dTotal = (q1['total'] as int) - (q0['total'] as int);
      final dDropped = (q1['dropped'] as int) - (q0['dropped'] as int);
      debugPrint(
        'BENCH $name wall=${wall.elapsedMilliseconds}ms '
        'cpu=${(cpu1 - cpu0).toStringAsFixed(0)}ms '
        'flutterFrames=${r?['frame_count']} '
        'build avg=${f('average_frame_build_time_millis')} worst=${f('worst_frame_build_time_millis')} | '
        'raster avg=${f('average_frame_rasterizer_time_millis')} p90=${f('90th_percentile_frame_rasterizer_time_millis')} worst=${f('worst_frame_rasterizer_time_millis')} | '
        'video decoded=$dTotal dropped=$dDropped',
      );
    }

    await scenario('video_steady_5s', () async {
      final end = DateTime.now().add(const Duration(seconds: 5));
      while (DateTime.now().isBefore(end)) {
        await tester.pump(const Duration(milliseconds: 16));
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 8)),
        );
      }
    });

    await scenario('video_resize_sweep_150', () async {
      for (var i = 0; i < 150; i++) {
        final t = i / 149.0;
        final k = t < 0.5 ? t * 2 : (1 - t) * 2;
        size.value = Size(1280 - 280 * k, 720 - 160 * k);
        await tester.pump(const Duration(milliseconds: 16));
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 8)),
        );
      }
    });

    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: const Offset(5, 5));
    await scenario('video_input_storm_60', () async {
      for (var f = 0; f < 60; f++) {
        for (var i = 0; i < 100; i++) {
          await mouse.moveTo(
            Offset(20.0 + (f * 7 + i) % 900, 20.0 + (i * 3) % 500),
          );
        }
        for (var i = 0; i < 10; i++) {
          await tester.sendEventToBinding(
            PointerScrollEvent(
              position: const Offset(400, 300),
              scrollDelta: const Offset(0, 4),
              kind: PointerDeviceKind.mouse,
            ),
          );
        }
        await tester.pump(const Duration(milliseconds: 16));
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 8)),
        );
      }
    });

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 500)),
    );
  });
}
