import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../chrome_safari_browser/platform_chrome_safari_browser.dart';
import 'enum_method.dart';

part 'prewarming_token.g.dart';

///Class that represents the Prewarming Token returned by [AqutterPlatformChromeSafariBrowser.prewarmConnections].
@ExchangeableObject()
class AqutterPrewarmingToken_ {
  ///Prewarming Token id.
  final String id;

  AqutterPrewarmingToken_({required this.id});
}
