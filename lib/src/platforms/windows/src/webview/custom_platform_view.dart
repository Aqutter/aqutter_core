import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../platform_util.dart';
import 'input_coalescer.dart';
import '_static_channel.dart';

const Map<String, SystemMouseCursor> _cursors = {
  'none': SystemMouseCursors.none,
  'basic': SystemMouseCursors.basic,
  'click': SystemMouseCursors.click,
  'forbidden': SystemMouseCursors.forbidden,
  'wait': SystemMouseCursors.wait,
  'progress': SystemMouseCursors.progress,
  'contextMenu': SystemMouseCursors.contextMenu,
  'help': SystemMouseCursors.help,
  'text': SystemMouseCursors.text,
  'verticalText': SystemMouseCursors.verticalText,
  'cell': SystemMouseCursors.cell,
  'precise': SystemMouseCursors.precise,
  'move': SystemMouseCursors.move,
  'grab': SystemMouseCursors.grab,
  'grabbing': SystemMouseCursors.grabbing,
  'noDrop': SystemMouseCursors.noDrop,
  'alias': SystemMouseCursors.alias,
  'copy': SystemMouseCursors.copy,
  'disappearing': SystemMouseCursors.disappearing,
  'allScroll': SystemMouseCursors.allScroll,
  'resizeLeftRight': SystemMouseCursors.resizeLeftRight,
  'resizeUpDown': SystemMouseCursors.resizeUpDown,
  'resizeUpLeftDownRight': SystemMouseCursors.resizeUpLeftDownRight,
  'resizeUpRightDownLeft': SystemMouseCursors.resizeUpRightDownLeft,
  'resizeUp': SystemMouseCursors.resizeUp,
  'resizeDown': SystemMouseCursors.resizeDown,
  'resizeLeft': SystemMouseCursors.resizeLeft,
  'resizeRight': SystemMouseCursors.resizeRight,
  'resizeUpLeft': SystemMouseCursors.resizeUpLeft,
  'resizeUpRight': SystemMouseCursors.resizeUpRight,
  'resizeDownLeft': SystemMouseCursors.resizeDownLeft,
  'resizeDownRight': SystemMouseCursors.resizeDownRight,
  'resizeColumn': SystemMouseCursors.resizeColumn,
  'resizeRow': SystemMouseCursors.resizeRow,
  'zoomIn': SystemMouseCursors.zoomIn,
  'zoomOut': SystemMouseCursors.zoomOut,
};

SystemMouseCursor _getCursorByName(String name) =>
    _cursors[name] ?? SystemMouseCursors.basic;

/// Pointer button type
// Order must match AqutterWebViewPointerEventKind (see in_app_webview.h)
enum PointerButton { none, primary, secondary, tertiary }

/// Pointer Event kind
// Order must match AqutterWebViewPointerEventKind (see in_app_webview.h)
enum AqutterWebViewPointerEventKind {
  activate,
  down,
  enter,
  leave,
  up,
  update,
  cancel,
}

/// Attempts to translate a button constant such as [kPrimaryMouseButton]
/// to a [PointerButton]
PointerButton _getButton(int value) {
  switch (value) {
    case kPrimaryMouseButton:
      return PointerButton.primary;
    case kSecondaryMouseButton:
      return PointerButton.secondary;
    case kTertiaryButton:
      return PointerButton.tertiary;
    default:
      return PointerButton.none;
  }
}

const MethodChannel _pluginChannel = IN_APP_WEBVIEW_STATIC_CHANNEL;

class CustomFlutterViewControllerValue {
  const CustomFlutterViewControllerValue({required this.isInitialized});

  final bool isInitialized;

  CustomFlutterViewControllerValue copyWith({bool? isInitialized}) {
    return CustomFlutterViewControllerValue(
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  CustomFlutterViewControllerValue.uninitialized() : this(isInitialized: false);
}

/// Controls a WebView and provides streams for various change events.
class CustomPlatformViewController
    extends ValueNotifier<CustomFlutterViewControllerValue> {
  Completer<void> _creatingCompleter = Completer<void>();
  int _textureId = 0;
  bool _isDisposed = false;

  Future<void> get ready => _creatingCompleter.future;

  late MethodChannel _methodChannel;
  late EventChannel _eventChannel;
  StreamSubscription? _eventStreamSubscription;

  final StreamController<SystemMouseCursor> _cursorStreamController =
      StreamController<SystemMouseCursor>.broadcast();

  /// A stream reflecting the current cursor style.
  Stream<SystemMouseCursor> get _cursor => _cursorStreamController.stream;

  CustomPlatformViewController()
    : super(CustomFlutterViewControllerValue.uninitialized());

  /// Initializes the underlying platform view.
  Future<void> initialize({
    Function(int id)? onPlatformViewCreated,
    dynamic arguments,
  }) async {
    if (_isDisposed) {
      return;
    }
    _textureId = (await _pluginChannel.invokeMethod<int>(
      'createAqutterWebView',
      arguments,
    ))!;

    _methodChannel = MethodChannel(
      'com.github.aqutter/custom_platform_view_$_textureId',
    );
    _eventChannel = EventChannel(
      'com.github.aqutter/custom_platform_view_${_textureId}_events',
    );
    _eventStreamSubscription = _eventChannel.receiveBroadcastStream().listen((
      event,
    ) {
      final map = event as Map<dynamic, dynamic>;
      switch (map['type']) {
        case 'cursorChanged':
          _cursorStreamController.add(_getCursorByName(map['value']));
          break;
      }
    });

    _methodChannel.setMethodCallHandler((call) {
      throw MissingPluginException('Unknown method ${call.method}');
    });

    value = value.copyWith(isInitialized: true);

    _creatingCompleter.complete();

    onPlatformViewCreated?.call(_textureId);
  }

  @override
  Future<void> dispose() async {
    await _creatingCompleter.future;
    if (!_isDisposed) {
      _isDisposed = true;
      await _eventStreamSubscription?.cancel();
      await _pluginChannel.invokeMethod('dispose', {"id": _textureId});
    }
    super.dispose();
  }

  /// Limits the number of frames per second to the given value.
  Future<void> setFpsLimit([int? maxFps = 0]) async {
    if (_isDisposed) {
      return;
    }
    assert(value.isInitialized);
    return _methodChannel.invokeMethod('setFpsLimit', maxFps);
  }

  /// Sends a Pointer (Touch) update
  Future<void> _setPointerUpdate(
    AqutterWebViewPointerEventKind kind,
    int pointer,
    Offset position,
    double size,
    double pressure,
  ) async {
    if (_isDisposed) {
      return;
    }
    assert(value.isInitialized);
    return _methodChannel.invokeMethod('setPointerUpdate', [
      pointer,
      kind.index,
      position.dx,
      position.dy,
      size,
      pressure,
    ]);
  }

  /// Moves the virtual cursor to [position].
  Future<void> _setCursorPos(Offset position) async {
    if (_isDisposed) {
      return;
    }
    assert(value.isInitialized);
    return _methodChannel.invokeMethod('setCursorPos', [
      position.dx,
      position.dy,
    ]);
  }

  /// Indicates whether the specified [button] is currently down.
  Future<void> _setPointerButtonState(
    AqutterWebViewPointerEventKind kind,
    PointerButton button,
  ) async {
    if (_isDisposed) {
      return;
    }
    assert(value.isInitialized);
    return _methodChannel.invokeMethod('setPointerButton', <String, dynamic>{
      'kind': kind.index,
      'button': button.index,
    });
  }

  /// Sets the horizontal and vertical scroll delta.
  Future<void> _setScrollDelta(double dx, double dy) async {
    if (_isDisposed) {
      return;
    }
    assert(value.isInitialized);
    return _methodChannel.invokeMethod('setScrollDelta', [dx, dy]);
  }

  /// Sets the surface size to the provided [size].
  Future<void> _setSize(Size size, double scaleFactor) async {
    if (_isDisposed) {
      return;
    }
    assert(value.isInitialized);
    return _methodChannel.invokeMethod('setSize', [
      size.width,
      size.height,
      scaleFactor,
    ]);
  }

  /// Sets the surface size to the provided [size].
  Future<void> _setPosition(Offset position, double scaleFactor) async {
    if (_isDisposed) {
      return;
    }
    assert(value.isInitialized);
    return _methodChannel.invokeMethod('setPosition', [
      position.dx,
      position.dy,
      scaleFactor,
    ]);
  }
}

class CustomPlatformView extends StatefulWidget {
  /// An optional scale factor. Defaults to [FlutterView.devicePixelRatio] for
  /// rendering in native resolution.
  /// Setting this to 1.0 will disable high-DPI support.
  /// This should only be needed to mimic old behavior before high-DPI support
  /// was available.
  final double? scaleFactor;

  /// The [FilterQuality] used for scaling the texture's contents.
  /// Defaults to [FilterQuality.none] as this renders in native resolution
  /// unless specifying a [scaleFactor].
  final FilterQuality filterQuality;

  final dynamic creationParams;

  final Function(int id)? onPlatformViewCreated;

  const CustomPlatformView({
    this.creationParams,
    this.onPlatformViewCreated,
    this.scaleFactor,
    this.filterQuality = FilterQuality.none,
  });

  @override
  _CustomPlatformViewState createState() => _CustomPlatformViewState();
}

class _CustomPlatformViewState extends State<CustomPlatformView>
    with PlatformUtilListener {
  final GlobalKey _key = GlobalKey();
  final _downButtons = <int, PointerButton>{};

  PointerDeviceKind _pointerKind = PointerDeviceKind.unknown;

  MouseCursor _cursor = SystemMouseCursors.basic;

  /// Where the in-flight trackpad gesture's synthetic contact went down.
  Offset _panContactOrigin = Offset.zero;

  /// Total pan reported so far by the in-flight gesture; the end event does not carry it.
  Offset _panTotal = Offset.zero;

  /// Geometry last reported from a pointer down, so an unchanged one can be skipped.
  ///
  /// Only that call site is deduplicated. Clicking never moves or resizes the view, yet every
  /// press costs two method channel round trips and makes WebView2 redo put_Bounds and
  /// SetWindowPos. The other call sites must keep repeating: a report that arrives before the
  /// WebView2 controller exists is dropped natively, and it is a later repeat that actually
  /// applies the bounds -- deduplicating them leaves the WebView blank.
  Size? _pointerDownSize;
  Offset? _pointerDownPosition;

  final _controller = CustomPlatformViewController();
  final _focusNode = FocusNode();

  /// Merges move / scroll / touch-update input to one channel call per frame.
  /// Everything that must stay ordered against it calls `_input.flush()` first.
  late final InputCoalescer _input = InputCoalescer(
    sendCursorPos: _controller._setCursorPos,
    sendScroll: _controller._setScrollDelta,
    sendTouchUpdate: (pointer, position, size, pressure) =>
        _controller._setPointerUpdate(
          AqutterWebViewPointerEventKind.update,
          pointer,
          position,
          size,
          pressure,
        ),
    schedule: (flush) =>
        SchedulerBinding.instance.scheduleFrameCallback((_) => flush()),
  );

  /// Whether a surface size / position report is already queued for the end of this frame.
  bool _geometryReportQueued = false;

  StreamSubscription? _cursorSubscription;

  late final AppLifecycleListener _listener;

  PlatformUtil _platformUtil = PlatformUtil.instance();

  @override
  void initState() {
    super.initState();

    _platformUtil.addListener(this);

    _controller.initialize(
      onPlatformViewCreated: (id) {
        widget.onPlatformViewCreated?.call(id);
        setState(() {});
      },
      arguments: widget.creationParams,
    );

    _listener = AppLifecycleListener(
      onStateChange: (state) {
        if ([
          AppLifecycleState.resumed,
          AppLifecycleState.hidden,
        ].contains(state)) {
          _queueGeometryReport();
        }
      },
    );

    // Report initial surface size and widget position
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reportSurfaceSize();
      _reportWidgetPosition();
    });

    _cursorSubscription = _controller._cursor.listen((cursor) {
      setState(() {
        _cursor = cursor;
      });
    });
  }

  @override
  void onWindowMove() {
    _queueGeometryReport();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      focusNode: _focusNode,
      canRequestFocus: true,
      debugLabel: "aqutter_core_windows_custom_platform_view",
      onFocusChange: (focused) {},
      child: SizedBox.expand(key: _key, child: _buildInner()),
    );
  }

  Widget _buildInner() {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (notification) {
        _queueGeometryReport();
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: _controller.value.isInitialized
            ? Listener(
                onPointerHover: (ev) {
                  // ev.kind is for whatever reason not set to touch
                  // even on touch input
                  if (_pointerKind == PointerDeviceKind.touch) {
                    // Ignoring hover events on touch for now
                    return;
                  }
                  _input.moveCursor(ev.localPosition);
                },
                onPointerDown: (ev) {
                  _input.flush();
                  _reportGeometryIfMoved();

                  if (!_focusNode.hasFocus) {
                    _focusNode.requestFocus();
                    Future.delayed(const Duration(milliseconds: 50), () {
                      if (!_focusNode.hasFocus) {
                        _focusNode.requestFocus();
                      }
                    });
                  }

                  _pointerKind = ev.kind;
                  if (ev.kind == PointerDeviceKind.touch) {
                    _controller._setPointerUpdate(
                      AqutterWebViewPointerEventKind.down,
                      ev.pointer,
                      ev.localPosition,
                      ev.size,
                      ev.pressure,
                    );
                    return;
                  }
                  final button = _getButton(ev.buttons);
                  _downButtons[ev.pointer] = button;
                  _controller._setPointerButtonState(
                    AqutterWebViewPointerEventKind.down,
                    button,
                  );
                },
                onPointerUp: (ev) {
                  _input.flush();
                  _pointerKind = ev.kind;
                  if (ev.kind == PointerDeviceKind.touch) {
                    _controller._setPointerUpdate(
                      AqutterWebViewPointerEventKind.up,
                      ev.pointer,
                      ev.localPosition,
                      ev.size,
                      ev.pressure,
                    );
                    return;
                  }
                  final button = _downButtons.remove(ev.pointer);
                  if (button != null) {
                    _controller._setPointerButtonState(
                      AqutterWebViewPointerEventKind.up,
                      button,
                    );
                  }
                },
                onPointerCancel: (ev) {
                  _input.flush();
                  _pointerKind = ev.kind;
                  final button = _downButtons.remove(ev.pointer);
                  if (button != null) {
                    _controller._setPointerButtonState(
                      AqutterWebViewPointerEventKind.cancel,
                      button,
                    );
                  }
                },
                onPointerMove: (ev) {
                  _pointerKind = ev.kind;
                  if (ev.kind == PointerDeviceKind.touch) {
                    _input.touchUpdate(
                      ev.pointer,
                      ev.localPosition,
                      ev.size,
                      ev.pressure,
                    );
                  } else {
                    _input.moveCursor(ev.localPosition);
                  }
                },
                onPointerSignal: (signal) {
                  if (signal is PointerScrollEvent) {
                    _input.addScroll(
                      -signal.scrollDelta.dx,
                      -signal.scrollDelta.dy,
                    );
                  }
                },
                onPointerPanZoomStart: (ev) {
                  // A trackpad gesture is handed over as a touch contact that starts under the
                  // cursor and then follows the fingers, leaving the scrolling itself to the
                  // browser. That is what produces momentum after the fingers lift, and what
                  // lets a diagonal swipe move both axes at once -- a synthetic wheel carries
                  // one axis per event and can express neither.
                  _input.flush();
                  _panContactOrigin = ev.localPosition;
                  _panTotal = Offset.zero;
                  _controller._setPointerUpdate(
                    AqutterWebViewPointerEventKind.down,
                    ev.pointer,
                    ev.localPosition,
                    0,
                    0,
                  );
                },
                onPointerPanZoomUpdate: (ev) {
                  // pan is the total since the gesture began, which is exactly where the
                  // contact should now be. No sign flip: a touch contact follows the fingers,
                  // and so does pan.
                  _panTotal = ev.pan;
                  _input.touchUpdate(
                    ev.pointer,
                    _panContactOrigin + ev.pan,
                    0,
                    0,
                  );
                },
                onPointerPanZoomEnd: (ev) {
                  // Lifting the contact is what lets the browser turn the movement that
                  // preceded it into a fling; the end event carries no pan of its own, so the
                  // last known position is reused.
                  _input.flush();
                  _controller._setPointerUpdate(
                    AqutterWebViewPointerEventKind.up,
                    ev.pointer,
                    _panContactOrigin + _panTotal,
                    0,
                    0,
                  );
                  _panTotal = Offset.zero;
                },
                child: MouseRegion(
                  cursor: _cursor,
                  onEnter: (ev) {
                    _input.flush();
                    final button = _getButton(ev.buttons);
                    _controller._setPointerButtonState(
                      AqutterWebViewPointerEventKind.enter,
                      button,
                    );
                  },
                  onExit: (ev) {
                    _input.flush();
                    final button = _getButton(ev.buttons);
                    _controller._setPointerButtonState(
                      AqutterWebViewPointerEventKind.leave,
                      button,
                    );
                  },
                  child: Texture(
                    textureId: _controller._textureId,
                    filterQuality: widget.filterQuality,
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  /// Reports geometry from a pointer down, skipping the report when nothing moved.
  /// See [_pointerDownSize] for why only this call site may be skipped.
  void _reportGeometryIfMoved() {
    final box = _key.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) {
      return;
    }
    final size = box.size;
    final position = box.localToGlobal(Offset.zero);
    if (size == _pointerDownSize && position == _pointerDownPosition) {
      return;
    }
    _pointerDownSize = size;
    _pointerDownPosition = position;
    _reportSurfaceSize();
    _reportWidgetPosition();
  }

  /// Queues one size + position report for the end of the current frame.
  ///
  /// A window drag or resize fires a layout notification, a window-move callback and a lifecycle
  /// callback for the same frame; each used to cost two method channel calls, and every size
  /// change makes WebView2 redo put_Bounds. Collapsing them keeps the final geometry of the frame
  /// (read after layout) and drops the redundant intermediates. This is deliberately not a timed
  /// debounce: a report must never be postponed past the frame that produced it, because the
  /// native side only applies bounds once its WebView2 controller exists (see [_pointerDownSize]).
  void _queueGeometryReport() {
    if (_geometryReportQueued) {
      return;
    }
    _geometryReportQueued = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _geometryReportQueued = false;
      if (!mounted) {
        return;
      }
      _reportSurfaceSize();
      _reportWidgetPosition();
    });
    WidgetsBinding.instance.ensureVisualUpdate();
  }

  void _reportSurfaceSize() async {
    final box = _key.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      await _controller.ready;
      unawaited(
        _controller._setSize(
          box.size,
          widget.scaleFactor ?? window.devicePixelRatio,
        ),
      );
    }
  }

  void _reportWidgetPosition() async {
    final box = _key.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      await _controller.ready;
      final position = box.localToGlobal(Offset.zero);
      unawaited(
        _controller._setPosition(
          position,
          widget.scaleFactor ?? window.devicePixelRatio,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _platformUtil.removeListener(this);
    _input.dispose();
    _cursorSubscription?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    _listener.dispose();
  }
}
