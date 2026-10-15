import 'package:flutter/services.dart';
import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import '../constants.dart';
import '../util.dart';

part 'custom_menu_item.dart';
part 'custom_tabs.dart';
part 'open_and_close.dart';
part 'trusted_web_activity.dart';
part 'sf_safari_view_controller.dart';

void main() {
  final shouldSkip = !AqutterChromeSafariBrowser.isClassSupported();

  skippableGroup('AqutterChromeSafariBrowser', () {
    openAndClose();
    customMenuItem();
    customTabs();
    trustedWebActivity();
    sfSafariViewController();
  }, skip: shouldSkip);
}
