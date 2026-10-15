import 'dart:core';

import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../webview_controller.dart';

///Use [AqutterWebViewController] instead.
@Deprecated("Use AqutterWebViewController instead")
class AqutterAndroidWebViewController {
  AqutterPlatformWebViewController? _controller;

  AqutterAndroidWebViewController({
    required AqutterPlatformWebViewController controller,
  }) {
    this._controller = controller;
  }

  ///Use [AqutterWebViewController.startSafeBrowsing] instead.
  @Deprecated("Use AqutterWebViewController.startSafeBrowsing instead")
  Future<bool> startSafeBrowsing() async {
    return await _controller?.startSafeBrowsing() ?? false;
  }

  ///Use [AqutterWebViewController.clearSslPreferences] instead.
  @Deprecated("Use AqutterWebViewController.clearSslPreferences instead")
  Future<void> clearSslPreferences() async {
    await _controller?.clearSslPreferences();
  }

  ///Use [AqutterWebViewController.pause] instead.
  @Deprecated("Use AqutterWebViewController.pause instead")
  Future<void> pause() async {
    await _controller?.pause();
  }

  ///Use [AqutterWebViewController.resume] instead.
  @Deprecated("Use AqutterWebViewController.resume instead")
  Future<void> resume() async {
    await _controller?.resume();
  }

  ///Use [AqutterWebViewController.pageDown] instead.
  @Deprecated("Use AqutterWebViewController.pageDown instead")
  Future<bool> pageDown({required bool bottom}) async {
    return await _controller?.pageDown(bottom: bottom) ?? false;
  }

  ///Use [AqutterWebViewController.pageUp] instead.
  @Deprecated("Use AqutterWebViewController.pageUp instead")
  Future<bool> pageUp({required bool top}) async {
    return await _controller?.pageUp(top: top) ?? false;
  }

  ///Use [AqutterWebViewController.zoomIn] instead.
  @Deprecated("Use AqutterWebViewController.zoomIn instead")
  Future<bool> zoomIn() async {
    return await _controller?.zoomIn() ?? false;
  }

  ///Use [AqutterWebViewController.zoomOut] instead.
  @Deprecated("Use AqutterWebViewController.zoomOut instead")
  Future<bool> zoomOut() async {
    return await _controller?.zoomOut() ?? false;
  }

  ///Use [AqutterWebViewController.clearHistory] instead.
  @Deprecated("Use AqutterWebViewController.clearHistory instead")
  Future<void> clearHistory() async {
    await _controller?.clearHistory();
  }

  ///Use [AqutterWebViewController.clearClientCertPreferences] instead.
  @Deprecated("Use AqutterWebViewController.clearClientCertPreferences instead")
  static Future<void> clearClientCertPreferences() async {
    await AqutterWebViewController.clearClientCertPreferences();
  }

  ///Use [AqutterWebViewController.getSafeBrowsingPrivacyPolicyUrl] instead.
  @Deprecated(
    "Use AqutterWebViewController.getSafeBrowsingPrivacyPolicyUrl instead",
  )
  static Future<Uri?> getSafeBrowsingPrivacyPolicyUrl() async {
    return await AqutterWebViewController.getSafeBrowsingPrivacyPolicyUrl();
  }

  ///Use [AqutterWebViewController.setSafeBrowsingWhitelist] instead.
  @Deprecated("Use AqutterWebViewController.setSafeBrowsingAllowlist instead")
  static Future<bool> setSafeBrowsingWhitelist({
    required List<String> hosts,
  }) async {
    return await AqutterWebViewController.setSafeBrowsingAllowlist(hosts: hosts);
  }

  ///Use [AqutterWebViewController.getCurrentWebViewPackage] instead.
  @Deprecated("Use AqutterWebViewController.getCurrentWebViewPackage instead")
  static Future<AqutterAndroidWebViewPackageInfo?> getCurrentWebViewPackage() async {
    Map<String, dynamic>? packageInfo =
        (await AqutterWebViewController.getCurrentWebViewPackage())?.toMap();
    return AqutterAndroidWebViewPackageInfo.fromMap(packageInfo);
  }

  ///Use [AqutterWebViewController.setWebContentsDebuggingEnabled] instead.
  @Deprecated(
    "Use AqutterWebViewController.setWebContentsDebuggingEnabled instead",
  )
  static Future<void> setWebContentsDebuggingEnabled(
    bool debuggingEnabled,
  ) async {
    return await AqutterWebViewController.setWebContentsDebuggingEnabled(
      debuggingEnabled,
    );
  }

  ///Use [AqutterWebViewController.getOriginalUrl] instead.
  @Deprecated('Use AqutterWebViewController.getOriginalUrl instead')
  Future<Uri?> getOriginalUrl() async {
    return await _controller?.getOriginalUrl();
  }

  void dispose() {
    _controller = null;
  }
}
