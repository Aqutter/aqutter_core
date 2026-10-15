// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'js_prompt_request.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the request of the [AqutterPlatformWebViewCreationParams.onJsPrompt] event.
class AqutterJsPromptRequest {
  ///The default value displayed in the prompt dialog.
  String? defaultValue;

  ///Use [isMainFrame] instead.
  @Deprecated('Use isMainFrame instead')
  bool? iosIsMainFrame;

  ///Indicates whether the request was made for the main frame.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  bool? isMainFrame;

  ///Message to be displayed in the window.
  String? message;

  ///The url of the page requesting the dialog.
  AqutterWebUri? url;
  AqutterJsPromptRequest({
    this.defaultValue,
    @Deprecated('Use isMainFrame instead') this.iosIsMainFrame,
    this.isMainFrame,
    this.message,
    this.url,
  }) {
    isMainFrame = isMainFrame ?? iosIsMainFrame;
  }

  ///Gets a possible [AqutterJsPromptRequest] instance from a [Map] value.
  static AqutterJsPromptRequest? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterJsPromptRequest(
      defaultValue: map['defaultValue'],
      iosIsMainFrame: map['isMainFrame'],
      isMainFrame: map['isMainFrame'],
      message: map['message'],
      url: map['url'] != null ? AqutterWebUri(map['url']) : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "defaultValue": defaultValue,
      "isMainFrame": isMainFrame,
      "message": message,
      "url": url?.toString(),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterJsPromptRequest{defaultValue: $defaultValue, isMainFrame: $isMainFrame, message: $message, url: $url}';
  }
}
