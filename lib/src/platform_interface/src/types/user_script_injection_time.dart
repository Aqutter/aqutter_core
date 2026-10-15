import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'user_script.dart';

part 'user_script_injection_time.g.dart';

///Class that represents contains the constants for the times at which to inject script content into a `WebView` used by an [AqutterUserScript].
@ExchangeableEnum()
class AqutterUserScriptInjectionTime_ {
  // ignore: unused_field
  final int _value;
  const AqutterUserScriptInjectionTime_._internal(this._value);

  ///**NOTE for iOS**: A constant to inject the script after the creation of the webpage’s document element, but before loading any other content.
  ///
  ///**NOTE for Android**: A constant to try to inject the script as soon as the page starts loading.
  static const AT_DOCUMENT_START = const AqutterUserScriptInjectionTime_._internal(0);

  ///**NOTE for iOS**: A constant to inject the script after the document finishes loading, but before loading any other subresources.
  ///
  ///**NOTE for Android**: A constant to inject the script as soon as the page finishes loading.
  static const AT_DOCUMENT_END = const AqutterUserScriptInjectionTime_._internal(1);
}
