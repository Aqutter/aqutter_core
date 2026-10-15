// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'js_before_unload_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the request of the [AqutterPlatformWebViewCreationParams.onJsBeforeUnload] event.
class AqutterJsBeforeUnloadRequest {
  ///Message to be displayed in the window.
  String? message;

  ///The url of the page requesting the dialog.
  AqutterWebUri? url;
  AqutterJsBeforeUnloadRequest({this.message, this.url});

  ///Gets a possible [AqutterJsBeforeUnloadRequest] instance from a [Map] value.
  static AqutterJsBeforeUnloadRequest? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterJsBeforeUnloadRequest(
      message: map['message'],
      url: map['url'] != null ? AqutterWebUri(map['url']) : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"message": message, "url": url?.toString()};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterJsBeforeUnloadRequest{message: $message, url: $url}';
  }
}
