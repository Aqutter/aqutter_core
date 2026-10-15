import 'dart:core';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:aqutter_core/src/platform_interface/flutter_webview_platform_interface.dart';

import '../webview_controller.dart';

///Use [AqutterWebViewController] instead.
@Deprecated("Use AqutterWebViewController instead")
class AqutterIOSWebViewController {
  AqutterPlatformWebViewController? _controller;

  AqutterIOSWebViewController({
    required AqutterPlatformWebViewController controller,
  }) {
    this._controller = controller;
  }

  ///Use [AqutterWebViewController.reloadFromOrigin] instead.
  @Deprecated("Use AqutterWebViewController.reloadFromOrigin instead")
  Future<void> reloadFromOrigin() async {
    await _controller?.reloadFromOrigin();
  }

  ///Use [AqutterWebViewController.createPdf] instead.
  @Deprecated("Use AqutterWebViewController.createPdf instead")
  Future<Uint8List?> createPdf({
    @Deprecated("Use pdfConfiguration instead")
    // ignore: deprecated_member_use_from_same_package
    AqutterIOSWKPDFConfiguration? iosWKPdfConfiguration,
    AqutterPDFConfiguration? pdfConfiguration,
  }) async {
    return await _controller?.createPdf(
      iosWKPdfConfiguration: iosWKPdfConfiguration,
      pdfConfiguration: pdfConfiguration,
    );
  }

  ///Use [AqutterWebViewController.createWebArchiveData] instead.
  @Deprecated("Use AqutterWebViewController.createWebArchiveData instead")
  Future<Uint8List?> createWebArchiveData() async {
    return await _controller?.createWebArchiveData();
  }

  ///Use [AqutterWebViewController.hasOnlySecureContent] instead.
  @Deprecated("Use AqutterWebViewController.hasOnlySecureContent instead")
  Future<bool> hasOnlySecureContent() async {
    return await _controller?.hasOnlySecureContent() ?? false;
  }

  ///Use [AqutterWebViewController.handlesURLScheme] instead.
  @Deprecated("Use AqutterWebViewController.handlesURLScheme instead")
  static Future<bool> handlesURLScheme(String urlScheme) async {
    return await AqutterWebViewController.handlesURLScheme(urlScheme);
  }

  void dispose() {
    _controller = null;
  }
}
