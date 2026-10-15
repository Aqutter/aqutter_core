import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'cache_mode.g.dart';

///Class used to override the way the cache is used.
@ExchangeableEnum()
class AqutterCacheMode_ {
  // ignore: unused_field
  final int _value;
  const AqutterCacheMode_._internal(this._value);

  ///Default cache usage mode. If the navigation type doesn't impose any specific behavior,
  ///use cached resources when they are available and not expired, otherwise load resources from the network.
  static const LOAD_DEFAULT = const AqutterCacheMode_._internal(-1);

  ///Use cached resources when they are available, even if they have expired. Otherwise load resources from the network.
  static const LOAD_CACHE_ELSE_NETWORK = const AqutterCacheMode_._internal(1);

  ///Don't use the cache, load from the network.
  static const LOAD_NO_CACHE = const AqutterCacheMode_._internal(2);

  ///Don't use the network, load from the cache.
  static const LOAD_CACHE_ONLY = const AqutterCacheMode_._internal(3);
}

///An Android-specific class used to override the way the cache is used.
///Use [AqutterCacheMode] instead.
@Deprecated("Use AqutterCacheMode instead")
@ExchangeableEnum()
class AqutterAndroidCacheMode_ {
  // ignore: unused_field
  final int _value;
  const AqutterAndroidCacheMode_._internal(this._value);

  ///Default cache usage mode. If the navigation type doesn't impose any specific behavior,
  ///use cached resources when they are available and not expired, otherwise load resources from the network.
  static const LOAD_DEFAULT = const AqutterAndroidCacheMode_._internal(-1);

  ///Use cached resources when they are available, even if they have expired. Otherwise load resources from the network.
  static const LOAD_CACHE_ELSE_NETWORK = const AqutterAndroidCacheMode_._internal(1);

  ///Don't use the cache, load from the network.
  static const LOAD_NO_CACHE = const AqutterAndroidCacheMode_._internal(2);

  ///Don't use the network, load from the cache.
  static const LOAD_CACHE_ONLY = const AqutterAndroidCacheMode_._internal(3);
}
