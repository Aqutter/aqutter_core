import 'package:aqutter_core/src/nativeview/native_inflight.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// 以假時鐘模擬：每秒呼叫一次 onTick，幀率由 [fpsFor] 依目前在途幀數決定。
  int simulate({required double Function(int window) fpsFor, int seconds = 20, AqutterNativeInFlightController? controller}) {
    final c = controller ?? AqutterNativeInFlightController();
    var frames = 0.0;
    var now = Duration.zero;
    var window = c.onTick(now, 0);
    for (var i = 0; i < seconds; i++) {
      now += const Duration(seconds: 1);
      frames += fpsFor(window);
      window = c.onTick(now, frames.round());
    }
    return window;
  }

  test('picks 1 when the frame rate does not depend on the window (capture bound)', () {
    expect(simulate(fpsFor: (_) => 15), 1);
  });

  test('keeps 3 when fewer in-flight frames cost a lot of throughput', () {
    expect(simulate(fpsFor: (w) => w == 1 ? 30 : w == 2 ? 45 : 60), 3);
  });

  test('picks 2 when 2 is almost as fast as 3 but 1 is clearly slower', () {
    expect(simulate(fpsFor: (w) => w == 1 ? 40 : 58), 2);
  });

  test('does not probe while the content is idle', () {
    final controller = AqutterNativeInFlightController();
    expect(simulate(fpsFor: (_) => 0, controller: controller), 3);
  });

  test('re-probes after the hold time and adapts when the content changes', () {
    final controller = AqutterNativeInFlightController(hold: const Duration(seconds: 5));
    var frames = 0.0;
    var now = Duration.zero;
    var window = controller.onTick(now, 0);
    final before = <int>{};
    final after = <int>{};
    for (var i = 0; i < 60; i++) {
      now += const Duration(seconds: 1);
      final changed = i >= 30; // 內容改變：前半段與在途無關，後半段在途 1 明顯變慢
      frames += changed ? (window == 1 ? 30 : 60) : 15;
      window = controller.onTick(now, frames.round());
      (changed ? after : before).add(window);
    }
    // 內容改變之後重新探測：試過 1（變慢），最後選了 2（與 3 幾乎一樣快）
    expect(before, contains(1));
    expect(after, containsAll([1, 2]));
  });
}
