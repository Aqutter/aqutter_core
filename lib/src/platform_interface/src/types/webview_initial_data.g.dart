// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webview_initial_data.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Initial [data] as a content for an `WebView` instance, using [baseUrl] as the base URL for it.
class AqutterWebViewInitialData {
  ///Use [historyUrl] instead.
  @Deprecated('Use historyUrl instead')
  Uri? androidHistoryUrl;

  ///The URL to use as the page's base URL. If `null` defaults to `about:blank`.
  AqutterWebUri? baseUrl;

  ///A String of data in the given encoding.
  String data;

  ///The encoding of the data. The default value is `"utf8"`.
  String encoding;

  ///The URL to use as the history entry. If `null` defaults to `about:blank`. If non-null, this must be a valid URL.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  AqutterWebUri? historyUrl;

  ///The MIME type of the data, e.g. "text/html". The default value is `"text/html"`.
  String mimeType;
  AqutterWebViewInitialData({
    @Deprecated('Use historyUrl instead') this.androidHistoryUrl,
    this.baseUrl,
    required this.data,
    this.encoding = "utf8",
    this.historyUrl,
    this.mimeType = "text/html",
  }) {
    historyUrl =
        historyUrl ??
        (androidHistoryUrl != null
            ? AqutterWebUri.uri(androidHistoryUrl!)
            : null);
  }

  ///Gets a possible [AqutterWebViewInitialData] instance from a [Map] value.
  static AqutterWebViewInitialData? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebViewInitialData(
      androidHistoryUrl: map['historyUrl'] != null
          ? Uri.tryParse(map['historyUrl'])
          : null,
      baseUrl: map['baseUrl'] != null ? AqutterWebUri(map['baseUrl']) : null,
      data: map['data'],
      historyUrl: map['historyUrl'] != null
          ? AqutterWebUri(map['historyUrl'])
          : null,
    );
    if (map['encoding'] != null) {
      instance.encoding = map['encoding'];
    }
    if (map['mimeType'] != null) {
      instance.mimeType = map['mimeType'];
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "baseUrl": baseUrl?.toString(),
      "data": data,
      "encoding": encoding,
      "historyUrl": historyUrl?.toString(),
      "mimeType": mimeType,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterWebViewInitialData{baseUrl: $baseUrl, data: $data, encoding: $encoding, historyUrl: $historyUrl, mimeType: $mimeType}';
  }
}
