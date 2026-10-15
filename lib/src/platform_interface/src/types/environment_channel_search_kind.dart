import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import '../webview_environment/platform_webview_environment.dart';

part 'environment_channel_search_kind.g.dart';

///The channel search kind determines the order that release
///channels are searched for during [AqutterPlatformWebViewEnvironment] creation.
@ExchangeableEnum()
class AqutterEnvironmentChannelSearchKind_ {
  // ignore: unused_field
  final int _value;
  const AqutterEnvironmentChannelSearchKind_._internal(this._value);

  ///Search for a release channel from most to least stable: WebView2 Runtime -> Beta -> Dev -> Canary. This is the default behavior.
  @EnumSupportedPlatforms(platforms: [EnumWindowsPlatform(value: 0)])
  static const MOST_STABLE = AqutterEnvironmentChannelSearchKind_._internal(0);

  ///Search for a release channel from least to most stable: Canary -> Dev -> Beta -> WebView2 Runtime.
  @EnumSupportedPlatforms(platforms: [EnumWindowsPlatform(value: 1)])
  static const LEAST_STABLE = AqutterEnvironmentChannelSearchKind_._internal(1);
}
