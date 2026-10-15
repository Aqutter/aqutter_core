// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webview_environment_settings.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///This class represents all the [AqutterPlatformWebViewEnvironment] settings available.
///
///The [browserExecutableFolder], [userDataFolder] and [additionalBrowserArguments]
///may be overridden by values either specified in environment variables or in the registry.
///
///**Officially Supported Platforms/Implementations**:
///- Windows WebView2
///- Linux WPE WebKit
class AqutterWebViewEnvironmentSettings {
  ///If there are multiple switches, there should be a space in between them.
  ///The one exception is if multiple features are being enabled/disabled for a single switch,
  ///in which case the features should be comma-seperated.
  ///Example: `"--disable-features=feature1,feature2 --some-other-switch --do-something"`
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2EnvironmentOptions.put_AdditionalBrowserArguments](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions?view=webview2-1.0.2210.55#put_additionalbrowserarguments))
  final String? additionalBrowserArguments;

  ///This property is used to enable single sign on with Azure Active Directory (AAD)
  ///and personal Microsoft Account (MSA) resources inside WebView.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2EnvironmentOptions.put_AllowSingleSignOnUsingOSPrimaryAccount](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions?view=webview2-1.0.2210.55#put_allowsinglesignonusingosprimaryaccount))
  final bool? allowSingleSignOnUsingOSPrimaryAccount;

  ///When this property is set to `true` new extensions can be added to user profile and used.
  ///
  ///[areBrowserExtensionsEnabled] is default to be `false`, in this case, new extensions can't be installed,
  ///and already installed extension won't be available to use in user profile.
  ///If connecting to an already running environment with a different value for
  ///[areBrowserExtensionsEnabled] property, it will fail with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.2210.55+ ([Official API - ICoreWebView2EnvironmentOptions6.put_AreBrowserExtensionsEnabled](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions6?view=webview2-1.0.2849.39#put_arebrowserextensionsenabled))
  final bool? areBrowserExtensionsEnabled;

  ///Enable or disable automation mode in the WebContext.
  ///
  ///When automation is allowed, web pages can use the WebDriver API to automate
  ///interaction with the WebView. This is useful for testing and automation scenarios.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_set_automation_allowed](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.set_automation_allowed.html))
  final bool? automationAllowed;

  ///Use [browserExecutableFolder] to specify whether WebView2 controls use a fixed
  ///or installed version of the WebView2 Runtime that exists on a user machine.
  ///To use a fixed version of the WebView2 Runtime, pass the folder path that contains
  ///the fixed version of the WebView2 Runtime to [browserExecutableFolder].
  ///BrowserExecutableFolder supports both relative (to the application's executable) and absolute files paths.
  ///To create WebView2 controls that use the installed version of the WebView2 Runtime that exists on user machines,
  ///pass a `null` or empty string to [browserExecutableFolder].
  ///In this scenario, the API tries to find a compatible version of the WebView2 Runtime
  ///that is installed on the user machine (first at the machine level, and then per user) using the selected channel preference.
  ///The path of fixed version of the WebView2 Runtime should not contain `\Edge\Application\`.
  ///When such a path is used, the API fails with `HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)`.
  ///
  ///The default channel search order is the WebView2 Runtime, Beta, Dev, and Canary.
  ///When an override `WEBVIEW2_RELEASE_CHANNEL_PREFERENCE` environment variable or
  ///applicable `releaseChannelPreference` registry value is set to `1`, the channel search order is reversed.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - CreateCoreWebView2EnvironmentWithOptions.browserExecutableFolder](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2210.55#createcorewebview2environmentwithoptions))
  final String? browserExecutableFolder;

  ///Set the cache model for the WebContext.
  ///
  ///Specifies the caching behavior. Different models optimize for different
  ///use cases like web browsing, document viewing, etc.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_set_cache_model](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.set_cache_model.html))
  final AqutterCacheModel? cacheModel;

  ///This property is [AqutterEnvironmentChannelSearchKind.MOST_STABLE] by default;
  ///environment creation searches for a release channel on the machine from
  ///most to least stable using the first channel found.
  ///
  ///The default search order is: WebView2 Runtime -> Beta -> Dev -> Canary.
  ///Set [channelSearchKind] to [AqutterEnvironmentChannelSearchKind.LEAST_STABLE] to reverse
  ///the search order so that environment creation searches for a channel from least to most stable.
  ///If [releaseChannels] has been provided, the loader will only search for channels in the set.
  ///See [AqutterEnvironmentReleaseChannels] for more details on channels.
  ///
  ///This property can be overridden by the corresponding registry key [channelSearchKind]
  ///or the environment variable `WEBVIEW2_CHANNEL_SEARCH_KIND`.
  ///Set the value to `1` to set the search kind to [AqutterEnvironmentChannelSearchKind.LEAST_STABLE].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.2478.35+ ([Official API - ICoreWebView2EnvironmentOptions7.put_ChannelSearchKind](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions7?view=webview2-1.0.2849.39#put_channelsearchkind))
  final AqutterEnvironmentChannelSearchKind? channelSearchKind;

  ///Set the array of custom scheme registrations to be used.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.1587.40+ ([Official API - ICoreWebView2EnvironmentOptions4.SetCustomSchemeRegistrations](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions4?view=webview2-1.0.2739.15#setcustomschemeregistrations))
  final List<AqutterCustomSchemeRegistration>? customSchemeRegistrations;

  ///This property is used to enable/disable tracking prevention feature in WebView2.
  ///
  ///This property enable/disable tracking prevention for all the WebView2's created in the same environment.
  ///By default this feature is enabled to block potentially harmful trackers and trackers from sites that aren't visited before.
  ///
  ///You can set this property to `false` to disable the tracking prevention feature if the app
  ///only renders content in the WebView2 that is known to be safe.
  ///Disabling this feature when creating environment also improves runtime performance by skipping related code.
  ///
  ///You shouldn't disable this property if WebView2 is being used as a "full browser"
  ///with arbitrary navigation and should protect end user privacy.
  ///
  ///Tracking prevention protects users from online tracking by restricting the ability
  ///of trackers to access browser-based storage as well as the network.
  ///See [Tracking prevention](https://learn.microsoft.com/en-us/microsoft-edge/web-platform/tracking-prevention).
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.1661.34+ ([Official API - ICoreWebView2EnvironmentOptions5.put_EnableTrackingPrevention](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions5?view=webview2-1.0.2849.39#put_enabletrackingprevention))
  final bool? enableTrackingPrevention;

  ///Whether other processes can create WebView2 from WebView2Environment created
  ///with the same user data folder and therefore sharing the same WebView browser process instance.
  ///
  ///The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.1185.39+ ([Official API - ICoreWebView2EnvironmentOptions2.put_ExclusiveUserDataFolderAccess](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions2?view=webview2-1.0.2849.39#put_exclusiveuserdatafolderaccess))
  final bool? exclusiveUserDataFolderAccess;

  ///When IsCustomCrashReportingEnabled is set to `true`,
  ///Windows won't send crash data to Microsoft endpoint.
  ///
  ///The default value is `false`.
  ///In this case, WebView will respect OS consent.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.1518.46+ ([Official API - ICoreWebView2EnvironmentOptions3.put_IsCustomCrashReportingEnabled](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions3?view=webview2-1.0.2849.39#put_iscustomcrashreportingenabled))
  final bool? isCustomCrashReportingEnabled;

  ///The default display language for WebView.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2EnvironmentOptions.put_Language](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions?view=webview2-1.0.2210.55#put_language))
  final String? language;

  ///Set the list of preferred languages for the WebContext.
  ///
  ///This will be used for the `Accept-Language` HTTP header and to set `navigator.language`.
  ///Languages should be specified in order of preference.
  ///For example, `["en-US", "en", "fr"]`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_set_preferred_languages](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.set_preferred_languages.html))
  final List<String>? preferredLanguages;

  ///Sets the [releaseChannels], which is a mask of one or more [AqutterEnvironmentReleaseChannels]
  ///indicating which channels environment creation should search for.
  ///
  ///OR operation(s) can be applied to multiple [AqutterEnvironmentReleaseChannels] to create a mask.
  ///The default value is a a mask of all the channels.
  ///By default, environment creation searches for channels from most to least stable,
  ///using the first channel found on the device.
  ///When [releaseChannels] is provided, environment creation will only
  ///search for the channels specified in the set.
  ///Set [channelSearchKind] to [AqutterEnvironmentChannelSearchKind.LEAST_STABLE] to reverse
  ///the search order so environment creation searches for least stable build first.
  ///See [AqutterEnvironmentReleaseChannels] for descriptions of each channel.
  ///
  ///The [AqutterPlatformWebViewEnvironment] creation will fails with `HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)`
  ///if environment creation is unable to find any channel from the AqutterEnvironmentReleaseChannels installed on the device.
  ///Use [AqutterPlatformWebViewEnvironment.getAvailableVersion] to verify which channel is used when this option is set.
  ///
  ///Examples:
  ///
  ///| ReleaseChannels                                                                                                                       | Channel Search Kind: Most Stable (default)  | Channel Search Kind: Least Stable          |
  ///|--------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------|--------------------------------------------|
  ///| [AqutterEnvironmentReleaseChannels.BETA] | [AqutterEnvironmentReleaseChannels.STABLE]                                                                          | WebView2 Runtime -> Beta                    | Beta -> WebView2 Runtime                   |
  ///| [AqutterEnvironmentReleaseChannels.CANARY] | [AqutterEnvironmentReleaseChannels.DEV] | [AqutterEnvironmentReleaseChannels.BETA] | [AqutterEnvironmentReleaseChannels.STABLE] | WebView2 Runtime -> Beta -> Dev -> Canary   | Canary -> Dev -> Beta -> WebView2 Runtime  |
  ///| [AqutterEnvironmentReleaseChannels.CANARY]                                                                                                              | Canary                                      | Canary                                     |
  ///| [AqutterEnvironmentReleaseChannels.BETA] | [AqutterEnvironmentReleaseChannels.CANARY] | [AqutterEnvironmentReleaseChannels.STABLE]                                    | WebView2 Runtime -> Beta -> Canary          | Canary -> Beta -> WebView2 Runtime         |
  ///
  ///If both [browserExecutableFolder] and [releaseChannels] are provided, the [browserExecutableFolder] takes precedence,
  ///regardless of whether or not the channel of [browserExecutableFolder] is included in the [releaseChannels].
  ///[releaseChannels] can be overridden by the corresponding registry override AqutterEnvironmentReleaseChannels or the environment
  ///variable `WEBVIEW2_RELEASE_CHANNELS`. Set the value to a comma-separated string of integers, which map to
  ///the following release channel values: Stable (0), Beta (1), Dev (2), and Canary (3).
  ///For example, the values "0,2" and "2,0" indicate that environment creation should only search for
  ///Dev channel and the WebView2 Runtime, using the order indicated by [channelSearchKind].
  ///[AqutterPlatformWebViewEnvironment] creation attempts to interpret each integer and treats any invalid entry as Stable channel.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.2478.35+ ([Official API - ICoreWebView2EnvironmentOptions7.put_ReleaseChannels](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions7?view=webview2-1.0.2849.39#put_releasechannels))
  final AqutterEnvironmentReleaseChannels? releaseChannels;

  ///Set additional paths that should be accessible when running in sandbox mode.
  ///
  ///Each path will be added to the sandbox to allow web processes to access those directories.
  ///This is useful when the WebView needs access to specific local files or directories.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_add_path_to_sandbox](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.add_path_to_sandbox.html))
  final List<String>? sandboxPaths;

  ///The ScrollBar style being set on the WebView2 Environment.
  ///
  ///The default value is [AqutterEnvironmentScrollbarStyle.DEFAULT] which specifies the default browser ScrollBar style.
  ///The `color-scheme` CSS property needs to be set on the corresponding
  ///page to allow ScrollBar to follow light or dark theme.
  ///Please see [color-scheme](https://developer.mozilla.org/docs/Web/CSS/color-scheme#declaring_color_scheme_preferences) for how `color-scheme` can be set.
  ///CSS styles that modify the ScrollBar applied on top of native ScrollBar styling that is selected with [scrollbarStyle].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.2535.41+ ([Official API - ICoreWebView2EnvironmentOptions8.put_ScrollBarStyle](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions8?view=webview2-1.0.2849.39#put_scrollbarstyle))
  final AqutterEnvironmentScrollbarStyle? scrollbarStyle;

  ///Enable or disable spell checking in the WebContext.
  ///
  ///When enabled, text entered by the user will be checked for spelling errors.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_set_spell_checking_enabled](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.set_spell_checking_enabled.html))
  final bool? spellCheckingEnabled;

  ///Set the list of spell checking languages to use.
  ///
  ///The locale string typically has the form `lang_COUNTRY` where `lang` is an
  ///ISO-639 language code and `COUNTRY` is an ISO-3166 country code.
  ///For example, `"en_US"`, `"es_ES"`, or `"pt_BR"`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_set_spell_checking_languages](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.set_spell_checking_languages.html))
  final List<String>? spellCheckingLanguages;

  ///Specifies the version of the WebView2 Runtime binaries required to be compatible with your app.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2EnvironmentOptions.put_TargetCompatibleBrowserVersion](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions?view=webview2-1.0.2210.55#put_targetcompatiblebrowserversion))
  final String? targetCompatibleBrowserVersion;

  ///Set a timezone override for web pages loaded in this WebContext.
  ///
  ///This allows overriding the system timezone for web content.
  ///The value should be a valid IANA timezone identifier like `"America/New_York"`,
  ///`"Europe/London"`, or `"Asia/Tokyo"`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - time-zone-override](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.WebContext.html)):
  ///    - This property must be set at WebContext construction time.
  final String? timeZoneOverride;

  ///You may specify the [userDataFolder] to change the default user data folder location for WebView2.
  ///The path is either an absolute file path or a relative file path that is interpreted as relative
  ///to the compiled code for the current process.
  ///For UWP apps, the default user data folder is the app data folder for the package.
  ///For non-UWP apps, the default user data (`{Executable File Name}.WebView2`) folder
  ///is created in the same directory next to the compiled code for the app.
  ///WebView2 creation fails if the compiled code is running in a directory in which the
  ///process does not have permission to create a new directory.
  ///The app is responsible to clean up the associated user data folder when it is done.
  ///
  ///**NOTE**: As a browser process may be shared among WebViews,
  ///WebView creation fails with `HRESULT_FROM_WIN32(ERROR_INVALID_STATE)` if the specified
  ///options does not match the options of the WebViews that are currently
  ///running in the shared browser process.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - CreateCoreWebView2EnvironmentWithOptions.userDataFolder](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2210.55#createcorewebview2environmentwithoptions))
  final String? userDataFolder;

  ///Set the directory where web process extension modules are located.
  ///
  ///Web process extensions allow extending the functionality of the web process
  ///with custom code. This is an advanced feature for specialized use cases.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_set_web_process_extensions_directory](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.set_web_process_extensions_directory.html))
  final String? webProcessExtensionsDirectory;

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///- Linux WPE WebKit
  AqutterWebViewEnvironmentSettings({
    this.additionalBrowserArguments,
    this.allowSingleSignOnUsingOSPrimaryAccount,
    this.areBrowserExtensionsEnabled,
    this.automationAllowed,
    this.browserExecutableFolder,
    this.cacheModel,
    this.channelSearchKind,
    this.customSchemeRegistrations,
    this.enableTrackingPrevention,
    this.exclusiveUserDataFolderAccess,
    this.isCustomCrashReportingEnabled,
    this.language,
    this.preferredLanguages,
    this.releaseChannels,
    this.sandboxPaths,
    this.scrollbarStyle,
    this.spellCheckingEnabled,
    this.spellCheckingLanguages,
    this.targetCompatibleBrowserVersion,
    this.timeZoneOverride,
    this.userDataFolder,
    this.webProcessExtensionsDirectory,
  });

  ///Gets a possible [AqutterWebViewEnvironmentSettings] instance from a [Map] value.
  static AqutterWebViewEnvironmentSettings? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterWebViewEnvironmentSettings(
      additionalBrowserArguments: map['additionalBrowserArguments'],
      allowSingleSignOnUsingOSPrimaryAccount:
          map['allowSingleSignOnUsingOSPrimaryAccount'],
      areBrowserExtensionsEnabled: map['areBrowserExtensionsEnabled'],
      automationAllowed: map['automationAllowed'],
      browserExecutableFolder: map['browserExecutableFolder'],
      cacheModel: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterCacheModel.fromNativeValue(
          map['cacheModel'],
        ),
        AqutterEnumMethod.value => AqutterCacheModel.fromValue(
          map['cacheModel'],
        ),
        AqutterEnumMethod.name => AqutterCacheModel.byName(map['cacheModel']),
      },
      channelSearchKind: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterEnvironmentChannelSearchKind.fromNativeValue(
            map['channelSearchKind'],
          ),
        AqutterEnumMethod.value =>
          AqutterEnvironmentChannelSearchKind.fromValue(
            map['channelSearchKind'],
          ),
        AqutterEnumMethod.name => AqutterEnvironmentChannelSearchKind.byName(
          map['channelSearchKind'],
        ),
      },
      customSchemeRegistrations: map['customSchemeRegistrations'] != null
          ? List<AqutterCustomSchemeRegistration>.from(
              map['customSchemeRegistrations'].map(
                (e) => AqutterCustomSchemeRegistration.fromMap(
                  e?.cast<String, dynamic>(),
                  enumMethod: enumMethod,
                )!,
              ),
            )
          : null,
      enableTrackingPrevention: map['enableTrackingPrevention'],
      exclusiveUserDataFolderAccess: map['exclusiveUserDataFolderAccess'],
      isCustomCrashReportingEnabled: map['isCustomCrashReportingEnabled'],
      language: map['language'],
      preferredLanguages: map['preferredLanguages'] != null
          ? List<String>.from(map['preferredLanguages']!.cast<String>())
          : null,
      releaseChannels: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterEnvironmentReleaseChannels.fromNativeValue(
            map['releaseChannels'],
          ),
        AqutterEnumMethod.value => AqutterEnvironmentReleaseChannels.fromValue(
          map['releaseChannels'],
        ),
        AqutterEnumMethod.name => AqutterEnvironmentReleaseChannels.byName(
          map['releaseChannels'],
        ),
      },
      sandboxPaths: map['sandboxPaths'] != null
          ? List<String>.from(map['sandboxPaths']!.cast<String>())
          : null,
      scrollbarStyle: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterEnvironmentScrollbarStyle.fromNativeValue(
            map['scrollbarStyle'],
          ),
        AqutterEnumMethod.value => AqutterEnvironmentScrollbarStyle.fromValue(
          map['scrollbarStyle'],
        ),
        AqutterEnumMethod.name => AqutterEnvironmentScrollbarStyle.byName(
          map['scrollbarStyle'],
        ),
      },
      spellCheckingEnabled: map['spellCheckingEnabled'],
      spellCheckingLanguages: map['spellCheckingLanguages'] != null
          ? List<String>.from(map['spellCheckingLanguages']!.cast<String>())
          : null,
      targetCompatibleBrowserVersion: map['targetCompatibleBrowserVersion'],
      timeZoneOverride: map['timeZoneOverride'],
      userDataFolder: map['userDataFolder'],
      webProcessExtensionsDirectory: map['webProcessExtensionsDirectory'],
    );
    return instance;
  }

  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isPropertySupported(
    AqutterWebViewEnvironmentSettingsProperty property, {
    TargetPlatform? platform,
  }) => _AqutterWebViewEnvironmentSettingsPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "additionalBrowserArguments": additionalBrowserArguments,
      "allowSingleSignOnUsingOSPrimaryAccount":
          allowSingleSignOnUsingOSPrimaryAccount,
      "areBrowserExtensionsEnabled": areBrowserExtensionsEnabled,
      "automationAllowed": automationAllowed,
      "browserExecutableFolder": browserExecutableFolder,
      "cacheModel": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => cacheModel?.toNativeValue(),
        AqutterEnumMethod.value => cacheModel?.toValue(),
        AqutterEnumMethod.name => cacheModel?.name(),
      },
      "channelSearchKind": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => channelSearchKind?.toNativeValue(),
        AqutterEnumMethod.value => channelSearchKind?.toValue(),
        AqutterEnumMethod.name => channelSearchKind?.name(),
      },
      "customSchemeRegistrations": customSchemeRegistrations
          ?.map((e) => e.toMap(enumMethod: enumMethod))
          .toList(),
      "enableTrackingPrevention": enableTrackingPrevention,
      "exclusiveUserDataFolderAccess": exclusiveUserDataFolderAccess,
      "isCustomCrashReportingEnabled": isCustomCrashReportingEnabled,
      "language": language,
      "preferredLanguages": preferredLanguages,
      "releaseChannels": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => releaseChannels?.toNativeValue(),
        AqutterEnumMethod.value => releaseChannels?.toValue(),
        AqutterEnumMethod.name => releaseChannels?.name(),
      },
      "sandboxPaths": sandboxPaths,
      "scrollbarStyle": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => scrollbarStyle?.toNativeValue(),
        AqutterEnumMethod.value => scrollbarStyle?.toValue(),
        AqutterEnumMethod.name => scrollbarStyle?.name(),
      },
      "spellCheckingEnabled": spellCheckingEnabled,
      "spellCheckingLanguages": spellCheckingLanguages,
      "targetCompatibleBrowserVersion": targetCompatibleBrowserVersion,
      "timeZoneOverride": timeZoneOverride,
      "userDataFolder": userDataFolder,
      "webProcessExtensionsDirectory": webProcessExtensionsDirectory,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  ///Returns a copy of AqutterWebViewEnvironmentSettings.
  AqutterWebViewEnvironmentSettings copy() {
    return AqutterWebViewEnvironmentSettings.fromMap(toMap()) ??
        AqutterWebViewEnvironmentSettings();
  }

  @override
  String toString() {
    return 'AqutterWebViewEnvironmentSettings{additionalBrowserArguments: $additionalBrowserArguments, allowSingleSignOnUsingOSPrimaryAccount: $allowSingleSignOnUsingOSPrimaryAccount, areBrowserExtensionsEnabled: $areBrowserExtensionsEnabled, automationAllowed: $automationAllowed, browserExecutableFolder: $browserExecutableFolder, cacheModel: $cacheModel, channelSearchKind: $channelSearchKind, customSchemeRegistrations: $customSchemeRegistrations, enableTrackingPrevention: $enableTrackingPrevention, exclusiveUserDataFolderAccess: $exclusiveUserDataFolderAccess, isCustomCrashReportingEnabled: $isCustomCrashReportingEnabled, language: $language, preferredLanguages: $preferredLanguages, releaseChannels: $releaseChannels, sandboxPaths: $sandboxPaths, scrollbarStyle: $scrollbarStyle, spellCheckingEnabled: $spellCheckingEnabled, spellCheckingLanguages: $spellCheckingLanguages, targetCompatibleBrowserVersion: $targetCompatibleBrowserVersion, timeZoneOverride: $timeZoneOverride, userDataFolder: $userDataFolder, webProcessExtensionsDirectory: $webProcessExtensionsDirectory}';
  }
}

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

///List of [AqutterWebViewEnvironmentSettings]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterWebViewEnvironmentSettingsProperty {
  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.additionalBrowserArguments] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.additionalBrowserArguments.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2EnvironmentOptions.put_AdditionalBrowserArguments](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions?view=webview2-1.0.2210.55#put_additionalbrowserarguments))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  additionalBrowserArguments,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.allowSingleSignOnUsingOSPrimaryAccount] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.allowSingleSignOnUsingOSPrimaryAccount.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2EnvironmentOptions.put_AllowSingleSignOnUsingOSPrimaryAccount](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions?view=webview2-1.0.2210.55#put_allowsinglesignonusingosprimaryaccount))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  allowSingleSignOnUsingOSPrimaryAccount,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.areBrowserExtensionsEnabled] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.areBrowserExtensionsEnabled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.2210.55+ ([Official API - ICoreWebView2EnvironmentOptions6.put_AreBrowserExtensionsEnabled](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions6?view=webview2-1.0.2849.39#put_arebrowserextensionsenabled))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  areBrowserExtensionsEnabled,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.automationAllowed] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.automationAllowed.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_set_automation_allowed](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.set_automation_allowed.html))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  automationAllowed,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.browserExecutableFolder] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.browserExecutableFolder.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - CreateCoreWebView2EnvironmentWithOptions.browserExecutableFolder](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2210.55#createcorewebview2environmentwithoptions))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  browserExecutableFolder,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.cacheModel] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.cacheModel.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_set_cache_model](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.set_cache_model.html))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  cacheModel,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.channelSearchKind] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.channelSearchKind.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.2478.35+ ([Official API - ICoreWebView2EnvironmentOptions7.put_ChannelSearchKind](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions7?view=webview2-1.0.2849.39#put_channelsearchkind))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  channelSearchKind,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.customSchemeRegistrations] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.customSchemeRegistrations.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.1587.40+ ([Official API - ICoreWebView2EnvironmentOptions4.SetCustomSchemeRegistrations](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions4?view=webview2-1.0.2739.15#setcustomschemeregistrations))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  customSchemeRegistrations,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.enableTrackingPrevention] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.enableTrackingPrevention.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.1661.34+ ([Official API - ICoreWebView2EnvironmentOptions5.put_EnableTrackingPrevention](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions5?view=webview2-1.0.2849.39#put_enabletrackingprevention))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  enableTrackingPrevention,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.exclusiveUserDataFolderAccess] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.exclusiveUserDataFolderAccess.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.1185.39+ ([Official API - ICoreWebView2EnvironmentOptions2.put_ExclusiveUserDataFolderAccess](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions2?view=webview2-1.0.2849.39#put_exclusiveuserdatafolderaccess))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  exclusiveUserDataFolderAccess,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.isCustomCrashReportingEnabled] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.isCustomCrashReportingEnabled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.1518.46+ ([Official API - ICoreWebView2EnvironmentOptions3.put_IsCustomCrashReportingEnabled](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions3?view=webview2-1.0.2849.39#put_iscustomcrashreportingenabled))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  isCustomCrashReportingEnabled,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.language] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.language.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2EnvironmentOptions.put_Language](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions?view=webview2-1.0.2210.55#put_language))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  language,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.preferredLanguages] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.preferredLanguages.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_set_preferred_languages](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.set_preferred_languages.html))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  preferredLanguages,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.releaseChannels] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.releaseChannels.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.2478.35+ ([Official API - ICoreWebView2EnvironmentOptions7.put_ReleaseChannels](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions7?view=webview2-1.0.2849.39#put_releasechannels))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  releaseChannels,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.sandboxPaths] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.sandboxPaths.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_add_path_to_sandbox](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.add_path_to_sandbox.html))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  sandboxPaths,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.scrollbarStyle] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.scrollbarStyle.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 1.0.2535.41+ ([Official API - ICoreWebView2EnvironmentOptions8.put_ScrollBarStyle](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions8?view=webview2-1.0.2849.39#put_scrollbarstyle))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  scrollbarStyle,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.spellCheckingEnabled] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.spellCheckingEnabled.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_set_spell_checking_enabled](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.set_spell_checking_enabled.html))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  spellCheckingEnabled,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.spellCheckingLanguages] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.spellCheckingLanguages.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_set_spell_checking_languages](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.set_spell_checking_languages.html))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  spellCheckingLanguages,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.targetCompatibleBrowserVersion] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.targetCompatibleBrowserVersion.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - ICoreWebView2EnvironmentOptions.put_TargetCompatibleBrowserVersion](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/icorewebview2environmentoptions?view=webview2-1.0.2210.55#put_targetcompatiblebrowserversion))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  targetCompatibleBrowserVersion,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.timeZoneOverride] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.timeZoneOverride.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - time-zone-override](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/class.WebContext.html)):
  ///    - This property must be set at WebContext construction time.
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  timeZoneOverride,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.userDataFolder] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.userDataFolder.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2 ([Official API - CreateCoreWebView2EnvironmentWithOptions.userDataFolder](https://learn.microsoft.com/en-us/microsoft-edge/webview2/reference/win32/webview2-idl?view=webview2-1.0.2210.55#createcorewebview2environmentwithoptions))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  userDataFolder,

  ///Can be used to check if the [AqutterWebViewEnvironmentSettings.webProcessExtensionsDirectory] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterWebViewEnvironmentSettings.webProcessExtensionsDirectory.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Linux WPE WebKit ([Official API - webkit_web_context_set_web_process_extensions_directory](https://wpewebkit.org/reference/stable/wpe-webkit-2.0/method.WebContext.set_web_process_extensions_directory.html))
  ///
  ///Use the [AqutterWebViewEnvironmentSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  webProcessExtensionsDirectory,
}

extension _AqutterWebViewEnvironmentSettingsPropertySupported
    on AqutterWebViewEnvironmentSettings {
  static bool isPropertySupported(
    AqutterWebViewEnvironmentSettingsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterWebViewEnvironmentSettingsProperty.additionalBrowserArguments:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty
          .allowSingleSignOnUsingOSPrimaryAccount:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty
          .areBrowserExtensionsEnabled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.automationAllowed:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.linux].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.browserExecutableFolder:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.cacheModel:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.linux].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.channelSearchKind:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.customSchemeRegistrations:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.enableTrackingPrevention:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty
          .exclusiveUserDataFolderAccess:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty
          .isCustomCrashReportingEnabled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.language:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.preferredLanguages:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.linux].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.releaseChannels:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.sandboxPaths:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.linux].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.scrollbarStyle:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.spellCheckingEnabled:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.linux].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.spellCheckingLanguages:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.linux].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty
          .targetCompatibleBrowserVersion:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.timeZoneOverride:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.linux].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty.userDataFolder:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterWebViewEnvironmentSettingsProperty
          .webProcessExtensionsDirectory:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.linux].contains(platform ?? defaultTargetPlatform);
    }
  }
}
