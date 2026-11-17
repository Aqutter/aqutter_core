import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// 連上工作階段，收集文字訊息（模式回覆）；二進位訊息（幀）計數但不處理。
class _Client {
  _Client._(this.socket) {
    socket.listen((data) {
      if (data is String) {
        texts.add(jsonDecode(data) as Map<String, dynamic>);
        _arrived.add(null);
      }
      else {
        binaryMessages += 1;
      }
    });
  }

  static Future<_Client> connect(AqutterNativeEndpoint endpoint, String id) async {
    final socket = await WebSocket.connect('ws://127.0.0.1:${endpoint.port}/native/$id?token=${endpoint.token}');
    return _Client._(socket);
  }

  final WebSocket socket;
  final List<Map<String, dynamic>> texts = [];
  int binaryMessages = 0;
  final StreamController<void> _arrived = StreamController<void>.broadcast();

  void send(Map<String, Object?> message) => socket.add(jsonEncode(message));

  /// 送出模式請求並等回覆。
  Future<Map<String, dynamic>> negotiate(String request, {bool pageReady = true}) async {
    final before = texts.length;
    send({'type': 'mode', 'request': request, 'pageReady': pageReady});
    while (texts.length == before) {
      await _arrived.stream.first.timeout(const Duration(seconds: 2));
    }
    return texts.last;
  }

  Future<void> close() => socket.close();
}

AqutterNativeSession _session(String id, {AqutterNativeMode mode = AqutterNativeMode.auto, void Function()? onCapture}) {
  return AqutterNativeSession(
    id: id,
    mode: mode,
    maxFps: 60,
    capture: () async {
      onCapture?.call();
      return AqutterNativeFrame(width: 1, height: 1, format: AqutterNativeFormat.rgba, payload: Uint8List.fromList([1, 2, 3, 255]));
    },
  );
}

Future<void> _settle() => Future<void>.delayed(const Duration(milliseconds: 80));

void main() {
  group('decideAqutterNativeMode', () {
    AqutterNativeModeDecision decide(
      AqutterNativeMode request, {
      AqutterNativeMode widgetMode = AqutterNativeMode.auto,
      bool platformSupported = true,
      bool pageReady = true,
      bool available = true,
    }) =>
        decideAqutterNativeMode(
          request: request,
          widgetMode: widgetMode,
          platformSupported: platformSupported,
          pageReady: pageReady,
          passthroughAvailable: available,
        );

    test('auto goes passthrough when everything allows it', () {
      expect(decide(AqutterNativeMode.auto), const AqutterNativeModeDecision(passthrough: true));
    });

    test('an explicit mirror request is always mirror without a reason', () {
      expect(decide(AqutterNativeMode.mirror), const AqutterNativeModeDecision(passthrough: false));
      expect(decide(AqutterNativeMode.mirror, widgetMode: AqutterNativeMode.mirror, platformSupported: false), const AqutterNativeModeDecision(passthrough: false));
    });

    test('a widget that only allows mirror wins over the request', () {
      for (final request in [AqutterNativeMode.auto, AqutterNativeMode.passthrough]) {
        expect(
          decide(request, widgetMode: AqutterNativeMode.mirror),
          const AqutterNativeModeDecision(passthrough: false, reason: AqutterNativeModeReason.unsupportedWidget),
        );
      }
    });

    test('an unsupported platform falls back, even when passthrough is requested', () {
      for (final request in [AqutterNativeMode.auto, AqutterNativeMode.passthrough]) {
        expect(
          decide(request, platformSupported: false),
          const AqutterNativeModeDecision(passthrough: false, reason: AqutterNativeModeReason.unsupportedPlatform),
        );
      }
    });

    test('pageReady only matters for auto', () {
      expect(
        decide(AqutterNativeMode.auto, pageReady: false),
        const AqutterNativeModeDecision(passthrough: false, reason: AqutterNativeModeReason.pageNotReady),
      );
      expect(decide(AqutterNativeMode.passthrough, pageReady: false), const AqutterNativeModeDecision(passthrough: true));
    });

    test('an unavailable passthrough reports transparent-failed', () {
      expect(
        decide(AqutterNativeMode.passthrough, available: false),
        const AqutterNativeModeDecision(passthrough: false, reason: AqutterNativeModeReason.transparentFailed),
      );
    });

    test('reasons are reported in the documented order', () {
      expect(
        decide(AqutterNativeMode.auto, widgetMode: AqutterNativeMode.mirror, platformSupported: false, pageReady: false, available: false).reason,
        AqutterNativeModeReason.unsupportedWidget,
      );
      expect(
        decide(AqutterNativeMode.auto, platformSupported: false, pageReady: false, available: false).reason,
        AqutterNativeModeReason.unsupportedPlatform,
      );
      expect(decide(AqutterNativeMode.auto, pageReady: false, available: false).reason, AqutterNativeModeReason.transparentFailed);
    });

    test('the reply message has the wire format of the contract', () {
      expect(const AqutterNativeModeDecision(passthrough: true).toJson(), {'type': 'mode', 'mode': 'passthrough'});
      expect(
        const AqutterNativeModeDecision(passthrough: false, reason: AqutterNativeModeReason.pageNotReady).toJson(),
        {'type': 'mode', 'mode': 'mirror', 'reason': 'page-not-ready'},
      );
    });
  });

  group('platform support', () {
    test('only Android and iOS are supported for now', () {
      for (final platform in [TargetPlatform.android, TargetPlatform.iOS]) {
        expect(aqutterNativePassthroughSupported(platform), isTrue, reason: '$platform');
      }
      for (final platform in [TargetPlatform.macOS, TargetPlatform.windows, TargetPlatform.linux, TargetPlatform.fuchsia]) {
        expect(aqutterNativePassthroughSupported(platform), isFalse, reason: '$platform');
      }
    });
  });

  group('AqutterNativeMode.tryParse / AqutterNativeLayout.tryParse', () {
    test('parses known modes and rejects the rest', () {
      expect(AqutterNativeMode.tryParse('auto'), AqutterNativeMode.auto);
      expect(AqutterNativeMode.tryParse('mirror'), AqutterNativeMode.mirror);
      expect(AqutterNativeMode.tryParse('passthrough'), AqutterNativeMode.passthrough);
      expect(AqutterNativeMode.tryParse('Passthrough'), isNull);
      expect(AqutterNativeMode.tryParse(null), isNull);
      expect(AqutterNativeMode.tryParse(1), isNull);
    });

    test('parses a valid layout message', () {
      final layout = AqutterNativeLayout.tryParse({'type': 'layout', 'left': 10, 'top': 20.5, 'width': 300, 'height': 200, 'visible': true, 'sentAt': 1});
      expect(layout, const AqutterNativeLayout(left: 10, top: 20.5, width: 300, height: 200, visible: true));
      expect(layout!.rect, const Rect.fromLTWH(10, 20.5, 300, 200));
    });

    test('rejects missing, mistyped, negative or non-finite fields', () {
      final valid = {'left': 0, 'top': 0, 'width': 10, 'height': 10, 'visible': true};
      expect(AqutterNativeLayout.tryParse({...valid, 'visible': 'yes'}), isNull);
      expect(AqutterNativeLayout.tryParse({...valid, 'width': -1}), isNull);
      expect(AqutterNativeLayout.tryParse({...valid, 'left': double.nan}), isNull);
      expect(AqutterNativeLayout.tryParse({...valid, 'height': double.infinity}), isNull);
      expect(AqutterNativeLayout.tryParse({...valid}..remove('top')), isNull);
    });
  });

  group('host mode negotiation', () {
    late AqutterNativeHost host;

    setUp(() {
      host = AqutterNativeHost.instance;
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
    });
    tearDown(() async {
      debugDefaultTargetPlatformOverride = null;
      host.passthroughAvailable = true;
      await host.stop();
    });

    test('auto negotiates passthrough, counts the session and adopts the layout from its owner', () async {
      final session = _session('map');
      host.register(session);
      final client = await _Client.connect(await host.ensureStarted(), 'map');
      addTearDown(client.close);

      expect(host.passthroughSessions.value, 0);
      expect(await client.negotiate('auto'), {'type': 'mode', 'mode': 'passthrough'});
      expect(session.passthrough, isTrue);
      expect(host.passthroughSessions.value, 1);

      client.send({'type': 'layout', 'left': 5, 'top': 6, 'width': 100, 'height': 50, 'visible': true});
      await _settle();
      expect(session.layoutListenable.value, const AqutterNativeLayout(left: 5, top: 6, width: 100, height: 50, visible: true));

      client.send({'type': 'layout', 'left': 'bad'});
      await _settle();
      expect(session.layoutListenable.value?.left, 5, reason: 'an invalid layout is ignored');
    });

    test('iOS negotiates passthrough like Android', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      final session = _session('map');
      host.register(session);
      final client = await _Client.connect(await host.ensureStarted(), 'map');
      addTearDown(client.close);

      expect(await client.negotiate('auto'), {'type': 'mode', 'mode': 'passthrough'});
      expect(session.passthrough, isTrue);
      expect(host.passthroughSessions.value, 1);
    });

    test('passthrough stops capturing and sending frames', () async {
      var captures = 0;
      final session = _session('map', onCapture: () => captures += 1);
      host.register(session);
      final client = await _Client.connect(await host.ensureStarted(), 'map');
      addTearDown(client.close);
      await client.negotiate('auto');
      await _settle();
      final capturesAtStart = captures;
      final binaryAtStart = client.binaryMessages;
      await Future<void>.delayed(const Duration(milliseconds: 300));
      expect(captures, capturesAtStart, reason: 'no capture after passthrough is negotiated');
      expect(client.binaryMessages, binaryAtStart, reason: 'no frames after passthrough is negotiated');
    });

    test('mirror requests and fallbacks reply with the reason and leave the count at zero', () async {
      final session = _session('map');
      host.register(session);
      final client = await _Client.connect(await host.ensureStarted(), 'map');
      addTearDown(client.close);

      expect(await client.negotiate('mirror'), {'type': 'mode', 'mode': 'mirror'});
      expect(await client.negotiate('auto', pageReady: false), {'type': 'mode', 'mode': 'mirror', 'reason': 'page-not-ready'});
      expect(await client.negotiate('passthrough', pageReady: false), {'type': 'mode', 'mode': 'passthrough'});
      expect(host.passthroughSessions.value, 1);
      expect(await client.negotiate('mirror'), {'type': 'mode', 'mode': 'mirror'});
      expect(session.passthrough, isFalse);
      expect(host.passthroughSessions.value, 0);
    });

    test('unsupported platform and a mirror-only widget are reported', () async {
      final mirrorOnly = _session('mirror-only', mode: AqutterNativeMode.mirror);
      host.register(mirrorOnly);
      final endpoint = await host.ensureStarted();
      final client = await _Client.connect(endpoint, 'mirror-only');
      addTearDown(client.close);
      expect(await client.negotiate('passthrough'), {'type': 'mode', 'mode': 'mirror', 'reason': 'unsupported-widget'});

      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      final desktop = _session('desktop');
      host.register(desktop);
      final desktopClient = await _Client.connect(endpoint, 'desktop');
      addTearDown(desktopClient.close);
      expect(await desktopClient.negotiate('auto'), {'type': 'mode', 'mode': 'mirror', 'reason': 'unsupported-platform'});
      expect(host.passthroughSessions.value, 0);
    });

    test('passthroughAvailable = false reports transparent-failed for new negotiations', () async {
      host.passthroughAvailable = false;
      final session = _session('map');
      host.register(session);
      final client = await _Client.connect(await host.ensureStarted(), 'map');
      addTearDown(client.close);
      expect(await client.negotiate('auto'), {'type': 'mode', 'mode': 'mirror', 'reason': 'transparent-failed'});
    });

    test('a session without a mode message stays mirror and keeps streaming (old pages)', () async {
      var captures = 0;
      final session = _session('map', onCapture: () => captures += 1);
      host.register(session);
      final client = await _Client.connect(await host.ensureStarted(), 'map');
      addTearDown(client.close);
      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(session.passthrough, isFalse);
      expect(captures, greaterThan(0));
      expect(client.binaryMessages, greaterThan(0));
    });

    test('closing the passthrough connection falls back and decrements the count', () async {
      final session = _session('map');
      host.register(session);
      final client = await _Client.connect(await host.ensureStarted(), 'map');
      await client.negotiate('auto');
      expect(host.passthroughSessions.value, 1);
      await client.close();
      await _settle();
      expect(session.passthrough, isFalse);
      expect(host.passthroughSessions.value, 0);
    });

    test('unregistering a passthrough session decrements the count', () async {
      final session = _session('map');
      host.register(session);
      final client = await _Client.connect(await host.ensureStarted(), 'map');
      addTearDown(client.close);
      await client.negotiate('auto');
      expect(host.passthroughSessions.value, 1);
      host.unregister(session);
      expect(host.passthroughSessions.value, 0);
    });
  });

  group('AqutterNative widget in passthrough', () {
    tearDown(() async => AqutterNativeHost.instance.stop());

    Widget app(Widget child, {AqutterNativeMode mode = AqutterNativeMode.auto}) => Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(children: [Positioned.fill(child: AqutterNative(sessionId: 'map', mode: mode, child: child))]),
        );

    testWidgets('keeps the child mounted, hides it until a visible layout, places it, survives mode switches', (tester) async {
      _Probe.initCount = 0;
      const child = _Probe();
      await tester.pumpWidget(app(child));
      expect(find.byType(_Probe), findsOneWidget, reason: 'mirror (no negotiation yet): the child is in the tree as before');

      late _Client client;
      await tester.runAsync(() async {
        final endpoint = await AqutterNativeHost.instance.ensureStarted();
        client = await _Client.connect(endpoint, 'map');
        await client.negotiate('auto');
        await _settle();
      });
      await tester.pump();
      expect(find.byType(_Probe), findsNothing, reason: 'passthrough: hidden (Offstage) until the first visible layout');
      expect(find.byType(_Probe, skipOffstage: false), findsOneWidget, reason: 'but already mounted');

      await tester.runAsync(() async {
        client.send({'type': 'layout', 'left': 20, 'top': 30, 'width': 200, 'height': 100, 'visible': true});
        await _settle();
      });
      await tester.pump();
      expect(find.byType(_Probe), findsOneWidget);
      expect(tester.getTopLeft(find.byType(_Probe)), const Offset(20, 30));
      expect(tester.getSize(find.byType(_Probe)), const Size(200, 100));

      await tester.runAsync(() async {
        client.send({'type': 'layout', 'left': 20, 'top': -40, 'width': 200, 'height': 100, 'visible': true});
        await _settle();
      });
      await tester.pump();
      expect(tester.getTopLeft(find.byType(_Probe)), const Offset(20, -40), reason: 'follows the element, even off-screen');

      await tester.runAsync(() async {
        client.send({'type': 'layout', 'left': 20, 'top': -40, 'width': 200, 'height': 100, 'visible': false});
        await _settle();
      });
      await tester.pump();
      expect(find.byType(_Probe), findsNothing, reason: 'Offstage children are skipped by the default finder');
      expect(find.byType(_Probe, skipOffstage: false), findsOneWidget, reason: 'but it stays mounted');

      await tester.runAsync(() async {
        await client.negotiate('mirror');
        await _settle();
      });
      await tester.pump();
      expect(find.byType(_Probe), findsOneWidget);
      expect(_Probe.initCount, 1, reason: 'the child state survives switching between passthrough and mirror');
      await tester.runAsync(client.close);
      await _unmount(tester);
    }, variant: _supportedPlatforms);

    testWidgets('a mirror-only widget never goes passthrough', (tester) async {
      await tester.pumpWidget(app(const _Probe(), mode: AqutterNativeMode.mirror));
      late Map<String, dynamic> reply;
      await tester.runAsync(() async {
        final endpoint = await AqutterNativeHost.instance.ensureStarted();
        final client = await _Client.connect(endpoint, 'map');
        reply = await client.negotiate('passthrough');
        await client.close();
      });
      expect(reply['mode'], 'mirror');
      expect(reply['reason'], 'unsupported-widget');
      await _unmount(tester);
    }, variant: _supportedPlatforms);
  });
}

final _supportedPlatforms = TargetPlatformVariant({TargetPlatform.android, TargetPlatform.iOS});

/// 在真實的非同步區域卸載 widget：dispose 時關閉 WebSocket 會建立 5 秒的計時器，
/// 留在 FakeAsync 裡會被測試結尾的「沒有待處理計時器」檢查擋下。
Future<void> _unmount(WidgetTester tester) async {
  await tester.runAsync(() async {
    await tester.pumpWidget(const SizedBox.shrink());
  });
}

class _Probe extends StatefulWidget {
  const _Probe();

  static int initCount = 0;

  @override
  State<_Probe> createState() => _ProbeState();
}

class _ProbeState extends State<_Probe> {
  @override
  void initState() {
    super.initState();
    _Probe.initCount += 1;
  }

  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}
