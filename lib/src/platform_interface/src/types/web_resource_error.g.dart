// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_resource_error.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Encapsulates information about errors occurred during loading of web resources.
class AqutterWebResourceError {
  ///The string describing the error.
  String description;

  ///The type of the error.
  AqutterWebResourceErrorType type;
  AqutterWebResourceError({required this.description, required this.type});

  ///Gets a possible [AqutterWebResourceError] instance from a [Map] value.
  static AqutterWebResourceError? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebResourceError(
      description: map['description'],
      type: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterWebResourceErrorType.fromNativeValue(map['type']),
        AqutterEnumMethod.value => AqutterWebResourceErrorType.fromValue(
          map['type'],
        ),
        AqutterEnumMethod.name => AqutterWebResourceErrorType.byName(
          map['type'],
        ),
      }!,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "description": description,
      "type": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => type.toNativeValue(),
        AqutterEnumMethod.value => type.toValue(),
        AqutterEnumMethod.name => type.name(),
      },
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterWebResourceError{description: $description, type: $type}';
  }
}
