import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'show_file_chooser_request.dart';

part 'show_file_chooser_request_mode.g.dart';

///It represents file chooser mode of a [AqutterShowFileChooserRequest].
@ExchangeableEnum()
class AqutterShowFileChooserRequestMode_ {
  // ignore: unused_field
  final int _value;
  // ignore: unused_field
  final int? _nativeValue = null;
  const AqutterShowFileChooserRequestMode_._internal(this._value);

  ///Open single file. Requires that the file exists before allowing the user to pick it.
  @EnumSupportedPlatforms(platforms: [EnumAndroidPlatform(value: 0)])
  static const OPEN = const AqutterShowFileChooserRequestMode_._internal(0);

  ///Like Open but allows multiple files to be selected.
  @EnumSupportedPlatforms(platforms: [EnumAndroidPlatform(value: 1)])
  static const OPEN_MULTIPLE = const AqutterShowFileChooserRequestMode_._internal(1);

  ///Like Open but allows a folder to be selected.
  ///The implementation should enumerate all files selected by this operation.
  ///This feature is not supported at the moment.
  @EnumSupportedPlatforms(platforms: [EnumAndroidPlatform(value: 2)])
  static const OPEN_FOLDER = const AqutterShowFileChooserRequestMode_._internal(2);

  ///Allows picking a nonexistent file and saving it.
  @EnumSupportedPlatforms(platforms: [EnumAndroidPlatform(value: 3)])
  static const SAVE = const AqutterShowFileChooserRequestMode_._internal(3);
}
