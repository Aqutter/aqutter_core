// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_start_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class representing a download request of the WebView used by the event [AqutterPlatformWebViewCreationParams.onDownloadStartRequest].
class AqutterDownloadStartRequest {
  ///Content-disposition http header, if present.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- Windows WebView2
  String? contentDisposition;

  ///The file size reported by the server.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  int contentLength;

  ///The mimetype of the content reported by the server.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  String? mimeType;

  ///A suggested filename to use if saving the resource to disk.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  String? suggestedFilename;

  ///The name of the text encoding of the receiver, or `null` if no text encoding was specified.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  String? textEncodingName;

  ///The full url to the content that should be downloaded.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  AqutterWebUri url;

  ///the user agent to be used for the download.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  String? userAgent;
  AqutterDownloadStartRequest({
    this.contentDisposition,
    required this.contentLength,
    this.mimeType,
    this.suggestedFilename,
    this.textEncodingName,
    required this.url,
    this.userAgent,
  });

  ///Gets a possible [AqutterDownloadStartRequest] instance from a [Map] value.
  static AqutterDownloadStartRequest? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterDownloadStartRequest(
      contentDisposition: map['contentDisposition'],
      contentLength: map['contentLength'],
      mimeType: map['mimeType'],
      suggestedFilename: map['suggestedFilename'],
      textEncodingName: map['textEncodingName'],
      url: AqutterWebUri(map['url']),
      userAgent: map['userAgent'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "contentDisposition": contentDisposition,
      "contentLength": contentLength,
      "mimeType": mimeType,
      "suggestedFilename": suggestedFilename,
      "textEncodingName": textEncodingName,
      "url": url.toString(),
      "userAgent": userAgent,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterDownloadStartRequest{contentDisposition: $contentDisposition, contentLength: $contentLength, mimeType: $mimeType, suggestedFilename: $suggestedFilename, textEncodingName: $textEncodingName, url: $url, userAgent: $userAgent}';
  }
}
