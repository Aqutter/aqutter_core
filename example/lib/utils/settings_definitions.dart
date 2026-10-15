import 'package:aqutter_core/aqutter_core.dart';
import 'package:aqutter_core_example/models/setting_definition.dart';

List<T> _safeEnumValues<T>(Iterable<T> Function() getter) {
  try {
    return getter().toList();
  } catch (_) {
    return <T>[];
  }
}

/// Get all setting definitions organized by category.
Map<String, List<SettingDefinition>> getSettingDefinitions() {
  return {
    'General': [
      SettingDefinition(
        name: 'JavaScript Enabled',
        description: 'Enable JavaScript execution in the WebView',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.javaScriptEnabled,
      ),
      SettingDefinition(
        name: 'User Agent',
        description: 'Custom user-agent string for the WebView',
        type: SettingType.string,
        defaultValue: '',
        property: AqutterWebViewSettingsProperty.userAgent,
      ),
      SettingDefinition(
        name: 'Application Name for User Agent',
        description: 'Append to the existing user-agent',
        type: SettingType.string,
        defaultValue: '',
        property: AqutterWebViewSettingsProperty.applicationNameForUserAgent,
      ),
      SettingDefinition(
        name: 'Cache Enabled',
        description: 'Enable browser caching',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.cacheEnabled,
      ),
      SettingDefinition(
        name: 'Incognito Mode',
        description: 'Open browser in incognito/private mode',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.incognito,
      ),
      SettingDefinition(
        name: 'Support Zoom',
        description: 'Enable zoom gestures and controls',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.supportZoom,
      ),
    ],
    'Layout': [
      SettingDefinition(
        name: 'Keyboard Avoidance',
        description: 'Keep the focused input visible when the keyboard opens',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.keyboardAvoidance,
      ),
      SettingDefinition(
        name: 'Use Wide ViewPort',
        description: 'Enable support for HTML viewport meta tag',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.useWideViewPort,
      ),
      SettingDefinition(
        name: 'Load With Overview Mode',
        description: 'Zoom out content to fit on screen',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.loadWithOverviewMode,
      ),
      SettingDefinition(
        name: 'Minimum Font Size',
        description: 'Minimum font size in pixels',
        type: SettingType.integer,
        defaultValue: 8,
        property: AqutterWebViewSettingsProperty.minimumFontSize,
      ),
      SettingDefinition(
        name: 'Default Font Size',
        description: 'Default font size in pixels',
        type: SettingType.integer,
        defaultValue: 16,
        property: AqutterWebViewSettingsProperty.defaultFontSize,
      ),
      SettingDefinition(
        name: 'Default Text Encoding',
        description: 'Default text encoding for HTML pages',
        type: SettingType.string,
        defaultValue: 'UTF-8',
        property: AqutterWebViewSettingsProperty.defaultTextEncodingName,
      ),
    ],
    'Content': [
      SettingDefinition(
        name: 'Allow Content Access',
        description: 'Enable content URL access',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.allowContentAccess,
      ),
      SettingDefinition(
        name: 'Allow File Access',
        description: 'Enable file system access',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.allowFileAccess,
      ),
      SettingDefinition(
        name: 'Allow File Access From File URLs',
        description: 'Allow file:// URLs to access other file:// URLs',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.allowFileAccessFromFileURLs,
      ),
      SettingDefinition(
        name: 'Allow Universal Access From File URLs',
        description: 'Allow file:// URLs to access any origin',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.allowUniversalAccessFromFileURLs,
      ),
      SettingDefinition(
        name: 'Block Network Images',
        description: 'Block loading images from the network',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.blockNetworkImage,
      ),
      SettingDefinition(
        name: 'Block Network Loads',
        description: 'Block all network resource loading',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.blockNetworkLoads,
      ),
    ],
    'Media': [
      SettingDefinition(
        name: 'Media Requires User Gesture',
        description: 'Require user interaction to play media',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.mediaPlaybackRequiresUserGesture,
      ),
      SettingDefinition(
        name: 'Allows Inline Media Playback',
        description: 'Allow HTML5 media to play inline',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.allowsInlineMediaPlayback,
      ),
      SettingDefinition(
        name: 'Allows AirPlay',
        description: 'Allow AirPlay for media playback',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.allowsAirPlayForMediaPlayback,
      ),
      SettingDefinition(
        name: 'Allows Picture-in-Picture',
        description: 'Allow videos to play in picture-in-picture',
        type: SettingType.boolean,
        defaultValue: true,
        property:
            AqutterWebViewSettingsProperty.allowsPictureInPictureMediaPlayback,
      ),
      SettingDefinition(
        name: 'Auto Adjust Scroll Indicator Insets',
        description: 'Automatically adjust scroll indicator insets',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty
            .automaticallyAdjustsScrollIndicatorInsets,
      ),
    ],
    'JavaScript': [
      SettingDefinition(
        name: 'JS Can Open Windows',
        description: 'Allow JavaScript to open windows automatically',
        type: SettingType.boolean,
        defaultValue: false,
        property:
            AqutterWebViewSettingsProperty.javaScriptCanOpenWindowsAutomatically,
      ),
      SettingDefinition(
        name: 'JavaScript Bridge Enabled',
        description: 'Enable the JavaScript bridge',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.javaScriptBridgeEnabled,
      ),
      SettingDefinition(
        name: 'JS Bridge Main Frame Only',
        description: 'Restrict JavaScript bridge to main frame',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.javaScriptBridgeForMainFrameOnly,
      ),
    ],
    'Security': [
      SettingDefinition(
        name: 'Mixed Content Mode',
        description: 'How to handle mixed HTTP/HTTPS content',
        type: SettingType.enumeration,
        defaultValue: null,
        enumValues: _safeEnumValues(() => AqutterMixedContentMode.values),
        property: AqutterWebViewSettingsProperty.mixedContentMode,
      ),
      SettingDefinition(
        name: 'Use Should Intercept Request',
        description: 'Enable request interception events',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.useShouldInterceptRequest,
      ),
      SettingDefinition(
        name: 'Use Should Override URL Loading',
        description: 'Enable URL loading override events',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.useShouldOverrideUrlLoading,
      ),
      SettingDefinition(
        name: 'Use On Load Resource',
        description: 'Enable resource loading events',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.useOnLoadResource,
      ),
      SettingDefinition(
        name: 'Fraudulent Website Warning',
        description: 'Show warnings for suspected phishing/malware',
        type: SettingType.boolean,
        defaultValue: true,
        property:
            AqutterWebViewSettingsProperty.isFraudulentWebsiteWarningEnabled,
      ),
      SettingDefinition(
        name: 'Safe Browsing',
        description: 'Enable Google Safe Browsing',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.safeBrowsingEnabled,
      ),
    ],
    'Cache': [
      SettingDefinition(
        name: 'Cache Mode',
        description: 'Override the way the cache is used',
        type: SettingType.enumeration,
        defaultValue: AqutterCacheMode.LOAD_DEFAULT.toNativeValue(),
        enumValues: _safeEnumValues(() => AqutterCacheMode.values),
        property: AqutterWebViewSettingsProperty.cacheMode,
      ),
    ],
    'Appearance': [
      SettingDefinition(
        name: 'Transparent Background',
        description: 'Make the WebView background transparent',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.transparentBackground,
      ),
      SettingDefinition(
        name: 'Vertical Scroll Bar',
        description: 'Show vertical scroll bar',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.verticalScrollBarEnabled,
      ),
      SettingDefinition(
        name: 'Horizontal Scroll Bar',
        description: 'Show horizontal scroll bar',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.horizontalScrollBarEnabled,
      ),
      SettingDefinition(
        name: 'Scrollbar Fading',
        description: 'Fade scrollbars when not scrolling',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.scrollbarFadingEnabled,
      ),
      SettingDefinition(
        name: 'Disable Vertical Scroll',
        description: 'Disable vertical scrolling',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.disableVerticalScroll,
      ),
      SettingDefinition(
        name: 'Disable Horizontal Scroll',
        description: 'Disable horizontal scrolling',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.disableHorizontalScroll,
      ),
      SettingDefinition(
        name: 'Disable Context Menu',
        description: 'Disable the long-press context menu',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.disableContextMenu,
      ),
    ],
    'Navigation': [
      SettingDefinition(
        name: 'Back/Forward Gestures',
        description: 'Enable swipe gestures for navigation',
        type: SettingType.boolean,
        defaultValue: true,
        property:
            AqutterWebViewSettingsProperty.allowsBackForwardNavigationGestures,
      ),
    ],
    'Rendering': [
      SettingDefinition(
        name: 'Suppress Incremental Rendering',
        description: 'Wait until content is fully loaded before rendering',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.suppressesIncrementalRendering,
      ),
      SettingDefinition(
        name: 'Hardware Acceleration',
        description: 'Enable hardware acceleration',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.hardwareAcceleration,
      ),
      SettingDefinition(
        name: 'Hybrid Composition',
        description: 'Use Flutter Hybrid Composition',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.useHybridComposition,
      ),
    ],
    'Zoom': [
      SettingDefinition(
        name: 'Ignore Viewport Scale Limits',
        description: 'Override user-scalable viewport setting',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.ignoresViewportScaleLimits,
      ),
      SettingDefinition(
        name: 'Built-In Zoom Controls',
        description: 'Use built-in zoom controls',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.builtInZoomControls,
      ),
      SettingDefinition(
        name: 'Display Zoom Controls',
        description: 'Show on-screen zoom controls',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.displayZoomControls,
      ),
      SettingDefinition(
        name: 'Pinch Zoom',
        description: 'Enable pinch-to-zoom gesture',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.pinchZoomEnabled,
      ),
    ],
    'Interaction': [
      SettingDefinition(
        name: 'Link Preview',
        description: 'Show link previews on long press',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.allowsLinkPreview,
      ),
    ],
    'AqutterStorage': [
      SettingDefinition(
        name: 'Third-Party Cookies',
        description: 'Allow third-party cookies',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.thirdPartyCookiesEnabled,
      ),
      SettingDefinition(
        name: 'DOM AqutterStorage',
        description: 'Enable DOM local storage',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.domStorageEnabled,
      ),
      SettingDefinition(
        name: 'Database',
        description: 'Enable database storage API',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.databaseEnabled,
      ),
    ],
    'APIs': [
      SettingDefinition(
        name: 'Geolocation',
        description: 'Enable Geolocation API',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.geolocationEnabled,
      ),
    ],
    'Forms': [
      SettingDefinition(
        name: 'General Autofill',
        description: 'Enable autofill for forms',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.generalAutofillEnabled,
      ),
      SettingDefinition(
        name: 'Password Autosave',
        description: 'Enable password autosave',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.passwordAutosaveEnabled,
      ),
    ],
    'UI': [
      SettingDefinition(
        name: 'Status Bar',
        description: 'Show status bar',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.statusBarEnabled,
      ),
      SettingDefinition(
        name: 'Browser Accelerator Keys',
        description: 'Enable browser keyboard shortcuts',
        type: SettingType.boolean,
        defaultValue: true,
        property: AqutterWebViewSettingsProperty.browserAcceleratorKeysEnabled,
      ),
    ],
    'Developer': [
      SettingDefinition(
        name: 'Inspectable',
        description: 'Allow Web Inspector/DevTools',
        type: SettingType.boolean,
        defaultValue: false,
        property: AqutterWebViewSettingsProperty.isInspectable,
      ),
    ],
  };
}
