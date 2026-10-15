import 'asn1_object.dart';

class AqutterASN1DistinguishedNames {
  final String _oid;
  final String _representation;

  const AqutterASN1DistinguishedNames._internal(this._oid, this._representation);

  static final Set<AqutterASN1DistinguishedNames> values = [
    AqutterASN1DistinguishedNames.COMMON_NAME,
    AqutterASN1DistinguishedNames.DN_QUALIFIER,
    AqutterASN1DistinguishedNames.SERIAL_NUMBER,
    AqutterASN1DistinguishedNames.GIVEN_NAME,
    AqutterASN1DistinguishedNames.SURNAME,
    AqutterASN1DistinguishedNames.ORGANIZATIONAL_UNIT_NAME,
    AqutterASN1DistinguishedNames.ORGANIZATION_NAME,
    AqutterASN1DistinguishedNames.STREET_ADDRESS,
    AqutterASN1DistinguishedNames.LOCALITY_NAME,
    AqutterASN1DistinguishedNames.STATE_OR_PROVINCE_NAME,
    AqutterASN1DistinguishedNames.COUNTRY_NAME,
    AqutterASN1DistinguishedNames.EMAIL,
  ].toSet();

  static AqutterASN1DistinguishedNames? fromValue(String? oid) {
    if (oid != null) {
      try {
        return AqutterASN1DistinguishedNames.values.firstWhere(
          (element) => element.oid() == oid,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  String oid() => _oid;

  String representation() => _representation;

  @override
  String toString() => "($_oid, $_representation)";

  static const COMMON_NAME = const AqutterASN1DistinguishedNames._internal(
    "2.5.4.3",
    "CN",
  );
  static const DN_QUALIFIER = const AqutterASN1DistinguishedNames._internal(
    "2.5.4.46",
    "DNQ",
  );
  static const SERIAL_NUMBER = const AqutterASN1DistinguishedNames._internal(
    "2.5.4.5",
    "SERIALNUMBER",
  );
  static const GIVEN_NAME = const AqutterASN1DistinguishedNames._internal(
    "2.5.4.42",
    "GIVENNAME",
  );
  static const SURNAME = const AqutterASN1DistinguishedNames._internal(
    "2.5.4.4",
    "SURNAME",
  );
  static const ORGANIZATIONAL_UNIT_NAME =
      const AqutterASN1DistinguishedNames._internal("2.5.4.11", "OU");
  static const ORGANIZATION_NAME = const AqutterASN1DistinguishedNames._internal(
    "2.5.4.10",
    "O",
  );
  static const STREET_ADDRESS = const AqutterASN1DistinguishedNames._internal(
    "2.5.4.9",
    "STREET",
  );
  static const LOCALITY_NAME = const AqutterASN1DistinguishedNames._internal(
    "2.5.4.7",
    "L",
  );
  static const STATE_OR_PROVINCE_NAME = const AqutterASN1DistinguishedNames._internal(
    "2.5.4.8",
    "ST",
  );
  static const COUNTRY_NAME = const AqutterASN1DistinguishedNames._internal(
    "2.5.4.6",
    "C",
  );
  static const EMAIL = const AqutterASN1DistinguishedNames._internal(
    "1.2.840.113549.1.9.1",
    "E",
  );

  bool operator ==(value) => value == _oid;

  @override
  int get hashCode => _oid.hashCode;

  /// Format subject/issuer information in RFC1779
  static String string({required AqutterASN1Object block}) {
    var result = "";
    var oidNames = AqutterASN1DistinguishedNames.values;
    for (var oidName in oidNames) {
      var oidBlock = block.findOid(oidValue: oidName.oid());
      if (oidBlock == null) {
        continue;
      }
      if (result.isNotEmpty) {
        result += ", ";
      }
      result += oidName.representation();
      result += "=";

      String? value;
      try {
        value = oidBlock.parent?.sub?.last.value as String?;
      } catch (e) {}
      if (value != null) {
        result += quote(value);
      }
    }
    return result;
  }

  static String quote(String string) {
    var specialChars = [",", "+", "=", "\n", "<", ">", "#", ";", "\\"];
    for (var specialChar in specialChars) {
      if (string.contains(specialChar)) {
        return "\"" + string + "\"";
      }
    }
    return string;
  }
}
