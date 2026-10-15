import 'dart:typed_data';

import 'x509_certificate.dart';

import 'asn1_identifier.dart';
import 'oid.dart';

class AqutterASN1Object {
  /// This property contains the DER encoded object
  Uint8List? encoded;

  /// This property contains the decoded object whenever is possible
  dynamic value;

  AqutterASN1Identifier? identifier;

  List<AqutterASN1Object>? sub;

  AqutterASN1Object? parent;

  AqutterASN1Object? subAtIndex(int index) {
    if (sub != null && index >= 0 && index < sub!.length) {
      return sub![index];
    }
    return null;
  }

  AqutterASN1Object? firstSub() {
    if (subCount() > 0) {
      return sub!.first;
    }
    return null;
  }

  AqutterASN1Object? lastSub() {
    if (subCount() > 0) {
      return sub!.last;
    }
    return null;
  }

  int subCount() {
    return sub?.length ?? 0;
  }

  AqutterASN1Object? findOid({AqutterOID? oid, String? oidValue}) {
    oidValue = oid != null ? oid.toValue() : oidValue;
    for (var child in (sub ?? <AqutterASN1Object>[])) {
      if (child.identifier?.tagNumber() ==
          AqutterASN1IdentifierTagNumber.OBJECT_IDENTIFIER) {
        if (child.value == oidValue) {
          return child;
        }
      } else {
        var result = child.findOid(oidValue: oidValue);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }

  String get description {
    return printAsn1();
  }

  String printAsn1({insets = ""}) {
    var output = insets;
    output += identifier?.description.toUpperCase() ?? "";
    output += (value != null ? ": $value" : "");
    if (identifier?.typeClass() == AqutterASN1IdentifierClass.UNIVERSAL &&
        identifier?.tagNumber() == AqutterASN1IdentifierTagNumber.OBJECT_IDENTIFIER) {
      var descr = AqutterOID.fromValue(value?.toString() ?? "")?.name();
      if (descr != null) {
        output += " ($descr)";
      }
    }
    output += sub != null && sub!.length > 0 ? " {" : "";
    output += "\n";
    for (var item in (sub ?? <AqutterASN1Object>[])) {
      output += item.printAsn1(insets: insets + "    ");
    }
    output += sub != null && sub!.length > 0 ? "}\n" : "";
    return output;
  }

  @override
  String toString() {
    return description;
  }

  AqutterASN1Object? atIndex(AqutterX509BlockPosition x509blockPosition) {
    if (sub != null && x509blockPosition.index < sub!.length) {
      return sub![x509blockPosition.index];
    }
    return null;
  }

  String? get asString {
    if (value is String) {
      return value;
    }

    if (sub != null && sub!.length > 0) {
      for (var item in sub!) {
        var itemAsString = item.asString;
        if (itemAsString != null) {
          return itemAsString;
        }
      }
    }

    return null;
  }
}
