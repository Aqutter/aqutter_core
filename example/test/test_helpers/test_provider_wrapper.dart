import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aqutter_core/aqutter_core.dart';
import 'package:aqutter_core_example/providers/event_log_provider.dart';
import 'package:aqutter_core_example/providers/network_monitor.dart';
import 'package:aqutter_core_example/providers/settings_manager.dart';

import 'mock_aqutter_platform.dart';

/// Creates a mock SettingsManager for testing.
/// This bypasses the SharedPreferences and AqutterWebViewEnvironment dependencies.
class MockSettingsManager extends SettingsManager {
  MockSettingsManager()
    : super(
        environmentFactory: (_) async => null,
        environmentSupportChecker: () => false,
      );

  @override
  AqutterWebViewEnvironmentSettings buildEnvironmentSettings() =>
      AqutterWebViewEnvironmentSettings(
        releaseChannels: AqutterEnvironmentReleaseChannels.STABLE,
      );

  @override
  AqutterWebViewSettings buildSettings() => AqutterWebViewSettings();
}

/// A wrapper widget that provides all common providers needed for testing.
class TestProviderWrapper extends StatelessWidget {
  final Widget child;
  final SettingsManager? settingsManager;
  final EventLogProvider? eventLogProvider;
  final NetworkMonitor? networkMonitor;

  const TestProviderWrapper({
    super.key,
    required this.child,
    this.settingsManager,
    this.eventLogProvider,
    this.networkMonitor,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsManager>.value(
          value: settingsManager ?? MockSettingsManager(),
        ),
        ChangeNotifierProvider<EventLogProvider>.value(
          value: eventLogProvider ?? EventLogProvider(),
        ),
        ChangeNotifierProvider<NetworkMonitor>.value(
          value: networkMonitor ?? NetworkMonitor(),
        ),
      ],
      child: child,
    );
  }
}

/// Helper to set up tests that require the AqutterWebViewPlatform mock.
void setUpMockPlatform() {
  MockAqutterPlatform.initialize();
}
