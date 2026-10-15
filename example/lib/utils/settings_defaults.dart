import 'package:aqutter_core/aqutter_core.dart';

AqutterWebViewSettings defaultWebViewSettings() {
  return AqutterWebViewSettings();
}

AqutterWebViewEnvironmentSettings defaultWebViewEnvironmentSettings() {
  return AqutterWebViewEnvironmentSettings();
}

Map<String, dynamic> defaultWebViewSettingsMap() {
  return defaultWebViewSettings().toMap(
    enumMethod: AqutterEnumMethod.nativeValue,
  );
}

Map<String, dynamic> defaultWebViewEnvironmentSettingsMap() {
  return defaultWebViewEnvironmentSettings().toMap(
    enumMethod: AqutterEnumMethod.nativeValue,
  );
}
