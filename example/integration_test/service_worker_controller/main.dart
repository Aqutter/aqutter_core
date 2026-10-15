import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:aqutter_core/aqutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import '../constants.dart';
import '../util.dart';

part 'set_service_worker_client.dart';
part 'should_intercept_request.dart';

void main() {
  final shouldSkip = !AqutterServiceWorkerController.isClassSupported();

  skippableGroup('Service Worker Controller', () {
    shouldInterceptRequest();
    setServiceWorkerClient();
  }, skip: shouldSkip);
}
