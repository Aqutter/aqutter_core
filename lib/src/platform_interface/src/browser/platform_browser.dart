import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:aqutter_core_internal_annotations/aqutter_core_internal_annotations.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../context_menu/context_menu.dart';
import '../debug_logging_settings.dart';
import '../find_interaction/platform_find_interaction_controller.dart';
import '../webview/webview_settings.dart';
import '../webview/platform_webview_controller.dart';
import '../webview_platform.dart';
import '../platform_webview_feature.dart';
import '../print_job/main.dart';
import '../pull_to_refresh/main.dart';
import '../pull_to_refresh/platform_pull_to_refresh_controller.dart';
import '../types/main.dart';
import '../web_uri.dart';
import '../webview_environment/platform_webview_environment.dart';
import 'browser_menu_item.dart';
import 'browser_settings.dart';

part 'platform_browser.g.dart';

///{@template aqutter_core.AqutterPlatformBrowserCreationParams}
/// Object specifying creation parameters for creating a [AqutterPlatformBrowser].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///{@endtemplate}
@immutable
class AqutterPlatformBrowserCreationParams {
  /// Used by the platform implementation to create a new [AqutterPlatformBrowser].
  const AqutterPlatformBrowserCreationParams({
    this.contextMenu,
    this.pullToRefreshController,
    this.findInteractionController,
    this.initialUserScripts,
    this.windowId,
    this.webViewEnvironment,
  });

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.contextMenu}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.contextMenu.supported_platforms}
  final AqutterContextMenu? contextMenu;

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.pullToRefreshController}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.pullToRefreshController.supported_platforms}
  final AqutterPlatformPullToRefreshController? pullToRefreshController;

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.findInteractionController}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.findInteractionController.supported_platforms}
  final AqutterPlatformFindInteractionController? findInteractionController;

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.initialUserScripts}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.initialUserScripts.supported_platforms}
  final UnmodifiableListView<AqutterUserScript>? initialUserScripts;

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.windowId}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.windowId.supported_platforms}
  final int? windowId;

  ///{@template aqutter_core.AqutterPlatformBrowserCreationParams.webViewEnvironment}
  ///Used to create the [AqutterPlatformBrowser] using the specified environment.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.webViewEnvironment.supported_platforms}
  final AqutterPlatformWebViewEnvironment? webViewEnvironment;
}

///{@template aqutter_core.AqutterPlatformBrowser}
///This class represents a native WebView displayed on top of the Flutter App,
///so it's not integrated into the Flutter widget tree.
///It uses the native WebView of the platform.
///The [webViewController] field can be used to access the [AqutterPlatformWebViewController] API.
///{@endtemplate}
///
///{@macro aqutter_core.AqutterPlatformBrowser.supported_platforms}
@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WindowsPlatform(),
    LinuxPlatform(
      apiName: 'GtkWindow + WPE WebKit',
      apiUrl:
          'https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.WebView.html',
    ),
  ],
)
abstract class AqutterPlatformBrowser extends PlatformInterface
    implements AqutterDisposable {
  ///Debug settings.
  static AqutterDebugLoggingSettings debugLoggingSettings = AqutterDebugLoggingSettings();

  /// Event handler object that handles the [AqutterPlatformBrowser] events.
  AqutterPlatformBrowserEvents? eventHandler;

  ///{@template aqutter_core.AqutterPlatformBrowser.id}
  ///View ID used internally.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.id.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  String get id {
    throw UnimplementedError('id is not implemented on the current platform');
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.contextMenu}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.contextMenu.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  AqutterContextMenu? get contextMenu => params.contextMenu;

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.pullToRefreshController}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.pullToRefreshController.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  AqutterPlatformPullToRefreshController? get pullToRefreshController =>
      params.pullToRefreshController;

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.findInteractionController}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.findInteractionController.supported_platforms}
  @SupportedPlatforms(
    platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
  )
  AqutterPlatformFindInteractionController? get findInteractionController =>
      params.findInteractionController;

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.initialUserScripts}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.initialUserScripts.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(
        note:
            """This property will be ignored if the [AqutterPlatformWebViewCreationParams.windowId] has been set.
There isn't any way to add/remove user scripts specific to iOS window WebViews.
This is a limitation of the native WebKit APIs.""",
      ),
      MacOSPlatform(
        note:
            """This property will be ignored if the [AqutterPlatformWebViewCreationParams.windowId] has been set.
There isn't any way to add/remove user scripts specific to iOS window WebViews.
This is a limitation of the native WebKit APIs.""",
      ),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  UnmodifiableListView<AqutterUserScript>? get initialUserScripts =>
      params.initialUserScripts;

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.windowId}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.windowId.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  int? get windowId => params.windowId;

  ///{@macro aqutter_core.AqutterPlatformBrowserCreationParams.webViewEnvironment}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.webViewEnvironment.supported_platforms}
  @SupportedPlatforms(platforms: [WindowsPlatform()])
  AqutterPlatformWebViewEnvironment? get webViewEnvironment =>
      params.webViewEnvironment;

  ///{@template aqutter_core.AqutterPlatformBrowser.webViewController}
  ///WebView Controller that can be used to access the [AqutterPlatformWebViewController] API.
  ///When [onExit] is fired, this will be `null` and cannot be used anymore.
  ///{@endtemplate}
  AqutterPlatformWebViewController? get webViewController {
    throw UnimplementedError(
      'webViewController is not implemented on the current platform',
    );
  }

  /// Creates a new [AqutterPlatformBrowser]
  factory AqutterPlatformBrowser(AqutterPlatformBrowserCreationParams params) {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformBrowser browser = AqutterWebViewPlatform.instance!
        .createPlatformBrowser(params);
    PlatformInterface.verify(browser, _token);
    return browser;
  }

  /// Creates a new [AqutterPlatformBrowser] to access static methods.
  factory AqutterPlatformBrowser.static() {
    assert(
      AqutterWebViewPlatform.instance != null,
      'A platform implementation for `aqutter` has not been set. Please '
      'ensure that an implementation of `AqutterWebViewPlatform` has been set to '
      '`AqutterWebViewPlatform.instance` before use. For unit testing, '
      '`AqutterWebViewPlatform.instance` can be set with your own test implementation.',
    );
    final AqutterPlatformBrowser browserStatic = AqutterWebViewPlatform
        .instance!
        .createPlatformBrowserStatic();
    PlatformInterface.verify(browserStatic, _token);
    return browserStatic;
  }

  /// Used by the platform implementation to create a new [AqutterPlatformBrowser].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  AqutterPlatformBrowser.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [AqutterPlatformBrowser].
  final AqutterPlatformBrowserCreationParams params;

  ///{@template aqutter_core.AqutterPlatformBrowser.openUrlRequest}
  ///Opens the [AqutterPlatformBrowser] instance with an [urlRequest].
  ///
  ///[urlRequest]: The [urlRequest] to load.
  ///
  ///[options]: Options for the [AqutterPlatformBrowser].
  ///
  ///[settings]: Settings for the [AqutterPlatformBrowser].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.openUrlRequest.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> openUrlRequest({
    required AqutterURLRequest urlRequest,
    // ignore: deprecated_member_use_from_same_package
    @Deprecated('Use settings instead') AqutterBrowserClassOptions? options,
    AqutterBrowserClassSettings? settings,
  }) {
    throw UnimplementedError(
      'openUrlRequest is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.openFile}
  ///Opens the [AqutterPlatformBrowser] instance with the given [assetFilePath] file.
  ///
  ///[options]: Options for the [AqutterPlatformBrowser].
  ///
  ///To be able to load your local files (assets, js, css, etc.), you need to add them in the `assets` section of the `pubspec.yaml` file, otherwise they cannot be found!
  ///
  ///Example of a `pubspec.yaml` file:
  ///```yaml
  ///...
  ///
  ///# The following section is specific to Flutter.
  ///flutter:
  ///
  ///  # The following line ensures that the Material Icons font is
  ///  # included with your application, so that you can use the icons in
  ///  # the material Icons class.
  ///  uses-material-design: true
  ///
  ///  assets:
  ///    - assets/index.html
  ///    - assets/css/
  ///    - assets/images/
  ///
  ///...
  ///```
  ///Example of a `main.dart` file:
  ///```dart
  ///...
  ///browser.openFile(assetFilePath: "assets/index.html");
  ///...
  ///```
  ///
  ///[headers]: The additional headers to be used in the HTTP request for this URL, specified as a map from name to value.
  ///
  ///[options]: Options for the [AqutterPlatformBrowser].
  ///
  ///[settings]: Settings for the [AqutterPlatformBrowser].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.openFile.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> openFile({
    required String assetFilePath,
    // ignore: deprecated_member_use_from_same_package
    @Deprecated('Use settings instead') AqutterBrowserClassOptions? options,
    AqutterBrowserClassSettings? settings,
  }) {
    throw UnimplementedError(
      'openFile is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.openData}
  ///Opens the [AqutterPlatformBrowser] instance with [data] as a content, using [baseUrl] as the base URL for it.
  ///
  ///The [mimeType] parameter specifies the format of the data. The default value is `"text/html"`.
  ///
  ///The [encoding] parameter specifies the encoding of the data. The default value is `"utf8"`.
  ///
  ///The [androidHistoryUrl] parameter is the URL to use as the history entry. The default value is `about:blank`. If non-null, this must be a valid URL. This parameter is used only on Android.
  ///
  ///The [options] parameter specifies the options for the [AqutterPlatformBrowser].
  ///
  ///[settings]: Settings for the [AqutterPlatformBrowser].
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.openData.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> openData({
    required String data,
    String mimeType = "text/html",
    String encoding = "utf8",
    AqutterWebUri? baseUrl,
    @Deprecated("Use historyUrl instead") Uri? androidHistoryUrl,
    AqutterWebUri? historyUrl,
    // ignore: deprecated_member_use_from_same_package
    @Deprecated('Use settings instead') AqutterBrowserClassOptions? options,
    AqutterBrowserClassSettings? settings,
  }) {
    throw UnimplementedError(
      'openData is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.openWithSystemBrowser}
  ///This is a static method that opens an [url] in the system browser.
  ///You wont be able to use the [AqutterPlatformBrowser] events and methods here.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.openWithSystemBrowser.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> openWithSystemBrowser({required AqutterWebUri url}) {
    throw UnimplementedError(
      'openWithSystemBrowser is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.addMenuItem}
  ///Adds a [AqutterBrowserMenuItem] to the menu.
  ///If the browser is already open,
  ///it will take effect the next time it is opened.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.addMenuItem.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(available: '14.0'),
      MacOSPlatform(available: '10.15'),
    ],
  )
  void addMenuItem(AqutterBrowserMenuItem menuItem) {
    throw UnimplementedError(
      'addMenuItem is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.addMenuItems}
  ///Adds a list of [AqutterBrowserMenuItem] to the menu.
  ///If the browser is already open,
  ///it will take effect the next time it is opened.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.addMenuItems.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(available: '14.0'),
      MacOSPlatform(available: '10.15'),
    ],
  )
  void addMenuItems(List<AqutterBrowserMenuItem> menuItems) {
    throw UnimplementedError(
      'addMenuItems is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.removeMenuItem}
  ///Removes the [menuItem] from the list.
  ///Returns `true` if it was in the list, `false` otherwise.
  ///If the browser is already open,
  ///it will take effect the next time it is opened.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.removeMenuItem.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(available: '14.0'),
      MacOSPlatform(available: '10.15'),
    ],
  )
  bool removeMenuItem(AqutterBrowserMenuItem menuItem) {
    throw UnimplementedError(
      'removeMenuItem is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.removeMenuItems}
  ///Removes a list of [menuItems] from the list.
  ///If the browser is already open,
  ///it will take effect the next time it is opened.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.removeMenuItems.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(available: '14.0'),
      MacOSPlatform(available: '10.15'),
    ],
  )
  void removeMenuItems(List<AqutterBrowserMenuItem> menuItems) {
    throw UnimplementedError(
      'removeMenuItems is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.removeAllMenuItem}
  ///Removes all the menu items from the list.
  ///If the browser is already open,
  ///it will take effect the next time it is opened.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.removeAllMenuItem.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(available: '14.0'),
      MacOSPlatform(available: '10.15'),
    ],
  )
  void removeAllMenuItem() {
    throw UnimplementedError(
      'removeAllMenuItem is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.hasMenuItem}
  ///Returns `true` if the [menuItem] has been already added, otherwise `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.hasMenuItem.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(available: '14.0'),
      MacOSPlatform(available: '10.15'),
    ],
  )
  bool hasMenuItem(AqutterBrowserMenuItem menuItem) {
    throw UnimplementedError(
      'hasMenuItem is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.show}
  ///Displays a [AqutterPlatformBrowser] window that was opened hidden. Calling this has no effect if the [AqutterPlatformBrowser] was already visible.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.show.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> show() {
    throw UnimplementedError('show is not implemented on the current platform');
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.hide}
  ///Hides the [AqutterPlatformBrowser] window. Calling this has no effect if the [AqutterPlatformBrowser] was already hidden.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.hide.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> hide() {
    throw UnimplementedError('hide is not implemented on the current platform');
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.close}
  ///Closes the [AqutterPlatformBrowser] window.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.close.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> close() {
    throw UnimplementedError(
      'close is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.isHidden}
  ///Check if the Web View of the [AqutterPlatformBrowser] instance is hidden.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.isHidden.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<bool> isHidden() {
    throw UnimplementedError(
      'isHidden is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.setOptions}
  ///Use [setSettings] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.setOptions.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  @Deprecated('Use setSettings instead')
  Future<void> setOptions({required AqutterBrowserClassOptions options}) {
    throw UnimplementedError(
      'setOptions is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.getOptions}
  ///Use [getSettings] instead.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.getOptions.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  @Deprecated('Use getSettings instead')
  Future<AqutterBrowserClassOptions?> getOptions() {
    throw UnimplementedError(
      'getOptions is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.setSettings}
  ///Sets the [AqutterPlatformBrowser] settings with the new [settings] and evaluates them.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.setSettings.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<void> setSettings({required AqutterBrowserClassSettings settings}) {
    throw UnimplementedError(
      'setSettings is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.getSettings}
  ///Gets the current [AqutterPlatformBrowser] settings. Returns `null` if it wasn't able to get them.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.getSettings.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  Future<AqutterBrowserClassSettings?> getSettings() {
    throw UnimplementedError(
      'getSettings is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.isOpened}
  ///Returns `true` if the [AqutterPlatformBrowser] instance is opened, otherwise `false`.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.isOpened.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  bool isOpened() {
    throw UnimplementedError(
      'isOpened is not implemented on the current platform',
    );
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.dispose}
  ///Disposes the channel and controllers.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowser.dispose.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  @override
  @mustCallSuper
  void dispose() {
    eventHandler = null;
  }

  ///{@template aqutter_core.AqutterPlatformBrowser.isClassSupported}
  ///Check if the current class is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isClassSupported({TargetPlatform? platform}) =>
      _AqutterPlatformBrowserClassSupported.isClassSupported(platform: platform);

  ///{@template aqutter_core.AqutterPlatformBrowser.isPropertySupported}
  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isPropertySupported(
    AqutterPlatformBrowserProperty property, {
    TargetPlatform? platform,
  }) => _AqutterPlatformBrowserPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );

  ///{@template aqutter_core.AqutterPlatformBrowser.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  bool isMethodSupported(
    AqutterPlatformBrowserMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformBrowserMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );

  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.isMethodSupported}
  bool isEventMethodSupported(
    AqutterPlatformBrowserEventsMethod method, {
    TargetPlatform? platform,
  }) =>
      AqutterPlatformBrowserEvents.isMethodSupported(method, platform: platform);
}

@SupportedPlatforms(
  platforms: [
    AndroidPlatform(),
    IOSPlatform(),
    MacOSPlatform(),
    WindowsPlatform(),
    LinuxPlatform(),
  ],
)
abstract class AqutterPlatformBrowserEvents {
  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onBrowserCreated}
  ///Event fired when the [AqutterPlatformBrowser] is created.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onBrowserCreated.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  void onBrowserCreated() {}

  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onExit}
  ///Event fired when the [AqutterPlatformBrowser] window is closed.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onExit.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
      LinuxPlatform(),
    ],
  )
  void onExit() {}

  ///{@template aqutter_core.AqutterPlatformBrowserEvents.onMainWindowWillClose}
  ///Event fired when the main window is about to close.
  ///{@endtemplate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onMainWindowWillClose.supported_platforms}
  @SupportedPlatforms(platforms: [MacOSPlatform()])
  void onMainWindowWillClose() {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onLoadStart}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onLoadStart.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.onPageStarted',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#onPageStarted(android.webkit.WebView,%20java.lang.String,%20android.graphics.Bitmap)',
      ),
      IOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455621-webview',
      ),
      MacOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455621-webview',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_NavigationStarting',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/iwebview2webview?view=webview2-0.8.355#add_navigationstarting',
      ),
    ],
  )
  void onLoadStart(AqutterWebUri? url) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onLoadStop}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onLoadStop.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.onPageFinished',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#onPageFinished(android.webkit.WebView,%20java.lang.String)',
      ),
      IOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455629-webview',
      ),
      MacOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455629-webview',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_NavigationCompleted',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/iwebview2webview?view=webview2-0.8.355#add_navigationcompleted',
      ),
    ],
  )
  void onLoadStop(AqutterWebUri? url) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onLoadError}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onLoadError.supported_platforms}
  @SupportedPlatforms(
    platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
  )
  @Deprecated("Use onReceivedError instead")
  void onLoadError(Uri? url, int code, String message) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedError}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onReceivedError.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.onReceivedError',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedError(android.webkit.WebView,%20android.webkit.AqutterWebResourceRequest,%20android.webkit.AqutterWebResourceError)',
      ),
      IOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455623-webview',
      ),
      MacOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455623-webview',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_NavigationCompleted',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/iwebview2webview?view=webview2-0.8.355#add_navigationcompleted',
      ),
    ],
  )
  void onReceivedError(AqutterWebResourceRequest request, AqutterWebResourceError error) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onLoadHttpError}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onLoadHttpError.supported_platforms}
  @SupportedPlatforms(
    platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
  )
  @Deprecated("Use onReceivedHttpError instead")
  void onLoadHttpError(Uri? url, int statusCode, String description) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedHttpError}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onReceivedHttpError.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.onReceivedHttpError',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedHttpError(android.webkit.WebView,%20android.webkit.AqutterWebResourceRequest,%20android.webkit.AqutterWebResourceResponse)',
        available: '23',
      ),
      IOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455643-webview',
      ),
      MacOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455643-webview',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_NavigationCompleted',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/iwebview2webview?view=webview2-0.8.355#add_navigationcompleted',
      ),
    ],
  )
  void onReceivedHttpError(
    AqutterWebResourceRequest request,
    AqutterWebResourceResponse errorResponse,
  ) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onProgressChanged}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onProgressChanged.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onProgressChanged',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onProgressChanged(android.webkit.WebView,%20int)',
      ),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(),
    ],
  )
  void onProgressChanged(int progress) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onConsoleMessage}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onConsoleMessage.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onConsoleMessage',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onConsoleMessage(android.webkit.AqutterConsoleMessage)',
      ),
      IOSPlatform(note: 'This event is implemented using JavaScript.'),
      MacOSPlatform(note: 'This event is implemented using JavaScript.'),
      WebPlatform(),
      WindowsPlatform(),
    ],
  )
  void onConsoleMessage(AqutterConsoleMessage consoleMessage) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.shouldOverrideUrlLoading}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.shouldOverrideUrlLoading.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.shouldOverrideUrlLoading',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#shouldOverrideUrlLoading(android.webkit.WebView,%20java.lang.String)',
        note:
            """There isn't any way to load an URL for a frame that is not the main frame, so if the request is not for the main frame, the navigation is allowed by default.
However, if you want to cancel requests for subframes, you can use the [AqutterWebViewSettings.regexToCancelSubFramesLoading] setting
to write a Regular Expression that, if the url request of a subframe matches, then the request of that subframe is canceled.
Instead, the [AqutterWebViewSettings.regexToAllowSyncUrlLoading] setting could
be used to allow navigation requests synchronously, as this event is synchronous on native side
and the current plugin implementation will always cancel the current request and load a new request if
this event returns [AqutterNavigationActionPolicy.ALLOW] because Flutter method channels work only asynchronously.
Also, this event is not called for POST requests and is not called on the first page load.""",
      ),
      IOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455641-webview',
      ),
      MacOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455641-webview',
      ),
      WindowsPlatform(),
    ],
  )
  FutureOr<AqutterNavigationActionPolicy?>? shouldOverrideUrlLoading(
    AqutterNavigationAction navigationAction,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onLaunchingExternalUriScheme}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onLaunchingExternalUriScheme.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2_18.add_LaunchingExternalUriScheme',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_18?view=webview2-1.0.2849.39#add_launchingexternalurischeme',
      ),
    ],
  )
  FutureOr<AqutterLaunchingExternalUriSchemeResponse?>? onLaunchingExternalUriScheme(
    AqutterLaunchingExternalUriSchemeRequest request,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onLoadResource}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onLoadResource.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(note: 'This event is implemented using JavaScript.'),
      IOSPlatform(note: 'This event is implemented using JavaScript.'),
      MacOSPlatform(note: 'This event is implemented using JavaScript.'),
    ],
  )
  void onLoadResource(AqutterLoadedResource resource) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onScrollChanged}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onScrollChanged.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.onScrollChanged',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#onScrollChanged(int,%20int,%20int,%20int)',
      ),
      IOSPlatform(
        apiName: 'UIScrollViewDelegate.scrollViewDidScroll',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiscrollviewdelegate/1619392-scrollviewdidscroll',
      ),
      MacOSPlatform(note: 'This event is implemented using JavaScript.'),
    ],
  )
  void onScrollChanged(int x, int y) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onDownloadStart}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onDownloadStart.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  @Deprecated('Use onDownloadStarting instead')
  void onDownloadStart(Uri url) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onDownloadStartRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onDownloadStartRequest.supported_platforms}
  @SupportedPlatforms(
    platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
  )
  @Deprecated('Use onDownloadStarting instead')
  void onDownloadStartRequest(AqutterDownloadStartRequest downloadStartRequest) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onDownloadStarting}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onDownloadStarting.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.setDownloadListener',
        apiUrl:
            '(https://developer.android.com/reference/android/webkit/WebView#setDownloadListener(android.webkit.DownloadListener)',
      ),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(
        apiName: 'ICoreWebView2_4.add_DownloadStarting',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_4?view=webview2-1.0.2849.39#add_downloadstarting',
      ),
    ],
  )
  FutureOr<AqutterDownloadStartResponse?>? onDownloadStarting(
    AqutterDownloadStartRequest downloadStartRequest,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onLoadResourceCustomScheme}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onLoadResourceCustomScheme.supported_platforms}
  @SupportedPlatforms(
    platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
  )
  @Deprecated('Use onLoadResourceWithCustomScheme instead')
  FutureOr<AqutterCustomSchemeResponse?>? onLoadResourceCustomScheme(Uri url) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onLoadResourceWithCustomScheme}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onLoadResourceWithCustomScheme.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(),
      IOSPlatform(
        apiName: 'WKURLSchemeHandler',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkurlschemehandler',
      ),
      MacOSPlatform(
        apiName: 'WKURLSchemeHandler',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkurlschemehandler',
      ),
      WindowsPlatform(),
    ],
  )
  FutureOr<AqutterCustomSchemeResponse?>? onLoadResourceWithCustomScheme(
    AqutterWebResourceRequest request,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onCreateWindow}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onCreateWindow.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onCreateWindow',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onCreateWindow(android.webkit.WebView,%20boolean,%20boolean,%20android.os.Message)',
        note:
            'You need to set [AqutterWebViewSettings.supportMultipleWindows] setting to `true`. Also, if the request has been created using JavaScript (`window.open()`), then there are some limitation: check the [AqutterNavigationAction] class.',
      ),
      IOSPlatform(
        apiName: 'WKUIDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkuidelegate/1536907-webview',
        note:
            """Setting these initial settings [AqutterWebViewSettings.supportZoom], [AqutterWebViewSettings.useOnLoadResource], [AqutterWebViewSettings.useShouldInterceptAjaxRequest],
[AqutterWebViewSettings.useShouldInterceptFetchRequest], [AqutterWebViewSettings.applicationNameForUserAgent], [AqutterWebViewSettings.javaScriptCanOpenWindowsAutomatically],
[AqutterWebViewSettings.javaScriptEnabled], [AqutterWebViewSettings.minimumFontSize], [AqutterWebViewSettings.preferredContentMode], [AqutterWebViewSettings.incognito],
[AqutterWebViewSettings.cacheEnabled], [AqutterWebViewSettings.mediaPlaybackRequiresUserGesture],
[AqutterWebViewSettings.resourceCustomSchemes], [AqutterWebViewSettings.sharedCookiesEnabled],
[AqutterWebViewSettings.enableViewportScale], [AqutterWebViewSettings.allowsAirPlayForMediaPlayback],
[AqutterWebViewSettings.allowsPictureInPictureMediaPlayback], [AqutterWebViewSettings.isFraudulentWebsiteWarningEnabled],
[AqutterWebViewSettings.allowsInlineMediaPlayback], [AqutterWebViewSettings.suppressesIncrementalRendering], [AqutterWebViewSettings.selectionGranularity],
[AqutterWebViewSettings.ignoresViewportScaleLimits], [AqutterWebViewSettings.limitsNavigationsToAppBoundDomains],
[AqutterWebViewSettings.upgradeKnownHostsToHTTPS],
will have no effect due to a `WKWebView` limitation when creating the new window WebView: it's impossible to return the new `WKWebView`
with a different `WKWebViewConfiguration` instance (see https://developer.apple.com/documentation/webkit/wkuidelegate/1536907-webview).
So, these options will be inherited from the caller WebView.
Also, note that calling [AqutterWebViewController.setSettings] method using the controller of the new created WebView,
it will update also the WebView options of the caller WebView.""",
      ),
      MacOSPlatform(
        apiName: 'WKUIDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkuidelegate/1536907-webview',
        note:
            """Setting these initial settings [AqutterWebViewSettings.supportZoom], [AqutterWebViewSettings.useOnLoadResource], [AqutterWebViewSettings.useShouldInterceptAjaxRequest],
[AqutterWebViewSettings.useShouldInterceptFetchRequest], [AqutterWebViewSettings.applicationNameForUserAgent], [AqutterWebViewSettings.javaScriptCanOpenWindowsAutomatically],
[AqutterWebViewSettings.javaScriptEnabled], [AqutterWebViewSettings.minimumFontSize], [AqutterWebViewSettings.preferredContentMode], [AqutterWebViewSettings.incognito],
[AqutterWebViewSettings.cacheEnabled], [AqutterWebViewSettings.mediaPlaybackRequiresUserGesture],
[AqutterWebViewSettings.resourceCustomSchemes], [AqutterWebViewSettings.sharedCookiesEnabled],
[AqutterWebViewSettings.enableViewportScale], [AqutterWebViewSettings.allowsAirPlayForMediaPlayback],
[AqutterWebViewSettings.allowsPictureInPictureMediaPlayback], [AqutterWebViewSettings.isFraudulentWebsiteWarningEnabled],
[AqutterWebViewSettings.allowsInlineMediaPlayback], [AqutterWebViewSettings.suppressesIncrementalRendering], [AqutterWebViewSettings.selectionGranularity],
[AqutterWebViewSettings.ignoresViewportScaleLimits], [AqutterWebViewSettings.limitsNavigationsToAppBoundDomains],
[AqutterWebViewSettings.upgradeKnownHostsToHTTPS],
will have no effect due to a `WKWebView` limitation when creating the new window WebView: it's impossible to return the new `WKWebView`
with a different `WKWebViewConfiguration` instance (see https://developer.apple.com/documentation/webkit/wkuidelegate/1536907-webview).
So, these options will be inherited from the caller WebView.
Also, note that calling [AqutterWebViewController.setSettings] method using the controller of the new created WebView,
it will update also the WebView options of the caller WebView.""",
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_NewWindowRequested',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_newwindowrequested',
      ),
    ],
  )
  FutureOr<bool?>? onCreateWindow(AqutterCreateWindowAction createWindowAction) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onCloseWindow}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onCloseWindow.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onCloseWindow',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onCloseWindow(android.webkit.WebView)',
      ),
      IOSPlatform(
        apiName: 'WKUIDelegate.webViewDidClose',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkuidelegate/1537390-webviewdidclose',
      ),
      MacOSPlatform(
        apiName: 'WKUIDelegate.webViewDidClose',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkuidelegate/1537390-webviewdidclose',
      ),
      WebPlatform(),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_WindowCloseRequested',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_windowcloserequested',
      ),
    ],
  )
  void onCloseWindow() {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onWindowFocus}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onWindowFocus.supported_platforms}
  @SupportedPlatforms(
    platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
  )
  void onWindowFocus() {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onWindowBlur}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onWindowBlur.supported_platforms}
  @SupportedPlatforms(
    platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
  )
  void onWindowBlur() {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onJsAlert}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onJsAlert.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onJsAlert',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onJsAlert(android.webkit.WebView,%20java.lang.String,%20java.lang.String,%20android.webkit.JsResult)',
      ),
      IOSPlatform(
        apiName: 'WKUIDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkuidelegate/1537406-webview',
      ),
      MacOSPlatform(
        apiName: 'WKUIDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkuidelegate/1537406-webview',
      ),
    ],
  )
  FutureOr<AqutterJsAlertResponse?>? onJsAlert(AqutterJsAlertRequest jsAlertRequest) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onJsConfirm}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onJsConfirm.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onJsConfirm',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onJsConfirm(android.webkit.WebView,%20java.lang.String,%20java.lang.String,%20android.webkit.JsResult)',
      ),
      IOSPlatform(
        apiName: 'WKUIDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkuidelegate/1536489-webview',
      ),
      MacOSPlatform(
        apiName: 'WKUIDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkuidelegate/1536489-webview',
      ),
    ],
  )
  FutureOr<AqutterJsConfirmResponse?>? onJsConfirm(AqutterJsConfirmRequest jsConfirmRequest) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onJsPrompt}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onJsPrompt.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onJsPrompt',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onJsPrompt(android.webkit.WebView,%20java.lang.String,%20java.lang.String,%20java.lang.String,%20android.webkit.JsPromptResult)',
      ),
      IOSPlatform(
        apiName: 'WKUIDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkuidelegate/1538086-webview',
      ),
      MacOSPlatform(
        apiName: 'WKUIDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wkuidelegate/1538086-webview',
      ),
    ],
  )
  FutureOr<AqutterJsPromptResponse?>? onJsPrompt(AqutterJsPromptRequest jsPromptRequest) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedHttpAuthRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onReceivedHttpAuthRequest.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.onReceivedHttpAuthRequest',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedHttpAuthRequest(android.webkit.WebView,%20android.webkit.HttpAuthHandler,%20java.lang.String,%20java.lang.String)',
      ),
      IOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview',
      ),
      MacOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2_10.add_BasicAuthenticationRequested',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_10?view=webview2-1.0.2849.39#add_basicauthenticationrequested',
      ),
    ],
  )
  FutureOr<AqutterHttpAuthResponse?>? onReceivedHttpAuthRequest(
    AqutterHttpAuthenticationChallenge challenge,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedServerTrustAuthRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onReceivedServerTrustAuthRequest.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.onReceivedSslError',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedSslError(android.webkit.WebView,%20android.webkit.SslErrorHandler,%20android.net.http.AqutterSslError)',
      ),
      IOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview',
        note:
            """To override the certificate verification logic, you have to provide ATS (App Transport Security) exceptions in your iOS/macOS `Info.plist`.
See `NSAppTransportSecurity` in the [Information Property List Key Reference](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW1) for details.""",
      ),
      MacOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview',
        note:
            """To override the certificate verification logic, you have to provide ATS (App Transport Security) exceptions in your iOS/macOS `Info.plist`.
See `NSAppTransportSecurity` in the [Information Property List Key Reference](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW1) for details.""",
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2_14.add_ServerCertificateErrorDetected',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_14?view=webview2-1.0.2792.45#add_servercertificateerrordetected',
      ),
    ],
  )
  FutureOr<AqutterServerTrustAuthResponse?>? onReceivedServerTrustAuthRequest(
    AqutterServerTrustChallenge challenge,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedClientCertRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onReceivedClientCertRequest.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.onReceivedClientCertRequest',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedClientCertRequest(android.webkit.WebView,%20android.webkit.ClientCertRequest)',
      ),
      IOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview',
      ),
      MacOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455638-webview',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2_5.add_ClientCertificateRequested',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_5?view=webview2-1.0.2849.39#add_clientcertificaterequested',
      ),
    ],
  )
  FutureOr<AqutterClientCertResponse?>? onReceivedClientCertRequest(
    AqutterClientCertChallenge challenge,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onFindResultReceived}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onFindResultReceived.supported_platforms}
  @SupportedPlatforms(
    platforms: [AndroidPlatform(), IOSPlatform(), MacOSPlatform()],
  )
  @Deprecated('Use AqutterFindInteractionController.onFindResultReceived instead')
  void onFindResultReceived(
    int activeMatchOrdinal,
    int numberOfMatches,
    bool isDoneCounting,
  ) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.shouldInterceptAjaxRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.shouldInterceptAjaxRequest.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        note:
            """In order to be able to listen this event, check the [AqutterWebViewSettings.useShouldInterceptAjaxRequest] setting documentation.
Also, on Android that doesn't support the [AqutterWebViewFeature.DOCUMENT_START_SCRIPT], unlike iOS that has [WKUserScript](https://developer.apple.com/documentation/webkit/wkuserscript) that
can inject javascript code right after the document element is created but before any other content is loaded, in Android the javascript code
used to intercept ajax requests is loaded as soon as possible so it won't be instantaneous as iOS.
In that case, after the `window.addEventListener("aqutterPlatformReady")` event is dispatched, the ajax requests can be intercept for sure.""",
      ),
      IOSPlatform(),
      MacOSPlatform(),
    ],
  )
  FutureOr<AqutterAjaxRequest?>? shouldInterceptAjaxRequest(AqutterAjaxRequest ajaxRequest) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onAjaxReadyStateChange}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onAjaxReadyStateChange.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        note:
            """In order to be able to listen this event, check the [AqutterWebViewSettings.useShouldInterceptAjaxRequest] and [AqutterWebViewSettings.useOnAjaxReadyStateChange] settings documentation.
Also, on Android that doesn't support the [AqutterWebViewFeature.DOCUMENT_START_SCRIPT], unlike iOS that has [WKUserScript](https://developer.apple.com/documentation/webkit/wkuserscript) that
can inject javascript code right after the document element is created but before any other content is loaded, in Android the javascript code
used to intercept ajax requests is loaded as soon as possible so it won't be instantaneous as iOS.
In that case, after the `window.addEventListener("aqutterPlatformReady")` event is dispatched, the ajax requests can be intercept for sure.""",
      ),
      IOSPlatform(),
      MacOSPlatform(),
    ],
  )
  FutureOr<AqutterAjaxRequestAction?>? onAjaxReadyStateChange(
    AqutterAjaxRequest ajaxRequest,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onAjaxProgress}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onAjaxProgress.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        note:
            """In order to be able to listen this event, check the [AqutterWebViewSettings.useShouldInterceptAjaxRequest] and [AqutterWebViewSettings.useOnAjaxProgress] settings documentation.
Also, on Android that doesn't support the [AqutterWebViewFeature.DOCUMENT_START_SCRIPT], unlike iOS that has [WKUserScript](https://developer.apple.com/documentation/webkit/wkuserscript) that
can inject javascript code right after the document element is created but before any other content is loaded, in Android the javascript code
used to intercept ajax requests is loaded as soon as possible so it won't be instantaneous as iOS.
In that case, after the `window.addEventListener("aqutterPlatformReady")` event is dispatched, the ajax requests can be intercept for sure.""",
      ),
      IOSPlatform(),
      MacOSPlatform(),
    ],
  )
  FutureOr<AqutterAjaxRequestAction?>? onAjaxProgress(AqutterAjaxRequest ajaxRequest) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.shouldInterceptFetchRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.shouldInterceptFetchRequest.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        note:
            """In order to be able to listen this event, check the [AqutterWebViewSettings.useShouldInterceptFetchRequest] setting documentation.
Also, on Android that doesn't support the [AqutterWebViewFeature.DOCUMENT_START_SCRIPT], unlike iOS that has [WKUserScript](https://developer.apple.com/documentation/webkit/wkuserscript) that
can inject javascript code right after the document element is created but before any other content is loaded, in Android the javascript code
used to intercept ajax requests is loaded as soon as possible so it won't be instantaneous as iOS.
In that case, after the `window.addEventListener("aqutterPlatformReady")` event is dispatched, the ajax requests can be intercept for sure.""",
      ),
      IOSPlatform(),
      MacOSPlatform(),
    ],
  )
  FutureOr<AqutterFetchRequest?>? shouldInterceptFetchRequest(
    AqutterFetchRequest fetchRequest,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onUpdateVisitedHistory}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onUpdateVisitedHistory.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.doUpdateVisitedHistory',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#doUpdateVisitedHistory(android.webkit.WebView,%20java.lang.String,%20boolean)',
      ),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_HistoryChanged',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_historychanged',
      ),
    ],
  )
  void onUpdateVisitedHistory(
    AqutterWebUri? url,
    @SupportedPlatforms(platforms: [AndroidPlatform()]) bool? isReload,
  ) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onPrint}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onPrint.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform(), IOSPlatform()])
  @Deprecated("Use onPrintRequest instead")
  void onPrint(Uri? url) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onPrintRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onPrintRequest.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'View.scrollBy',
        apiUrl:
            'https://developer.android.com/reference/android/view/View#scrollBy(int,%20int)',
      ),
      IOSPlatform(
        apiName: 'UIScrollView.setContentOffset',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiscrollview/1619400-setcontentoffset',
      ),
      MacOSPlatform(note: 'This method is implemented using JavaScript.'),
    ],
  )
  FutureOr<bool?>? onPrintRequest(
    AqutterWebUri? url,
    AqutterPlatformPrintJobController? printJobController,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onLongPressHitTestResult}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onLongPressHitTestResult.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'View.setOnLongClickListener',
        apiUrl:
            'https://developer.android.com/reference/android/view/View#setOnLongClickListener(android.view.View.OnLongClickListener)',
      ),
      IOSPlatform(
        apiName: 'UILongPressGestureRecognizer',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uilongpressgesturerecognizer',
      ),
    ],
  )
  void onLongPressHitTestResult(AqutterWebViewHitTestResult hitTestResult) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onEnterFullscreen}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onEnterFullscreen.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onShowCustomView',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onShowCustomView(android.view.View,%20android.webkit.WebChromeClient.CustomViewCallback)',
      ),
      IOSPlatform(
        apiName: 'UIWindow.didBecomeVisibleNotification',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiwindow/1621621-didbecomevisiblenotification',
      ),
      MacOSPlatform(
        apiName: 'NSWindow.didEnterFullScreenNotification',
        apiUrl:
            'https://developer.apple.com/documentation/appkit/nswindow/1419651-didenterfullscreennotification',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_ContainsFullScreenElementChanged',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_containsfullscreenelementchanged',
      ),
    ],
  )
  void onEnterFullscreen() {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onExitFullscreen}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onExitFullscreen.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onHideCustomView',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onHideCustomView()',
      ),
      IOSPlatform(
        apiName: 'UIWindow.didBecomeHiddenNotification',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiwindow/1621617-didbecomehiddennotification',
      ),
      MacOSPlatform(
        apiName: 'NSWindow.didExitFullScreenNotification',
        apiUrl:
            'https://developer.apple.com/documentation/appkit/nswindow/1419177-didexitfullscreennotification',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_ContainsFullScreenElementChanged',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_containsfullscreenelementchanged',
      ),
    ],
  )
  void onExitFullscreen() {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onContentLoading}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onContentLoading.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_ContentLoading',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_contentloading',
      ),
    ],
  )
  void onContentLoading(AqutterWebUri? url) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onDOMContentLoaded}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onDOMContentLoaded.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2_2.add_DOMContentLoaded',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_2?view=webview2-1.0.2210.55#add_domcontentloaded',
      ),
    ],
  )
  void onDOMContentLoaded(AqutterWebUri? url) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onPageCommitVisible}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onPageCommitVisible.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.onPageCommitVisible',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#onPageCommitVisible(android.webkit.WebView,%20java.lang.String)',
      ),
      IOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455635-webview',
      ),
      MacOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455635-webview',
      ),
    ],
  )
  void onPageCommitVisible(AqutterWebUri? url) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onTitleChanged}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onTitleChanged.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onReceivedTitle',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onReceivedTitle(android.webkit.WebView,%20java.lang.String)',
      ),
      IOSPlatform(),
      MacOSPlatform(),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_DocumentTitleChanged',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_documenttitlechanged',
      ),
    ],
  )
  void onTitleChanged(String? title) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onOverScrolled}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onOverScrolled.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebView.onOverScrolled',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebView#onOverScrolled(int,%20int,%20boolean,%20boolean)',
      ),
      IOSPlatform(),
    ],
  )
  void onOverScrolled(int x, int y, bool clampedX, bool clampedY) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onZoomScaleChanged}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onZoomScaleChanged.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.onScaleChanged',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#onScaleChanged(android.webkit.WebView,%20float,%20float)',
      ),
      IOSPlatform(
        apiName: 'UIScrollViewDelegate.scrollViewDidZoom',
        apiUrl:
            'https://developer.apple.com/documentation/uikit/uiscrollviewdelegate/1619409-scrollviewdidzoom',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2Controller.add_ZoomFactorChanged',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller?view=webview2-1.0.2849.39#add_zoomfactorchanged',
      ),
    ],
  )
  void onZoomScaleChanged(double oldScale, double newScale) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnSafeBrowsingHit}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnSafeBrowsingHit.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated("Use onSafeBrowsingHit instead")
  FutureOr<AqutterSafeBrowsingResponse?>? androidOnSafeBrowsingHit(
    Uri url,
    AqutterSafeBrowsingThreat? threatType,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onSafeBrowsingHit}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onSafeBrowsingHit.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.onSafeBrowsingHit',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#onSafeBrowsingHit(android.webkit.WebView,%20android.webkit.AqutterWebResourceRequest,%20int,%20android.webkit.AqutterSafeBrowsingResponse)',
        available: '27',
      ),
    ],
  )
  FutureOr<AqutterSafeBrowsingResponse?>? onSafeBrowsingHit(
    AqutterWebUri url,
    AqutterSafeBrowsingThreat? threatType,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnPermissionRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnPermissionRequest.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated("Use onPermissionRequest instead")
  FutureOr<AqutterPermissionRequestResponse?>? androidOnPermissionRequest(
    String origin,
    List<String> resources,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onPermissionRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onPermissionRequest.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onPermissionRequest',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onPermissionRequest(android.webkit.AqutterPermissionRequest)',
        available: '21',
      ),
      IOSPlatform(
        available: '15.0',
        note:
            'The default [AqutterPermissionResponse.action] is [AqutterPermissionResponseAction.PROMPT].',
      ),
      MacOSPlatform(
        available: '12.0',
        note:
            'The default [AqutterPermissionResponse.action] is [AqutterPermissionResponseAction.PROMPT].',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_PermissionRequested',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2210.55#add_permissionrequested',
      ),
    ],
  )
  FutureOr<AqutterPermissionResponse?>? onPermissionRequest(
    AqutterPermissionRequest permissionRequest,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnGeolocationPermissionsShowPrompt}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnGeolocationPermissionsShowPrompt.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated("Use onGeolocationPermissionsShowPrompt instead")
  FutureOr<AqutterGeolocationPermissionShowPromptResponse?>?
  androidOnGeolocationPermissionsShowPrompt(String origin) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onGeolocationPermissionsShowPrompt}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onGeolocationPermissionsShowPrompt.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onGeolocationPermissionsShowPrompt',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onGeolocationPermissionsShowPrompt(java.lang.String,%20android.webkit.GeolocationPermissions.Callback)',
      ),
    ],
  )
  FutureOr<AqutterGeolocationPermissionShowPromptResponse?>?
  onGeolocationPermissionsShowPrompt(String origin) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnGeolocationPermissionsHidePrompt}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnGeolocationPermissionsHidePrompt.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated("Use onGeolocationPermissionsHidePrompt instead")
  void androidOnGeolocationPermissionsHidePrompt() {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onGeolocationPermissionsHidePrompt}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onGeolocationPermissionsHidePrompt.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onGeolocationPermissionsHidePrompt',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onGeolocationPermissionsHidePrompt()',
      ),
    ],
  )
  void onGeolocationPermissionsHidePrompt() {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidShouldInterceptRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidShouldInterceptRequest.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated("Use shouldInterceptRequest instead")
  FutureOr<AqutterWebResourceResponse?>? androidShouldInterceptRequest(
    AqutterWebResourceRequest request,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.shouldInterceptRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.shouldInterceptRequest.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.shouldInterceptRequest',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#shouldInterceptRequest(android.webkit.WebView,%20android.webkit.AqutterWebResourceRequest)',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_WebResourceRequested',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2478.35#add_webresourcerequested',
      ),
    ],
  )
  FutureOr<AqutterWebResourceResponse?>? shouldInterceptRequest(
    AqutterWebResourceRequest request,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnRenderProcessUnresponsive}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnRenderProcessUnresponsive.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated("Use onRenderProcessUnresponsive instead")
  FutureOr<AqutterWebViewRenderProcessAction?>? androidOnRenderProcessUnresponsive(
    Uri? url,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onRenderProcessUnresponsive}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onRenderProcessUnresponsive.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewRenderProcessClient.onRenderProcessUnresponsive',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewRenderProcessClient#onRenderProcessUnresponsive(android.webkit.WebView,%20android.webkit.WebViewRenderProcess)',
        available: '29',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_ProcessFailed',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2849.39#add_processfailed',
      ),
    ],
  )
  FutureOr<AqutterWebViewRenderProcessAction?>? onRenderProcessUnresponsive(
    AqutterWebUri? url,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnRenderProcessResponsive}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnRenderProcessResponsive.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated("Use onRenderProcessResponsive instead")
  FutureOr<AqutterWebViewRenderProcessAction?>? androidOnRenderProcessResponsive(
    Uri? url,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onRenderProcessResponsive}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onRenderProcessResponsive.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewRenderProcessClient.onRenderProcessResponsive',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewRenderProcessClient#onRenderProcessResponsive(android.webkit.WebView,%20android.webkit.WebViewRenderProcess)',
        available: '29',
      ),
    ],
  )
  FutureOr<AqutterWebViewRenderProcessAction?>? onRenderProcessResponsive(
    AqutterWebUri? url,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnRenderProcessGone}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnRenderProcessGone.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated("Use onRenderProcessGone instead")
  void androidOnRenderProcessGone(AqutterRenderProcessGoneDetail detail) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onRenderProcessGone}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onRenderProcessGone.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.onRenderProcessGone',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#onRenderProcessGone(android.webkit.WebView,%20android.webkit.AqutterRenderProcessGoneDetail)',
        available: '26',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_ProcessFailed',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2849.39#add_processfailed',
      ),
    ],
  )
  void onRenderProcessGone(AqutterRenderProcessGoneDetail detail) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnFormResubmission}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnFormResubmission.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated('Use onFormResubmission instead')
  FutureOr<AqutterFormResubmissionAction?>? androidOnFormResubmission(Uri? url) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onFormResubmission}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onFormResubmission.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.onFormResubmission',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#onFormResubmission(android.webkit.WebView,%20android.os.Message,%20android.os.Message)',
      ),
    ],
  )
  FutureOr<AqutterFormResubmissionAction?>? onFormResubmission(AqutterWebUri? url) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnScaleChanged}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnScaleChanged.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated('Use onZoomScaleChanged instead')
  void androidOnScaleChanged(double oldScale, double newScale) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnReceivedIcon}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnReceivedIcon.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated('Use onReceivedIcon instead')
  void androidOnReceivedIcon(Uint8List icon) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedIcon}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onReceivedIcon.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onReceivedIcon',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onReceivedIcon(android.webkit.WebView,%20android.graphics.Bitmap)',
      ),
    ],
  )
  @Deprecated('Use onFaviconChanged instead')
  void onReceivedIcon(Uint8List icon) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onFaviconChanged}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onFaviconChanged.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onReceivedIcon',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onReceivedIcon(android.webkit.WebView,%20android.graphics.Bitmap)',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2_15.add_FaviconChanged',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_15?view=webview2-1.0.2849.39#add_faviconchanged',
      ),
    ],
  )
  void onFaviconChanged(AqutterFaviconChangedRequest faviconChangedRequest) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnReceivedTouchIconUrl}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnReceivedTouchIconUrl.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated('Use onReceivedTouchIconUrl instead')
  void androidOnReceivedTouchIconUrl(Uri url, bool precomposed) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnReceivedTouchIconUrl}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnReceivedTouchIconUrl.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onReceivedTouchIconUrl',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onReceivedTouchIconUrl(android.webkit.WebView,%20java.lang.String,%20boolean)',
      ),
    ],
  )
  void onReceivedTouchIconUrl(AqutterWebUri url, bool precomposed) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnJsBeforeUnload}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnJsBeforeUnload.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated('Use onJsBeforeUnload instead')
  FutureOr<AqutterJsBeforeUnloadResponse?>? androidOnJsBeforeUnload(
    AqutterJsBeforeUnloadRequest jsBeforeUnloadRequest,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onJsBeforeUnload}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onJsBeforeUnload.supported_platforms}
  FutureOr<AqutterJsBeforeUnloadResponse?>? onJsBeforeUnload(
    AqutterJsBeforeUnloadRequest jsBeforeUnloadRequest,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.androidOnReceivedLoginRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.androidOnReceivedLoginRequest.supported_platforms}
  @SupportedPlatforms(platforms: [AndroidPlatform()])
  @Deprecated('Use onReceivedLoginRequest instead')
  void androidOnReceivedLoginRequest(AqutterLoginRequest loginRequest) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onReceivedLoginRequest}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onReceivedLoginRequest.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebViewClient.onReceivedLoginRequest',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebViewClient#onReceivedLoginRequest(android.webkit.WebView,%20java.lang.String,%20java.lang.String,%20java.lang.String)',
      ),
    ],
  )
  void onReceivedLoginRequest(AqutterLoginRequest loginRequest) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onPermissionRequestCanceled}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onPermissionRequestCanceled.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onPermissionRequestCanceled',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onPermissionRequestCanceled(android.webkit.AqutterPermissionRequest)',
        available: '21',
      ),
    ],
  )
  void onPermissionRequestCanceled(AqutterPermissionRequest permissionRequest) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onRequestFocus}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onRequestFocus.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onRequestFocus',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onRequestFocus(android.webkit.WebView)',
      ),
    ],
  )
  void onRequestFocus() {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.iosOnWebContentProcessDidTerminate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.iosOnWebContentProcessDidTerminate.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform()])
  @Deprecated('Use onWebContentProcessDidTerminate instead')
  void iosOnWebContentProcessDidTerminate() {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onWebContentProcessDidTerminate}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onWebContentProcessDidTerminate.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKNavigationDelegate.webViewWebContentProcessDidTerminate',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455639-webviewwebcontentprocessdidtermi',
      ),
      MacOSPlatform(
        apiName: 'WKNavigationDelegate.webViewWebContentProcessDidTerminate',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455639-webviewwebcontentprocessdidtermi',
      ),
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_ProcessFailed',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2849.39#add_processfailed',
      ),
    ],
  )
  void onWebContentProcessDidTerminate() {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.iosOnDidReceiveServerRedirectForProvisionalNavigation}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.iosOnDidReceiveServerRedirectForProvisionalNavigation.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform()])
  @Deprecated('Use onDidReceiveServerRedirectForProvisionalNavigation instead')
  void iosOnDidReceiveServerRedirectForProvisionalNavigation() {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onDidReceiveServerRedirectForProvisionalNavigation}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onDidReceiveServerRedirectForProvisionalNavigation.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455627-webview',
      ),
      MacOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455627-webview',
      ),
    ],
  )
  void onDidReceiveServerRedirectForProvisionalNavigation() {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.iosOnNavigationResponse}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.iosOnNavigationResponse.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform()])
  @Deprecated('Use onNavigationResponse instead')
  FutureOr<AqutterIOSNavigationResponseAction?>? iosOnNavigationResponse(
    AqutterIOSWKNavigationResponse navigationResponse,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onNavigationResponse}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onNavigationResponse.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455643-webview',
      ),
      MacOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/1455643-webview',
      ),
    ],
  )
  FutureOr<AqutterNavigationResponseAction?>? onNavigationResponse(
    AqutterNavigationResponse navigationResponse,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.iosShouldAllowDeprecatedTLS}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.iosShouldAllowDeprecatedTLS.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform()])
  @Deprecated('Use shouldAllowDeprecatedTLS instead')
  FutureOr<AqutterIOSShouldAllowDeprecatedTLSAction?>? iosShouldAllowDeprecatedTLS(
    AqutterURLAuthenticationChallenge challenge,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.shouldAllowDeprecatedTLS}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.shouldAllowDeprecatedTLS.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/3601237-webview',
        available: '14.0',
      ),
      MacOSPlatform(
        apiName: 'WKNavigationDelegate.webView',
        apiUrl:
            'https://developer.apple.com/documentation/webkit/wknavigationdelegate/3601237-webview',
        available: '11.0',
      ),
    ],
  )
  FutureOr<AqutterShouldAllowDeprecatedTLSAction?>? shouldAllowDeprecatedTLS(
    AqutterURLAuthenticationChallenge challenge,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onCameraCaptureStateChanged}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onCameraCaptureStateChanged.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(available: '15.0'),
      MacOSPlatform(available: '12.0'),
    ],
  )
  void onCameraCaptureStateChanged(
    AqutterMediaCaptureState? oldState,
    AqutterMediaCaptureState? newState,
  ) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onMicrophoneCaptureStateChanged}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onMicrophoneCaptureStateChanged.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      IOSPlatform(available: '15.0'),
      MacOSPlatform(available: '12.0'),
    ],
  )
  void onMicrophoneCaptureStateChanged(
    AqutterMediaCaptureState? oldState,
    AqutterMediaCaptureState? newState,
  ) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onContentSizeChanged}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onContentSizeChanged.supported_platforms}
  @SupportedPlatforms(platforms: [IOSPlatform()])
  void onContentSizeChanged(Size oldContentSize, Size newContentSize) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onProcessFailed}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onProcessFailed.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2.add_ProcessFailed',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2?view=webview2-1.0.2849.39#add_processfailed',
      ),
    ],
  )
  void onProcessFailed(AqutterProcessFailedDetail detail) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onNotificationReceived}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onNotificationReceived.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2_24.add_NotificationReceived',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_24?view=webview2-1.0.2849.39#add_notificationreceived',
      ),
    ],
  )
  FutureOr<AqutterNotificationReceivedResponse?>? onNotificationReceived(
    AqutterNotificationReceivedRequest request,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onSaveAsUIShowing}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onSaveAsUIShowing.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2_25.add_SaveAsUIShowing',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_25?view=webview2-1.0.2849.39#add_saveasuishowing',
      ),
    ],
  )
  FutureOr<AqutterSaveAsUIShowingResponse?>? onSaveAsUIShowing(
    AqutterSaveAsUIShowingRequest request,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onSaveFileSecurityCheckStarting}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onSaveFileSecurityCheckStarting.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2_26.add_SaveFileSecurityCheckStarting',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_26?view=webview2-1.0.2849.39#add_savefilesecuritycheckstarting',
      ),
    ],
  )
  FutureOr<AqutterSaveFileSecurityCheckStartingResponse?>?
  onSaveFileSecurityCheckStarting(
    AqutterSaveFileSecurityCheckStartingRequest request,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onScreenCaptureStarting}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onScreenCaptureStarting.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2_27.add_ScreenCaptureStarting',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2_27?view=webview2-1.0.2849.39#add_screencapturestarting',
      ),
    ],
  )
  FutureOr<AqutterScreenCaptureStartingResponse?>? onScreenCaptureStarting(
    AqutterScreenCaptureStartingRequest request,
  ) {
    return null;
  }

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onAcceleratorKeyPressed}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onAcceleratorKeyPressed.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      WindowsPlatform(
        apiName: 'ICoreWebView2Controller.add_AcceleratorKeyPressed',
        apiUrl:
            'https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2controller?view=webview2-1.0.2849.39#add_acceleratorkeypressed',
      ),
    ],
  )
  void onAcceleratorKeyPressed(AqutterAcceleratorKeyPressedDetail detail) {}

  ///{@macro aqutter_core.AqutterPlatformWebViewCreationParams.onShowFileChooser}
  ///
  ///{@macro aqutter_core.AqutterPlatformBrowserEvents.onShowFileChooser.supported_platforms}
  @SupportedPlatforms(
    platforms: [
      AndroidPlatform(
        apiName: 'WebChromeClient.onShowFileChooser',
        apiUrl:
            'https://developer.android.com/reference/android/webkit/WebChromeClient#onShowFileChooser(android.webkit.WebView,%20android.webkit.ValueCallback%3Candroid.net.Uri[]%3E,%20android.webkit.WebChromeClient.FileChooserParams)',
      ),
    ],
  )
  FutureOr<AqutterShowFileChooserResponse?> onShowFileChooser(
    AqutterShowFileChooserRequest request,
  ) {
    return null;
  }

  ///{@template aqutter_core.AqutterPlatformBrowserEvents.isMethodSupported}
  ///Check if the given [method] is supported by the [defaultTargetPlatform] or a specific [platform].
  ///{@endtemplate}
  static bool isMethodSupported(
    AqutterPlatformBrowserEventsMethod method, {
    TargetPlatform? platform,
  }) => _AqutterPlatformBrowserEventsMethodSupported.isMethodSupported(
    method,
    platform: platform,
  );
}
