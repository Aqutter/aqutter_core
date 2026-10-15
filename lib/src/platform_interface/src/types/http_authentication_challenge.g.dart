// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_authentication_challenge.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the challenge of the [AqutterPlatformWebViewCreationParams.onReceivedHttpAuthRequest] event.
///It provides all the information about the challenge.
class AqutterHttpAuthenticationChallenge
    extends AqutterURLAuthenticationChallenge {
  ///The error object representing the last authentication failure.
  ///This value is `null` if the protocol doesn’t use errors to indicate an authentication failure.
  ///
  ///**NOTE**: available only on iOS.
  String? error;

  ///The URL response object representing the last authentication failure.
  ///This value is `null` if the protocol doesn’t use responses to indicate an authentication failure.
  ///
  ///**NOTE**: available only on iOS.
  AqutterURLResponse? failureResponse;

  ///Use [error] instead.
  @Deprecated('Use error instead')
  String? iosError;

  ///Use [failureResponse] instead.
  @Deprecated('Use failureResponse instead')
  AqutterIOSURLResponse? iosFailureResponse;

  ///A count of previous failed authentication attempts.
  int previousFailureCount;

  ///The proposed credential for this challenge.
  ///This method returns `null` if there is no default credential for this challenge.
  ///If you have previously attempted to authenticate and failed, this method returns the most recent failed credential.
  ///If the proposed credential is not nil and returns true when you call its hasPassword method, then the credential is ready to use as-is.
  ///If the proposed credential’s hasPassword method returns false, then the credential provides a default user name,
  ///and the client must prompt the user for a corresponding password.
  AqutterURLCredential? proposedCredential;
  AqutterHttpAuthenticationChallenge({
    this.error,
    this.failureResponse,
    @Deprecated('Use error instead') this.iosError,
    @Deprecated('Use failureResponse instead') this.iosFailureResponse,
    required this.previousFailureCount,
    this.proposedCredential,
    required AqutterURLProtectionSpace protectionSpace,
  }) : super(protectionSpace: protectionSpace) {
    error = error ?? iosError;
    failureResponse =
        failureResponse ??
        AqutterURLResponse.fromMap(iosFailureResponse?.toMap());
  }

  ///Gets a possible [AqutterHttpAuthenticationChallenge] instance from a [Map] value.
  static AqutterHttpAuthenticationChallenge? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterHttpAuthenticationChallenge(
      protectionSpace: AqutterURLProtectionSpace.fromMap(
        map['protectionSpace']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      )!,
      error: map['error'],
      failureResponse: AqutterURLResponse.fromMap(
        map['failureResponse']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      iosError: map['error'],
      iosFailureResponse: AqutterIOSURLResponse.fromMap(
        map['failureResponse']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      previousFailureCount: map['previousFailureCount'],
      proposedCredential: AqutterURLCredential.fromMap(
        map['proposedCredential']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "protectionSpace": protectionSpace.toMap(enumMethod: enumMethod),
      "error": error,
      "failureResponse": failureResponse?.toMap(enumMethod: enumMethod),
      "previousFailureCount": previousFailureCount,
      "proposedCredential": proposedCredential?.toMap(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterHttpAuthenticationChallenge{protectionSpace: $protectionSpace, error: $error, failureResponse: $failureResponse, previousFailureCount: $previousFailureCount, proposedCredential: $proposedCredential}';
  }
}
