// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ajax_request_event.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class used by [AqutterAjaxRequest] class. It represents events measuring progress of an [AqutterAjaxRequest].
class AqutterAjaxRequestEvent {
  ///Is a Boolean flag indicating if the total work to be done, and the amount of work already done, by the underlying process is calculable.
  ///In other words, it tells if the progress is measurable or not.
  bool? lengthComputable;

  ///Is an integer representing the amount of work already performed by the underlying process.
  ///The ratio of work done can be calculated with the property and [AqutterAjaxRequestEvent.total].
  ///When downloading a resource using HTTP, this only represent the part of the content itself, not headers and other overhead.
  int? loaded;

  ///Is an integer representing the total amount of work that the underlying process is in the progress of performing.
  ///When downloading a resource using HTTP, this only represent the content itself, not headers and other overhead.
  int? total;

  ///Event type.
  AqutterAjaxRequestEventType? type;
  AqutterAjaxRequestEvent({
    this.lengthComputable,
    this.loaded,
    this.total,
    this.type,
  });

  ///Gets a possible [AqutterAjaxRequestEvent] instance from a [Map] value.
  static AqutterAjaxRequestEvent? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterAjaxRequestEvent(
      lengthComputable: map['lengthComputable'],
      loaded: map['loaded'],
      total: map['total'],
      type: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterAjaxRequestEventType.fromNativeValue(map['type']),
        AqutterEnumMethod.value => AqutterAjaxRequestEventType.fromValue(
          map['type'],
        ),
        AqutterEnumMethod.name => AqutterAjaxRequestEventType.byName(
          map['type'],
        ),
      },
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "lengthComputable": lengthComputable,
      "loaded": loaded,
      "total": total,
      "type": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => type?.toNativeValue(),
        AqutterEnumMethod.value => type?.toValue(),
        AqutterEnumMethod.name => type?.name(),
      },
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterAjaxRequestEvent{lengthComputable: $lengthComputable, loaded: $loaded, total: $total, type: $type}';
  }
}
