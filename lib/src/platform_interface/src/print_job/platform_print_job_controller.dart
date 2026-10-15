import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../webview/platform_webview_controller.dart';
import '../webview_platform.dart';
import '../types/disposable.dart';
import '../types/print_job_info.dart';

// ignore: uri_has_not_been_generated
part 'platform_print_job_controller.g.dart';

///{@template aqutter_core.AqutterPlatformPrintJobControllerCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformPrintJobController].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformPrintJobControllerCreationParams.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WindowsPlatform(),
  ],
)
@immutable
class AqutterPlatformPrintJobControllerCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformPrintJobController].
  const AqutterPlatformPrintJobControllerCreationParams({required this.id});

  ///{@template aqutter_core.AqutterPlatformPrintJobControllerCreationParams.id}
  ///Print job ID.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobControllerCreationParams.id.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
    ],
  )
  final String id;

  ///{@template aqutter_core.AqutterPlatformPrintJobControllerCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformPrintJobControllerCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformPrintJobControllerCreationParams.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformPrintJobControllerCreationParamsProperty property, {
    TargetPlatform? platform,
  }) =>
      _AqutterPlatformPrintJobControllerCreationParamsPropertySupported.isPropertySupported(
        property,
        platform: platform,
      );
}

///A completion handler for the [AqutterPlatformPrintJobController].
typedef AqutterPrintJobCompletionHandler =
    Future<void> Function(bool completed, String? error)?;

///{@template aqutter_core.AqutterPlatformPrintJobController}
///Class representing a print job eventually returned by [AqutterPlatformWebViewController.printCurrentPage].
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformPrintJobController.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WindowsPlatform(),
  ],
)
abstract class AqutterPlatformPrintJobController extends PlatformInterface
    implements AqutterDisposable {
  /// Creates a new [AqutterPlatformPrintJobController]
  factory AqutterPlatformPrintJobController(
    AqutterPlatformPrintJobControllerCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformPrintJobController printJobController = AqutterWebViewPlatform
        .instance!
        .createPlatformPrintJobController(params);
    PlatformInterface.verify(printJobController, _token);
    return printJobController;
  }

  /// Creates a new empty [AqutterPlatformPrintJobController] to access static methods.
  factory AqutterPlatformPrintJobController.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`WebViewPlatform.instance` before use. For unit testing, '
      '`WebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformPrintJobController printJobControllerStatic =
        AqutterWebViewPlatform.instance!.createPlatformPrintJobControllerStatic();
    PlatformInterface.verify(printJobControllerStatic, _token);
    return printJobControllerStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformPrintJobController].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformPrintJobController.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformPrintJobController].
  final AqutterPlatformPrintJobControllerCreationParams params;

  ///{@macro aqutter_core.AqutterPlatformPrintJobControllerCreationParams.id}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobControllerCreationParams.id.supported_platforms}
  String get id => params.id;

  ///{@template aqutter_core.AqutterPlatformPrintJobController.onComplete}
  ///A completion handler used to handle the conclusion of the print job (for instance, to reset state) and to handle any errors encountered in printing.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.onComplete.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'PrintDocumentAdapter.onFinish',
        apiUrl:
            'https://developer.android.com/reference/android/print/PrintDocumentAdapter#onFinish()',
        note: '`completed` is always `true` and `error` is always `null`.',
      ),
      IOSPlatform(
        apiName: 'UIPrintInteractionController.CompletionHandler',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiprintinteractioncontroller/completionhandler',
      ),
      MacOSPlatform(
        apiName: 'NSPrintOperation.runModal',
        apiUrl:
            'https://developer.apple.com/documentation/appkit/nsprintoperation/1532065-runmodal',
      ),
      WindowsPlatform(),
    ],
  )
  AqutterPrintJobCompletionHandler? onComplete;

  ///{@template aqutter_core.AqutterPlatformPrintJobController.cancel}
  ///Cancels this print job.
  ///You can request cancellation of a queued, started, blocked, or failed print job.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.cancel.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'PrintJob.cancel',
        apiUrl:
            'https://developer.android.com/reference/android/print/PrintJob#cancel()',
      ),
    ],
  )
  Future<void> cancel() {
    throw UnimplementedError(
      'cancel is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPrintJobController.restart}
  ///Restarts this print job.
  ///You can request restart of a failed print job.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.restart.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'PrintJob.restart',
        apiUrl:
            'https://developer.android.com/reference/android/print/PrintJob#restart()',
      ),
    ],
  )
  Future<void> restart() {
    throw UnimplementedError(
      'restart is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPrintJobController.dismiss}
  ///Dismisses the printing-options sheet or popover.
  ///
  ///You should dismiss the printing options when they are presented in a sheet or
  ///animated from a rectangle and the user changes the orientation of the device.
  ///(This, of course, assumes your application responds to orientation changes.)
  ///You should then present the printing options again once the new orientation takes effect.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.dismiss.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform()])
  Future<void> dismiss({bool animated = true}) {
    throw UnimplementedError(
      'dismiss is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPrintJobController.getInfo}
  ///Gets the [AqutterPrintJobInfo] that describes this job.
  ///
  ///**NOTE**: The returned info object is a snapshot of the
  ///current print job state. Every call to this method returns a fresh
  ///info object that reflects the current print job state.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.getInfo.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'PrintJob.getInfo',
        apiUrl:
            'https://developer.android.com/reference/android/print/PrintJob#getInfo()',
      ),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
    ],
  )
  Future<AqutterPrintJobInfo?> getInfo() {
    throw UnimplementedError(
      'getInfo is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformPrintJobController.dispose}
  ///Disposes the print job.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformPrintJobController.dispose.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
    ],
  )
  @override
  void dispose() {
    throw UnimplementedError(
      'dispose is not implemented on the current platform',
    );
  }

  ///{@macro aqutter_core.AqutterPlatformPrintJobControllerCreationParams.isClassSupported}
  bool isClassSupported({TargetPlatform? platform}) =>
      params.isClassSupported(platform: platform);

  ///{@template aqutter_core.AqutterPlatformPrintJobController.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///The property should be one of the [AqutterPlatformPrintJobControllerProperty] or [AqutterPlatformPrintJobControllerCreationParamsProperty] values.
  ///{@endtemplate}
  bool isPropertySupported(dynamic property, {TargetPlatform? platform}) =>
      property is AqutterPlatformPrintJobControllerCreationParamsProperty
      ? params.isPropertySupported(property, platform: platform)
      : _AqutterPlatformPrintJobControllerPropertySupported.isPropertySupported(
          property,
          platform: platform,
        );

  ///{@template aqutter_core.AqutterPlatformPrintJobController.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformPrintJobControllerMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformPrintJobControllerMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}
