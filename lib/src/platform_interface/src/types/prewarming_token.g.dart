// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prewarming_token.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the Prewarming Token returned by [AqutterPlatformChromeSafariBrowser.prewarmConnections].
class AqutterPrewarmingToken {
  ///Prewarming Token id.
  final String id;
  AqutterPrewarmingToken({required this.id});

  ///Gets a possible [AqutterPrewarmingToken] instance from a [Map] value.
  static AqutterPrewarmingToken? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterPrewarmingToken(id: map['id']);
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"id": id};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterPrewarmingToken{id: $id}';
  }
}
