class AqutterOID {
  final String _value;

  const AqutterOID._internal(this._value);

  static final Set<AqutterOID> values = [
    AqutterOID.etsiQcsCompliance,
    AqutterOID.etsiQcsRetentionPeriod,
    AqutterOID.etsiQcsQcSSCD,
    AqutterOID.dsa,
    AqutterOID.ecPublicKey,
    AqutterOID.prime256v1,
    AqutterOID.ecdsaWithSHA256,
    AqutterOID.ecdsaWithSHA512,
    AqutterOID.rsaEncryption,
    AqutterOID.md2WithRSAEncryption,
    AqutterOID.md4WithRSAEncryption,
    AqutterOID.md5WithRSAEncryption,
    AqutterOID.sha1WithRSAEncryption,
    AqutterOID.RSAES_OAEP,
    AqutterOID.mgf1,
    AqutterOID.pSpecified,
    AqutterOID.RSASSA_PSS,
    AqutterOID.sha256WithRSAEncryption,
    AqutterOID.sha384WithRSAEncryption,
    AqutterOID.sha512WithRSAEncryption,
    AqutterOID.pkcs7data,
    AqutterOID.pkcs7signedData,
    AqutterOID.pkcs7envelopedData,
    AqutterOID.emailAddress,
    AqutterOID.signingCertificateV2,
    AqutterOID.contentType,
    AqutterOID.messageDigest,
    AqutterOID.signingTime,
    AqutterOID.dsaWithSha1,
    AqutterOID.certificateExtension,
    AqutterOID.jurisdictionOfIncorporationSP,
    AqutterOID.jurisdictionOfIncorporationC,
    AqutterOID.authorityInfoAccess,
    AqutterOID.qcStatements,
    AqutterOID.cps,
    AqutterOID.unotice,
    AqutterOID.serverAuth,
    AqutterOID.clientAuth,
    AqutterOID.ocsp,
    AqutterOID.caIssuers,
    AqutterOID.dateOfBirth,
    AqutterOID.desCBC,
    AqutterOID.sha1,
    AqutterOID.sha256,
    AqutterOID.sha384,
    AqutterOID.sha512,
    AqutterOID.md5,
    AqutterOID.VeriSignEVpolicy,
    AqutterOID.extendedValidation,
    AqutterOID.organizationValidated,
    AqutterOID.subjectKeyIdentifier,
    AqutterOID.keyUsage,
    AqutterOID.subjectAltName,
    AqutterOID.issuerAltName,
    AqutterOID.basicConstraints,
    AqutterOID.cRLDistributionPoints,
    AqutterOID.certificatePolicies,
    AqutterOID.authorityKeyIdentifier,
    AqutterOID.extKeyUsage,
    AqutterOID.subjectDirectoryAttributes,
    AqutterOID.organizationName,
    AqutterOID.organizationalUnitName,
    AqutterOID.businessCategory,
    AqutterOID.postalCode,
    AqutterOID.commonName,
    AqutterOID.surname,
    AqutterOID.givenName,
    AqutterOID.dnQualifier,
    AqutterOID.serialNumber,
    AqutterOID.countryName,
    AqutterOID.localityName,
    AqutterOID.stateOrProvinceName,
    AqutterOID.streetAddress,
    AqutterOID.desEDE3CBC,
    AqutterOID.aes128CBC,
    AqutterOID.aes192CBC,
    AqutterOID.aes256CBC,
    AqutterOID.nsCertType,
    AqutterOID.nsComment,
    AqutterOID.privateKeyUsagePeriod,
    AqutterOID.cRLNumber,
    AqutterOID.cRLReason,
    AqutterOID.expirationDate,
    AqutterOID.instructionCode,
    AqutterOID.invalidityDate,
    AqutterOID.deltaCRLIndicator,
    AqutterOID.issuingDistributionPoint,
    AqutterOID.certificateIssuer,
    AqutterOID.nameConstraints,
    AqutterOID.policyMappings,
    AqutterOID.policyConstraints,
    AqutterOID.freshestCRL,
    AqutterOID.inhibitAnyPolicy,
    AqutterOID.codeSigning,
    AqutterOID.emailProtection,
    AqutterOID.timeStamping,
    AqutterOID.pkcsSha256,
    AqutterOID.sha2Family,
    AqutterOID.sha3_244,
    AqutterOID.sha3_256,
    AqutterOID.sha3_384,
  ].toSet();

  static AqutterOID? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterOID.values.firstWhere((element) => element.toValue() == value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  String toValue() => _value;

  String name() =>
      _oidMapName.containsKey(this._value) ? _oidMapName[this._value]! : "";

  @override
  String toString() => "($_value, ${name()})";

  static const etsiQcsCompliance = const AqutterOID._internal("0.4.0.1862.1.1");
  static const etsiQcsRetentionPeriod = const AqutterOID._internal("0.4.0.1862.1.3");
  static const etsiQcsQcSSCD = const AqutterOID._internal("0.4.0.1862.1.4");
  static const dsa = const AqutterOID._internal("1.2.840.10040.4.1");
  static const ecPublicKey = const AqutterOID._internal("1.2.840.10045.2.1");
  static const prime256v1 = const AqutterOID._internal("1.2.840.10045.3.1.7");
  static const ecdsaWithSHA256 = const AqutterOID._internal("1.2.840.10045.4.3.2");
  static const ecdsaWithSHA512 = const AqutterOID._internal("1.2.840.10045.4.3.4");
  static const rsaEncryption = const AqutterOID._internal("1.2.840.113549.1.1.1");
  static const md2WithRSAEncryption = const AqutterOID._internal(
    "1.2.840.113549.1.1.2",
  );
  static const md4WithRSAEncryption = const AqutterOID._internal(
    "1.2.840.113549.1.1.3",
  );
  static const md5WithRSAEncryption = const AqutterOID._internal(
    "1.2.840.113549.1.1.4",
  );
  static const sha1WithRSAEncryption = const AqutterOID._internal(
    "1.2.840.113549.1.1.5",
  );
  static const RSAES_OAEP = const AqutterOID._internal("1.2.840.113549.1.1.7");
  static const mgf1 = const AqutterOID._internal(".2.840.113549.1.1.8");
  static const pSpecified = const AqutterOID._internal(".2.840.113549.1.1.9");
  static const RSASSA_PSS = const AqutterOID._internal(".2.840.113549.1.1.10");
  static const sha256WithRSAEncryption = const AqutterOID._internal(
    "1.2.840.113549.1.1.11",
  );
  static const sha384WithRSAEncryption = const AqutterOID._internal(
    "1.2.840.113549.1.1.12",
  );
  static const sha512WithRSAEncryption = const AqutterOID._internal(
    "1.2.840.113549.1.1.13",
  );
  static const pkcs7data = const AqutterOID._internal("1.2.840.113549.1.7.1");
  static const pkcs7signedData = const AqutterOID._internal("1.2.840.113549.1.7.2");
  static const pkcs7envelopedData = const AqutterOID._internal("1.2.840.113549.1.7.3");
  static const emailAddress = const AqutterOID._internal("1.2.840.113549.1.9.1");
  static const signingCertificateV2 = const AqutterOID._internal(
    "1.2.840.113549.1.9.16.2.47",
  );
  static const contentType = const AqutterOID._internal("1.2.840.113549.1.9.3");
  static const messageDigest = const AqutterOID._internal("1.2.840.113549.1.9.4");
  static const signingTime = const AqutterOID._internal("1.2.840.113549.1.9.5");
  static const dsaWithSha1 = const AqutterOID._internal("1.2.840.10040.4.3");
  static const certificateExtension = const AqutterOID._internal(
    "1.3.6.1.4.1.11129.2.4.2",
  );
  static const jurisdictionOfIncorporationSP = const AqutterOID._internal(
    "1.3.6.1.4.1.311.60.2.1.2",
  );
  static const jurisdictionOfIncorporationC = const AqutterOID._internal(
    "1.3.6.1.4.1.311.60.2.1.3",
  );
  static const authorityInfoAccess = const AqutterOID._internal("1.3.6.1.5.5.7.1.1");
  static const qcStatements = const AqutterOID._internal("1.3.6.1.5.5.7.1.3");
  static const cps = const AqutterOID._internal("1.3.6.1.5.5.7.2.1");
  static const unotice = const AqutterOID._internal("1.3.6.1.5.5.7.2.2");
  static const serverAuth = const AqutterOID._internal("1.3.6.1.5.5.7.3.1");
  static const clientAuth = const AqutterOID._internal("1.3.6.1.5.5.7.3.2");
  static const ocsp = const AqutterOID._internal("1.3.6.1.5.5.7.48.1");
  static const caIssuers = const AqutterOID._internal("1.3.6.1.5.5.7.48.2");
  static const dateOfBirth = const AqutterOID._internal("1.3.6.1.5.5.7.9.1");
  static const desCBC = const AqutterOID._internal("1.3.14.3.2.7");
  static const sha1 = const AqutterOID._internal("1.3.14.3.2.26");
  static const pkcsSha256 = const AqutterOID._internal("1.3.6.1.4.1.22554.1.2.1");
  static const sha2Family = const AqutterOID._internal("1.3.6.1.4.1.22554.1.2");
  static const sha3_244 = const AqutterOID._internal("2.16.840.1.101.3.4.2.7");
  static const sha3_256 = const AqutterOID._internal("2.16.840.1.101.3.4.2.8");
  static const sha3_384 = const AqutterOID._internal("2.16.840.1.101.3.4.2.9");
  static const md5 = const AqutterOID._internal("0.2.262.1.10.1.3.2");
  static const sha256 = const AqutterOID._internal("2.16.840.1.101.3.4.2.1");
  static const sha384 = const AqutterOID._internal("2.16.840.1.101.3.4.2.2");
  static const sha512 = const AqutterOID._internal("2.16.840.1.101.3.4.2.3");
  static const VeriSignEVpolicy = const AqutterOID._internal(
    "2.16.840.1.113733.1.7.23.6",
  );
  static const extendedValidation = const AqutterOID._internal("2.23.140.1.1");
  static const organizationValidated = const AqutterOID._internal("2.23.140.1.2.2");
  static const subjectKeyIdentifier = const AqutterOID._internal("2.5.29.14");
  static const keyUsage = const AqutterOID._internal("2.5.29.15");
  static const subjectAltName = const AqutterOID._internal("2.5.29.17");
  static const issuerAltName = const AqutterOID._internal("2.5.29.18");
  static const basicConstraints = const AqutterOID._internal("2.5.29.19");
  static const cRLDistributionPoints = const AqutterOID._internal("2.5.29.31");
  static const certificatePolicies = const AqutterOID._internal("2.5.29.32");
  static const authorityKeyIdentifier = const AqutterOID._internal("2.5.29.35");
  static const extKeyUsage = const AqutterOID._internal("2.5.29.37");
  static const subjectDirectoryAttributes = const AqutterOID._internal("2.5.29.9");
  static const organizationName = const AqutterOID._internal("2.5.4.10");
  static const organizationalUnitName = const AqutterOID._internal("2.5.4.11");
  static const businessCategory = const AqutterOID._internal("2.5.4.15");
  static const postalCode = const AqutterOID._internal("2.5.4.17");
  static const commonName = const AqutterOID._internal("2.5.4.3");
  static const surname = const AqutterOID._internal("2.5.4.4");
  static const givenName = const AqutterOID._internal("2.5.4.42");
  static const dnQualifier = const AqutterOID._internal("2.5.4.46");
  static const serialNumber = const AqutterOID._internal("2.5.4.5");
  static const countryName = const AqutterOID._internal("2.5.4.6");
  static const localityName = const AqutterOID._internal("2.5.4.7");
  static const stateOrProvinceName = const AqutterOID._internal("2.5.4.8");
  static const streetAddress = const AqutterOID._internal("2.5.4.9");
  static const desEDE3CBC = const AqutterOID._internal("1.2.840.113549.3.7");
  static const aes128CBC = const AqutterOID._internal("2.16.840.1.101.3.4.1.2");
  static const aes192CBC = const AqutterOID._internal("2.16.840.1.101.3.4.1.22");
  static const aes256CBC = const AqutterOID._internal("2.16.840.1.101.3.4.1.42");
  static const nsCertType = const AqutterOID._internal("2.16.840.1.113730.1.1");
  static const nsComment = const AqutterOID._internal("2.16.840.1.113730.1.13");
  static const privateKeyUsagePeriod = const AqutterOID._internal("2.5.29.16");
  static const cRLNumber = const AqutterOID._internal("2.5.29.20");
  static const cRLReason = const AqutterOID._internal("2.5.29.21");
  static const expirationDate = const AqutterOID._internal("2.5.29.22");
  static const instructionCode = const AqutterOID._internal("2.5.29.23");
  static const invalidityDate = const AqutterOID._internal("2.5.29.24");
  static const deltaCRLIndicator = const AqutterOID._internal("2.5.29.27");
  static const issuingDistributionPoint = const AqutterOID._internal("2.5.29.28");
  static const certificateIssuer = const AqutterOID._internal("2.5.29.29");
  static const nameConstraints = const AqutterOID._internal("2.5.29.30");
  static const policyMappings = const AqutterOID._internal("2.5.29.33");
  static const policyConstraints = const AqutterOID._internal("2.5.29.36");
  static const freshestCRL = const AqutterOID._internal("2.5.29.46");
  static const inhibitAnyPolicy = const AqutterOID._internal("2.5.29.54");
  static const codeSigning = const AqutterOID._internal("1.3.6.1.5.5.7.3.3");
  static const emailProtection = const AqutterOID._internal("1.3.6.1.5.5.7.3.4");
  static const timeStamping = const AqutterOID._internal("1.3.6.1.5.5.7.3.8");

  bool operator ==(value) => value == _value;

  @override
  int get hashCode => _value.hashCode;

  static const Map<String, String> _oidMapName = {
    "0.4.0.1862.1.1": "etsiQcsCompliance",
    "0.4.0.1862.1.3": "etsiQcsRetentionPeriod",
    "0.4.0.1862.1.4": "etsiQcsQcSSCD",
    "1.2.840.10040.4.1": "dsa",
    "1.2.840.10045.2.1": "ecPublicKey",
    "1.2.840.10045.3.1.7": "prime256v1",
    "1.2.840.10045.4.3.2": "ecdsaWithSHA256",
    "1.2.840.10045.4.3.4": "ecdsaWithSHA512",
    "1.2.840.113549.1.1.1": "rsaEncryption",
    "1.2.840.113549.1.1.2": "md2WithRSAEncryption",
    "1.2.840.113549.1.1.3": "md4WithRSAEncryption",
    "1.2.840.113549.1.1.4": "md5WithRSAEncryption",
    "1.2.840.113549.1.1.5": "sha1WithRSAEncryption",
    "1.2.840.113549.1.1.7": "RSAES-OAEP",
    ".2.840.113549.1.1.8": "mgf1",
    ".2.840.113549.1.1.9": "pSpecified",
    ".2.840.113549.1.1.10": "RSASSA-PSS",
    "1.2.840.113549.1.1.11": "sha256WithRSAEncryption",
    "1.2.840.113549.1.1.12": "sha384WithRSAEncryption",
    "1.2.840.113549.1.1.13": "sha512WithRSAEncryption",
    "1.2.840.113549.1.7.1": "pkcs7data",
    "1.2.840.113549.1.7.2": "pkcs7signedData",
    "1.2.840.113549.1.7.3": "pkcs7envelopedData",
    "1.2.840.113549.1.9.1": "emailAddress",
    "1.2.840.113549.1.9.16.2.47": "signingCertificateV2",
    "1.2.840.113549.1.9.3": "contentType",
    "1.2.840.113549.1.9.4": "messageDigest",
    "1.2.840.113549.1.9.5": "signingTime",
    "1.2.840.10040.4.3": "dsaWithSha1",
    "1.3.6.1.4.1.11129.2.4.2": "certificateExtension",
    "1.3.6.1.4.1.311.60.2.1.2": "jurisdictionOfIncorporationSP",
    "1.3.6.1.4.1.311.60.2.1.3": "jurisdictionOfIncorporationC",
    "1.3.6.1.5.5.7.1.1": "authorityInfoAccess",
    "1.3.6.1.5.5.7.1.3": "qcStatements",
    "1.3.6.1.5.5.7.2.1": "cps",
    "1.3.6.1.5.5.7.2.2": "unotice",
    "1.3.6.1.5.5.7.3.1": "serverAuth",
    "1.3.6.1.5.5.7.3.2": "clientAuth",
    "1.3.6.1.5.5.7.48.1": "ocsp",
    "1.3.6.1.5.5.7.48.2": "caIssuers",
    "1.3.6.1.5.5.7.9.1": "dateOfBirth",
    "1.3.14.3.2.7": "desCBC",
    "1.3.14.3.2.26": "sha1",
    "1.3.6.1.4.1.22554.1.2.1": "pkcsSha256",
    "1.3.6.1.4.1.22554.1.2": "sha2Family",
    "2.16.840.1.101.3.4.2.7": "sha3_244",
    "2.16.840.1.101.3.4.2.8": "sha3_256",
    "2.16.840.1.101.3.4.2.9": "sha3_384",
    "2.16.840.1.101.3.4.2.1": "sha256",
    "2.16.840.1.101.3.4.2.2": "sha384",
    "2.16.840.1.101.3.4.2.3": "sha512",
    "0.2.262.1.10.1.3.2": "md5",
    "2.16.840.1.113733.1.7.23.6": "VeriSign EV policy",
    "2.23.140.1.1": "extendedValidation",
    "2.23.140.1.2.2": "organizationValidated",
    "2.5.29.14": "subjectKeyIdentifier",
    "2.5.29.15": "keyUsage",
    "2.5.29.17": "subjectAltName",
    "2.5.29.18": "issuerAltName",
    "2.5.29.19": "basicConstraints",
    "2.5.29.31": "cRLDistributionPoints",
    "2.5.29.32": "certificatePolicies",
    "2.5.29.35": "authorityKeyIdentifier",
    "2.5.29.37": "extKeyUsage",
    "2.5.29.9": "subjectDirectoryAttributes",
    "2.5.4.10": "organizationName",
    "2.5.4.11": "organizationalUnitName",
    "2.5.4.15": "businessCategory",
    "2.5.4.17": "postalCode",
    "2.5.4.3": "commonName",
    "2.5.4.4": "surname",
    "2.5.4.42": "givenName",
    "2.5.4.46": "dnQualifier",
    "2.5.4.5": "serialNumber",
    "2.5.4.6": "countryName",
    "2.5.4.7": "localityName",
    "2.5.4.8": "stateOrProvinceName",
    "2.5.4.9": "streetAddress",
    "1.2.840.113549.3.7": "des-EDE3-CBC",
    "2.16.840.1.101.3.4.1.2": "aes128-CBC",
    "2.16.840.1.101.3.4.1.22": "aes192-CBC",
    "2.16.840.1.101.3.4.1.42": "aes256-CBC",
    "2.16.840.1.113730.1.1": "nsCertType",
    "2.16.840.1.113730.1.13": "nsComment",
    "2.5.29.16": "privateKeyUsagePeriod",
    "2.5.29.20": "cRLNumber",
    "2.5.29.21": "cRLReason",
    "2.5.29.22": "expirationDate",
    "2.5.29.23": "instructionCode",
    "2.5.29.24": "invalidityDate",
    "2.5.29.27": "deltaCRLIndicator",
    "2.5.29.28": "issuingDistributionPoint",
    "2.5.29.29": "certificateIssuer",
    "2.5.29.30": "nameConstraints",
    "2.5.29.33": "policyMappings",
    "2.5.29.36": "policyConstraints",
    "2.5.29.46": "freshestCRL",
    "2.5.29.54": "inhibitAnyPolicy",
    "1.3.6.1.5.5.7.3.3": "codeSigning",
    "1.3.6.1.5.5.7.3.4": "emailProtection",
    "1.3.6.1.5.5.7.3.8": "timeStamping",
  };
}
