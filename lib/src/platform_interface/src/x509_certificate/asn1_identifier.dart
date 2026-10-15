class AqutterASN1IdentifierClass {
  final int _value;

  const AqutterASN1IdentifierClass._internal(this._value);

  static final Set<AqutterASN1IdentifierClass> values = [
    AqutterASN1IdentifierClass.UNIVERSAL,
    AqutterASN1IdentifierClass.APPLICATION,
    AqutterASN1IdentifierClass.CONTEXT_SPECIFIC,
    AqutterASN1IdentifierClass.PRIVATE,
  ].toSet();

  static AqutterASN1IdentifierClass? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterASN1IdentifierClass.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  int toValue() => _value;

  static const UNIVERSAL = const AqutterASN1IdentifierClass._internal(0x00);
  static const APPLICATION = const AqutterASN1IdentifierClass._internal(0x40);
  static const CONTEXT_SPECIFIC = const AqutterASN1IdentifierClass._internal(0x80);
  static const PRIVATE = const AqutterASN1IdentifierClass._internal(0xC0);

  @override
  String toString() {
    switch (this.toValue()) {
      case 0x00:
        return "UNIVERSAL";
      case 0x40:
        return "APPLICATION";
      case 0x80:
        return "CONTEXT_SPECIFIC";
      case 0xC0:
        return "PRIVATE";
    }
    return "";
  }

  bool operator ==(value) => value == _value;

  @override
  int get hashCode => _value.hashCode;
}

class AqutterASN1IdentifierTagNumber {
  final int _value;

  const AqutterASN1IdentifierTagNumber._internal(this._value);

  static final Set<AqutterASN1IdentifierTagNumber> values = [
    AqutterASN1IdentifierTagNumber.END_OF_CONTENT,
    AqutterASN1IdentifierTagNumber.BOOLEAN,
    AqutterASN1IdentifierTagNumber.INTEGER,
    AqutterASN1IdentifierTagNumber.BIT_STRING,
    AqutterASN1IdentifierTagNumber.OCTET_STRING,
    AqutterASN1IdentifierTagNumber.NULL,
    AqutterASN1IdentifierTagNumber.OBJECT_IDENTIFIER,
    AqutterASN1IdentifierTagNumber.OBJECT_DESCRIPTOR,
    AqutterASN1IdentifierTagNumber.EXTERNAL,
    AqutterASN1IdentifierTagNumber.READ,
    AqutterASN1IdentifierTagNumber.ENUMERATED,
    AqutterASN1IdentifierTagNumber.EMBEDDED_PDV,
    AqutterASN1IdentifierTagNumber.UTF8_STRING,
    AqutterASN1IdentifierTagNumber.RELATIVE_OID,
    AqutterASN1IdentifierTagNumber.SEQUENCE,
    AqutterASN1IdentifierTagNumber.SET,
    AqutterASN1IdentifierTagNumber.NUMERIC_STRING,
    AqutterASN1IdentifierTagNumber.PRINTABLE_STRING,
    AqutterASN1IdentifierTagNumber.T61_STRING,
    AqutterASN1IdentifierTagNumber.VIDEOTEX_STRING,
    AqutterASN1IdentifierTagNumber.IA5_STRING,
    AqutterASN1IdentifierTagNumber.UTC_TIME,
    AqutterASN1IdentifierTagNumber.GENERALIZED_TIME,
    AqutterASN1IdentifierTagNumber.GRAPHIC_STRING,
    AqutterASN1IdentifierTagNumber.VISIBLE_STRING,
    AqutterASN1IdentifierTagNumber.GENERAL_STRING,
    AqutterASN1IdentifierTagNumber.UNIVERSAL_STRING,
    AqutterASN1IdentifierTagNumber.CHARACTER_STRING,
    AqutterASN1IdentifierTagNumber.BMP_STRING,
  ].toSet();

  static AqutterASN1IdentifierTagNumber? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterASN1IdentifierTagNumber.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  int toValue() => _value;

  static const END_OF_CONTENT = const AqutterASN1IdentifierTagNumber._internal(0x00);
  static const BOOLEAN = const AqutterASN1IdentifierTagNumber._internal(0x01);
  static const INTEGER = const AqutterASN1IdentifierTagNumber._internal(0x02);
  static const BIT_STRING = const AqutterASN1IdentifierTagNumber._internal(0x03);
  static const OCTET_STRING = const AqutterASN1IdentifierTagNumber._internal(0x04);
  static const NULL = const AqutterASN1IdentifierTagNumber._internal(0x05);
  static const OBJECT_IDENTIFIER = const AqutterASN1IdentifierTagNumber._internal(
    0x06,
  );
  static const OBJECT_DESCRIPTOR = const AqutterASN1IdentifierTagNumber._internal(
    0x07,
  );
  static const EXTERNAL = const AqutterASN1IdentifierTagNumber._internal(0x08);
  static const READ = const AqutterASN1IdentifierTagNumber._internal(0x09);
  static const ENUMERATED = const AqutterASN1IdentifierTagNumber._internal(0x0A);
  static const EMBEDDED_PDV = const AqutterASN1IdentifierTagNumber._internal(0x0B);
  static const UTF8_STRING = const AqutterASN1IdentifierTagNumber._internal(0x0C);
  static const RELATIVE_OID = const AqutterASN1IdentifierTagNumber._internal(0x0D);
  static const SEQUENCE = const AqutterASN1IdentifierTagNumber._internal(0x10);
  static const SET = const AqutterASN1IdentifierTagNumber._internal(0x11);
  static const NUMERIC_STRING = const AqutterASN1IdentifierTagNumber._internal(0x12);
  static const PRINTABLE_STRING = const AqutterASN1IdentifierTagNumber._internal(0x13);
  static const T61_STRING = const AqutterASN1IdentifierTagNumber._internal(0x14);
  static const VIDEOTEX_STRING = const AqutterASN1IdentifierTagNumber._internal(0x15);
  static const IA5_STRING = const AqutterASN1IdentifierTagNumber._internal(0x16);
  static const UTC_TIME = const AqutterASN1IdentifierTagNumber._internal(0x17);
  static const GENERALIZED_TIME = const AqutterASN1IdentifierTagNumber._internal(0x18);
  static const GRAPHIC_STRING = const AqutterASN1IdentifierTagNumber._internal(0x19);
  static const VISIBLE_STRING = const AqutterASN1IdentifierTagNumber._internal(0x1A);
  static const GENERAL_STRING = const AqutterASN1IdentifierTagNumber._internal(0x1B);
  static const UNIVERSAL_STRING = const AqutterASN1IdentifierTagNumber._internal(0x1C);
  static const CHARACTER_STRING = const AqutterASN1IdentifierTagNumber._internal(0x1D);
  static const BMP_STRING = const AqutterASN1IdentifierTagNumber._internal(0x1E);

  @override
  String toString() {
    switch (this.toValue()) {
      case 0x00:
        return "END_OF_CONTENT";
      case 0x01:
        return "BOOLEAN";
      case 0x02:
        return "INTEGER";
      case 0x03:
        return "BIT_STRING";
      case 0x04:
        return "OCTET_STRING";
      case 0x05:
        return "NULL";
      case 0x06:
        return "OBJECT_IDENTIFIER";
      case 0x07:
        return "OBJECT_DESCRIPTOR";
      case 0x08:
        return "EXTERNAL";
      case 0x09:
        return "READ";
      case 0x0A:
        return "ENUMERATED";
      case 0x0B:
        return "EMBEDDED_PDV";
      case 0x0C:
        return "UTF8_STRING";
      case 0x0D:
        return "RELATIVE_OID";
      case 0x10:
        return "SEQUENCE";
      case 0x11:
        return "SET";
      case 0x12:
        return "NUMERIC_STRING";
      case 0x13:
        return "PRINTABLE_STRING";
      case 0x14:
        return "T61_STRING";
      case 0x15:
        return "VIDEOTEX_STRING";
      case 0x16:
        return "IA5_STRING";
      case 0x17:
        return "UTC_TIME";
      case 0x18:
        return "GENERALIZED_TIME";
      case 0x19:
        return "GRAPHIC_STRING";
      case 0x1A:
        return "VISIBLE_STRING";
      case 0x1B:
        return "GENERAL_STRING";
      case 0x1C:
        return "UNIVERSAL_STRING";
      case 0x1D:
        return "CHARACTER_STRING";
      case 0x1E:
        return "BMP_STRING";
    }
    return "";
  }

  bool operator ==(value) => value == _value;

  @override
  int get hashCode => _value.hashCode;
}

class AqutterASN1Identifier {
  int rawValue;
  static int constructedTag = 0x20;

  AqutterASN1Identifier(this.rawValue);

  bool isPrimitive() {
    return (rawValue & AqutterASN1Identifier.constructedTag) == 0;
  }

  bool isConstructed() {
    return (rawValue & AqutterASN1Identifier.constructedTag) != 0;
  }

  AqutterASN1IdentifierTagNumber tagNumber() {
    return AqutterASN1IdentifierTagNumber.fromValue(rawValue & 0x1F) ??
        AqutterASN1IdentifierTagNumber.END_OF_CONTENT;
  }

  AqutterASN1IdentifierClass typeClass() {
    for (var tc in [
      AqutterASN1IdentifierClass.APPLICATION,
      AqutterASN1IdentifierClass.CONTEXT_SPECIFIC,
      AqutterASN1IdentifierClass.PRIVATE,
    ]) {
      if ((rawValue & tc.toValue()) == tc.toValue()) {
        return tc;
      }
    }
    return AqutterASN1IdentifierClass.UNIVERSAL;
  }

  String get description {
    var tc = typeClass();
    var tn = tagNumber();
    if (tc == AqutterASN1IdentifierClass.UNIVERSAL) {
      return tn.toString();
    } else {
      return "$tc(${tn.toValue()})";
    }
  }

  @override
  String toString() {
    return description;
  }
}
