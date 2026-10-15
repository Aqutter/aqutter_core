import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'search_result_display_style.dart';
import 'enum_method.dart';

part 'find_session.g.dart';

@ExchangeableObject()
class AqutterFindSession_ {
  ///Returns the total number of results.
  int resultCount;

  ///Returns the index of the currently highlighted result.
  ///If no result is currently highlighted.
  int highlightedResultIndex;

  /// Defines how results are reported through the find panel's UI.
  AqutterSearchResultDisplayStyle_ searchResultDisplayStyle;

  AqutterFindSession_({
    required this.resultCount,
    required this.highlightedResultIndex,
    required this.searchResultDisplayStyle,
  });
}
