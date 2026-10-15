import 'package:flutter/foundation.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../debug_logging_settings.dart';
import '../webview_platform.dart';
import '../webview/platform_webview.dart';
import '../types/browser_process_info.dart';
import '../types/cache_model.dart';
import '../types/disposable.dart';
import '../types/browser_process_exited_detail.dart';
import '../types/browser_process_infos_changed_detail.dart';
import '../types/webview_interface.dart';
import 'webview_environment_settings.dart';

part 'platform_webview_environment.g.dart';

/// Object specifying creation parameters for creating a [AqutterPlatformWebViewEnvironment].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
@SupportedPlatforms(platforms: [WindowsPlatform(), LinuxPlatform()])
@immutable
class AqutterPlatformWebViewEnvironmentCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformWebViewEnvironment].
  const AqutterPlatformWebViewEnvironmentCreationParams({this.settings});

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironmentCreationParams.settings}
  /// WebView Environment settings.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironmentCreationParams.settings.supported_platforms}
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  final AqutterWebViewEnvironmentSettings? settings;

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironmentCreationParams.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebViewEnvironmentCreationParamsClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironmentCreationParams.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformWebViewEnvironmentCreationParamsProperty property, {
    TargetPlatform? platform,
  }) =>
      _AqutterPlatformWebViewEnvironmentCreationParamsPropertySupported.isPropertySupported(
        property,
        platform: platform,
      );
}

///Controls a WebView Environment used by WebView instances.
///Use [dispose] when not needed anymore to release references.
///
///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.supported_platforms}
@SupportedPlatforms(platforms: [WindowsPlatform(), LinuxPlatform()])
abstract class AqutterPlatformWebViewEnvironment extends PlatformInterface
    implements AqutterDisposable {
  ///Debug settings used by [AqutterPlatformWebViewEnvironment].
  static AqutterDebugLoggingSettings debugLoggingSettings = AqutterDebugLoggingSettings(
    maxLogMessageLength: 1000,
  );

  /// Creates a new [AqutterPlatformWebViewController]
  factory AqutterPlatformWebViewEnvironment(
    AqutterPlatformWebViewEnvironmentCreationParams params,
  ) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebViewEnvironment webViewEnvironment = AqutterWebViewPlatform
        .instance!
        .createPlatformWebViewEnvironment(params);
    PlatformInterface.verify(webViewEnvironment, _token);
    return webViewEnvironment;
  }

  /// Creates a new [AqutterPlatformWebViewEnvironment] to access static methods.
  factory AqutterPlatformWebViewEnvironment.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformWebViewEnvironment webViewEnvironment = AqutterWebViewPlatform
        .instance!
        .createPlatformWebViewEnvironmentStatic();
    PlatformInterface.verify(webViewEnvironment, _token);
    return webViewEnvironment;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformWebViewEnvironment].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformWebViewEnvironment.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformWebViewEnvironment].
  final AqutterPlatformWebViewEnvironmentCreationParams params;

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.id}
  /// WebView Environment ID.
  ///{@endtemplate}
  @SupportedPlatforms(platforms: [WindowsPlatform(), LinuxPlatform()])
  String get id =>
      throw UnimplementedError('id is not implemented on the current platform');

  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironmentCreationParams.settings}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironmentCreationParams.settings.supported_platforms}
  AqutterWebViewEnvironmentSettings? get settings => params.settings;

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.isInterfaceSupported}
  ///Returns `true` if the WebView Environment supports the specified [interface], otherwise `false`.
  ///Only the ones related to [AqutterWebViewInterface.ICoreWebView2Environment] are valid interfaces to check;
  ///otherwise, it will always return `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.isInterfaceSupported.supported_platforms}
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  Future<bool> isInterfaceSupported(AqutterWebViewInterface interface) async {
    throw UnimplementedError(
      'isInterfaceSupported is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.getProcessInfos}
  ///Returns a list of all process using same user data folder except for crashpad process.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getProcessInfos.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        available: '1.0.1108.44+',
        apiName: 'ICoreWebView2Environment8.GetProcessInfos',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment8?view=webview2-1.0.2849.39#getprocessinfos',
      ),
    ],
  )
  Future<List<AqutterBrowserProcessInfo>> getProcessInfos() async {
    throw UnimplementedError(
      'getProcessInfos is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.getProcessInfos}
  ///Returns the path of the folder where minidump files are written.
  ///
  ///Whenever a WebView2 process crashes, a crash dump file will be created in the crash dump folder.
  ///The crash dump format is minidump files.
  ///Please see [Minidump Files documentation](https://learn.microsoft.com/en-us/windows/win32/debug/minidump-files) for detailed information.
  ///Normally when a single child process fails, a minidump will be generated and written to disk,
  ///then the [AqutterPlatformWebViewCreationParams.onProcessFailed] event is raised.
  ///But for unexpected crashes, a minidump file might
  ///not be generated at all, despite whether [AqutterPlatformWebViewCreationParams.onProcessFailed] event is raised.
  ///If there are multiple process failures at once, multiple minidump files could be generated.
  ///Thus [getFailureReportFolderPath] could contain old minidump files that are
  ///not associated with a specific [AqutterPlatformWebViewCreationParams.onProcessFailed] event.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getFailureReportFolderPath.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        available: '1.0.1518.46+',
        apiName: 'ICoreWebView2Environment11.get_FailureReportFolderPath',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment11?view=webview2-1.0.2849.39#get_failurereportfolderpath',
      ),
    ],
  )
  Future<String?> getFailureReportFolderPath() async {
    throw UnimplementedError(
      'getFailureReportFolderPath is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.create}
  ///Creates the [AqutterPlatformWebViewEnvironment] using [settings].
  ///
  ///Check https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2210.55#createcorewebview2environmentwithoptions
  ///for more info.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.create.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'CreateCoreWebView2EnvironmentWithOptions',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2210.55#createcorewebview2environmentwithoptions',
      ),
      LinuxPlatform(
        apiName: 'WebKitWebContext',
        apiUrl:
            'https://webkitgtk.org/reference/webkit2gtk/stable/class.WebContext.html',
        note:
            'Creates a new WebKitWebContext for shared WebView configuration.',
      ),
    ],
  )
  Future<AqutterPlatformWebViewEnvironment> create({
    AqutterWebViewEnvironmentSettings? settings,
  }) {
    throw UnimplementedError(
      'create is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.getAvailableVersion}
  ///Get the browser version info including channel name if it is not the WebView2 Runtime.
  ///
  ///Channel names are Beta, Dev, and Canary.
  ///If an override exists for the browserExecutableFolder or the channel preference, the override is used.
  ///If an override is not specified, then the parameter value passed to [getAvailableVersion] is used.
  ///Returns `null` if it fails to find an installed WebView2 runtime or non-stable Microsoft Edge installation.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getAvailableVersion.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'GetAvailableCoreWebView2BrowserVersionString',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2849.39#getavailablecorewebview2browserversionstring',
      ),
      LinuxPlatform(
        apiName: 'webkit_get_major_version',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/func.get_major_version.html',
        note:
            'Returns WPE WebKit version string composed of major.minor.micro versions.',
      ),
    ],
  )
  Future<String?> getAvailableVersion({String? browserExecutableFolder}) {
    throw UnimplementedError(
      'getAvailableVersion is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.compareBrowserVersions}
  ///This method is for anyone want to compare version correctly to determine which version is newer, older or same.
  ///
  ///Use it to determine whether to use webview2 or certain feature based upon version.
  ///Sets the value of result to `-1`, `0` or `1` if version1 is less than, equal or greater than version2 respectively.
  ///Returns `null` if it fails to parse any of the version strings.
  ///Directly use the version info obtained from [getAvailableVersion] with input, channel information is ignored.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.compareBrowserVersions.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'CompareBrowserVersions',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2210.55#comparebrowserversions',
      ),
    ],
  )
  Future<int?> compareBrowserVersions({
    required String version1,
    required String version2,
  }) {
    throw UnimplementedError(
      'compareBrowserVersions is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.onNewBrowserVersionAvailable}
  ///[onNewBrowserVersionAvailable] runs when a newer version of the WebView2 Runtime
  ///is installed and available using WebView2.
  ///To use the newer version of the browser you must create a new [AqutterPlatformWebViewEnvironment] and WebView.
  ///The event only runs for new version from the same WebView2 Runtime from which the code is running.
  ///When not running with installed WebView2 Runtime, no event is run.
  ///
  ///Because a user data folder is only able to be used by one browser process at a time,
  ///if you want to use the same user data folder in the WebView using the new version of the browser,
  ///you must close the environment and instance of WebView that are using the older version of the browser first.
  ///Or simply prompt the user to restart the app.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.onNewBrowserVersionAvailable.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2Environment.add_NewBrowserVersionAvailable',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment?view=webview2-1.0.2849.39#add_newbrowserversionavailable',
      ),
    ],
  )
  void Function()? onNewBrowserVersionAvailable;

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.onBrowserProcessExited}
  ///The [onBrowserProcessExited] event is raised when the collection of WebView2 Runtime
  ///processes for the browser process of this environment terminate due to browser process failure
  ///or normal shutdown (for example, when all associated WebViews are closed),
  ///after all resources have been released (including the user data folder).
  ///To learn about what these processes are, go to [Process model](https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/process-model).
  ///
  ///Multiple app processes can share a browser process by creating their webviews
  ///from a [AqutterPlatformWebViewEnvironment] with the same user data folder.
  ///When the entire collection of WebView2Runtime processes for the browser process exit,
  ///all associated [AqutterPlatformWebViewEnvironment] objects receive the [onBrowserProcessExited] event.
  ///Multiple processes sharing the same browser process need to coordinate their
  ///use of the shared user data folder to avoid race conditions and unnecessary waits.
  ///For example, one process should not clear the user data folder at the same
  ///time that another process recovers from a crash by recreating its WebView controls;
  ///one process should not block waiting for the event if other app processes
  ///are using the same browser process (the browser process will not exit
  ///until those other processes have closed their webviews too).
  ///
  ///The difference between [onBrowserProcessExited] and [AqutterPlatformWebViewCreationParams.onProcessFailed] is that
  ///[onBrowserProcessExited] is raised for any browser process exit
  ///(expected or unexpected, after all associated processes have exited too),
  ///while [AqutterPlatformWebViewCreationParams.onProcessFailed] is raised for
  ///unexpected process exits of any kind (browser, render, GPU, and all other types),
  ///or for main frame render process unresponsiveness.
  ///To learn more about the WebView2 Process Model, go to
  ///[Process model](https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/process-model).
  ///
  ///In the case the browser process crashes, both [onBrowserProcessExited] and
  ///[AqutterPlatformWebViewCreationParams.onProcessFailed] events are raised, but the order is not guaranteed.
  ///These events are intended for different scenarios.
  ///It is up to the app to coordinate the handlers so they do not try to perform
  ///reliability recovery while also trying to move to a new WebView2 Runtime version
  ///or remove the user data folder.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.onBrowserProcessExited.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        available: '1.0.992.28+',
        apiName: 'ICoreWebView2Environment5.add_BrowserProcessExited',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment5?view=webview2-1.0.2849.39#add_browserprocessexited',
      ),
    ],
  )
  void Function(AqutterBrowserProcessExitedDetail detail)? onBrowserProcessExited;

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.onProcessInfosChanged}
  ///Event fired with a list of all process using same user data folder except for crashpad process.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.onProcessInfosChanged.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        available: '1.0.1108.44+',
        apiName: 'ICoreWebView2Environment8.add_ProcessInfosChanged',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environment8?view=webview2-1.0.2849.39#add_processinfoschanged',
      ),
    ],
  )
  void Function(AqutterBrowserProcessInfosChangedDetail detail)? onProcessInfosChanged;

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.isSpellCheckingEnabled}
  ///Returns whether spell checking is enabled for this WebContext.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.isSpellCheckingEnabled.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      LinuxPlatform(
        apiName: 'webkit_web_context_get_spell_checking_enabled',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.get_spell_checking_enabled.html',
      ),
    ],
  )
  Future<bool> isSpellCheckingEnabled() {
    throw UnimplementedError(
      'isSpellCheckingEnabled is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.getSpellCheckingLanguages}
  ///Returns the list of spell checking languages currently configured for this WebContext.
  ///
  ///The locale strings are in the form `lang_COUNTRY` where `lang` is an
  ///ISO-639 language code and `COUNTRY` is an ISO-3166 country code.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getSpellCheckingLanguages.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      LinuxPlatform(
        apiName: 'webkit_web_context_get_spell_checking_languages',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.get_spell_checking_languages.html',
      ),
    ],
  )
  Future<List<String>> getSpellCheckingLanguages() {
    throw UnimplementedError(
      'getSpellCheckingLanguages is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.getCacheModel}
  ///Returns the current cache model for this WebContext.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.getCacheModel.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      LinuxPlatform(
        apiName: 'webkit_web_context_get_cache_model',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.get_cache_model.html',
      ),
    ],
  )
  Future<AqutterCacheModel?> getCacheModel() {
    throw UnimplementedError(
      'getCacheModel is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.isAutomationAllowed}
  ///Returns whether automation is allowed for this WebContext.
  ///
  ///When automation is allowed, web pages can use the WebDriver API.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.isAutomationAllowed.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      LinuxPlatform(
        apiName: 'webkit_web_context_is_automation_allowed',
        apiUrl:
            'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.is_automation_allowed.html',
      ),
    ],
  )
  Future<bool> isAutomationAllowed() {
    throw UnimplementedError(
      'isAutomationAllowed is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.dispose}
  ///Disposes the WebView Environment reference.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformWebViewEnvironment.dispose.supported_platforms}
  @SupportedPlatforms(platforms: [WindowsPlatform(), LinuxPlatform()])
  Future<void> dispose() {
    throw UnimplementedError(
      'dispose is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformWebViewEnvironmentClassSupported.isClassSupported(
        platform: platform,
      );

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///The property should be one of the [AqutterPlatformWebViewEnvironmentProperty] or [AqutterPlatformWebViewEnvironmentCreationParamsProperty] values.
  ///{@endtemplate}
  bool isPropertySupported(dynamic property, {TargetPlatform? platform}) =>
      property is AqutterPlatformWebViewEnvironmentCreationParamsProperty
      ? params.isPropertySupported(property, platform: platform)
      : _AqutterPlatformWebViewEnvironmentPropertySupported.isPropertySupported(
          property,
          platform: platform,
        );

  ///{@template aqutter_core.AqutterPlatformWebViewEnvironment.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformWebViewEnvironmentMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformWebViewEnvironmentMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}
