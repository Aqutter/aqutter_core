class AqutterKeyUsage {
  final int _value;

  const AqutterKeyUsage._internal(this._value);

  static final Set<AqutterKeyUsage> values = [
    AqutterKeyUsage.digitalSignature,
    AqutterKeyUsage.nonRepudiation,
    AqutterKeyUsage.keyEncipherment,
    AqutterKeyUsage.dataEncipherment,
    AqutterKeyUsage.keyAgreement,
    AqutterKeyUsage.keyCertSign,
    AqutterKeyUsage.cRLSign,
    AqutterKeyUsage.encipherOnly,
    AqutterKeyUsage.decipherOnly,
  ].toSet();

  static AqutterKeyUsage? fromIndex(int? value) {
    if (value != null) {
      try {
        return AqutterKeyUsage.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  int toValue() => _value;

  String name() => _KeyUsageMapName.containsKey(this._value)
      ? _KeyUsageMapName[this._value]!
      : "";

  @override
  String toString() => "($_value, ${name()})";

  static const digitalSignature = const AqutterKeyUsage._internal(0);
  static const nonRepudiation = const AqutterKeyUsage._internal(1);
  static const keyEncipherment = const AqutterKeyUsage._internal(2);
  static const dataEncipherment = const AqutterKeyUsage._internal(3);
  static const keyAgreement = const AqutterKeyUsage._internal(4);
  static const keyCertSign = const AqutterKeyUsage._internal(5);
  static const cRLSign = const AqutterKeyUsage._internal(6);
  static const encipherOnly = const AqutterKeyUsage._internal(7);
  static const decipherOnly = const AqutterKeyUsage._internal(8);

  bool operator ==(value) => value == _value;

  @override
  int get hashCode => _value.hashCode;

  static const Map<int, String> _KeyUsageMapName = {
    0: "digitalSignature",
    1: "nonRepudiation",
    2: "keyEncipherment",
    3: "dataEncipherment",
    4: "keyAgreement",
    5: "keyCertSign",
    6: "cRLSign",
    7: "encipherOnly",
    8: "decipherOnly",
  };
}
