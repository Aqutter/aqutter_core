import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aqutter_core/aqutter_core.dart';
import '../constants.dart';
import '../env.dart';
import '../util.dart';

part 'clear_and_set_proxy_override.dart';

void main() {
  final shouldSkip = !AqutterProxyController.isClassSupported();

  skippableGroup('Proxy Controller', () {
    clearAndSetProxyOverride();
  }, skip: shouldSkip);
}
