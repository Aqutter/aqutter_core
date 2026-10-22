import 'dart:ui';

/// Merges high-frequency pointer input so that at most one method channel call per kind is made
/// for each flush (normally once per frame).
///
/// A 1000 Hz mouse or a trackpad delivers many move/scroll events inside a single frame, yet only
/// the newest position (or the summed scroll delta) can be observed by the page. Sending each one
/// costs a method channel round trip and a WebView2 input injection.
///
/// Ordering is preserved: anything that must be ordered against the merged input (button
/// down/up, enter/leave, touch down/up) calls [flush] first.
class InputCoalescer {
  InputCoalescer({
    required this.sendCursorPos,
    required this.sendScroll,
    required this.sendTouchUpdate,
    required this.schedule,
  });

  final void Function(Offset position) sendCursorPos;
  final void Function(double dx, double dy) sendScroll;
  final void Function(
    int pointer,
    Offset position,
    double size,
    double pressure,
  )
  sendTouchUpdate;

  /// Arranges for [flush] to run later, typically at the start of the next frame.
  /// Called at most once per batch of pending input.
  final void Function(void Function() flush) schedule;

  Offset? _cursor;
  // Last position actually sent, so a hover that did not move is not sent again.
  Offset? _lastSentCursor;
  double _scrollDx = 0;
  double _scrollDy = 0;
  bool _hasScroll = false;
  // LinkedHashMap keeps first-seen order of pointers.
  final Map<int, _TouchUpdate> _touches = <int, _TouchUpdate>{};
  bool _scheduled = false;
  bool _disposed = false;

  bool get hasPending => _cursor != null || _hasScroll || _touches.isNotEmpty;

  void moveCursor(Offset position) {
    if (_disposed) return;
    _cursor = position;
    _arm();
  }

  void addScroll(double dx, double dy) {
    if (_disposed) return;
    _scrollDx += dx;
    _scrollDy += dy;
    _hasScroll = true;
    _arm();
  }

  void touchUpdate(int pointer, Offset position, double size, double pressure) {
    if (_disposed) return;
    _touches[pointer] = _TouchUpdate(position, size, pressure);
    _arm();
  }

  /// Sends everything pending now. Safe to call when nothing is pending.
  void flush() {
    if (_disposed) return;
    final cursor = _cursor;
    final hasScroll = _hasScroll;
    final dx = _scrollDx;
    final dy = _scrollDy;
    final touches = _touches.isEmpty
        ? const <MapEntry<int, _TouchUpdate>>[]
        : List<MapEntry<int, _TouchUpdate>>.of(_touches.entries);

    _cursor = null;
    _hasScroll = false;
    _scrollDx = 0;
    _scrollDy = 0;
    _touches.clear();

    if (cursor != null && cursor != _lastSentCursor) {
      _lastSentCursor = cursor;
      sendCursorPos(cursor);
    }
    for (final t in touches) {
      sendTouchUpdate(t.key, t.value.position, t.value.size, t.value.pressure);
    }
    if (hasScroll && (dx != 0 || dy != 0)) {
      sendScroll(dx, dy);
    }
  }

  /// Forgets the last sent cursor position so the next one is always sent. Call when something
  /// other than the pointer changed what is under it (enter / leave, layout change).
  void resetLastSentCursor() => _lastSentCursor = null;

  /// Drops pending input without sending it.
  void dispose() {
    _disposed = true;
    _cursor = null;
    _hasScroll = false;
    _touches.clear();
  }

  void _arm() {
    if (_scheduled) return;
    _scheduled = true;
    schedule(() {
      _scheduled = false;
      flush();
    });
  }
}

class _TouchUpdate {
  const _TouchUpdate(this.position, this.size, this.pressure);
  final Offset position;
  final double size;
  final double pressure;
}
