// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_history_item.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///A convenience class for accessing fields in an entry in the back/forward list of a `WebView`.
///Each [AqutterWebHistoryItem] is a snapshot of the requested history item.
class AqutterWebHistoryItem {
  ///Unique id of the navigation history entry.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  int? entryId;

  ///0-based position index in the back-forward [AqutterWebHistory.list].
  int? index;

  ///Position offset respect to the currentIndex of the back-forward [AqutterWebHistory.list].
  int? offset;

  ///Original url of this history item.
  AqutterWebUri? originalUrl;

  ///Document title of this history item.
  String? title;

  ///Url of this history item.
  AqutterWebUri? url;
  AqutterWebHistoryItem({
    this.entryId,
    this.index,
    this.offset,
    this.originalUrl,
    this.title,
    this.url,
  });

  ///Gets a possible [AqutterWebHistoryItem] instance from a [Map] value.
  static AqutterWebHistoryItem? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebHistoryItem(
      entryId: map['entryId'],
      index: map['index'],
      offset: map['offset'],
      originalUrl: map['originalUrl'] != null
          ? AqutterWebUri(map['originalUrl'])
          : null,
      title: map['title'],
      url: map['url'] != null ? AqutterWebUri(map['url']) : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "entryId": entryId,
      "index": index,
      "offset": offset,
      "originalUrl": originalUrl?.toString(),
      "title": title,
      "url": url?.toString(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterWebHistoryItem{entryId: $entryId, index: $index, offset: $offset, originalUrl: $originalUrl, title: $title, url: $url}';
  }
}
