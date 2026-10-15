import 'dart:typed_data';

import '../types/enum_method.dart';
import 'asn1_decoder.dart';
import 'asn1_der_encoder.dart';
import 'asn1_object.dart';
import 'oid.dart';

class AqutterX509PublicKey {
  AqutterASN1Object? pkBlock;

  AqutterX509PublicKey({this.pkBlock});

  String? get algOid => pkBlock?.subAtIndex(0)?.subAtIndex(0)?.value;

  String? get algName => AqutterOID.fromValue(algOid)?.name();

  String? get algParams => pkBlock?.subAtIndex(0)?.subAtIndex(1)?.value;

  Uint8List? get derEncodedKey {
    var value = pkBlock?.encoded;
    if (value != null) {
      return AqutterASN1DEREncoder.encodeSequence(content: value);
    }
    return null;
  }

  Uint8List? get encoded {
    var oid = AqutterOID.fromValue(algOid);
    var keyData = pkBlock?.subAtIndex(1)?.value ?? null;

    if (oid != null && algOid != null && keyData != null) {
      if (oid == AqutterOID.ecPublicKey) {
        return Uint8List.fromList(keyData);
      } else if (oid == AqutterOID.rsaEncryption) {
        List<AqutterASN1Object>? publicKeyAsn1Objects;
        try {
          publicKeyAsn1Objects = AqutterASN1DERDecoder.decode(
            data: keyData.toList(growable: true),
          );
        } catch (e) {}

        if (publicKeyAsn1Objects != null && publicKeyAsn1Objects.length > 0) {
          var publicKeyModulus = publicKeyAsn1Objects.first
              .subAtIndex(0)
              ?.value;
          if (publicKeyModulus != null) {
            return Uint8List.fromList(publicKeyModulus);
          }
        }
      }
    }
    return null;
  }

  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "algOid": algOid,
      "algName": algName,
      "algParams": algParams,
      "encoded": encoded,
    };
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }
}
