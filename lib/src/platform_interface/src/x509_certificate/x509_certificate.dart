import 'dart:convert';
import 'dart:typed_data';

import '../types/enum_method.dart';
import 'asn1_decoder.dart';
import 'asn1_object.dart';
import 'oid.dart';
import 'x509_public_key.dart';

import 'x509_extension.dart';
import 'asn1_distinguished_names.dart';

///Class that represents a X.509 certificate.
///This provides a standard way to access all the attributes of an X.509 certificate.
class AqutterX509Certificate {
  List<AqutterASN1Object>? asn1;
  AqutterASN1Object? block1;

  ///Returns the encoded form of this certificate. It is
  ///assumed that each certificate type would have only a single
  ///form of encoding; for example, X.509 certificates would
  ///be encoded as ASN.1 DER.
  Uint8List? encoded;

  static const beginPemBlock = "-----BEGIN CERTIFICATE-----";
  static const endPemBlock = "-----END CERTIFICATE-----";

  AqutterX509Certificate({AqutterASN1Object? asn1}) {
    if (asn1 != null) {
      var block1 = asn1.subAtIndex(0);
      if (block1 == null) {
        throw AqutterASN1ParseError();
      }
    }
  }

  static AqutterX509Certificate fromData({required Uint8List data}) {
    var decoded = utf8.decode(data, allowMalformed: true);
    if (decoded.contains(AqutterX509Certificate.beginPemBlock)) {
      return AqutterX509Certificate.fromPemData(pem: data);
    } else {
      return AqutterX509Certificate.fromDerData(der: data);
    }
  }

  static AqutterX509Certificate fromDerData({required Uint8List der}) {
    var asn1 = AqutterASN1DERDecoder.decode(data: der.toList(growable: true));
    if (asn1.length > 0) {
      var block1 = asn1.first.subAtIndex(0);
      if (block1 != null) {
        var certificate = AqutterX509Certificate();
        certificate.asn1 = asn1;
        certificate.block1 = block1;
        certificate.encoded = der;
        return certificate;
      }
    }
    throw AqutterASN1ParseError();
  }

  static AqutterX509Certificate fromPemData({required Uint8List pem}) {
    var derData = AqutterX509Certificate.decodeToDER(pemData: pem);
    if (derData == null) {
      throw AqutterASN1ParseError();
    }
    return AqutterX509Certificate.fromDerData(der: derData);
  }

  ///Read possible PEM encoding
  static Uint8List? decodeToDER({required pemData}) {
    var pem = String.fromCharCodes(pemData);
    if (pem.contains(AqutterX509Certificate.beginPemBlock)) {
      var lines = pem.split("\n");
      var base64buffer = "";
      var certLine = false;
      for (var line in lines) {
        if (line == AqutterX509Certificate.endPemBlock) {
          certLine = false;
        }
        if (certLine) {
          base64buffer += line;
        }
        if (line == AqutterX509Certificate.beginPemBlock) {
          certLine = true;
        }
      }

      Uint8List? derDataDecoded;
      try {
        derDataDecoded = Uint8List.fromList(base64Decode(base64buffer));
      } catch (e) {}
      if (derDataDecoded != null) {
        return derDataDecoded;
      }
    }
    return null;
  }

  String get description =>
      asn1?.fold(
        "",
        (value, element) => (value ?? '') + element.description + '\n',
      ) ??
      '';

  ///Checks that the given date is within the certificate's validity period.
  bool checkValidity({DateTime? date}) {
    if (date == null) {
      date = DateTime.now();
    }
    if (notBefore != null && notAfter != null) {
      return date.isAfter(notBefore!) && date.isBefore(notAfter!);
    }
    return false;
  }

  ///Gets the version (version number) value from the certificate.
  int? get version {
    if (block1 != null) {
      var v = firstLeafValue(block: block1!);
      if (v is List<int>) {
        var index = toIntValue(v);
        if (index != null) {
          return index.toInt() + 1;
        }
      }
    }
    return null;
  }

  ///Gets the serialNumber value from the certificate.
  List<int>? get serialNumber {
    var data = block1?.atIndex(AqutterX509BlockPosition.serialNumber)?.value;
    return data is List<int> ? data : null;
  }

  ///Returns the issuer (issuer distinguished name) value from the certificate as a String.
  String? get issuerDistinguishedName {
    var issuerBlock = block1?.atIndex(AqutterX509BlockPosition.issuer);
    if (issuerBlock != null) {
      return AqutterASN1DistinguishedNames.string(block: issuerBlock);
    }
    return null;
  }

  List<String> get issuerOIDs {
    var result = <String>[];
    var issuerBlock = block1?.atIndex(AqutterX509BlockPosition.issuer);
    if (issuerBlock != null) {
      for (var sub in (issuerBlock.sub ?? <AqutterASN1Object>[])) {
        var value = firstLeafValue(block: sub);
        if (value is String) {
          result.add(value);
        }
      }
    }
    return result;
  }

  String? issuer({String? oid, AqutterASN1DistinguishedNames? dn}) {
    if (oid == null && dn != null) {
      oid = dn.oid();
    }
    if (oid != null) {
      var issuerBlock = block1?.atIndex(AqutterX509BlockPosition.issuer);
      if (issuerBlock != null) {
        var oidBlock = issuerBlock.findOid(oidValue: oid);
        if (oidBlock != null) {
          var sub = oidBlock.parent?.sub;
          if (sub != null && sub.length > 0 && sub.last.value is String) {
            return sub.last.value;
          } else {
            return null;
          }
        }
      }
    }
    return null;
  }

  ///Returns the subject (subject distinguished name) value from the certificate as a String.
  String? get subjectDistinguishedName {
    var subjectBlock = block1?.atIndex(AqutterX509BlockPosition.subject);
    if (subjectBlock != null) {
      return AqutterASN1DistinguishedNames.string(block: subjectBlock);
    }
    return null;
  }

  List<String> get subjectOIDs {
    var result = <String>[];
    var subjectBlock = block1?.atIndex(AqutterX509BlockPosition.subject);
    if (subjectBlock != null) {
      for (var sub in (subjectBlock.sub ?? <AqutterASN1Object>[])) {
        var value = firstLeafValue(block: sub);
        if (value is String) {
          result.add(value);
        }
      }
    }
    return result;
  }

  String? subject({String? oid, AqutterASN1DistinguishedNames? dn}) {
    if (oid == null && dn != null) {
      oid = dn.oid();
    }
    if (oid != null) {
      var subjectBlock = block1?.atIndex(AqutterX509BlockPosition.subject);
      if (subjectBlock != null) {
        var oidBlock = subjectBlock.findOid(oidValue: oid);
        if (oidBlock != null) {
          var sub = oidBlock.parent?.sub;
          if (sub != null && sub.length > 0 && sub.last.value is String) {
            return sub.last.value;
          } else {
            return null;
          }
        }
      }
    }
    return null;
  }

  ///Gets the notBefore date from the validity period of the certificate.
  DateTime? get notBefore {
    var data = block1
        ?.atIndex(AqutterX509BlockPosition.dateValidity)
        ?.subAtIndex(0)
        ?.value;
    return data is DateTime ? data : null;
  }

  ///Gets the notAfter date from the validity period of the certificate.
  DateTime? get notAfter {
    var data = block1
        ?.atIndex(AqutterX509BlockPosition.dateValidity)
        ?.subAtIndex(1)
        ?.value;
    return data is DateTime ? data : null;
  }

  ///Gets the signature value (the raw signature bits) from the certificate.
  List<int>? get signature {
    var data = asn1?[0].subAtIndex(2)?.value;
    return data is List<int> ? data : null;
  }

  ///Gets the signature algorithm name for the certificate signature algorithm.
  String? get sigAlgName => AqutterOID.fromValue(sigAlgOID ?? '')?.name();

  ///Gets the signature algorithm AqutterOID string from the certificate.
  String? get sigAlgOID {
    var data = block1?.subAtIndex(2)?.subAtIndex(0)?.value;
    return data is String ? data : null;
  }

  ///Gets the DER-encoded signature algorithm parameters from this certificate's signature algorithm.
  List<int>? get sigAlgParams => null;

  ///Gets a boolean array representing bits of the AqutterKeyUsage extension, (AqutterOID = 2.5.29.15).
  ///```
  ///AqutterKeyUsage ::= BIT STRING {
  ///digitalSignature        (0),
  ///nonRepudiation          (1),
  ///keyEncipherment         (2),
  ///dataEncipherment        (3),
  ///keyAgreement            (4),
  ///keyCertSign             (5),
  ///cRLSign                 (6),
  ///encipherOnly            (7),
  ///decipherOnly            (8)
  ///}
  ///```
  List<bool> get keyUsage {
    var result = <bool>[];
    var oidBlock = block1?.findOid(oid: AqutterOID.keyUsage);
    if (oidBlock != null) {
      var sub = oidBlock.parent?.sub;
      if (sub != null && sub.length > 0) {
        var data = sub.last.subAtIndex(0)?.value;
        int bits = (data is List<int> && data.length > 0) ? data.first : 0;
        for (var index = 0; index < 8; index++) {
          var value = bits & (1 << index).toUnsigned(8) != 0;
          result.insert(0, value);
        }
      }
    }
    return result;
  }

  ///Gets a list of Strings representing the OBJECT IDENTIFIERs of the ExtKeyUsageSyntax field of
  ///the extended key usage extension, (AqutterOID = 2.5.29.37).
  List<String> get extendedKeyUsage =>
      extensionObject(oid: AqutterOID.extKeyUsage)?.valueAsStrings ?? <String>[];

  ///Gets a collection of subject alternative names from the SubjectAltName extension, (AqutterOID = 2.5.29.17).
  List<String> get subjectAlternativeNames =>
      extensionObject(oid: AqutterOID.subjectAltName)?.alternativeNameAsStrings ??
      <String>[];

  ///Gets a collection of issuer alternative names from the IssuerAltName extension, (AqutterOID = 2.5.29.18).
  List<String> get issuerAlternativeNames =>
      extensionObject(oid: AqutterOID.issuerAltName)?.alternativeNameAsStrings ??
      <String>[];

  ///Gets the informations of the public key from this certificate.
  AqutterX509PublicKey? get publicKey {
    var pkBlock = block1?.atIndex(AqutterX509BlockPosition.publicKey);
    if (pkBlock != null) {
      return AqutterX509PublicKey(pkBlock: pkBlock);
    }
    return null;
  }

  ///Get a list of critical extension AqutterOID codes
  List<String> get criticalExtensionOIDs {
    var extensionBlocks = this.extensionBlocks;
    if (extensionBlocks == null) {
      return <String>[];
    }
    return extensionBlocks
        .map((block) => AqutterX509Extension(block: block))
        .where((extension) => extension.isCritical)
        .map((extension) => extension.oid ?? '')
        .toList();
  }

  ///Get a list of non critical extension AqutterOID codes
  List<String> get nonCriticalExtensionOIDs {
    var extensionBlocks = this.extensionBlocks;
    if (extensionBlocks == null) {
      return <String>[];
    }
    return extensionBlocks
        .map((block) => AqutterX509Extension(block: block))
        .where((extension) => !extension.isCritical)
        .map((extension) => extension.oid ?? '')
        .toList();
  }

  ///Gets the certificate constraints path length from the
  ///critical BasicConstraints extension, (AqutterOID = 2.5.29.19).
  AqutterBasicConstraintExtension? get basicConstraints =>
      extensionObject(oid: AqutterOID.basicConstraints) as AqutterBasicConstraintExtension?;

  ///Gets the raw bits from the Subject Key Identifier (SKID) extension, (AqutterOID = 2.5.29.14).
  AqutterSubjectKeyIdentifierExtension? get subjectKeyIdentifier =>
      extensionObject(oid: AqutterOID.subjectKeyIdentifier)
          as AqutterSubjectKeyIdentifierExtension?;

  ///Gets the raw bits from the Authority Key Identifier extension, (AqutterOID = 2.5.29.35).
  AqutterAuthorityKeyIdentifierExtension? get authorityKeyIdentifier =>
      extensionObject(oid: AqutterOID.authorityKeyIdentifier)
          as AqutterAuthorityKeyIdentifierExtension?;

  ///Gets the list of certificate policies from the CertificatePolicies extension, (AqutterOID = 2.5.29.32).
  AqutterCertificatePoliciesExtension? get certificatePolicies =>
      extensionObject(oid: AqutterOID.certificatePolicies)
          as AqutterCertificatePoliciesExtension?;

  ///Gets the list of CRL distribution points from the CRLDistributionPoints extension, (AqutterOID = 2.5.29.31).
  AqutterCRLDistributionPointsExtension? get cRLDistributionPoints =>
      extensionObject(oid: AqutterOID.cRLDistributionPoints)
          as AqutterCRLDistributionPointsExtension?;

  ///Gets the map of the format (as a key) and location (as a value) of additional information
  ///about the CA who issued the certificate in which this extension appears
  ///from the AqutterAuthorityInfoAccess extension, (AqutterOID = 1.3.6.1.5.5.5.7.1.1).
  AqutterAuthorityInfoAccessExtension? get authorityInfoAccess =>
      extensionObject(oid: AqutterOID.authorityInfoAccess)
          as AqutterAuthorityInfoAccessExtension?;

  List<AqutterASN1Object>? get extensionBlocks =>
      block1?.atIndex(AqutterX509BlockPosition.extensions)?.subAtIndex(0)?.sub;

  ///Gets the extension information of the given AqutterOID code or enum string value.
  AqutterX509Extension? extensionObject({String? oidValue, AqutterOID? oid}) {
    if (oidValue == null && oid != null) {
      oidValue = oid.toValue();
    }
    if (oidValue != null) {
      var block = block1
          ?.atIndex(AqutterX509BlockPosition.extensions)
          ?.findOid(oidValue: oidValue)
          ?.parent;
      if (block != null) {
        if (oidValue == AqutterOID.basicConstraints.toValue()) {
          return AqutterBasicConstraintExtension(block: block);
        } else if (oidValue == AqutterOID.subjectKeyIdentifier.toValue()) {
          return AqutterSubjectKeyIdentifierExtension(block: block);
        } else if (oidValue == AqutterOID.authorityInfoAccess.toValue()) {
          return AqutterAuthorityInfoAccessExtension(block: block);
        } else if (oidValue == AqutterOID.authorityKeyIdentifier.toValue()) {
          return AqutterAuthorityKeyIdentifierExtension(block: block);
        } else if (oidValue == AqutterOID.certificatePolicies.toValue()) {
          return AqutterCertificatePoliciesExtension(block: block);
        } else if (oidValue == AqutterOID.cRLDistributionPoints.toValue()) {
          return AqutterCRLDistributionPointsExtension(block: block);
        }
        return AqutterX509Extension(block: block);
      }
    }
    return null;
  }

  @override
  String toString() {
    return description;
  }

  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "basicConstraints": basicConstraints?.toMap(enumMethod: enumMethod),
      "subjectAlternativeNames": subjectAlternativeNames,
      "issuerAlternativeNames": issuerAlternativeNames,
      "extendedKeyUsage": extendedKeyUsage,
      "issuerDistinguishedName": issuerDistinguishedName,
      "keyUsage": keyUsage,
      "notAfter": notAfter?.millisecondsSinceEpoch,
      "notBefore": notBefore?.millisecondsSinceEpoch,
      "serialNumber": serialNumber,
      "sigAlgName": sigAlgName,
      "sigAlgOID": sigAlgOID,
      "sigAlgParams": sigAlgParams,
      "signature": signature,
      "subjectDistinguishedName": subjectDistinguishedName,
      "version": version,
      "criticalExtensionOIDs": criticalExtensionOIDs,
      "nonCriticalExtensionOIDs": nonCriticalExtensionOIDs,
      "encoded": encoded,
      "publicKey": publicKey?.toMap(enumMethod: enumMethod),
      "subjectKeyIdentifier": subjectKeyIdentifier?.toMap(
        enumMethod: enumMethod,
      ),
      "authorityKeyIdentifier": authorityKeyIdentifier?.toMap(
        enumMethod: enumMethod,
      ),
      "certificatePolicies": certificatePolicies?.toMap(enumMethod: enumMethod),
      "cRLDistributionPoints": cRLDistributionPoints?.toMap(
        enumMethod: enumMethod,
      ),
      "authorityInfoAccess": authorityInfoAccess?.toMap(enumMethod: enumMethod),
    };
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }
}

dynamic firstLeafValue({required AqutterASN1Object block}) {
  var sub = block.sub;
  if (sub != null && sub.length > 0) {
    AqutterASN1Object? subFirst;
    try {
      subFirst = sub.first;
    } catch (e) {}
    if (subFirst != null) {
      return firstLeafValue(block: subFirst);
    }
  }
  return block.value;
}

enum AqutterX509BlockPosition {
  version,
  serialNumber,
  signatureAlg,
  issuer,
  dateValidity,
  subject,
  publicKey,
  extensions,
}
