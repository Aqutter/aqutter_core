import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

///{@macro aqutter_core.AqutterPlatformWebViewEnvironment}
///
///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.supported_platforms}
class AqutterWebViewEnvironment {
  /// Constructs a [AqutterWebViewEnvironment].
  ///
  /// See [AqutterWebViewEnvironment.fromPlatformCreationParams] for setting parameters for
  /// a specific platform.
  AqutterWebViewEnvironment.fromPlatformCreationParams({
    required AqutterPlatformWebViewEnvironmentCreationParams params,
  }) : this.fromPlatform(platform: AqutterPlatformWebViewEnvironment(params));

  /// Constructs a [AqutterWebViewEnvironment] from a specific platform implementation.
  AqutterWebViewEnvironment.fromPlatform({required this.platform});

  /// Implementation of [AqutterPlatformWebViewEnvironment] for the current platform.
  final AqutterPlatformWebViewEnvironment platform;

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.id}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.id.supported_platforms}
  String get id => platform.id;

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.settings}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.settings.supported_platforms}
  AqutterWebViewEnvironmentSettings? get settings => platform.settings;

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.isInterfaceSupported}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.isInterfaceSupported.supported_platforms}
  Future<bool> isInterfaceSupported(AqutterWebViewInterface interface) =>
      platform.isInterfaceSupported(interface);

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getProcessInfos}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getProcessInfos.supported_platforms}
  Future<List<AqutterBrowserProcessInfo>> getProcessInfos() =>
      platform.getProcessInfos();

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getFailureReportFolderPath}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getFailureReportFolderPath.supported_platforms}
  Future<String?> getFailureReportFolderPath() =>
      platform.getFailureReportFolderPath();

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.create}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.create.supported_platforms}
  static Future<AqutterWebViewEnvironment> create({
    AqutterWebViewEnvironmentSettings? settings,
  }) async {
    return AqutterWebViewEnvironment.fromPlatform(
      platform: await AqutterPlatformWebViewEnvironment.static().create(
        settings: settings,
      ),
    );
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getAvailableVersion}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getAvailableVersion.supported_platforms}
  static Future<String?> getAvailableVersion({
    String? browserExecutableFolder,
  }) => AqutterPlatformWebViewEnvironment.static().getAvailableVersion(
    browserExecutableFolder: browserExecutableFolder,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getAvailableVersion}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getAvailableVersion.supported_platforms}
  static Future<int?> compareBrowserVersions({
    required String version1,
    required String version2,
  }) => AqutterPlatformWebViewEnvironment.static().compareBrowserVersions(
    version1: version1,
    version2: version2,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.onNewBrowserVersionAvailable}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.onNewBrowserVersionAvailable.supported_platforms}
  void Function()? get onNewBrowserVersionAvailable =>
      platform.onNewBrowserVersionAvailable;
  set onNewBrowserVersionAvailable(void Function()? value) =>
      platform.onNewBrowserVersionAvailable = value;

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.onBrowserProcessExited}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.onBrowserProcessExited.supported_platforms}
  void Function(AqutterBrowserProcessExitedDetail detail)?
  get onBrowserProcessExited => platform.onBrowserProcessExited;
  set onBrowserProcessExited(
    void Function(AqutterBrowserProcessExitedDetail detail)? value,
  ) => platform.onBrowserProcessExited = value;

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.onProcessInfosChanged}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.onProcessInfosChanged.supported_platforms}
  void Function(AqutterBrowserProcessInfosChangedDetail detail)?
  get onProcessInfosChanged => platform.onProcessInfosChanged;
  set onProcessInfosChanged(
    void Function(AqutterBrowserProcessInfosChangedDetail detail)? value,
  ) => platform.onProcessInfosChanged = value;

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getCacheModel}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getCacheModel.supported_platforms}
  Future<AqutterCacheModel?> getCacheModel() => platform.getCacheModel();

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.isSpellCheckingEnabled}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.isSpellCheckingEnabled.supported_platforms}
  Future<bool> isSpellCheckingEnabled() => platform.isSpellCheckingEnabled();

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getSpellCheckingLanguages}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getSpellCheckingLanguages.supported_platforms}
  Future<List<String>> getSpellCheckingLanguages() =>
      platform.getSpellCheckingLanguages();

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.isAutomationAllowed}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.isAutomationAllowed.supported_platforms}
  Future<bool> isAutomationAllowed() => platform.isAutomationAllowed();

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.dispose}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.dispose.supported_platforms}
  Future<void> dispose() => platform.dispose();

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironmentCreationParams.isClassSupported}
  static bool isClassSupported({TargetPlatform? platform}) =>
      AqutterPlatformWebViewEnvironment.static().isClassSupported(platform: platform);

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.isPropertySupported}
  static bool isPropertySupported(
    dynamic property, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebViewEnvironment.static().isPropertySupported(
    property,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.isMethodSupported}
  static bool isMethodSupported(
    AqutterPlatformWebViewEnvironmentMethod method, {
    TargetPlatform? platform,
  }) => AqutterPlatformWebViewEnvironment.static().isMethodSupported(
    method,
    platform: platform,
  );
}
