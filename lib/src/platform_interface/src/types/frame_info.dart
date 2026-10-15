import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';

import 'url_request.dart';
import 'security_origin.dart';
import 'frame_kind.dart';
import 'enum_method.dart';

part 'frame_info.g.dart';

///An object that contains information about a frame on a webpage.
@ExchangeableObject()
class AqutterFrameInfo_ {
  ///A Boolean value indicating whether the frame is the web site's main frame or a subframe.
  @SupportedPlatforms(
    platforms: [IOSPlatform(), MacOSPlatform(), WindowsPlatform()],
  )
  bool isMainFrame;

  ///The frame’s current request.
  @SupportedPlatforms(
    platforms: [IOSPlatform(), MacOSPlatform(), WindowsPlatform()],
  )
  AqutterURLRequest_? request;

  ///The frame’s security origin.
  @SupportedPlatforms(
    platforms: [IOSPlatform(), MacOSPlatform(), WindowsPlatform()],
  )
  AqutterSecurityOrigin_? securityOrigin;

  ///Gets the name attribute of the frame, as in <iframe name="frame-name">...</iframe>.
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  String? name;

  ///The unique identifier of the frame associated with the current [AqutterFrameInfo].
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  int? frameId;

  ///The kind of the frame.
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  AqutterFrameKind_? kind;

  AqutterFrameInfo_({
    required this.isMainFrame,
    required this.request,
    this.securityOrigin,
    this.name,
    this.frameId,
    this.kind,
  });
}

///An object that contains information about a frame on a webpage.
///
///**NOTE**: available only on iOS.
///
///Use [AqutterFrameInfo] instead.
@Deprecated("Use AqutterFrameInfo instead")
@ExchangeableObject()
class AqutterIOSWKFrameInfo_ {
  ///A Boolean value indicating whether the frame is the web site's main frame or a subframe.
  bool isMainFrame;

  ///The frame’s current request.
  AqutterURLRequest_? request;

  ///The frame’s security origin.
  AqutterIOSWKSecurityOrigin_? securityOrigin;

  AqutterIOSWKFrameInfo_({
    required this.isMainFrame,
    required this.request,
    this.securityOrigin,
  });
}
