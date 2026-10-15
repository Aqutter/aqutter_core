import 'package:aqutter_core/aqutter_core.dart';
import 'package:aqutter_core_example/providers/settings_manager.dart';

/// Lightweight settings manager for widget tests.
class TestSettingsManager extends SettingsManager {
  TestSettingsManager()
    : super(
        environmentFactory: (_) async => null,
        environmentSupportChecker: () => false,
      );

  @override
  Future<void> init() async {}

  @override
  AqutterWebViewSettings buildSettings() => AqutterWebViewSettings();

  @override
  AqutterWebViewEnvironmentSettings buildEnvironmentSettings() =>
      AqutterWebViewEnvironmentSettings(
        releaseChannels: AqutterEnvironmentReleaseChannels.STABLE,
      );

  @override
  AqutterWebViewEnvironment? get webViewEnvironment => null;

  @override
  int get environmentRevision => 0;

  @override
  int get settingsRevision => 0;
}
