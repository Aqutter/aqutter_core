import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'enum_method.dart';
import 'ssl_certificate.dart';

part 'ssl_certificate_dname.g.dart';

///Distinguished name helper class. Used by [AqutterSslCertificate].
@ExchangeableObject()
class AqutterSslCertificateDName_ {
  ///Common-name (CN) component of the name
  String? CName;

  ///Distinguished name (normally includes CN, O, and OU names)
  String? DName;

  ///Organization (O) component of the name
  String? OName;

  ///Organizational Unit (OU) component of the name
  String? UName;

  AqutterSslCertificateDName_({
    this.CName = "",
    this.DName = "",
    this.OName = "",
    this.UName = "",
  });
}
