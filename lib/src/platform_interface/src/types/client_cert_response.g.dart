// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_cert_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onReceivedClientCertRequest] event.
class AqutterClientCertResponse {
  ///Indicate the [AqutterClientCertResponseAction] to take in response of the client certificate challenge.
  AqutterClientCertResponseAction? action;

  ///Use [keyStoreType] instead.
  @Deprecated('Use keyStoreType instead')
  String? androidKeyStoreType;

  ///The certificate password.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  String? certificatePassword;

  ///The file path of the certificate to use.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  String certificatePath;

  ///An Android-specific property used by Java [KeyStore](https://developer.android.com/reference/java/security/KeyStore) class to get the instance.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  String? keyStoreType;

  ///The index of the selected certificate.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  int selectedCertificate;
  AqutterClientCertResponse({
    this.certificatePath = "",
    this.certificatePassword = "",
    @Deprecated('Use keyStoreType instead') this.androidKeyStoreType = "PKCS12",
    this.keyStoreType = "PKCS12",
    this.selectedCertificate = -1,
    this.action = AqutterClientCertResponseAction.CANCEL,
  }) {
    if (this.action == AqutterClientCertResponseAction.PROCEED &&
        !Util.isWindows)
      assert(certificatePath.isNotEmpty);
    this.keyStoreType = this.keyStoreType ?? this.androidKeyStoreType;
    if (Util.isAndroid) assert(this.keyStoreType != null);
  }

  ///Gets a possible [AqutterClientCertResponse] instance from a [Map] value.
  static AqutterClientCertResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterClientCertResponse();
    instance.action = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterClientCertResponseAction.fromNativeValue(map['action']),
      AqutterEnumMethod.value => AqutterClientCertResponseAction.fromValue(
        map['action'],
      ),
      AqutterEnumMethod.name => AqutterClientCertResponseAction.byName(
        map['action'],
      ),
    };
    instance.androidKeyStoreType = map['keyStoreType'];
    instance.certificatePassword = map['certificatePassword'];
    if (map['certificatePath'] != null) {
      instance.certificatePath = map['certificatePath'];
    }
    instance.keyStoreType = map['keyStoreType'];
    if (map['selectedCertificate'] != null) {
      instance.selectedCertificate = map['selectedCertificate'];
    }
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "action": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => action?.toNativeValue(),
        AqutterEnumMethod.value => action?.toValue(),
        AqutterEnumMethod.name => action?.name(),
      },
      "certificatePassword": certificatePassword,
      "certificatePath": certificatePath,
      "keyStoreType": keyStoreType,
      "selectedCertificate": selectedCertificate,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterClientCertResponse{action: $action, certificatePassword: $certificatePassword, certificatePath: $certificatePath, keyStoreType: $keyStoreType, selectedCertificate: $selectedCertificate}';
  }
}
