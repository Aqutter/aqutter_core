import 'package:flutter_test/flutter_test.dart';
import 'package:aqutter_core/aqutter_core.dart';
import 'package:aqutter_core_example/utils/controller_methods_registry.dart';
import 'package:aqutter_core_example/utils/support_checker.dart';

void main() {
  group('SupportChecker naming', () {
    test('helper class names use Type.toString()', () {
      expect(
        SupportChecker.classNameOf(AqutterWebViewController),
        (AqutterWebViewController).toString(),
      );
      expect(
        SupportChecker.classNameOf(AqutterHeadlessWebView),
        (AqutterHeadlessWebView).toString(),
      );
      expect(
        SupportChecker.classNameOf(AqutterBrowser),
        (AqutterBrowser).toString(),
      );
      expect(
        SupportChecker.eventClassNameOf(AqutterWebView),
        '${(AqutterWebView).toString()} Events',
      );
    });

    test('API definitions use (Type).toString() class names', () {
      final definitions = SupportChecker.getAllApiDefinitions();

      final controllerDefinition = definitions.firstWhere(
        (definition) =>
            definition.className == (AqutterWebViewController).toString(),
      );
      expect(
        controllerDefinition.className,
        (AqutterWebViewController).toString(),
      );
      expect(controllerDefinition.methods, isNotEmpty);
      expect(
        controllerDefinition.methods.every(
          (method) => method.className == controllerDefinition.className,
        ),
        isTrue,
      );

      final eventsDefinition = definitions.firstWhere(
        (definition) =>
            definition.className == '${(AqutterWebView).toString()} Events',
      );
      expect(eventsDefinition.className, '${(AqutterWebView).toString()} Events');
      expect(
        eventsDefinition.events.every(
          (event) => event.className == eventsDefinition.className,
        ),
        isTrue,
      );
    });
  });

  group('ControllerMethodsRegistry naming', () {
    test('method entries use enum .name for id and name', () {
      final registry = ControllerMethodsRegistry.instance;
      final methods = registry.allMethods;

      expect(methods, isNotEmpty);

      for (final entry in methods) {
        expect(entry.id, entry.methodEnum.name);
        expect(entry.name, entry.methodEnum.name);
        expect(entry.id.contains('.'), isFalse);
        expect(entry.name.contains('.'), isFalse);
      }
    });

    test('category ids use enum .name', () {
      final registry = ControllerMethodsRegistry.instance;
      for (final category in registry.categories) {
        expect(category.id, category.categoryType.name);
        expect(category.id.contains('.'), isFalse);
      }
    });
  });
}
