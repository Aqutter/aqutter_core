import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview_environment/platform_webview_environment.dart';
import 'browser_process_exit_kind.dart';
import 'enum_method.dart';

part 'browser_process_exited_detail.g.dart';

///An object that contains information for the [AqutterPlatformWebViewEnvironment.onBrowserProcessExited] event.
@ExchangeableObject()
class AqutterBrowserProcessExitedDetail_ {
  ///The kind of browser process exit that has occurred.
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  AqutterBrowserProcessExitKind_ kind;

  ///The process ID of the browser process that has exited.
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  int? processId;

  AqutterBrowserProcessExitedDetail_({required this.kind, this.processId});
}
