// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ssl_certificate.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///SSL certificate info (certificate details) class.
class AqutterSslCertificate {
  ///Name of the entity this certificate is issued by.
  AqutterSslCertificateDName? issuedBy;

  ///Name of the entity this certificate is issued to.
  AqutterSslCertificateDName? issuedTo;

  ///Not-after date from the validity period.
  DateTime? validNotAfterDate;

  ///Not-before date from the validity period.
  DateTime? validNotBeforeDate;

  ///The original source certificate, if available.
  AqutterX509Certificate? x509Certificate;
  AqutterSslCertificate({
    this.issuedBy,
    this.issuedTo,
    this.validNotAfterDate,
    this.validNotBeforeDate,
    this.x509Certificate,
  });

  ///Gets a possible [AqutterSslCertificate] instance from a [Map] value.
  static AqutterSslCertificate? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    AqutterX509Certificate? x509Certificate;
    try {
      x509Certificate = AqutterX509Certificate.fromData(
        data: map["x509Certificate"],
      );
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    AqutterSslCertificateDName? issuedBy = AqutterSslCertificateDName.fromMap(
      map["issuedBy"]?.cast<String, dynamic>(),
      enumMethod: enumMethod,
    );
    if (issuedBy == null && x509Certificate != null) {
      issuedBy = AqutterSslCertificateDName(
        CName:
            x509Certificate.issuer(
              dn: AqutterASN1DistinguishedNames.COMMON_NAME,
            ) ??
            "",
        DName: x509Certificate.issuerDistinguishedName ?? "",
        OName:
            x509Certificate.issuer(
              dn: AqutterASN1DistinguishedNames.ORGANIZATION_NAME,
            ) ??
            "",
        UName:
            x509Certificate.issuer(
              dn: AqutterASN1DistinguishedNames.ORGANIZATIONAL_UNIT_NAME,
            ) ??
            "",
      );
    }
    AqutterSslCertificateDName? issuedTo = AqutterSslCertificateDName.fromMap(
      map["issuedTo"]?.cast<String, dynamic>(),
      enumMethod: enumMethod,
    );
    if (issuedTo == null && x509Certificate != null) {
      issuedTo = AqutterSslCertificateDName(
        CName:
            x509Certificate.subject(
              dn: AqutterASN1DistinguishedNames.COMMON_NAME,
            ) ??
            "",
        DName: x509Certificate.subjectDistinguishedName ?? "",
        OName:
            x509Certificate.subject(
              dn: AqutterASN1DistinguishedNames.ORGANIZATION_NAME,
            ) ??
            "",
        UName:
            x509Certificate.subject(
              dn: AqutterASN1DistinguishedNames.ORGANIZATIONAL_UNIT_NAME,
            ) ??
            "",
      );
    }
    DateTime? validNotAfterDate = map["validNotAfterDate"] != null
        ? DateTime.fromMillisecondsSinceEpoch(map["validNotAfterDate"])
        : x509Certificate?.notAfter;
    DateTime? validNotBeforeDate = map["validNotBeforeDate"] != null
        ? DateTime.fromMillisecondsSinceEpoch(map["validNotBeforeDate"])
        : x509Certificate?.notBefore;
    return AqutterSslCertificate(
      issuedBy: issuedBy,
      issuedTo: issuedTo,
      validNotAfterDate: validNotAfterDate,
      validNotBeforeDate: validNotBeforeDate,
      x509Certificate: x509Certificate,
    );
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "issuedBy": issuedBy?.toMap(enumMethod: enumMethod),
      "issuedTo": issuedTo?.toMap(enumMethod: enumMethod),
      "validNotAfterDate": validNotAfterDate?.millisecondsSinceEpoch,
      "validNotBeforeDate": validNotBeforeDate?.millisecondsSinceEpoch,
      "x509Certificate": x509Certificate?.toMap(enumMethod: enumMethod),
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterSslCertificate{issuedBy: $issuedBy, issuedTo: $issuedTo, validNotAfterDate: $validNotAfterDate, validNotBeforeDate: $validNotBeforeDate, x509Certificate: $x509Certificate}';
  }
}
