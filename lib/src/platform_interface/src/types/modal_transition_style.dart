import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

part 'modal_transition_style.g.dart';

///Class used to specify the transition style when presenting a view controller.
@ExchangeableEnum()
class AqutterModalTransitionStyle_ {
  // ignore: unused_field
  final int _value;
  const AqutterModalTransitionStyle_._internal(this._value);

  ///When the view controller is presented, its view slides up from the bottom of the screen.
  ///On dismissal, the view slides back down. This is the default transition style.
  static const COVER_VERTICAL = const AqutterModalTransitionStyle_._internal(0);

  ///When the view controller is presented, the current view initiates a horizontal 3D flip from right-to-left,
  ///resulting in the revealing of the new view as if it were on the back of the previous view.
  ///On dismissal, the flip occurs from left-to-right, returning to the original view.
  static const FLIP_HORIZONTAL = const AqutterModalTransitionStyle_._internal(1);

  ///When the view controller is presented, the current view fades out while the new view fades in at the same time.
  ///On dismissal, a similar type of cross-fade is used to return to the original view.
  static const CROSS_DISSOLVE = const AqutterModalTransitionStyle_._internal(2);

  ///When the view controller is presented, one corner of the current view curls up to reveal the presented view underneath.
  ///On dismissal, the curled up page unfurls itself back on top of the presented view.
  ///A view controller presented using this transition is itself prevented from presenting any additional view controllers.
  static const PARTIAL_CURL = const AqutterModalTransitionStyle_._internal(3);
}

///An iOS-specific class used to specify the transition style when presenting a view controller.
///Use [AqutterModalTransitionStyle] instead.
@Deprecated("Use AqutterModalTransitionStyle instead")
@ExchangeableEnum()
class AqutterIOSUIModalTransitionStyle_ {
  // ignore: unused_field
  final int _value;
  const AqutterIOSUIModalTransitionStyle_._internal(this._value);

  ///When the view controller is presented, its view slides up from the bottom of the screen.
  ///On dismissal, the view slides back down. This is the default transition style.
  static const COVER_VERTICAL = const AqutterIOSUIModalTransitionStyle_._internal(0);

  ///When the view controller is presented, the current view initiates a horizontal 3D flip from right-to-left,
  ///resulting in the revealing of the new view as if it were on the back of the previous view.
  ///On dismissal, the flip occurs from left-to-right, returning to the original view.
  static const FLIP_HORIZONTAL = const AqutterIOSUIModalTransitionStyle_._internal(1);

  ///When the view controller is presented, the current view fades out while the new view fades in at the same time.
  ///On dismissal, a similar type of cross-fade is used to return to the original view.
  static const CROSS_DISSOLVE = const AqutterIOSUIModalTransitionStyle_._internal(2);

  ///When the view controller is presented, one corner of the current view curls up to reveal the presented view underneath.
  ///On dismissal, the curled up page unfurls itself back on top of the presented view.
  ///A view controller presented using this transition is itself prevented from presenting any additional view controllers.
  static const PARTIAL_CURL = const AqutterIOSUIModalTransitionStyle_._internal(3);
}
