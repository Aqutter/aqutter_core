import 'package:flutter/material.dart';
import 'package:aqutter_core/aqutter_core.dart';
import '../utils/platform_utils.dart';
import '../widgets/common/section_card.dart';

/// Screen displaying detailed platform information and capabilities.
class PlatformInfoScreen extends StatelessWidget {
  const PlatformInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Platform Information')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          InfoSection(
            title: 'Platform Details',
            icon: PlatformUtils.getPlatformIcon(),
            children: [
              _buildInfoTile(
                'Platform',
                PlatformUtils.getPlatformName(),
                Icons.devices,
              ),
              _buildInfoTile(
                'Flutter Version',
                PlatformUtils.getFlutterVersion(),
                Icons.flutter_dash,
              ),
              _buildInfoTile(
                'Dart Version',
                PlatformUtils.getDartVersion(),
                Icons.code,
              ),
              _buildInfoTile(
                'Platform Type',
                _getPlatformType(),
                Icons.category,
              ),
            ],
          ),
          const SizedBox(height: 24),
          InfoSection(
            title: 'Core WebView Features',
            icon: Icons.web,
            children: [_buildFeaturesList(context, _getCoreWebViewFeatures())],
          ),
          const SizedBox(height: 24),
          InfoSection(
            title: 'Browser Features',
            icon: Icons.open_in_browser,
            children: [_buildFeaturesList(context, _getBrowserFeatures())],
          ),
          const SizedBox(height: 24),
          InfoSection(
            title: 'AqutterStorage & Data',
            icon: Icons.storage,
            children: [_buildFeaturesList(context, _getStorageFeatures())],
          ),
          const SizedBox(height: 24),
          InfoSection(
            title: 'Controllers',
            icon: Icons.tune,
            children: [_buildFeaturesList(context, _getControllerFeatures())],
          ),
          const SizedBox(height: 24),
          InfoSection(
            title: 'Messaging & Communication',
            icon: Icons.message,
            children: [_buildFeaturesList(context, _getMessagingFeatures())],
          ),
          const SizedBox(height: 24),
          InfoSection(
            title: 'Advanced Features',
            icon: Icons.settings_applications,
            children: [_buildFeaturesList(context, _getAdvancedFeatures())],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList(BuildContext context, Map<String, bool> features) {
    return Column(
      children: features.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Icon(
                entry.value ? Icons.check_circle : Icons.cancel,
                color: entry.value ? Colors.green : Colors.red,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(entry.key, style: const TextStyle(fontSize: 14)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _getPlatformType() {
    if (PlatformUtils.isWebPlatform()) {
      return 'Web';
    } else if (PlatformUtils.isMobilePlatform()) {
      return 'Mobile';
    } else if (PlatformUtils.isDesktopPlatform()) {
      return 'Desktop';
    }
    return 'Unknown';
  }

  /// Core WebView features
  Map<String, bool> _getCoreWebViewFeatures() {
    try {
      return {
        '${AqutterWebView} (Widget)': AqutterWebView.isClassSupported(),
        '${AqutterWebViewController}': AqutterWebViewController.isClassSupported(),
        '${AqutterHeadlessWebView}': AqutterHeadlessWebView.isClassSupported(),
      };
    } catch (e) {
      return {};
    }
  }

  /// Browser features
  Map<String, bool> _getBrowserFeatures() {
    try {
      return {
        '${AqutterBrowser}': AqutterBrowser.isClassSupported(),
        '${AqutterChromeSafariBrowser}': AqutterChromeSafariBrowser.isClassSupported(),
        '${AqutterWebAuthenticationSession}':
            AqutterWebAuthenticationSession.isClassSupported(),
      };
    } catch (e) {
      return {};
    }
  }

  /// AqutterStorage and data features
  Map<String, bool> _getStorageFeatures() {
    try {
      return {
        '${AqutterCookieManager}': AqutterCookieManager.isClassSupported(),
        '${AqutterWebStorage}': AqutterWebStorage.isClassSupported(),
        '${AqutterLocalStorage}': AqutterLocalStorage.isClassSupported(),
        '${AqutterSessionStorage}': AqutterSessionStorage.isClassSupported(),
        '${AqutterWebStorageManager}': AqutterWebStorageManager.isClassSupported(),
        '${AqutterHttpAuthCredentialDatabase}':
            AqutterHttpAuthCredentialDatabase.isClassSupported(),
      };
    } catch (e) {
      return {};
    }
  }

  /// Controller features
  Map<String, bool> _getControllerFeatures() {
    try {
      return {
        '${AqutterPullToRefreshController}':
            AqutterPullToRefreshController.isClassSupported(),
        '${AqutterFindInteractionController}':
            AqutterFindInteractionController.isClassSupported(),
        '${AqutterPrintJobController}': AqutterPrintJobController.isClassSupported(),
        '${AqutterServiceWorkerController}':
            AqutterServiceWorkerController.isClassSupported(),
        '${AqutterProxyController}': AqutterProxyController.isClassSupported(),
        '${AqutterTracingController}': AqutterTracingController.isClassSupported(),
      };
    } catch (e) {
      return {};
    }
  }

  /// Messaging and communication features
  Map<String, bool> _getMessagingFeatures() {
    try {
      return {
        '${AqutterWebMessageChannel}': AqutterWebMessageChannel.isClassSupported(),
        '${AqutterWebMessageListener}': AqutterWebMessageListener.isClassSupported(),
      };
    } catch (e) {
      return {};
    }
  }

  /// Advanced features
  Map<String, bool> _getAdvancedFeatures() {
    try {
      return {
        '${AqutterWebViewEnvironment}': AqutterWebViewEnvironment.isClassSupported(),
        '${AqutterProcessGlobalConfig}': AqutterProcessGlobalConfig.isClassSupported(),
      };
    } catch (e) {
      return {};
    }
  }
}
