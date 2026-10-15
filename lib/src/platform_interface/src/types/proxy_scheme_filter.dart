import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../platform_proxy_controller.dart';

part 'proxy_scheme_filter.g.dart';

///Class that represent scheme filters used by [AqutterPlatformProxyController].
@ExchangeableEnum()
class AqutterProxySchemeFilter_ {
  // ignore: unused_field
  final String _value;
  const AqutterProxySchemeFilter_._internal(this._value);

  ///Matches all schemes.
  static const MATCH_ALL_SCHEMES = const AqutterProxySchemeFilter_._internal("*");

  ///HTTP scheme.
  static const MATCH_HTTP = const AqutterProxySchemeFilter_._internal("http");

  ///HTTPS scheme.
  static const MATCH_HTTPS = const AqutterProxySchemeFilter_._internal("https");
}
