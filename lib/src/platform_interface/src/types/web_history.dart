import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'web_history_item.dart';
import 'enum_method.dart';

part 'web_history.g.dart';

///This class contains a snapshot of the current back/forward list for a `WebView`.
@ExchangeableObject()
class AqutterWebHistory_ {
  ///List of all [AqutterWebHistoryItem]s.
  List<AqutterWebHistoryItem_>? list;

  ///Index of the current [AqutterWebHistoryItem].
  int? currentIndex;

  AqutterWebHistory_({this.list, this.currentIndex});
}
