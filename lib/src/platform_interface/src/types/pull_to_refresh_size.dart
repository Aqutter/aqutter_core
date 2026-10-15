import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'pull_to_refresh_size.g.dart';

///Class representing the size of the refresh indicator.
@ExchangeableEnum()
class AqutterPullToRefreshSize_ {
  // ignore: unused_field
  final int _value;
  const AqutterPullToRefreshSize_._internal(this._value);

  ///Default size.
  static const DEFAULT = const AqutterPullToRefreshSize_._internal(1);

  ///Large size.
  static const LARGE = const AqutterPullToRefreshSize_._internal(0);
}

///Android-specific class representing the size of the refresh indicator.
///Use [AqutterPullToRefreshSize] instead.
@Deprecated("Use AqutterPullToRefreshSize instead")
@ExchangeableEnum()
class AqutterAndroidPullToRefreshSize_ {
  // ignore: unused_field
  final int _value;
  const AqutterAndroidPullToRefreshSize_._internal(this._value);

  ///Default size.
  static const DEFAULT = const AqutterAndroidPullToRefreshSize_._internal(1);

  ///Large size.
  static const LARGE = const AqutterAndroidPullToRefreshSize_._internal(0);
}
