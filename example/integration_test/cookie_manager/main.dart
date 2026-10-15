import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import '../constants.dart';
import '../util.dart';

part 'set_get_delete.dart';

void main() {
  final shouldSkip = !AqutterCookieManager.isClassSupported();

  skippableGroup('AqutterCookie Manager', () {
    setGetDelete();
  }, skip: shouldSkip);
}
