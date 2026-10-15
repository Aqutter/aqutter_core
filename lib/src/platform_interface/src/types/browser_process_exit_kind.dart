import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview/platform_webview.dart';
import '../webview_environment/platform_webview_environment.dart';

part 'browser_process_exit_kind.g.dart';

///The kind of browser process exit that has occurred.
@ExchangeableEnum(bitwiseOrOperator: true)
class AqutterBrowserProcessExitKind_ {
  // ignore: unused_field
  final int _value;
  const AqutterBrowserProcessExitKind_._internal(this._value);

  ///Indicates that the browser process ended normally.
  @EnumSupportedPlatforms(platforms: [EnumWindowsPlatform(value: 0)])
  static const NORMAL = AqutterBrowserProcessExitKind_._internal(0);

  ///Indicates that the browser process ended unexpectedly.
  ///A [AqutterPlatformWebViewCreationParams.onProcessFailed] event will also be
  ///raised to listening WebViews from the [AqutterPlatformWebViewEnvironment] associated to the failed process.
  @EnumSupportedPlatforms(platforms: [EnumWindowsPlatform(value: 1)])
  static const FAILED = AqutterBrowserProcessExitKind_._internal(1);
}
