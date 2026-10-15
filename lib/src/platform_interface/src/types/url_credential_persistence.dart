import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'url_credential_persistence.g.dart';

///Class that represents the constants that specify how long the credential will be kept.
@ExchangeableEnum()
class AqutterURLCredentialPersistence_ {
  // ignore: unused_field
  final int _value;
  const AqutterURLCredentialPersistence_._internal(this._value);

  ///The credential should not be stored.
  static const NONE = const AqutterURLCredentialPersistence_._internal(0);

  ///The credential should be stored only for this session
  static const FOR_SESSION = const AqutterURLCredentialPersistence_._internal(1);

  ///The credential should be stored in the keychain.
  static const PERMANENT = const AqutterURLCredentialPersistence_._internal(2);

  ///The credential should be stored permanently in the keychain,
  ///and in addition should be distributed to other devices based on the owning Apple ID.
  static const SYNCHRONIZABLE = const AqutterURLCredentialPersistence_._internal(3);
}

///An iOS-specific class that represents the constants that specify how long the credential will be kept.
///Use [AqutterURLCredentialPersistence] instead.
@Deprecated("Use AqutterURLCredentialPersistence instead")
@ExchangeableEnum()
class AqutterIOSURLCredentialPersistence_ {
  // ignore: unused_field
  final int _value;
  const AqutterIOSURLCredentialPersistence_._internal(this._value);

  ///The credential should not be stored.
  static const NONE = const AqutterIOSURLCredentialPersistence_._internal(0);

  ///The credential should be stored only for this session
  static const FOR_SESSION = const AqutterIOSURLCredentialPersistence_._internal(1);

  ///The credential should be stored in the keychain.
  static const PERMANENT = const AqutterIOSURLCredentialPersistence_._internal(2);

  ///The credential should be stored permanently in the keychain,
  ///and in addition should be distributed to other devices based on the owning Apple ID.
  static const SYNCHRONIZABLE = const AqutterIOSURLCredentialPersistence_._internal(3);
}
