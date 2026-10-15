import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview_environment/platform_webview_environment.dart';
import 'browser_process_kind.dart';
import 'frame_info.dart';
import 'enum_method.dart';

part 'browser_process_info.g.dart';

///An object that contains information for a process in the [AqutterPlatformWebViewEnvironment].
@ExchangeableObject()
class AqutterBrowserProcessInfo_ {
  ///The kind of the process.
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  AqutterBrowserProcessKind_ kind;

  ///The process id of the process.
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  int? processId;

  ///A list of associated [AqutterFrameInfo]s which are actively running
  ///(showing or hiding UI elements) in the renderer process.
  @SupportedPlatforms(platforms: [WindowsPlatform(available: '1.0.2210.55')])
  List<AqutterFrameInfo_>? frameInfos;

  AqutterBrowserProcessInfo_({required this.kind, this.processId, this.frameInfos});
}
