import 'dart:ui';

import 'package:aqutter_core/src/platforms/windows/src/webview/input_coalescer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late List<String> log;
  late List<void Function()> scheduled;
  late InputCoalescer input;

  setUp(() {
    log = [];
    scheduled = [];
    input = InputCoalescer(
      sendCursorPos: (p) => log.add('cursor ${p.dx},${p.dy}'),
      sendScroll: (dx, dy) => log.add('scroll $dx,$dy'),
      sendTouchUpdate: (id, p, s, pr) => log.add('touch $id ${p.dx},${p.dy}'),
      schedule: scheduled.add,
    );
  });

  void runFrame() {
    final pending = List.of(scheduled);
    scheduled.clear();
    for (final cb in pending) {
      cb();
    }
  }

  test('many moves in one frame send only the newest position', () {
    for (var i = 1; i <= 50; i++) {
      input.moveCursor(Offset(i.toDouble(), 0));
    }
    expect(scheduled, hasLength(1), reason: 'armed once per batch');
    expect(log, isEmpty);
    runFrame();
    expect(log, ['cursor 50.0,0.0']);
  });

  test('scroll deltas are summed', () {
    input.addScroll(0, -10);
    input.addScroll(2, -30);
    input.addScroll(-2, 5);
    runFrame();
    expect(log, ['scroll 0.0,-35.0']);
  });

  test('scroll that cancels out sends nothing', () {
    input.addScroll(0, 10);
    input.addScroll(0, -10);
    runFrame();
    expect(log, isEmpty);
  });

  test('touch updates keep newest per pointer, in first-seen order', () {
    input.touchUpdate(7, const Offset(1, 1), 0, 0);
    input.touchUpdate(3, const Offset(2, 2), 0, 0);
    input.touchUpdate(7, const Offset(9, 9), 0, 0);
    runFrame();
    expect(log, ['touch 7 9.0,9.0', 'touch 3 2.0,2.0']);
  });

  test('flush before an ordered event keeps cursor ahead of the click', () {
    input.moveCursor(const Offset(5, 6));
    input.flush(); // what onPointerDown does before sending button state
    log.add('button down');
    expect(log, ['cursor 5.0,6.0', 'button down']);
    // the frame callback armed earlier must not resend
    runFrame();
    expect(log, ['cursor 5.0,6.0', 'button down']);
  });

  test(
    'input after a manual flush is still delivered by the armed callback',
    () {
      input.moveCursor(const Offset(1, 1));
      input.flush();
      input.moveCursor(const Offset(2, 2));
      expect(scheduled, hasLength(1), reason: 'no second callback needed');
      runFrame();
      expect(log, ['cursor 1.0,1.0', 'cursor 2.0,2.0']);
    },
  );

  test('a new batch after the frame arms again', () {
    input.moveCursor(const Offset(1, 1));
    runFrame();
    input.moveCursor(const Offset(2, 2));
    expect(scheduled, hasLength(1));
    runFrame();
    expect(log, ['cursor 1.0,1.0', 'cursor 2.0,2.0']);
  });

  test('a hover that did not move is not sent again', () {
    input.moveCursor(const Offset(3, 4));
    runFrame();
    input.moveCursor(const Offset(3, 4));
    runFrame();
    expect(log, ['cursor 3.0,4.0']);
    input.moveCursor(const Offset(3, 5));
    runFrame();
    expect(log, ['cursor 3.0,4.0', 'cursor 3.0,5.0']);
  });

  test('after resetLastSentCursor the same position is sent again', () {
    input.moveCursor(const Offset(3, 4));
    runFrame();
    input.resetLastSentCursor();
    input.moveCursor(const Offset(3, 4));
    runFrame();
    expect(log, ['cursor 3.0,4.0', 'cursor 3.0,4.0']);
  });

  test('dispose drops pending input and ignores later input', () {
    input.moveCursor(const Offset(1, 1));
    input.dispose();
    runFrame();
    input.moveCursor(const Offset(2, 2));
    input.flush();
    expect(log, isEmpty);
  });
}
