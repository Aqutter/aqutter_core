import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../web_uri.dart';
import 'web_history.dart';
import 'enum_method.dart';

part 'web_history_item.g.dart';

///A convenience class for accessing fields in an entry in the back/forward list of a `WebView`.
///Each [AqutterWebHistoryItem] is a snapshot of the requested history item.
@ExchangeableObject()
class AqutterWebHistoryItem_ {
  ///Original url of this history item.
  AqutterWebUri? originalUrl;

  ///Document title of this history item.
  String? title;

  ///Url of this history item.
  AqutterWebUri? url;

  ///0-based position index in the back-forward [AqutterWebHistory.list].
  int? index;

  ///Position offset respect to the currentIndex of the back-forward [AqutterWebHistory.list].
  int? offset;

  ///Unique id of the navigation history entry.
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  int? entryId;

  AqutterWebHistoryItem_({
    this.originalUrl,
    this.title,
    this.url,
    this.index,
    this.offset,
    this.entryId,
  });
}
