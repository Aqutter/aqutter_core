// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_message.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///The type corresponding to the [AqutterWebMessage].
class AqutterWebMessageType {
  final int _value;
  final int? _nativeValue;
  const AqutterWebMessageType._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterWebMessageType._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterWebMessageType._internal(value, nativeValue());

  ///Indicates the payload of WebMessageCompat is JavaScript ArrayBuffer.
  ///
  ///**NOTE**: available only if [AqutterWebViewFeature.WEB_MESSAGE_ARRAY_BUFFER] feature is supported.
  static const ARRAY_BUFFER = AqutterWebMessageType._internal(1, 1);

  ///Indicates the payload of WebMessageCompat is String.
  static const STRING = AqutterWebMessageType._internal(0, 0);

  ///Set of all values of [AqutterWebMessageType].
  static final Set<AqutterWebMessageType> values = [
    AqutterWebMessageType.ARRAY_BUFFER,
    AqutterWebMessageType.STRING,
  ].toSet();

  ///Gets a possible [AqutterWebMessageType] instance from [int] value.
  static AqutterWebMessageType? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterWebMessageType.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterWebMessageType] instance from a native value.
  static AqutterWebMessageType? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterWebMessageType.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterWebMessageType] instance value with name [name].
  ///
  /// Goes through [AqutterWebMessageType.values] looking for a value with
  /// name [name], as reported by [AqutterWebMessageType.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterWebMessageType? byName(String? name) {
    if (name != null) {
      try {
        return AqutterWebMessageType.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterWebMessageType] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterWebMessageType> asNameMap() =>
      <String, AqutterWebMessageType>{
        for (final value in AqutterWebMessageType.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 1:
        return 'ARRAY_BUFFER';
      case 0:
        return 'STRING';
    }
    return _value.toString();
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(value) => value == _value;

  ///Checks if the value is supported by the [defaultTargetPlatform].
  bool isSupported() {
    return _nativeValue != null;
  }

  @override
  String toString() {
    return name();
  }
}

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///The Dart representation of the HTML5 PostMessage event.
///See https://html.spec.whatwg.org/multipage/comms.html#the-messageevent-interfaces for definition of a MessageEvent in HTML5.
class AqutterWebMessage {
  ///The data of the message.
  dynamic data;

  ///The ports that are sent with the message.
  List<AqutterIWebMessagePort>? ports;

  ///The payload type of the message.
  AqutterWebMessageType type;
  AqutterWebMessage({
    this.data,
    this.type = AqutterWebMessageType.STRING,
    this.ports,
  }) {
    assert(
      ((this.data == null || this.data is String) &&
              this.type == AqutterWebMessageType.STRING) ||
          (this.data != null &&
              this.data is Uint8List &&
              this.type == AqutterWebMessageType.ARRAY_BUFFER),
    );
  }

  ///Gets a possible [AqutterWebMessage] instance from a [Map] value.
  static AqutterWebMessage? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebMessage(
      data: map['data'],
      ports: map['ports'] != null
          ? List<AqutterIWebMessagePort>.from(map['ports'].map((e) => e))
          : null,
      type: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterWebMessageType.fromNativeValue(
          map['type'],
        ),
        AqutterEnumMethod.value => AqutterWebMessageType.fromValue(map['type']),
        AqutterEnumMethod.name => AqutterWebMessageType.byName(map['type']),
      }!,
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "data": data,
      "ports": ports?.map((e) => e.toMap(enumMethod: enumMethod)).toList(),
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
    return 'AqutterWebMessage{data: $data, ports: $ports, type: $type}';
  }
}
