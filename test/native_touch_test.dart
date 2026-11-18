import 'package:aqutter_core/aqutter_core.dart';
import 'package:aqutter_core/src/nativeview/native_touch_gate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _layout([Object? webRegions = _absent]) => <String, dynamic>{
      'type': 'layout',
      'left': 10,
      'top': 20,
      'width': 300,
      'height': 200,
      'visible': true,
      if (!identical(webRegions, _absent)) 'webRegions': webRegions,
    };

const Object _absent = Object();

void main() {
  group('AqutterNativeLayout webRegions', () {
    test('absent means the client does not support native touch', () {
      expect(AqutterNativeLayout.tryParse(_layout())!.webRegions, isNull);
    });

    test('parses valid regions, including an empty list', () {
      final layout = AqutterNativeLayout.tryParse(_layout([
        {'x': 0, 'y': 150, 'width': 300, 'height': 50},
      ]));
      expect(layout!.webRegions, const [Rect.fromLTWH(0, 150, 300, 50)]);
      expect(AqutterNativeLayout.tryParse(_layout(<Object>[]))!.webRegions, isEmpty);
    });

    test('ignores the whole field when it is malformed, but keeps the layout', () {
      final bad = <Object?>[
        'nope',
        [1],
        [
          {'x': 0, 'y': 0, 'width': 0, 'height': 5},
        ],
        [
          {'x': 0, 'y': 0, 'width': -1, 'height': 5},
        ],
        [
          {'x': double.nan, 'y': 0, 'width': 1, 'height': 5},
        ],
        [
          {'x': 0, 'y': 0, 'width': 1},
        ],
        List.generate(65, (i) => {'x': 0, 'y': i, 'width': 1, 'height': 1}),
      ];
      for (final regions in bad) {
        final layout = AqutterNativeLayout.tryParse(_layout(regions));
        expect(layout, isNotNull, reason: '$regions');
        expect(layout!.webRegions, isNull, reason: '$regions');
        expect(layout.width, 300);
      }
    });

    test('regions take part in equality', () {
      final a = AqutterNativeLayout.tryParse(_layout([
        {'x': 0, 'y': 0, 'width': 1, 'height': 1},
      ]));
      final b = AqutterNativeLayout.tryParse(_layout([
        {'x': 0, 'y': 0, 'width': 1, 'height': 1},
      ]));
      expect(a, b);
      expect(a, isNot(AqutterNativeLayout.tryParse(_layout())));
    });
  });

  group('subtractRects', () {
    const rect = Rect.fromLTWH(0, 0, 100, 100);

    double area(List<Rect> rects) => rects.fold(0, (sum, r) => sum + r.width * r.height);

    test('returns the rect itself without holes, nothing for an empty rect', () {
      expect(subtractRects(rect, const []), [rect]);
      expect(subtractRects(Rect.zero, const []), isEmpty);
      expect(subtractRects(rect, const [Rect.fromLTWH(200, 200, 5, 5)]), [rect]);
    });

    test('a full-width hole at the bottom leaves one rect', () {
      expect(subtractRects(rect, const [Rect.fromLTWH(0, 70, 100, 30)]), const [Rect.fromLTWH(0, 0, 100, 70)]);
    });

    test('a hole in the middle leaves the rest without overlap', () {
      final result = subtractRects(rect, const [Rect.fromLTWH(40, 40, 20, 20)]);
      expect(area(result), 100 * 100 - 20 * 20);
      for (final r in result) {
        expect(r.overlaps(const Rect.fromLTWH(40, 40, 20, 20)), isFalse);
      }
      for (var i = 0; i < result.length; i++) {
        for (var j = i + 1; j < result.length; j++) {
          expect(result[i].overlaps(result[j]), isFalse);
        }
      }
    });

    test('overlapping holes and holes sticking out are handled', () {
      final result = subtractRects(rect, const [Rect.fromLTWH(-10, -10, 60, 60), Rect.fromLTWH(30, 30, 100, 100)]);
      // 左上與右下兩個洞互相重疊：聯集面積 = 50*50 + 70*70 - 20*20
      expect(area(result), closeTo(100 * 100 - (50 * 50 + 70 * 70 - 20 * 20), 0.001));
    });

    test('a hole covering everything leaves nothing', () {
      expect(subtractRects(rect, const [Rect.fromLTWH(0, 0, 100, 100)]), isEmpty);
    });
  });

  group('AqutterNativeSession native touch', () {
    tearDown(() => debugDefaultTargetPlatformOverride = null);

    AqutterNativeSession passthroughSession() {
      final session = AqutterNativeSession(id: 'touch', capture: () async => null);
      session.setPassthrough(true);
      return session;
    }

    AqutterNativeLayout layout({List<Rect>? web, bool visible = true}) => AqutterNativeLayout(
          left: 10,
          top: 20,
          width: 300,
          height: 200,
          visible: visible,
          webRegions: web,
        );

    test('is on for iOS passthrough with webRegions and sends the native area', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      final session = passthroughSession();
      addTearDown(session.dispose);
      session.updateLayout(layout(web: const [Rect.fromLTWH(0, 150, 300, 50)]));
      expect(session.nativeTouchListenable.value, isTrue);
      expect(NativeTouchRegions.instance.regions.value, const [Rect.fromLTWH(10, 20, 300, 150)]);
    });

    test('is off without webRegions (old client), when invisible, and on other platforms', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      final session = passthroughSession();
      addTearDown(session.dispose);
      session.updateLayout(layout());
      expect(session.nativeTouchListenable.value, isFalse);
      expect(NativeTouchRegions.instance.regions.value, isEmpty);
      session.updateLayout(layout(web: const [], visible: false));
      expect(session.nativeTouchListenable.value, isFalse);

      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      session.updateLayout(layout(web: const []));
      expect(session.nativeTouchListenable.value, isFalse);
      expect(NativeTouchRegions.instance.regions.value, isEmpty);
    });

    test('leaving passthrough and disposing clear the regions', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      final session = passthroughSession();
      session.updateLayout(layout(web: const []));
      expect(NativeTouchRegions.instance.regions.value, isNotEmpty);
      session.setPassthrough(false);
      expect(session.nativeTouchListenable.value, isFalse);
      expect(NativeTouchRegions.instance.regions.value, isEmpty);

      session.setPassthrough(true);
      session.updateLayout(layout(web: const []));
      expect(NativeTouchRegions.instance.regions.value, isNotEmpty);
      session.dispose();
      expect(NativeTouchRegions.instance.regions.value, isEmpty);
    });
  });

  group('AqutterNativeTouch', () {
    testWidgets('defaults to false without an AqutterNative above', (tester) async {
      late ValueListenable<bool> found;
      await tester.pumpWidget(Builder(builder: (context) {
        found = AqutterNativeTouch.of(context);
        return const SizedBox.shrink();
      }));
      expect(found.value, isFalse);
    });
  });
}
