import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../x509_certificate/x509_certificate.dart';
import '../x509_certificate/asn1_distinguished_names.dart';
import 'enum_method.dart';

import 'ssl_certificate_dname.dart';

part 'ssl_certificate.g.dart';

///SSL certificate info (certificate details) class.
@ExchangeableObject()
class AqutterSslCertificate_ {
  ///Name of the entity this certificate is issued by.
  AqutterSslCertificateDName_? issuedBy;

  ///Name of the entity this certificate is issued to.
  AqutterSslCertificateDName_? issuedTo;

  ///Not-after date from the validity period.
  DateTime? validNotAfterDate;

  ///Not-before date from the validity period.
  DateTime? validNotBeforeDate;

  ///The original source certificate, if available.
  AqutterX509Certificate? x509Certificate;

  AqutterSslCertificate_({
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
      x509Certificate = AqutterX509Certificate.fromData(data: map["x509Certificate"]);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }

    // Try to get issuedBy from map, otherwise fall back to x509Certificate
    AqutterSslCertificateDName? issuedBy = AqutterSslCertificateDName.fromMap(
      map["issuedBy"]?.cast<String, dynamic>(),
      enumMethod: enumMethod,
    );
    if (issuedBy == null && x509Certificate != null) {
      issuedBy = AqutterSslCertificateDName(
        CName:
            x509Certificate.issuer(dn: AqutterASN1DistinguishedNames.COMMON_NAME) ??
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

    // Try to get issuedTo from map, otherwise fall back to x509Certificate
    AqutterSslCertificateDName? issuedTo = AqutterSslCertificateDName.fromMap(
      map["issuedTo"]?.cast<String, dynamic>(),
      enumMethod: enumMethod,
    );
    if (issuedTo == null && x509Certificate != null) {
      issuedTo = AqutterSslCertificateDName(
        CName:
            x509Certificate.subject(dn: AqutterASN1DistinguishedNames.COMMON_NAME) ??
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

    // Try to get dates from map, otherwise fall back to x509Certificate
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
}
