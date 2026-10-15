// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_notification.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the data of a web notification.
///
///This corresponds to the properties of the [ICoreWebView2Notification](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2notification?view=webview2-1.0.3595.46) interface.
class AqutterWebNotification {
  ///The badge URI.
  AqutterWebUri? badgeUri;

  ///The body text of the notification.
  String? body;

  ///The body image URI.
  AqutterWebUri? bodyImageUri;

  ///The text direction.
  AqutterTextDirectionKind? direction;

  ///The icon URI.
  AqutterWebUri? iconUri;

  ///Whether the notification is silent.
  bool? isSilent;

  ///The language of the notification.
  String? language;

  ///Whether the notification requires interaction.
  bool? requiresInteraction;

  ///Whether the notification should renotify.
  bool? shouldRenotify;

  ///The tag of the notification.
  String? tag;

  ///The timestamp of the notification, in milliseconds since UNIX epoch.
  double? timestamp;

  ///The title of the notification.
  String? title;

  ///The vibration pattern for devices with vibration hardware to emit.
  ///
  ///The vibration pattern can be represented by an array of 64-bit unsigned integers
  ///describing a pattern of vibrations and pauses. See [Vibration API](https://developer.mozilla.org/docs/Web/API/Vibration_API) for more information.
  ///This corresponds to [Notification.vibrate](https://developer.mozilla.org/docs/Web/API/Notification/vibrate) DOM API.
  ///An empty list is returned if no vibration patterns are specified.
  List<int>? vibrationPattern;
  AqutterWebNotification({
    this.badgeUri,
    this.body,
    this.bodyImageUri,
    this.direction,
    this.iconUri,
    this.isSilent,
    this.language,
    this.requiresInteraction,
    this.shouldRenotify,
    this.tag,
    this.timestamp,
    this.title,
    this.vibrationPattern,
  });

  ///Gets a possible [AqutterWebNotification] instance from a [Map] value.
  static AqutterWebNotification? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebNotification(
      badgeUri: map['badgeUri'] != null ? AqutterWebUri(map['badgeUri']) : null,
      body: map['body'],
      bodyImageUri: map['bodyImageUri'] != null
          ? AqutterWebUri(map['bodyImageUri'])
          : null,
      direction: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterTextDirectionKind.fromNativeValue(map['direction']),
        AqutterEnumMethod.value => AqutterTextDirectionKind.fromValue(
          map['direction'],
        ),
        AqutterEnumMethod.name => AqutterTextDirectionKind.byName(
          map['direction'],
        ),
      },
      iconUri: map['iconUri'] != null ? AqutterWebUri(map['iconUri']) : null,
      isSilent: map['isSilent'],
      language: map['language'],
      requiresInteraction: map['requiresInteraction'],
      shouldRenotify: map['shouldRenotify'],
      tag: map['tag'],
      timestamp: map['timestamp'],
      title: map['title'],
      vibrationPattern: map['vibrationPattern'] != null
          ? List<int>.from(map['vibrationPattern']!.cast<int>())
          : null,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "badgeUri": badgeUri?.toString(),
      "body": body,
      "bodyImageUri": bodyImageUri?.toString(),
      "direction": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => direction?.toNativeValue(),
        AqutterEnumMethod.value => direction?.toValue(),
        AqutterEnumMethod.name => direction?.name(),
      },
      "iconUri": iconUri?.toString(),
      "isSilent": isSilent,
      "language": language,
      "requiresInteraction": requiresInteraction,
      "shouldRenotify": shouldRenotify,
      "tag": tag,
      "timestamp": timestamp,
      "title": title,
      "vibrationPattern": vibrationPattern,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterWebNotification{badgeUri: $badgeUri, body: $body, bodyImageUri: $bodyImageUri, direction: $direction, iconUri: $iconUri, isSilent: $isSilent, language: $language, requiresInteraction: $requiresInteraction, shouldRenotify: $shouldRenotify, tag: $tag, timestamp: $timestamp, title: $title, vibrationPattern: $vibrationPattern}';
  }
}
