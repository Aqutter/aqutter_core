import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import '../util.dart';

part 'find_interactions.dart';

void main() {
  final shouldSkip = !AqutterFindInteractionController.isClassSupported();

  skippableGroup('AqutterFindInteractionController', () {
    findInteractions();
  }, skip: shouldSkip);
}
