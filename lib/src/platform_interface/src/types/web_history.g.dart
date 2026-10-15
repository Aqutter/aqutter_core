// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_history.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///This class contains a snapshot of the current back/forward list for a `WebView`.
class AqutterWebHistory {
  ///Index of the current [AqutterWebHistoryItem].
  int? currentIndex;

  ///List of all [AqutterWebHistoryItem]s.
  List<AqutterWebHistoryItem>? list;
  AqutterWebHistory({this.currentIndex, this.list});

  ///Gets a possible [AqutterWebHistory] instance from a [Map] value.
  static AqutterWebHistory? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebHistory(
      currentIndex: map['currentIndex'],
      list: map['list'] != null
          ? List<AqutterWebHistoryItem>.from(
              map['list'].map(
                (e) => AqutterWebHistoryItem.fromMap(
                  e?.cast<String, dynamic>(),
                  enumMethod: enumMethod,
                )!,
              ),
            )
          : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "currentIndex": currentIndex,
      "list": list?.map((e) => e.toMap(enumMethod: enumMethod)).toList(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterWebHistory{currentIndex: $currentIndex, list: $list}';
  }
}
