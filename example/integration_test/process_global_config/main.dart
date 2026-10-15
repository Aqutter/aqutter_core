import 'package:flutter_test/flutter_test.dart';
import 'package:aqutter_core/aqutter_core.dart';
import 'package:path_provider/path_provider.dart';
import '../util.dart';

part 'apply.dart';

void main() {
  final shouldSkip = !AqutterProcessGlobalConfig.isClassSupported();

  skippableGroup('Process Global Config', () {
    apply();
  }, skip: shouldSkip);
}
