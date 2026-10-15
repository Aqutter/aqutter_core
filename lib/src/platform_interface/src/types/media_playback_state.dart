import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'media_playback_state.g.dart';

///Class that describes whether an audio or video presentation is playing, paused, or suspended.
@ExchangeableEnum()
class AqutterMediaPlaybackState_ {
  // ignore: unused_field
  final int _value;
  const AqutterMediaPlaybackState_._internal(this._value);

  ///There is no media to play back.
  static const NONE = const AqutterMediaPlaybackState_._internal(0);

  ///The media is playing.
  static const PLAYING = const AqutterMediaPlaybackState_._internal(1);

  ///The media playback is paused.
  static const PAUSED = const AqutterMediaPlaybackState_._internal(2);

  ///The media is not playing, and cannot be resumed until the user revokes the suspension.
  static const SUSPENDED = const AqutterMediaPlaybackState_._internal(3);
}
