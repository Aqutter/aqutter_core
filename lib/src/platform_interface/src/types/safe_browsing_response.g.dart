// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safe_browsing_response.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the response used by the [AqutterPlatformWebViewCreationParams.onSafeBrowsingHit] event.
///It is used to indicate an action to take when hitting a malicious URL.
class AqutterSafeBrowsingResponse {
  ///Indicate the [AqutterSafeBrowsingResponseAction] to take when hitting a malicious URL.
  AqutterSafeBrowsingResponseAction? action;

  ///If reporting is enabled, all reports will be sent according to the privacy policy referenced by [AqutterPlatformWebViewController.getSafeBrowsingPrivacyPolicyUrl].
  bool report;
  AqutterSafeBrowsingResponse({
    AqutterSafeBrowsingResponseAction? action,
    this.report = true,
  }) : action = action ?? AqutterSafeBrowsingResponseAction.SHOW_INTERSTITIAL;

  ///Gets a possible [AqutterSafeBrowsingResponse] instance from a [Map] value.
  static AqutterSafeBrowsingResponse? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterSafeBrowsingResponse();
    instance.action = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterSafeBrowsingResponseAction.fromNativeValue(map['action']),
      AqutterEnumMethod.value => AqutterSafeBrowsingResponseAction.fromValue(
        map['action'],
      ),
      AqutterEnumMethod.name => AqutterSafeBrowsingResponseAction.byName(
        map['action'],
      ),
    };
    if (map['report'] != null) {
      instance.report = map['report'];
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
      "report": report,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterSafeBrowsingResponse{action: $action, report: $report}';
  }
}
