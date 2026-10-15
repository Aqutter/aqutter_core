// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_session.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

class AqutterFindSession {
  ///Returns the index of the currently highlighted result.
  ///If no result is currently highlighted.
  int highlightedResultIndex;

  ///Returns the total number of results.
  int resultCount;

  /// Defines how results are reported through the find panel's UI.
  AqutterSearchResultDisplayStyle searchResultDisplayStyle;
  AqutterFindSession({
    required this.highlightedResultIndex,
    required this.resultCount,
    required this.searchResultDisplayStyle,
  });

  ///Gets a possible [AqutterFindSession] instance from a [Map] value.
  static AqutterFindSession? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterFindSession(
      highlightedResultIndex: map['highlightedResultIndex'],
      resultCount: map['resultCount'],
      searchResultDisplayStyle: switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterSearchResultDisplayStyle.fromNativeValue(
            map['searchResultDisplayStyle'],
          ),
        AqutterEnumMethod.value => AqutterSearchResultDisplayStyle.fromValue(
          map['searchResultDisplayStyle'],
        ),
        AqutterEnumMethod.name => AqutterSearchResultDisplayStyle.byName(
          map['searchResultDisplayStyle'],
        ),
      }!,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "highlightedResultIndex": highlightedResultIndex,
      "resultCount": resultCount,
      "searchResultDisplayStyle": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          searchResultDisplayStyle.toNativeValue(),
        AqutterEnumMethod.value => searchResultDisplayStyle.toValue(),
        AqutterEnumMethod.name => searchResultDisplayStyle.name(),
      },
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterFindSession{highlightedResultIndex: $highlightedResultIndex, resultCount: $resultCount, searchResultDisplayStyle: $searchResultDisplayStyle}';
  }
}
