import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview_environment/platform_webview_environment.dart';
import 'browser_process_info.dart';
import 'enum_method.dart';

part 'browser_process_infos_changed_detail.g.dart';

///An object that contains information for the [AqutterPlatformWebViewEnvironment.onProcessInfosChanged] event.
@ExchangeableObject()
class AqutterBrowserProcessInfosChangedDetail_ {
  ///The kind of the process.
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  List<AqutterBrowserProcessInfo_> infos;

  AqutterBrowserProcessInfosChangedDetail_({this.infos = const []});
}
