import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aqutter_core/aqutter_core.dart';

/// Represents a platform for API support checking.
enum SupportedPlatform {
  android,
  ios,
  macos,
  web,
  windows,
  linux;

  String get displayName {
    switch (this) {
      case SupportedPlatform.android:
        return 'Android';
      case SupportedPlatform.ios:
        return 'iOS';
      case SupportedPlatform.macos:
        return 'macOS';
      case SupportedPlatform.web:
        return 'Web';
      case SupportedPlatform.windows:
        return 'Windows';
      case SupportedPlatform.linux:
        return 'Linux';
    }
  }

  IconData get icon {
    switch (this) {
      case SupportedPlatform.android:
        return Icons.android;
      case SupportedPlatform.ios:
        return Icons.phone_iphone;
      case SupportedPlatform.macos:
        return Icons.laptop_mac;
      case SupportedPlatform.web:
        return Icons.language;
      case SupportedPlatform.windows:
        return Icons.desktop_windows;
      case SupportedPlatform.linux:
        return Icons.computer;
    }
  }

  Color get color {
    switch (this) {
      case SupportedPlatform.android:
        return Colors.green.shade600;
      case SupportedPlatform.ios:
        return Colors.grey.shade700;
      case SupportedPlatform.macos:
        return Colors.blueGrey.shade600;
      case SupportedPlatform.web:
        return Colors.blue.shade600;
      case SupportedPlatform.windows:
        return Colors.lightBlue.shade600;
      case SupportedPlatform.linux:
        return Colors.orange.shade700;
    }
  }

  TargetPlatform? get targetPlatform {
    switch (this) {
      case SupportedPlatform.android:
        return TargetPlatform.android;
      case SupportedPlatform.ios:
        return TargetPlatform.iOS;
      case SupportedPlatform.macos:
        return TargetPlatform.macOS;
      case SupportedPlatform.windows:
        return TargetPlatform.windows;
      case SupportedPlatform.linux:
        return TargetPlatform.linux;
      case SupportedPlatform.web:
        return null; // Web doesn't have a TargetPlatform
    }
  }
}

/// Helper utilities for support checks across platforms.
class SupportCheckHelper {
  /// Maps [SupportedPlatform] to a [TargetPlatform] when possible.
  static TargetPlatform? targetPlatformFor(SupportedPlatform platform) {
    return platform.targetPlatform;
  }

  /// Checks class support for a specific [SupportedPlatform].
  static bool isClassSupportedForPlatform({
    required SupportedPlatform platform,
    required bool Function({TargetPlatform? platform}) checker,
  }) {
    if (platform == SupportedPlatform.web) {
      return checker(platform: null);
    }
    return checker(platform: targetPlatformFor(platform));
  }

  /// Checks method support for a specific [SupportedPlatform].
  static bool isMethodSupportedForPlatform<T>({
    required SupportedPlatform platform,
    required T method,
    required bool Function(T method, {TargetPlatform? platform}) checker,
  }) {
    if (platform == SupportedPlatform.web) {
      return checker(method, platform: null);
    }
    return checker(method, platform: targetPlatformFor(platform));
  }

  /// Checks property support for a specific [SupportedPlatform].
  static bool isPropertySupportedForPlatform({
    required SupportedPlatform platform,
    required dynamic property,
    required bool Function(dynamic property, {TargetPlatform? platform})
    checker,
  }) {
    if (platform == SupportedPlatform.web) {
      return checker(property, platform: null);
    }
    return checker(property, platform: targetPlatformFor(platform));
  }

  /// Returns all supported platforms for a given class checker.
  static Set<SupportedPlatform> supportedPlatformsForClass({
    required bool Function({TargetPlatform? platform}) checker,
  }) {
    return SupportedPlatform.values
        .where(
          (platform) =>
              isClassSupportedForPlatform(platform: platform, checker: checker),
        )
        .toSet();
  }

  /// Returns all supported platforms for a given method checker.
  static Set<SupportedPlatform> supportedPlatformsForMethod<T>({
    required T method,
    required bool Function(T method, {TargetPlatform? platform}) checker,
  }) {
    return SupportedPlatform.values
        .where(
          (platform) => isMethodSupportedForPlatform(
            platform: platform,
            method: method,
            checker: checker,
          ),
        )
        .toSet();
  }

  /// Returns all supported platforms for a given property checker.
  static Set<SupportedPlatform> supportedPlatformsForProperty({
    required dynamic property,
    required bool Function(dynamic property, {TargetPlatform? platform})
    checker,
  }) {
    return SupportedPlatform.values
        .where(
          (platform) => isPropertySupportedForPlatform(
            platform: platform,
            property: property,
            checker: checker,
          ),
        )
        .toSet();
  }
}

/// Definition of an API method with platform support information.
class ApiMethodDefinition {
  final String name;
  final String signature;
  final String description;
  final String className;
  final bool isStatic;
  final bool isDeprecated;
  final String? category;

  const ApiMethodDefinition({
    required this.name,
    this.signature = '',
    this.description = '',
    required this.className,
    this.isStatic = false,
    this.isDeprecated = false,
    this.category,
  });

  /// Returns the supported platforms for this method using runtime checks.
  Set<SupportedPlatform> get supportedPlatforms =>
      SupportChecker.getSupportedPlatformsForMethod(className, name);

  bool isSupported(SupportedPlatform platform) =>
      supportedPlatforms.contains(platform);
}

/// Definition of an API event with platform support information.
class ApiEventDefinition {
  final String name;
  final String signature;
  final String description;
  final String className;
  final String? category;

  const ApiEventDefinition({
    required this.name,
    this.signature = '',
    this.description = '',
    required this.className,
    this.category,
  });

  /// Returns the supported platforms for this event using runtime checks.
  Set<SupportedPlatform> get supportedPlatforms =>
      SupportChecker.getSupportedPlatformsForEvent(className, name);

  bool isSupported(SupportedPlatform platform) =>
      supportedPlatforms.contains(platform);
}

/// Definition of an API class with its methods and events.
class ApiClassDefinition {
  final String className;
  final String description;
  final List<ApiMethodDefinition> methods;
  final List<ApiEventDefinition> events;
  final bool Function()? isClassSupported;

  const ApiClassDefinition({
    required this.className,
    this.description = '',
    this.methods = const [],
    this.events = const [],
    this.isClassSupported,
  });

  int get totalApis => methods.length + events.length;

  int methodCountForPlatform(SupportedPlatform platform) =>
      methods.where((m) => m.isSupported(platform)).length;

  int eventCountForPlatform(SupportedPlatform platform) =>
      events.where((e) => e.isSupported(platform)).length;
}

/// Summary of API support statistics.
class SupportSummary {
  final int totalMethods;
  final int totalEvents;
  final Map<SupportedPlatform, int> methodsPerPlatform;
  final Map<SupportedPlatform, int> eventsPerPlatform;

  const SupportSummary({
    required this.totalMethods,
    required this.totalEvents,
    required this.methodsPerPlatform,
    required this.eventsPerPlatform,
  });

  int get totalApis => totalMethods + totalEvents;

  int totalApisForPlatform(SupportedPlatform platform) =>
      (methodsPerPlatform[platform] ?? 0) + (eventsPerPlatform[platform] ?? 0);
}

typedef _MethodSupportResolver =
    bool Function(String methodName, SupportedPlatform platform);

typedef _PropertySupportResolver =
    bool Function(String propertyName, SupportedPlatform platform);

/// Utility class that provides comprehensive API support information.
class SupportChecker {
  // All supported platforms
  static const allPlatforms = {
    SupportedPlatform.android,
    SupportedPlatform.ios,
    SupportedPlatform.macos,
    SupportedPlatform.web,
    SupportedPlatform.windows,
    SupportedPlatform.linux,
  };

  // Mobile platforms
  static const mobilePlatforms = {
    SupportedPlatform.android,
    SupportedPlatform.ios,
  };

  // Native platforms (non-web)
  static const nativePlatforms = {
    SupportedPlatform.android,
    SupportedPlatform.ios,
    SupportedPlatform.macos,
    SupportedPlatform.windows,
    SupportedPlatform.linux,
  };

  // Desktop platforms
  static const desktopPlatforms = {
    SupportedPlatform.macos,
    SupportedPlatform.windows,
    SupportedPlatform.linux,
  };

  // Apple platforms
  static const applePlatforms = {
    SupportedPlatform.ios,
    SupportedPlatform.macos,
  };

  static String _enumName(Object? value) {
    if (value is Enum) return value.name;
    return value.toString().split('.').last;
  }

  static String classNameOf(Type type) => type.toString();

  static String eventClassNameOf(Type type) => '${classNameOf(type)} Events';

  static Set<String> get registeredClassNames => {
    ..._classSupportResolvers.keys,
    ..._methodSupportResolvers.keys,
    ..._eventSupportResolvers.keys,
  };

  static _MethodSupportResolver _buildMethodResolver<T>({
    required List<T> values,
    required bool Function(T method, {TargetPlatform? platform}) checker,
  }) {
    final methodByName = {for (final value in values) _enumName(value): value};
    return (String methodName, SupportedPlatform platform) {
      final resolved = methodByName[methodName];
      if (resolved == null) return false;
      return SupportCheckHelper.isMethodSupportedForPlatform(
        platform: platform,
        method: resolved,
        checker: checker,
      );
    };
  }

  static _PropertySupportResolver _buildPropertyResolver<T>({
    required List<T> values,
    required bool Function(dynamic property, {TargetPlatform? platform})
    checker,
    Map<String, String> nameOverrides = const {},
  }) {
    final propertyByName = {
      for (final value in values) _enumName(value): value,
    };
    return (String propertyName, SupportedPlatform platform) {
      final resolvedName = nameOverrides[propertyName] ?? propertyName;
      final resolved = propertyByName[resolvedName];
      if (resolved == null) return false;
      return SupportCheckHelper.isPropertySupportedForPlatform(
        platform: platform,
        property: resolved,
        checker: checker,
      );
    };
  }

  static final Map<String, bool Function({TargetPlatform? platform})>
  _classSupportResolvers = {
    classNameOf(AqutterWebViewController):
        AqutterWebViewController.isClassSupported,
    eventClassNameOf(AqutterWebView): AqutterWebView.isClassSupported,
    classNameOf(AqutterHeadlessWebView): AqutterHeadlessWebView.isClassSupported,
    classNameOf(AqutterBrowser): AqutterBrowser.isClassSupported,
    classNameOf(AqutterChromeSafariBrowser): AqutterChromeSafariBrowser.isClassSupported,
    classNameOf(AqutterCookieManager): AqutterCookieManager.isClassSupported,
    classNameOf(AqutterWebStorage): AqutterWebStorage.isClassSupported,
    classNameOf(AqutterFindInteractionController):
        AqutterFindInteractionController.isClassSupported,
    classNameOf(AqutterPullToRefreshController):
        AqutterPullToRefreshController.isClassSupported,
    classNameOf(AqutterPrintJobController): AqutterPrintJobController.isClassSupported,
    classNameOf(AqutterWebAuthenticationSession):
        AqutterWebAuthenticationSession.isClassSupported,
    classNameOf(AqutterServiceWorkerController):
        AqutterServiceWorkerController.isClassSupported,
    classNameOf(AqutterProxyController): AqutterProxyController.isClassSupported,
    classNameOf(AqutterTracingController): AqutterTracingController.isClassSupported,
    classNameOf(AqutterHttpAuthCredentialDatabase):
        AqutterHttpAuthCredentialDatabase.isClassSupported,
    classNameOf(AqutterWebViewEnvironment): AqutterWebViewEnvironment.isClassSupported,
    classNameOf(AqutterProcessGlobalConfig): AqutterProcessGlobalConfig.isClassSupported,
    classNameOf(AqutterWebMessageChannel): AqutterWebMessageChannel.isClassSupported,
  };

  static final Map<String, _MethodSupportResolver> _methodSupportResolvers = {
    classNameOf(AqutterWebViewController): _buildMethodResolver(
      values: AqutterPlatformWebViewControllerMethod.values,
      checker: AqutterWebViewController.isMethodSupported,
    ),
    classNameOf(AqutterHeadlessWebView): _buildMethodResolver(
      values: AqutterPlatformHeadlessWebViewMethod.values,
      checker: AqutterHeadlessWebView.isMethodSupported,
    ),
    classNameOf(AqutterBrowser): _buildMethodResolver(
      values: AqutterPlatformBrowserMethod.values,
      checker: AqutterBrowser.isMethodSupported,
    ),
    classNameOf(AqutterChromeSafariBrowser): _buildMethodResolver(
      values: AqutterPlatformChromeSafariBrowserMethod.values,
      checker: AqutterChromeSafariBrowser.isMethodSupported,
    ),
    classNameOf(AqutterCookieManager): _buildMethodResolver(
      values: AqutterPlatformCookieManagerMethod.values,
      checker: AqutterCookieManager.isMethodSupported,
    ),
    classNameOf(AqutterWebStorage): _buildMethodResolver(
      values: AqutterPlatformLocalStorageMethod.values,
      checker: AqutterLocalStorage.isMethodSupported,
    ),
    classNameOf(AqutterFindInteractionController): _buildMethodResolver(
      values: AqutterPlatformFindInteractionControllerMethod.values,
      checker: AqutterFindInteractionController.isMethodSupported,
    ),
    classNameOf(AqutterPullToRefreshController): _buildMethodResolver(
      values: AqutterPlatformPullToRefreshControllerMethod.values,
      checker: AqutterPullToRefreshController.isMethodSupported,
    ),
    classNameOf(AqutterPrintJobController): _buildMethodResolver(
      values: AqutterPlatformPrintJobControllerMethod.values,
      checker: AqutterPrintJobController.isMethodSupported,
    ),
    classNameOf(AqutterWebAuthenticationSession): _buildMethodResolver(
      values: AqutterPlatformWebAuthenticationSessionMethod.values,
      checker: AqutterWebAuthenticationSession.isMethodSupported,
    ),
    classNameOf(AqutterServiceWorkerController): _buildMethodResolver(
      values: AqutterPlatformServiceWorkerControllerMethod.values,
      checker: AqutterServiceWorkerController.isMethodSupported,
    ),
    classNameOf(AqutterProxyController): _buildMethodResolver(
      values: AqutterPlatformProxyControllerMethod.values,
      checker: AqutterProxyController.isMethodSupported,
    ),
    classNameOf(AqutterTracingController): _buildMethodResolver(
      values: AqutterPlatformTracingControllerMethod.values,
      checker: AqutterTracingController.isMethodSupported,
    ),
    classNameOf(AqutterHttpAuthCredentialDatabase): _buildMethodResolver(
      values: AqutterPlatformHttpAuthCredentialDatabaseMethod.values,
      checker: AqutterHttpAuthCredentialDatabase.isMethodSupported,
    ),
    classNameOf(AqutterWebViewEnvironment): _buildMethodResolver(
      values: AqutterPlatformWebViewEnvironmentMethod.values,
      checker: AqutterWebViewEnvironment.isMethodSupported,
    ),
    classNameOf(AqutterProcessGlobalConfig): _buildMethodResolver(
      values: AqutterPlatformProcessGlobalConfigMethod.values,
      checker: AqutterProcessGlobalConfig.isMethodSupported,
    ),
    classNameOf(AqutterWebMessageChannel): _buildMethodResolver(
      values: AqutterPlatformWebMessageChannelMethod.values,
      checker: AqutterWebMessageChannel.isMethodSupported,
    ),
  };

  static final Map<String, _PropertySupportResolver> _eventSupportResolvers = {
    eventClassNameOf(AqutterWebView): _buildPropertyResolver(
      values: AqutterPlatformWebViewCreationParamsProperty.values,
      checker: AqutterWebView.isPropertySupported,
    ),
    classNameOf(AqutterFindInteractionController): _buildPropertyResolver(
      values: AqutterPlatformFindInteractionControllerCreationParamsProperty.values,
      checker: (property, {platform}) =>
          AqutterFindInteractionController.isPropertySupported(
            property as AqutterPlatformFindInteractionControllerCreationParamsProperty,
            platform: platform,
          ),
    ),
  };

  /// Get all API definitions organized by class.
  static List<ApiClassDefinition> getAllApiDefinitions() {
    return [
      _getWebViewControllerDefinition(),
      _getWebViewEventsDefinition(),
      _getHeadlessWebViewDefinition(),
      _getBrowserDefinition(),
      _getChromeSafariBrowserDefinition(),
      _getCookieManagerDefinition(),
      _getWebStorageDefinition(),
      _getFindInteractionControllerDefinition(),
      _getPullToRefreshControllerDefinition(),
      _getPrintJobControllerDefinition(),
      _getWebAuthenticationSessionDefinition(),
      _getServiceWorkerControllerDefinition(),
      _getProxyControllerDefinition(),
      _getTracingControllerDefinition(),
      _getHttpAuthCredentialDatabaseDefinition(),
      _getWebViewEnvironmentDefinition(),
      _getProcessGlobalConfigDefinition(),
      _getWebMessageChannelDefinition(),
    ];
  }

  /// Check if a specific method is supported on current platform.
  static bool isMethodSupported(String className, String methodName) {
    final currentPlatform = _getCurrentPlatform();
    if (currentPlatform == null) return false;
    return isMethodSupportedForPlatform(className, methodName, currentPlatform);
  }

  /// Check if a specific method is supported on a target platform.
  static bool isMethodSupportedForPlatform(
    String className,
    String methodName,
    SupportedPlatform platform,
  ) {
    final resolver = _methodSupportResolvers[className];
    if (resolver != null) {
      return resolver(methodName, platform);
    }

    final definitions = getAllApiDefinitions();
    final classDef = definitions.cast<ApiClassDefinition?>().firstWhere(
      (c) => c?.className == className,
      orElse: () => null,
    );
    if (classDef == null) return false;

    final method = classDef.methods.cast<ApiMethodDefinition?>().firstWhere(
      (m) => m?.name == methodName,
      orElse: () => null,
    );
    if (method == null) return false;

    return method.isSupported(platform);
  }

  /// Check if a specific event is supported on current platform.
  static bool isEventSupported(String className, String eventName) {
    final currentPlatform = _getCurrentPlatform();
    if (currentPlatform == null) return false;
    return isEventSupportedForPlatform(className, eventName, currentPlatform);
  }

  /// Check if a specific event is supported on a target platform.
  static bool isEventSupportedForPlatform(
    String className,
    String eventName,
    SupportedPlatform platform,
  ) {
    final resolver = _eventSupportResolvers[className];
    if (resolver != null) {
      return resolver(eventName, platform);
    }

    final definitions = getAllApiDefinitions();
    final classDef = definitions.cast<ApiClassDefinition?>().firstWhere(
      (c) => c?.className == className,
      orElse: () => null,
    );
    if (classDef == null) return false;

    final event = classDef.events.cast<ApiEventDefinition?>().firstWhere(
      (e) => e?.name == eventName,
      orElse: () => null,
    );
    if (event == null) return false;

    return event.isSupported(platform);
  }

  /// Returns supported platforms for a given class.
  static Set<SupportedPlatform> getSupportedPlatformsForClass(
    String className,
  ) {
    final resolver = _classSupportResolvers[className];
    if (resolver != null) {
      return SupportCheckHelper.supportedPlatformsForClass(checker: resolver);
    }

    final definitions = getAllApiDefinitions();
    final classDef = definitions.cast<ApiClassDefinition?>().firstWhere(
      (c) => c?.className == className,
      orElse: () => null,
    );
    if (classDef == null) return {};

    final supported = <SupportedPlatform>{};
    if (classDef.isClassSupported != null) {
      final currentPlatform = _getCurrentPlatform();
      if (currentPlatform != null && classDef.isClassSupported!()) {
        supported.add(currentPlatform);
      }
    }

    for (final platform in SupportedPlatform.values) {
      if (classDef.methods.any((m) => m.isSupported(platform)) ||
          classDef.events.any((e) => e.isSupported(platform))) {
        supported.add(platform);
      }
    }
    return supported;
  }

  /// Returns supported platforms for a specific method.
  static Set<SupportedPlatform> getSupportedPlatformsForMethod(
    String className,
    String methodName,
  ) {
    final resolver = _methodSupportResolvers[className];
    if (resolver != null) {
      return SupportedPlatform.values
          .where((p) => resolver(methodName, p))
          .toSet();
    }
    // No resolver registered for this class
    return <SupportedPlatform>{};
  }

  /// Returns supported platforms for a specific event.
  static Set<SupportedPlatform> getSupportedPlatformsForEvent(
    String className,
    String eventName,
  ) {
    final resolver = _eventSupportResolvers[className];
    if (resolver != null) {
      return SupportedPlatform.values
          .where((p) => resolver(eventName, p))
          .toSet();
    }
    // No resolver registered for this class
    return <SupportedPlatform>{};
  }

  /// Get support summary statistics.
  static SupportSummary getSupportSummary() {
    final definitions = getAllApiDefinitions();

    int totalMethods = 0;
    int totalEvents = 0;
    final methodsPerPlatform = <SupportedPlatform, int>{};
    final eventsPerPlatform = <SupportedPlatform, int>{};

    for (final platform in SupportedPlatform.values) {
      methodsPerPlatform[platform] = 0;
      eventsPerPlatform[platform] = 0;
    }

    for (final classDef in definitions) {
      totalMethods += classDef.methods.length;
      totalEvents += classDef.events.length;

      for (final method in classDef.methods) {
        final supported = getSupportedPlatformsForMethod(
          classDef.className,
          method.name,
        );
        for (final platform in supported) {
          methodsPerPlatform[platform] = methodsPerPlatform[platform]! + 1;
        }
      }

      for (final event in classDef.events) {
        final supported = getSupportedPlatformsForEvent(
          classDef.className,
          event.name,
        );
        for (final platform in supported) {
          eventsPerPlatform[platform] = eventsPerPlatform[platform]! + 1;
        }
      }
    }

    return SupportSummary(
      totalMethods: totalMethods,
      totalEvents: totalEvents,
      methodsPerPlatform: methodsPerPlatform,
      eventsPerPlatform: eventsPerPlatform,
    );
  }

  static SupportedPlatform? _getCurrentPlatform() {
    if (kIsWeb) return SupportedPlatform.web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return SupportedPlatform.android;
      case TargetPlatform.iOS:
        return SupportedPlatform.ios;
      case TargetPlatform.macOS:
        return SupportedPlatform.macos;
      case TargetPlatform.windows:
        return SupportedPlatform.windows;
      case TargetPlatform.linux:
        return SupportedPlatform.linux;
      default:
        return null;
    }
  }

  // ====================
  // API Class Definitions
  // ====================

  static ApiClassDefinition _getWebViewControllerDefinition() {
    final className = classNameOf(AqutterWebViewController);
    return ApiClassDefinition(
      className: className,
      description: 'Controls an ${AqutterWebView} instance.',
      isClassSupported: () => AqutterWebViewController.isClassSupported(),
      methods: [
        // Navigation methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.loadUrl.name,
          signature: 'Future<void> loadUrl({required AqutterURLRequest urlRequest})',
          description: 'Loads the given URL with optional headers.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.postUrl.name,
          signature:
              'Future<void> postUrl({required AqutterWebUri url, required Uint8List postData})',
          description: 'Loads the URL with POST data.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.loadData.name,
          signature: 'Future<void> loadData({required String data, ...})',
          description: 'Loads HTML data directly into the WebView.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.loadFile.name,
          signature: 'Future<void> loadFile({required String assetFilePath})',
          description: 'Loads a file from the asset bundle.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.reload.name,
          signature: 'Future<void> reload()',
          description: 'Reloads the current page.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.reloadFromOrigin.name,
          signature: 'Future<void> reloadFromOrigin()',
          description:
              'Reloads the current page, performing end-to-end validation.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.goBack.name,
          signature: 'Future<void> goBack()',
          description: 'Goes back in the history of the WebView.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.goForward.name,
          signature: 'Future<void> goForward()',
          description: 'Goes forward in the history of the WebView.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.goBackOrForward.name,
          signature: 'Future<void> goBackOrForward({required int steps})',
          description: 'Goes to the history item at the given offset.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.goTo.name,
          signature: 'Future<void> goTo({required AqutterWebHistoryItem historyItem})',
          description: 'Goes to the specified history item.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.canGoBack.name,
          signature: 'Future<bool> canGoBack()',
          description: 'Returns whether the WebView can go back in history.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.canGoForward.name,
          signature: 'Future<bool> canGoForward()',
          description: 'Returns whether the WebView can go forward in history.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.canGoBackOrForward.name,
          signature: 'Future<bool> canGoBackOrForward({required int steps})',
          description:
              'Returns whether the WebView can go to the specified offset.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.isLoading.name,
          signature: 'Future<bool> isLoading()',
          description: 'Returns whether the WebView is currently loading.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.stopLoading.name,
          signature: 'Future<void> stopLoading()',
          description: 'Stops the current page load.',
          className: className,
          category: 'Navigation',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.loadSimulatedRequest.name,
          signature:
              'Future<void> loadSimulatedRequest({required AqutterURLRequest urlRequest, ...})',
          description:
              'Navigates to a requested URL with simulated response data.',
          className: className,
          category: 'Navigation',
        ),

        // Page Info methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getUrl.name,
          signature: 'Future<AqutterWebUri?> getUrl()',
          description: 'Gets the current URL of the WebView.',
          className: className,
          category: 'Page Info',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getTitle.name,
          signature: 'Future<String?> getTitle()',
          description: 'Gets the title of the current page.',
          className: className,
          category: 'Page Info',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getProgress.name,
          signature: 'Future<int?> getProgress()',
          description: 'Gets the current loading progress.',
          className: className,
          category: 'Page Info',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getHtml.name,
          signature: 'Future<String?> getHtml()',
          description: 'Gets the HTML content of the current page.',
          className: className,
          category: 'Page Info',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getFavicons.name,
          signature: 'Future<List<AqutterFavicon>> getFavicons()',
          description: 'Gets the favicons of the current page.',
          className: className,
          category: 'Page Info',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getOriginalUrl.name,
          signature: 'Future<AqutterWebUri?> getOriginalUrl()',
          description: 'Gets the original URL before redirects.',
          className: className,
          category: 'Page Info',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getSelectedText.name,
          signature: 'Future<String?> getSelectedText()',
          description: 'Gets the currently selected text.',
          className: className,
          category: 'Page Info',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getHitTestResult.name,
          signature:
              'Future<${AqutterWebViewHitTestResult}?> ${AqutterPlatformWebViewControllerMethod.getHitTestResult.name}()',
          description: 'Gets a hit test result for the last tap.',
          className: className,
          category: 'Page Info',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getMetaTags.name,
          signature: 'Future<List<AqutterMetaTag>> getMetaTags()',
          description: 'Gets all meta tags of the current page.',
          className: className,
          category: 'Page Info',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getMetaThemeColor.name,
          signature: 'Future<Color?> getMetaThemeColor()',
          description: 'Gets the meta theme color of the page.',
          className: className,
          category: 'Page Info',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getCertificate.name,
          signature: 'Future<AqutterSslCertificate?> getCertificate()',
          description: 'Gets the SSL certificate for the main resource.',
          className: className,
          category: 'Page Info',
        ),
        ApiMethodDefinition(
          name:
              AqutterPlatformWebViewControllerMethod.getCopyBackForwardList.name,
          signature: 'Future<AqutterWebHistory?> getCopyBackForwardList()',
          description: 'Gets a copy of the back/forward list.',
          className: className,
          category: 'Page Info',
        ),

        // JavaScript methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.evaluateJavascript.name,
          signature:
              'Future<dynamic> evaluateJavascript({required String source, ...})',
          description: 'Evaluates JavaScript code and returns the result.',
          className: className,
          category: 'JavaScript',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.callAsyncJavaScript.name,
          signature:
              'Future<AqutterCallAsyncJavaScriptResult?> callAsyncJavaScript({...})',
          description: 'Calls a JavaScript function asynchronously.',
          className: className,
          category: 'JavaScript',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .injectJavascriptFileFromUrl
              .name,
          signature:
              'Future<void> injectJavascriptFileFromUrl({required AqutterWebUri urlFile, ...})',
          description: 'Injects a JavaScript file from a URL.',
          className: className,
          category: 'JavaScript',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .injectJavascriptFileFromAsset
              .name,
          signature:
              'Future<dynamic> injectJavascriptFileFromAsset({required String assetFilePath})',
          description: 'Injects a JavaScript file from assets.',
          className: className,
          category: 'JavaScript',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.injectCSSCode.name,
          signature: 'Future<void> injectCSSCode({required String source})',
          description: 'Injects CSS code into the page.',
          className: className,
          category: 'JavaScript',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.injectCSSFileFromUrl.name,
          signature:
              'Future<void> injectCSSFileFromUrl({required AqutterWebUri urlFile, ...})',
          description: 'Injects a CSS file from a URL.',
          className: className,
          category: 'JavaScript',
        ),
        ApiMethodDefinition(
          name:
              AqutterPlatformWebViewControllerMethod.injectCSSFileFromAsset.name,
          signature:
              'Future<void> injectCSSFileFromAsset({required String assetFilePath})',
          description: 'Injects a CSS file from assets.',
          className: className,
          category: 'JavaScript',
        ),

        // JavaScript Handler methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.addJavaScriptHandler.name,
          signature:
              'void addJavaScriptHandler({required String handlerName, ...})',
          description: 'Adds a handler for JavaScript to call.',
          className: className,
          category: 'Handlers',
        ),
        ApiMethodDefinition(
          name:
              AqutterPlatformWebViewControllerMethod.removeJavaScriptHandler.name,
          signature:
              'AqutterJavaScriptHandlerCallback? removeJavaScriptHandler({required String handlerName})',
          description: 'Removes a JavaScript handler.',
          className: className,
          category: 'Handlers',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.hasJavaScriptHandler.name,
          signature: 'bool hasJavaScriptHandler({required String handlerName})',
          description: 'Checks if a JavaScript handler exists.',
          className: className,
          category: 'Handlers',
        ),

        // User Scripts methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.addUserScript.name,
          signature:
              'Future<void> addUserScript({required AqutterUserScript userScript})',
          description: 'Adds a user script to the WebView.',
          className: className,
          category: 'User Scripts',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.removeUserScript.name,
          signature:
              'Future<bool> removeUserScript({required AqutterUserScript userScript})',
          description: 'Removes a user script.',
          className: className,
          category: 'User Scripts',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .removeUserScriptsByGroupName
              .name,
          signature:
              'Future<void> removeUserScriptsByGroupName({required String groupName})',
          description: 'Removes user scripts by group name.',
          className: className,
          category: 'User Scripts',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.removeAllUserScripts.name,
          signature: 'Future<void> removeAllUserScripts()',
          description: 'Removes all user scripts.',
          className: className,
          category: 'User Scripts',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.hasUserScript.name,
          signature: 'bool hasUserScript({required AqutterUserScript userScript})',
          description: 'Checks if a user script exists.',
          className: className,
          category: 'User Scripts',
        ),

        // Scrolling methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.scrollTo.name,
          signature:
              'Future<void> scrollTo({required int x, required int y, bool animated})',
          description: 'Scrolls the WebView to the specified position.',
          className: className,
          category: 'Scrolling',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.scrollBy.name,
          signature:
              'Future<void> scrollBy({required int x, required int y, bool animated})',
          description: 'Scrolls the WebView by the specified amount.',
          className: className,
          category: 'Scrolling',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getScrollX.name,
          signature: 'Future<int?> getScrollX()',
          description: 'Gets the current horizontal scroll position.',
          className: className,
          category: 'Scrolling',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getScrollY.name,
          signature: 'Future<int?> getScrollY()',
          description: 'Gets the current vertical scroll position.',
          className: className,
          category: 'Scrolling',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getContentHeight.name,
          signature: 'Future<int?> getContentHeight()',
          description: 'Gets the height of the HTML content.',
          className: className,
          category: 'Scrolling',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getContentWidth.name,
          signature: 'Future<int?> getContentWidth()',
          description: 'Gets the width of the HTML content.',
          className: className,
          category: 'Scrolling',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.canScrollVertically.name,
          signature: 'Future<bool> canScrollVertically()',
          description: 'Checks if the WebView can scroll vertically.',
          className: className,
          category: 'Scrolling',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.canScrollHorizontally.name,
          signature: 'Future<bool> canScrollHorizontally()',
          description: 'Checks if the WebView can scroll horizontally.',
          className: className,
          category: 'Scrolling',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.pageDown.name,
          signature: 'Future<bool> pageDown({required bool bottom})',
          description: 'Scrolls down by half or full page.',
          className: className,
          category: 'Scrolling',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.pageUp.name,
          signature: 'Future<bool> pageUp({required bool top})',
          description: 'Scrolls up by half or full page.',
          className: className,
          category: 'Scrolling',
        ),

        // Zoom methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.zoomBy.name,
          signature: 'Future<void> zoomBy({required double zoomFactor, ...})',
          description: 'Zooms by the specified factor.',
          className: className,
          category: 'Zoom',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.zoomIn.name,
          signature: 'Future<bool> zoomIn()',
          description: 'Zooms in by a standard amount.',
          className: className,
          category: 'Zoom',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.zoomOut.name,
          signature: 'Future<bool> zoomOut()',
          description: 'Zooms out by a standard amount.',
          className: className,
          category: 'Zoom',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getZoomScale.name,
          signature: 'Future<double?> getZoomScale()',
          description: 'Gets the current zoom scale.',
          className: className,
          category: 'Zoom',
        ),

        // Settings methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.setSettings.name,
          signature:
              'Future<void> ${AqutterPlatformWebViewControllerMethod.setSettings.name}({required ${AqutterWebViewSettings} settings})',
          description: 'Updates the WebView settings.',
          className: className,
          category: 'Settings',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getSettings.name,
          signature:
              'Future<${AqutterWebViewSettings}?> ${AqutterPlatformWebViewControllerMethod.getSettings.name}()',
          description: 'Gets the current WebView settings.',
          className: className,
          category: 'Settings',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.setContextMenu.name,
          signature: 'Future<void> setContextMenu(AqutterContextMenu? contextMenu)',
          description: 'Sets the context menu.',
          className: className,
          category: 'Settings',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.requestFocus.name,
          signature: 'Future<void> requestFocus()',
          description: 'Requests focus for the WebView.',
          className: className,
          category: 'Settings',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.clearFocus.name,
          signature: 'Future<void> clearFocus()',
          description: 'Clears focus from the WebView.',
          className: className,
          category: 'Settings',
        ),

        // Screenshot methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.takeScreenshot.name,
          signature:
              'Future<Uint8List?> takeScreenshot({AqutterScreenshotConfiguration? screenshotConfiguration})',
          description: 'Takes a screenshot of the WebView.',
          className: className,
          category: 'Screenshot',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.printCurrentPage.name,
          signature:
              'Future<${AqutterPrintJobController}?> ${AqutterPlatformWebViewControllerMethod.printCurrentPage.name}({${AqutterPrintJobSettings}? settings})',
          description: 'Prints the current page.',
          className: className,
          category: 'Screenshot',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.createPdf.name,
          signature:
              'Future<Uint8List?> createPdf({PdfConfiguration? pdfConfiguration})',
          description: 'Creates a PDF from the current page.',
          className: className,
          category: 'Screenshot',
        ),

        // Cache methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.clearHistory.name,
          signature: 'Future<void> clearHistory()',
          description: 'Clears the WebView history.',
          className: className,
          category: 'Cache',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.clearFormData.name,
          signature: 'Future<void> clearFormData()',
          description: 'Clears form data.',
          className: className,
          category: 'Cache',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.clearSslPreferences.name,
          signature: 'Future<void> clearSslPreferences()',
          description: 'Clears SSL preferences.',
          className: className,
          category: 'Cache',
        ),

        // Pause/Resume methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.pause.name,
          signature: 'Future<void> pause()',
          description: 'Pauses the WebView.',
          className: className,
          category: 'Pause/Resume',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.resume.name,
          signature: 'Future<void> resume()',
          description: 'Resumes the WebView.',
          className: className,
          category: 'Pause/Resume',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.pauseTimers.name,
          signature: 'Future<void> pauseTimers()',
          description: 'Pauses all layout, parsing, and JavaScript timers.',
          className: className,
          category: 'Pause/Resume',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.resumeTimers.name,
          signature: 'Future<void> resumeTimers()',
          description: 'Resumes all layout, parsing, and JavaScript timers.',
          className: className,
          category: 'Pause/Resume',
        ),

        // Web Messaging methods
        ApiMethodDefinition(
          name:
              AqutterPlatformWebViewControllerMethod.createWebMessageChannel.name,
          signature:
              'Future<${AqutterWebMessageChannel}?> ${AqutterPlatformWebViewControllerMethod.createWebMessageChannel.name}()',
          description: 'Creates a message channel for communication.',
          className: className,
          category: 'Web Messaging',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.postWebMessage.name,
          signature:
              'Future<void> ${AqutterPlatformWebViewControllerMethod.postWebMessage.name}({required ${AqutterWebMessage} message, ...})',
          description: 'Posts a message to the WebView.',
          className: className,
          category: 'Web Messaging',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.addWebMessageListener.name,
          signature:
              'Future<void> ${AqutterPlatformWebViewControllerMethod.addWebMessageListener.name}(${AqutterWebMessageListener} webMessageListener)',
          description: 'Adds a listener for web messages.',
          className: className,
          category: 'Web Messaging',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.hasWebMessageListener.name,
          signature:
              'bool hasWebMessageListener({required String jsObjectName})',
          description: 'Checks if a web message listener exists.',
          className: className,
          category: 'Web Messaging',
        ),

        // Media methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.isInFullscreen.name,
          signature: 'Future<bool?> isInFullscreen()',
          description: 'Returns whether the WebView is in fullscreen mode.',
          className: className,
          category: 'Media',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.pauseAllMediaPlayback.name,
          signature: 'Future<void> pauseAllMediaPlayback()',
          description: 'Pauses all media playback.',
          className: className,
          category: 'Media',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .setAllMediaPlaybackSuspended
              .name,
          signature:
              'Future<void> setAllMediaPlaybackSuspended({required bool suspended})',
          description: 'Suspends or resumes all media playback.',
          className: className,
          category: 'Media',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .closeAllMediaPresentations
              .name,
          signature: 'Future<void> closeAllMediaPresentations()',
          description: 'Closes all media presentations.',
          className: className,
          category: 'Media',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .requestMediaPlaybackState
              .name,
          signature: 'Future<AqutterMediaPlaybackState?> requestMediaPlaybackState()',
          description: 'Gets the current media playback state.',
          className: className,
          category: 'Media',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.isPlayingAudio.name,
          signature: 'Future<bool?> isPlayingAudio()',
          description: 'Checks if audio is currently playing.',
          className: className,
          category: 'Media',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.isMuted.name,
          signature: 'Future<bool?> isMuted()',
          description: 'Checks if audio is muted.',
          className: className,
          category: 'Media',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.setMuted.name,
          signature: 'Future<void> setMuted({required bool muted})',
          description: 'Sets the muted state.',
          className: className,
          category: 'Media',
        ),

        // Camera/Mic methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getCameraCaptureState.name,
          signature: 'Future<AqutterMediaCaptureState?> getCameraCaptureState()',
          description: 'Gets the camera capture state.',
          className: className,
          category: 'Camera/Mic',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.setCameraCaptureState.name,
          signature:
              'Future<void> setCameraCaptureState({required AqutterMediaCaptureState state})',
          description: 'Sets the camera capture state.',
          className: className,
          category: 'Camera/Mic',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .getMicrophoneCaptureState
              .name,
          signature: 'Future<AqutterMediaCaptureState?> getMicrophoneCaptureState()',
          description: 'Gets the microphone capture state.',
          className: className,
          category: 'Camera/Mic',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .setMicrophoneCaptureState
              .name,
          signature:
              'Future<void> setMicrophoneCaptureState({required AqutterMediaCaptureState state})',
          description: 'Sets the microphone capture state.',
          className: className,
          category: 'Camera/Mic',
        ),

        // Security methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.isSecureContext.name,
          signature: 'Future<bool> isSecureContext()',
          description: 'Checks if the current context is secure (HTTPS).',
          className: className,
          category: 'Security',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.hasOnlySecureContent.name,
          signature: 'Future<bool> hasOnlySecureContent()',
          description: 'Checks if the page has only secure content.',
          className: className,
          category: 'Security',
        ),

        // Android-specific methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.startSafeBrowsing.name,
          signature: 'Future<bool> startSafeBrowsing()',
          description: 'Starts the Safe Browsing initialization.',
          className: className,
          category: 'Android',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.saveWebArchive.name,
          signature:
              'Future<String?> saveWebArchive({required String basename, ...})',
          description: 'Saves the current page as a web archive.',
          className: className,
          category: 'Android',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.requestFocusNodeHref.name,
          signature:
              'Future<AqutterRequestFocusNodeHrefResult?> requestFocusNodeHref()',
          description: 'Requests the URL of the focused anchor.',
          className: className,
          category: 'Android',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.requestImageRef.name,
          signature: 'Future<AqutterRequestImageRefResult?> requestImageRef()',
          description: 'Requests the URL of the focused image.',
          className: className,
          category: 'Android',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.saveState.name,
          signature: 'Future<Uint8List?> saveState()',
          description: 'Saves the WebView state to a bundle.',
          className: className,
          category: 'Android',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.restoreState.name,
          signature: 'Future<void> restoreState({required Uint8List state})',
          description: 'Restores the WebView state from a bundle.',
          className: className,
          category: 'Android',
        ),

        // iOS/macOS-specific methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.createWebArchiveData.name,
          signature: 'Future<Uint8List?> createWebArchiveData()',
          description: 'Creates a web archive of the current page.',
          className: className,
          category: 'iOS/macOS',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.terminateWebProcess.name,
          signature: 'Future<void> terminateWebProcess()',
          description: 'Terminates the web content process.',
          className: className,
          category: 'iOS/macOS',
        ),

        // Windows-specific methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.openDevTools.name,
          signature: 'Future<void> openDevTools()',
          description: 'Opens the browser DevTools.',
          className: className,
          category: 'Windows',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .callDevToolsProtocolMethod
              .name,
          signature:
              'Future<dynamic> callDevToolsProtocolMethod({required String methodName, ...})',
          description: 'Calls a DevTools Protocol method.',
          className: className,
          category: 'Windows',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .addDevToolsProtocolEventListener
              .name,
          signature:
              'Future<void> addDevToolsProtocolEventListener({required String eventName, ...})',
          description: 'Adds a DevTools Protocol event listener.',
          className: className,
          category: 'Windows',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .removeDevToolsProtocolEventListener
              .name,
          signature:
              'Future<void> removeDevToolsProtocolEventListener({required String eventName})',
          description: 'Removes a DevTools Protocol event listener.',
          className: className,
          category: 'Windows',
        ),

        // Web-specific methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getIFrameId.name,
          signature: 'Future<String?> getIFrameId()',
          description: 'Gets the iframe ID on web platform.',
          className: className,
          category: 'Web',
        ),

        // Other methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getViewId.name,
          signature: 'int getViewId()',
          description: 'Gets the view ID of the WebView.',
          className: className,
          category: 'Other',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.dispose.name,
          signature: 'void dispose()',
          description: 'Disposes the controller and releases resources.',
          className: className,
          category: 'Other',
        ),

        // Static methods
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getDefaultUserAgent.name,
          signature: 'static Future<String> getDefaultUserAgent()',
          description: 'Gets the default User-Agent string.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .clearClientCertPreferences
              .name,
          signature: 'static Future<void> clearClientCertPreferences()',
          description: 'Clears the client certificate preferences.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .getSafeBrowsingPrivacyPolicyUrl
              .name,
          signature: 'static Future<AqutterWebUri?> getSafeBrowsingPrivacyPolicyUrl()',
          description: 'Gets the Safe Browsing privacy policy URL.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .setSafeBrowsingAllowlist
              .name,
          signature:
              'static Future<bool> setSafeBrowsingAllowlist({required List<String> hosts})',
          description: 'Sets the Safe Browsing allowlist.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .getCurrentWebViewPackage
              .name,
          signature:
              'static Future<AqutterWebViewPackageInfo?> getCurrentWebViewPackage()',
          description: 'Gets the current WebView package info.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .setWebContentsDebuggingEnabled
              .name,
          signature:
              'static Future<void> setWebContentsDebuggingEnabled(bool debuggingEnabled)',
          description: 'Enables or disables debugging.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.getVariationsHeader.name,
          signature: 'static Future<String?> getVariationsHeader()',
          description: 'Gets the variations header.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.isMultiProcessEnabled.name,
          signature: 'static Future<bool> isMultiProcessEnabled()',
          description: 'Checks if multi-process is enabled.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.disableWebView.name,
          signature: 'static Future<void> disableWebView()',
          description: 'Disables the WebView.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.handlesURLScheme.name,
          signature: 'static Future<bool> handlesURLScheme(String urlScheme)',
          description: 'Checks if the WebView handles a URL scheme.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.disposeKeepAlive.name,
          signature:
              'static Future<void> disposeKeepAlive(${AqutterWebViewKeepAlive} keepAlive)',
          description: 'Disposes a keep-alive instance.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod.clearAllCache.name,
          signature:
              'static Future<void> clearAllCache({bool includeDiskFiles = true})',
          description: 'Clears all WebView caches.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewControllerMethod
              .enableSlowWholeDocumentDraw
              .name,
          signature: 'static Future<void> enableSlowWholeDocumentDraw()',
          description: 'Enables slow whole document draw.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name:
              AqutterPlatformWebViewControllerMethod.setJavaScriptBridgeName.name,
          signature:
              'static Future<void> setJavaScriptBridgeName(String bridgeName)',
          description: 'Sets the JavaScript bridge name.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
        ApiMethodDefinition(
          name:
              AqutterPlatformWebViewControllerMethod.getJavaScriptBridgeName.name,
          signature: 'static Future<String> getJavaScriptBridgeName()',
          description: 'Gets the JavaScript bridge name.',
          className: className,
          isStatic: true,
          category: 'Static',
        ),
      ],
    );
  }

  static ApiClassDefinition _getWebViewEventsDefinition() {
    final className = eventClassNameOf(AqutterWebView);
    return ApiClassDefinition(
      className: className,
      description: 'Events fired by ${AqutterWebView}.',
      events: [
        // Core events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onWebViewCreated.name,
          description: 'Called when the WebView is created.',
          className: className,
          category: 'Core',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onLoadStart.name,
          description: 'Called when a page starts loading.',
          className: className,
          category: 'Core',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onLoadStop.name,
          description: 'Called when a page finishes loading.',
          className: className,
          category: 'Core',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onLoadError.name,
          description: 'Called when a page fails to load.',
          className: className,
          category: 'Core',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onLoadHttpError.name,
          description: 'Called when an HTTP error is received.',
          className: className,
          category: 'Core',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onProgressChanged.name,
          description: 'Called when the loading progress changes.',
          className: className,
          category: 'Core',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onConsoleMessage.name,
          description: 'Called when a console message is received.',
          className: className,
          category: 'Core',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onTitleChanged.name,
          description: 'Called when the page title changes.',
          className: className,
          category: 'Core',
        ),
        ApiEventDefinition(
          name:
              AqutterPlatformWebViewCreationParamsProperty.onUpdateVisitedHistory.name,
          description: 'Called when the visited history is updated.',
          className: className,
          category: 'Core',
        ),

        // Navigation events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .shouldOverrideUrlLoading
              .name,
          description: 'Called to handle URL navigation requests.',
          className: className,
          category: 'Navigation',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onNavigationResponse.name,
          description: 'Called when receiving a navigation response.',
          className: className,
          category: 'Navigation',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .shouldAllowDeprecatedTLS
              .name,
          description: 'Called to check if deprecated TLS should be allowed.',
          className: className,
          category: 'Navigation',
        ),

        // Window events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onCreateWindow.name,
          description: 'Called when a new window is requested.',
          className: className,
          category: 'Window',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onCloseWindow.name,
          description: 'Called when a window should be closed.',
          className: className,
          category: 'Window',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onWindowFocus.name,
          description: 'Called when the window receives focus.',
          className: className,
          category: 'Window',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onWindowBlur.name,
          description: 'Called when the window loses focus.',
          className: className,
          category: 'Window',
        ),

        // JS Dialog events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onJsAlert.name,
          description: 'Called when a JavaScript alert is shown.',
          className: className,
          category: 'JS Dialogs',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onJsConfirm.name,
          description: 'Called when a JavaScript confirm is shown.',
          className: className,
          category: 'JS Dialogs',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onJsPrompt.name,
          description: 'Called when a JavaScript prompt is shown.',
          className: className,
          category: 'JS Dialogs',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onJsBeforeUnload.name,
          description: 'Called before the page is unloaded.',
          className: className,
          category: 'JS Dialogs',
        ),

        // Authentication events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onReceivedHttpAuthRequest
              .name,
          description: 'Called for HTTP authentication requests.',
          className: className,
          category: 'Authentication',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onReceivedServerTrustAuthRequest
              .name,
          description: 'Called for server trust authentication.',
          className: className,
          category: 'Authentication',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onReceivedClientCertRequest
              .name,
          description: 'Called when a client certificate is requested.',
          className: className,
          category: 'Authentication',
        ),

        // Network events
        ApiEventDefinition(
          name:
              AqutterPlatformWebViewCreationParamsProperty.shouldInterceptRequest.name,
          description: 'Called to intercept resource requests.',
          className: className,
          category: 'Network',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onLoadResource.name,
          description: 'Called when a resource is loaded.',
          className: className,
          category: 'Network',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onLoadResourceWithCustomScheme
              .name,
          description: 'Called when loading a custom scheme resource.',
          className: className,
          category: 'Network',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onReceivedError.name,
          description: 'Called when a resource load error occurs.',
          className: className,
          category: 'Network',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onReceivedHttpError.name,
          description: 'Called when an HTTP error occurs.',
          className: className,
          category: 'Network',
        ),

        // Download events
        ApiEventDefinition(
          name:
              AqutterPlatformWebViewCreationParamsProperty.onDownloadStartRequest.name,
          description: 'Called when a download is requested.',
          className: className,
          category: 'Download',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onDownloadStarting.name,
          description: 'Called when a download is starting.',
          className: className,
          category: 'Download',
        ),

        // Scroll events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onScrollChanged.name,
          description: 'Called when the scroll position changes.',
          className: className,
          category: 'Scroll',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onOverScrolled.name,
          description: 'Called when the WebView is over-scrolled.',
          className: className,
          category: 'Scroll',
        ),

        // Zoom events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onZoomScaleChanged.name,
          description: 'Called when the zoom scale changes.',
          className: className,
          category: 'Zoom',
        ),

        // Print events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onPrintRequest.name,
          description: 'Called when a print request is made.',
          className: className,
          category: 'Print',
        ),

        // Fullscreen events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onEnterFullscreen.name,
          description: 'Called when entering fullscreen mode.',
          className: className,
          category: 'Fullscreen',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onExitFullscreen.name,
          description: 'Called when exiting fullscreen mode.',
          className: className,
          category: 'Fullscreen',
        ),

        // Permission events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onPermissionRequest.name,
          description: 'Called when a permission is requested.',
          className: className,
          category: 'Permission',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onPermissionRequestCanceled
              .name,
          description: 'Called when a permission request is canceled.',
          className: className,
          category: 'Permission',
        ),

        // Touch/Gesture events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onLongPressHitTestResult
              .name,
          description: 'Called on a long press.',
          className: className,
          category: 'Touch',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onGeolocationPermissionsShowPrompt
              .name,
          description: 'Called when requesting geolocation permission.',
          className: className,
          category: 'Permission',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onGeolocationPermissionsHidePrompt
              .name,
          description: 'Called when hiding geolocation permission prompt.',
          className: className,
          category: 'Permission',
        ),

        // Render Process events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onRenderProcessGone.name,
          description: 'Called when the render process terminates.',
          className: className,
          category: 'Render Process',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onRenderProcessResponsive
              .name,
          description: 'Called when the render process becomes responsive.',
          className: className,
          category: 'Render Process',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onRenderProcessUnresponsive
              .name,
          description: 'Called when the render process becomes unresponsive.',
          className: className,
          category: 'Render Process',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onWebContentProcessDidTerminate
              .name,
          description: 'Called when the web content process terminates.',
          className: className,
          category: 'Render Process',
        ),

        // Form events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onFormResubmission.name,
          description: 'Called when a form is resubmitted.',
          className: className,
          category: 'Form',
        ),

        // Icon events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onReceivedIcon.name,
          description: 'Called when a favicon is received.',
          className: className,
          category: 'Icon',
        ),
        ApiEventDefinition(
          name:
              AqutterPlatformWebViewCreationParamsProperty.onReceivedTouchIconUrl.name,
          description: 'Called when a touch icon URL is received.',
          className: className,
          category: 'Icon',
        ),

        // Safe Browsing events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onSafeBrowsingHit.name,
          description: 'Called when Safe Browsing detects a threat.',
          className: className,
          category: 'Safe Browsing',
        ),

        // iOS/macOS events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onDidReceiveServerRedirectForProvisionalNavigation
              .name,
          description: 'Called when a server redirect is received.',
          className: className,
          category: 'iOS/macOS',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onCameraCaptureStateChanged
              .name,
          description: 'Called when camera capture state changes.',
          className: className,
          category: 'iOS/macOS',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .onMicrophoneCaptureStateChanged
              .name,
          description: 'Called when microphone capture state changes.',
          className: className,
          category: 'iOS/macOS',
        ),

        // Windows events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onProcessFailed.name,
          description: 'Called when a process failure occurs.',
          className: className,
          category: 'Windows',
        ),

        // Other events
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onPageCommitVisible.name,
          description: 'Called when the page becomes visible.',
          className: className,
          category: 'Other',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onContentSizeChanged.name,
          description: 'Called when the content size changes.',
          className: className,
          category: 'Other',
        ),
        ApiEventDefinition(
          name:
              AqutterPlatformWebViewCreationParamsProperty.onAjaxReadyStateChange.name,
          description: 'Called when an AJAX ready state changes.',
          className: className,
          category: 'Other',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty.onAjaxProgress.name,
          description: 'Called for AJAX progress updates.',
          className: className,
          category: 'Other',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .shouldInterceptAjaxRequest
              .name,
          description: 'Called to intercept AJAX requests.',
          className: className,
          category: 'Other',
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewCreationParamsProperty
              .shouldInterceptFetchRequest
              .name,
          description: 'Called to intercept fetch requests.',
          className: className,
          category: 'Other',
        ),
      ],
    );
  }

  static ApiClassDefinition _getHeadlessWebViewDefinition() {
    final className = classNameOf(AqutterHeadlessWebView);
    return ApiClassDefinition(
      className: className,
      description: 'A WebView that runs without UI.',
      isClassSupported: () => AqutterHeadlessWebView.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformHeadlessWebViewMethod.run.name,
          signature: 'Future<void> run()',
          description: 'Runs the headless WebView.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformHeadlessWebViewMethod.isRunning.name,
          signature: 'Future<bool> isRunning()',
          description: 'Checks if the WebView is running.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformHeadlessWebViewMethod.setSize.name,
          signature: 'Future<void> setSize(Size size)',
          description: 'Sets the WebView size.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformHeadlessWebViewMethod.getSize.name,
          signature: 'Future<Size?> getSize()',
          description: 'Gets the WebView size.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformHeadlessWebViewMethod.dispose.name,
          signature: 'Future<void> dispose()',
          description: 'Disposes the headless WebView.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getBrowserDefinition() {
    final className = classNameOf(AqutterBrowser);
    return ApiClassDefinition(
      className: className,
      description: 'A full-screen in-app browser.',
      isClassSupported: () => AqutterBrowser.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformBrowserMethod.openUrlRequest.name,
          signature:
              'Future<void> openUrlRequest({required AqutterURLRequest urlRequest, ...})',
          description: 'Opens a URL in the browser.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformBrowserMethod.openFile.name,
          signature:
              'Future<void> openFile({required String assetFilePath, ...})',
          description: 'Opens a file from assets.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformBrowserMethod.openData.name,
          signature: 'Future<void> openData({required String data, ...})',
          description: 'Opens HTML data.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformBrowserMethod.openWithSystemBrowser.name,
          signature:
              'static Future<void> openWithSystemBrowser({required AqutterWebUri url})',
          description: 'Opens a URL in the system browser.',
          className: className,
          isStatic: true,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformBrowserMethod.show.name,
          signature: 'Future<void> show()',
          description: 'Shows the browser.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformBrowserMethod.hide.name,
          signature: 'Future<void> hide()',
          description: 'Hides the browser.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformBrowserMethod.close.name,
          signature: 'Future<void> close()',
          description: 'Closes the browser.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformBrowserMethod.isHidden.name,
          signature: 'Future<bool> isHidden()',
          description: 'Checks if the browser is hidden.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformBrowserMethod.setSettings.name,
          signature:
              'Future<void> ${AqutterPlatformBrowserMethod.setSettings.name}({required ${AqutterBrowserClassSettings} settings})',
          description: 'Sets the browser settings.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformBrowserMethod.getSettings.name,
          signature:
              'Future<${AqutterBrowserClassSettings}?> ${AqutterPlatformBrowserMethod.getSettings.name}()',
          description: 'Gets the browser settings.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformBrowserMethod.isOpened.name,
          signature: 'bool isOpened()',
          description: 'Checks if the browser is opened.',
          className: className,
        ),
      ],
      events: [
        ApiEventDefinition(
          name: AqutterPlatformBrowserEventsMethod.onBrowserCreated.name,
          description: 'Called when the browser is created.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformBrowserEventsMethod.onExit.name,
          description: 'Called when the browser exits.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformBrowserEventsMethod.onMainWindowWillClose.name,
          description: 'Called when the main window will close.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getChromeSafariBrowserDefinition() {
    final className = classNameOf(AqutterChromeSafariBrowser);
    return ApiClassDefinition(
      className: className,
      description:
          'A browser using Chrome Custom Tabs or SFSafariViewController.',
      isClassSupported: () => AqutterChromeSafariBrowser.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.open.name,
          signature: 'Future<void> open({AqutterWebUri? url, ...})',
          description: 'Opens a URL in the browser.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.launchUrl.name,
          signature: 'Future<void> launchUrl({required AqutterWebUri url, ...})',
          description: 'Launches a URL.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.mayLaunchUrl.name,
          signature: 'Future<bool> mayLaunchUrl({AqutterWebUri? url, ...})',
          description: 'Hints to the browser to start loading a URL.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.validateRelationship.name,
          signature:
              'Future<bool> validateRelationship({required AqutterCustomTabsRelationType relation, ...})',
          description: 'Validates a relationship.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.close.name,
          signature: 'Future<void> close()',
          description: 'Closes the browser.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.isOpened.name,
          signature: 'bool isOpened()',
          description: 'Checks if the browser is opened.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.isAvailable.name,
          signature: 'static Future<bool> isAvailable()',
          description: 'Checks if the browser is available.',
          className: className,
          isStatic: true,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.getMaxToolbarItems.name,
          signature: 'static Future<int> getMaxToolbarItems()',
          description: 'Gets the maximum toolbar items.',
          className: className,
          isStatic: true,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.getPackageName.name,
          signature:
              'static Future<String?> getPackageName({List<String>? packages, ...})',
          description: 'Gets the package name for Custom Tabs.',
          className: className,
          isStatic: true,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.clearWebsiteData.name,
          signature: 'static Future<void> clearWebsiteData()',
          description: 'Clears website data.',
          className: className,
          isStatic: true,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.prewarmConnections.name,
          signature:
              'static Future<AqutterPrewarmingToken?> prewarmConnections({required List<AqutterWebUri> urls})',
          description: 'Prewarms connections.',
          className: className,
          isStatic: true,
        ),
        ApiMethodDefinition(
          name:
              AqutterPlatformChromeSafariBrowserMethod.invalidatePrewarmingToken.name,
          signature:
              'static Future<void> invalidatePrewarmingToken({required AqutterPrewarmingToken prewarmingToken})',
          description: 'Invalidates a prewarming token.',
          className: className,
          isStatic: true,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.setActionButton.name,
          signature:
              'Future<void> ${AqutterPlatformChromeSafariBrowserMethod.setActionButton.name}(${AqutterChromeSafariBrowserActionButton} actionButton)',
          description: 'Sets an action button.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.updateActionButton.name,
          signature:
              'Future<void> updateActionButton({required Uint8List icon, required String description})',
          description: 'Updates the action button.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.setSecondaryToolbar.name,
          signature:
              'Future<void> ${AqutterPlatformChromeSafariBrowserMethod.setSecondaryToolbar.name}(${AqutterChromeSafariBrowserSecondaryToolbar} secondaryToolbar)',
          description: 'Sets a secondary toolbar.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.updateSecondaryToolbar.name,
          signature:
              'Future<void> ${AqutterPlatformChromeSafariBrowserMethod.updateSecondaryToolbar.name}(${AqutterChromeSafariBrowserSecondaryToolbar} secondaryToolbar)',
          description: 'Updates the secondary toolbar.',
          className: className,
        ),
        ApiMethodDefinition(
          name:
              AqutterPlatformChromeSafariBrowserMethod.requestPostMessageChannel.name,
          signature:
              'Future<bool> requestPostMessageChannel({required AqutterWebUri sourceOrigin, ...})',
          description: 'Requests a post message channel.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod.postMessage.name,
          signature:
              'Future<AqutterCustomTabsPostMessageResultType> postMessage({required String message})',
          description: 'Posts a message.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformChromeSafariBrowserMethod
              .isEngagementSignalsApiAvailable
              .name,
          signature: 'Future<bool> isEngagementSignalsApiAvailable()',
          description: 'Checks if engagement signals API is available.',
          className: className,
        ),
      ],
      events: [
        ApiEventDefinition(
          name: AqutterPlatformChromeSafariBrowserEventsMethod.onOpened.name,
          description: 'Called when the browser is opened.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformChromeSafariBrowserEventsMethod.onClosed.name,
          description: 'Called when the browser is closed.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformChromeSafariBrowserEventsMethod
              .onCompletedInitialLoad
              .name,
          description: 'Called when the initial load completes.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformChromeSafariBrowserEventsMethod
              .onInitialLoadDidRedirect
              .name,
          description: 'Called when the initial load redirects.',
          className: className,
        ),
        ApiEventDefinition(
          name:
              AqutterPlatformChromeSafariBrowserEventsMethod.onWillOpenInBrowser.name,
          description: 'Called when opening in the browser.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformChromeSafariBrowserEventsMethod.onNavigationEvent.name,
          description: 'Called on navigation events.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformChromeSafariBrowserEventsMethod.onServiceConnected.name,
          description: 'Called when the service connects.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformChromeSafariBrowserEventsMethod
              .onRelationshipValidationResult
              .name,
          description: 'Called with relationship validation results.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformChromeSafariBrowserEventsMethod
              .onMessageChannelReady
              .name,
          description: 'Called when the message channel is ready.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformChromeSafariBrowserEventsMethod.onPostMessage.name,
          description: 'Called when a post message is received.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformChromeSafariBrowserEventsMethod
              .onVerticalScrollEvent
              .name,
          description: 'Called on vertical scroll events.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformChromeSafariBrowserEventsMethod
              .onGreatestScrollPercentageIncreased
              .name,
          description: 'Called when the greatest scroll percentage increases.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformChromeSafariBrowserEventsMethod.onSessionEnded.name,
          description: 'Called when the session ends.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getCookieManagerDefinition() {
    final className = classNameOf(AqutterCookieManager);
    return ApiClassDefinition(
      className: className,
      description: 'Manages cookies for WebViews.',
      isClassSupported: () => AqutterCookieManager.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformCookieManagerMethod.setCookie.name,
          signature:
              'Future<bool> setCookie({required AqutterWebUri url, required String name, required String value, ...})',
          description: 'Sets a cookie.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformCookieManagerMethod.getCookies.name,
          signature: 'Future<List<AqutterCookie>> getCookies({required AqutterWebUri url})',
          description: 'Gets all cookies for a URL.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformCookieManagerMethod.getCookie.name,
          signature:
              'Future<AqutterCookie?> getCookie({required AqutterWebUri url, required String name})',
          description: 'Gets a specific cookie.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformCookieManagerMethod.deleteCookie.name,
          signature:
              'Future<void> deleteCookie({required AqutterWebUri url, required String name, ...})',
          description: 'Deletes a cookie.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformCookieManagerMethod.deleteCookies.name,
          signature:
              'Future<void> deleteCookies({required AqutterWebUri url, String? domain, String? path})',
          description: 'Deletes cookies for a URL.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformCookieManagerMethod.deleteAllCookies.name,
          signature: 'Future<void> deleteAllCookies()',
          description: 'Deletes all cookies.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformCookieManagerMethod.removeSessionCookies.name,
          signature: 'Future<bool> removeSessionCookies()',
          description: 'Removes all session cookies.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformCookieManagerMethod.flush.name,
          signature: 'Future<void> flush()',
          description: 'Flushes cookies to persistent storage.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformCookieManagerMethod.getAllCookies.name,
          signature: 'Future<List<AqutterCookie>> getAllCookies()',
          description: 'Gets all cookies.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getWebStorageDefinition() {
    final className = classNameOf(AqutterWebStorage);
    return ApiClassDefinition(
      className: className,
      description: 'Manages ${AqutterLocalStorage} and ${AqutterSessionStorage}.',
      isClassSupported: () => AqutterWebStorage.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformLocalStorageMethod.length.name,
          signature: 'Future<int?> length()',
          description: 'Gets the number of items.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformLocalStorageMethod.setItem.name,
          signature:
              'Future<void> setItem({required String key, required dynamic value})',
          description: 'Sets an item.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformLocalStorageMethod.getItem.name,
          signature: 'Future<dynamic> getItem({required String key})',
          description: 'Gets an item.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformLocalStorageMethod.removeItem.name,
          signature: 'Future<void> removeItem({required String key})',
          description: 'Removes an item.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformLocalStorageMethod.getItems.name,
          signature:
              'Future<List<${AqutterWebStorageItem}>> ${AqutterPlatformLocalStorageMethod.getItems.name}()',
          description: 'Gets all items.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformLocalStorageMethod.clear.name,
          signature: 'Future<void> clear()',
          description: 'Clears all items.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformLocalStorageMethod.key.name,
          signature: 'Future<String> key({required int index})',
          description: 'Gets the key at an index.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getFindInteractionControllerDefinition() {
    final className = classNameOf(AqutterFindInteractionController);
    return ApiClassDefinition(
      className: className,
      description: 'Controls find-in-page functionality.',
      isClassSupported: () => AqutterFindInteractionController.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformFindInteractionControllerMethod.findAll.name,
          signature: 'Future<void> findAll({String? find})',
          description: 'Finds all occurrences.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformFindInteractionControllerMethod.findNext.name,
          signature: 'Future<void> findNext({bool forward = true})',
          description: 'Finds the next occurrence.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformFindInteractionControllerMethod.clearMatches.name,
          signature: 'Future<void> clearMatches()',
          description: 'Clears all matches.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformFindInteractionControllerMethod.setSearchText.name,
          signature: 'Future<void> setSearchText(String? searchText)',
          description: 'Sets the search text.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformFindInteractionControllerMethod.getSearchText.name,
          signature: 'Future<String?> getSearchText()',
          description: 'Gets the search text.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformFindInteractionControllerMethod
              .isFindNavigatorVisible
              .name,
          signature: 'Future<bool?> isFindNavigatorVisible()',
          description: 'Checks if the find navigator is visible.',
          className: className,
        ),
        ApiMethodDefinition(
          name:
              AqutterPlatformFindInteractionControllerMethod.presentFindNavigator.name,
          signature: 'Future<void> presentFindNavigator()',
          description: 'Presents the find navigator.',
          className: className,
        ),
        ApiMethodDefinition(
          name:
              AqutterPlatformFindInteractionControllerMethod.dismissFindNavigator.name,
          signature: 'Future<void> dismissFindNavigator()',
          description: 'Dismisses the find navigator.',
          className: className,
        ),
        ApiMethodDefinition(
          name:
              AqutterPlatformFindInteractionControllerMethod.getActiveFindSession.name,
          signature: 'Future<AqutterFindSession?> getActiveFindSession()',
          description: 'Gets the active find session.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformFindInteractionControllerMethod.dispose.name,
          signature: 'void dispose()',
          description: 'Disposes the controller.',
          className: className,
        ),
      ],
      events: [
        ApiEventDefinition(
          name: AqutterPlatformFindInteractionControllerCreationParamsProperty
              .onFindResultReceived
              .name,
          description: 'Called when find results are received.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getPullToRefreshControllerDefinition() {
    final className = classNameOf(AqutterPullToRefreshController);
    return ApiClassDefinition(
      className: className,
      description: 'Controls pull-to-refresh functionality.',
      isClassSupported: () => AqutterPullToRefreshController.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformPullToRefreshControllerMethod.setEnabled.name,
          signature: 'Future<void> setEnabled(bool enabled)',
          description: 'Enables or disables pull-to-refresh.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPullToRefreshControllerMethod.isEnabled.name,
          signature: 'Future<bool> isEnabled()',
          description: 'Checks if pull-to-refresh is enabled.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPullToRefreshControllerMethod.beginRefreshing.name,
          signature: 'Future<void> beginRefreshing()',
          description: 'Starts the refresh animation.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPullToRefreshControllerMethod.endRefreshing.name,
          signature: 'Future<void> endRefreshing()',
          description: 'Stops the refresh animation.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPullToRefreshControllerMethod.isRefreshing.name,
          signature: 'Future<bool> isRefreshing()',
          description: 'Checks if currently refreshing.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPullToRefreshControllerMethod.setColor.name,
          signature: 'Future<void> setColor(Color color)',
          description: 'Sets the indicator color.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPullToRefreshControllerMethod.setBackgroundColor.name,
          signature: 'Future<void> setBackgroundColor(Color color)',
          description: 'Sets the background color.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPullToRefreshControllerMethod
              .setDistanceToTriggerSync
              .name,
          signature:
              'Future<void> setDistanceToTriggerSync(double distanceToTrigger)',
          description: 'Sets the distance to trigger refresh.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPullToRefreshControllerMethod.setSlingshotDistance.name,
          signature:
              'Future<void> setSlingshotDistance(double slingshotDistance)',
          description: 'Sets the slingshot distance.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPullToRefreshControllerMethod
              .getDefaultSlingshotDistance
              .name,
          signature: 'Future<double> getDefaultSlingshotDistance()',
          description: 'Gets the default slingshot distance.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPullToRefreshControllerMethod.setIndicatorSize.name,
          signature: 'Future<void> setIndicatorSize(AqutterPullToRefreshSize size)',
          description: 'Sets the indicator size.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPullToRefreshControllerMethod.dispose.name,
          signature: 'void dispose()',
          description: 'Disposes the controller.',
          className: className,
        ),
      ],
      events: [
        ApiEventDefinition(
          name: AqutterPlatformPullToRefreshControllerCreationParamsProperty
              .onRefresh
              .name,
          description: 'Called when a refresh is triggered.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getPrintJobControllerDefinition() {
    final className = classNameOf(AqutterPrintJobController);
    return ApiClassDefinition(
      className: className,
      description: 'Controls print jobs.',
      isClassSupported: () => AqutterPrintJobController.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformPrintJobControllerMethod.cancel.name,
          signature: 'Future<void> cancel()',
          description: 'Cancels the print job.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPrintJobControllerMethod.restart.name,
          signature: 'Future<void> restart()',
          description: 'Restarts the print job.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPrintJobControllerMethod.dismiss.name,
          signature: 'Future<void> dismiss({bool animated = true})',
          description: 'Dismisses the print interface.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformPrintJobControllerMethod.getInfo.name,
          signature: 'Future<AqutterPrintJobInfo?> getInfo()',
          description: 'Gets the print job info.',
          className: className,
        ),
      ],
      events: [
        ApiEventDefinition(
          name: AqutterPlatformPrintJobControllerProperty.onComplete.name,
          description: 'Called when the print job completes.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getWebAuthenticationSessionDefinition() {
    final className = classNameOf(AqutterWebAuthenticationSession);
    return ApiClassDefinition(
      className: className,
      description: 'Handles web authentication sessions.',
      isClassSupported: () => AqutterWebAuthenticationSession.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformWebAuthenticationSessionMethod.create.name,
          signature:
              'static Future<${AqutterWebAuthenticationSession}> ${AqutterPlatformWebAuthenticationSessionMethod.create.name}({...})',
          description: 'Creates a new authentication session.',
          className: className,
          isStatic: true,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebAuthenticationSessionMethod.canStart.name,
          signature: 'Future<bool> canStart()',
          description: 'Checks if the session can start.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebAuthenticationSessionMethod.start.name,
          signature: 'Future<void> start()',
          description: 'Starts the authentication session.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebAuthenticationSessionMethod.cancel.name,
          signature: 'Future<void> cancel()',
          description: 'Cancels the session.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebAuthenticationSessionMethod.dispose.name,
          signature: 'Future<void> dispose()',
          description: 'Disposes the session.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebAuthenticationSessionMethod.isAvailable.name,
          signature: 'static Future<bool> isAvailable()',
          description: 'Checks if web authentication is available.',
          className: className,
          isStatic: true,
        ),
      ],
      events: [
        ApiEventDefinition(
          name: AqutterPlatformWebAuthenticationSessionProperty.onComplete.name,
          description: 'Called when authentication completes.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getServiceWorkerControllerDefinition() {
    final className = classNameOf(AqutterServiceWorkerController);
    return ApiClassDefinition(
      className: className,
      description: 'Controls service workers.',
      isClassSupported: () => AqutterServiceWorkerController.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name:
              AqutterPlatformServiceWorkerControllerMethod.setServiceWorkerClient.name,
          signature:
              'Future<void> setServiceWorkerClient(AqutterServiceWorkerClient? value)',
          description: 'Sets the service worker client.',
          className: className,
        ),
        ApiMethodDefinition(
          name:
              AqutterPlatformServiceWorkerControllerMethod.getAllowContentAccess.name,
          signature: 'Future<bool> getAllowContentAccess()',
          description: 'Gets allow content access setting.',
          className: className,
        ),
        ApiMethodDefinition(
          name:
              AqutterPlatformServiceWorkerControllerMethod.setAllowContentAccess.name,
          signature: 'Future<void> setAllowContentAccess(bool allow)',
          description: 'Sets allow content access setting.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformServiceWorkerControllerMethod.getAllowFileAccess.name,
          signature: 'Future<bool> getAllowFileAccess()',
          description: 'Gets allow file access setting.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformServiceWorkerControllerMethod.setAllowFileAccess.name,
          signature: 'Future<void> setAllowFileAccess(bool allow)',
          description: 'Sets allow file access setting.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformServiceWorkerControllerMethod.getBlockNetworkLoads.name,
          signature: 'Future<bool> getBlockNetworkLoads()',
          description: 'Gets block network loads setting.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformServiceWorkerControllerMethod.setBlockNetworkLoads.name,
          signature: 'Future<void> setBlockNetworkLoads(bool block)',
          description: 'Sets block network loads setting.',
          className: className,
        ),
      ],
      events: [
        ApiEventDefinition(
          name: AqutterServiceWorkerClientProperty.shouldInterceptRequest.name,
          description: 'Called to intercept service worker requests.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getProxyControllerDefinition() {
    final className = classNameOf(AqutterProxyController);
    return ApiClassDefinition(
      className: className,
      description: 'Controls proxy settings.',
      isClassSupported: () => AqutterProxyController.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformProxyControllerMethod.setProxyOverride.name,
          signature:
              'Future<void> setProxyOverride({required AqutterProxySettings settings})',
          description: 'Sets the proxy override.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformProxyControllerMethod.clearProxyOverride.name,
          signature: 'Future<void> clearProxyOverride()',
          description: 'Clears the proxy override.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getTracingControllerDefinition() {
    final className = classNameOf(AqutterTracingController);
    return ApiClassDefinition(
      className: className,
      description: 'Controls tracing.',
      isClassSupported: () => AqutterTracingController.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformTracingControllerMethod.start.name,
          signature: 'Future<void> start({required AqutterTracingSettings settings})',
          description: 'Starts tracing.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformTracingControllerMethod.stop.name,
          signature: 'Future<bool> stop({String? filePath})',
          description: 'Stops tracing.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformTracingControllerMethod.isTracing.name,
          signature: 'Future<bool> isTracing()',
          description: 'Checks if tracing is active.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getHttpAuthCredentialDatabaseDefinition() {
    final className = classNameOf(AqutterHttpAuthCredentialDatabase);
    return ApiClassDefinition(
      className: className,
      description: 'Manages HTTP authentication credentials.',
      isClassSupported: () => AqutterHttpAuthCredentialDatabase.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformHttpAuthCredentialDatabaseMethod
              .getAllAuthCredentials
              .name,
          signature:
              'Future<List<AqutterURLProtectionSpaceHttpAuthCredentials>> getAllAuthCredentials()',
          description: 'Gets all stored credentials.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformHttpAuthCredentialDatabaseMethod
              .getHttpAuthCredentials
              .name,
          signature:
              'Future<List<AqutterURLCredential>> getHttpAuthCredentials({...})',
          description: 'Gets credentials for a protection space.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformHttpAuthCredentialDatabaseMethod
              .setHttpAuthCredential
              .name,
          signature: 'Future<void> setHttpAuthCredential({...})',
          description: 'Sets a credential.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformHttpAuthCredentialDatabaseMethod
              .removeHttpAuthCredential
              .name,
          signature: 'Future<void> removeHttpAuthCredential({...})',
          description: 'Removes a credential.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformHttpAuthCredentialDatabaseMethod
              .removeHttpAuthCredentials
              .name,
          signature: 'Future<void> removeHttpAuthCredentials({...})',
          description: 'Removes all credentials for a protection space.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformHttpAuthCredentialDatabaseMethod
              .clearAllAuthCredentials
              .name,
          signature: 'Future<void> clearAllAuthCredentials()',
          description: 'Clears all credentials.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getWebViewEnvironmentDefinition() {
    final className = classNameOf(AqutterWebViewEnvironment);
    return ApiClassDefinition(
      className: className,
      description: 'WebView2 environment for Windows.',
      isClassSupported: () => AqutterWebViewEnvironment.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformWebViewEnvironmentMethod.create.name,
          signature:
              'static Future<${AqutterWebViewEnvironment}> ${AqutterPlatformWebViewEnvironmentMethod.create.name}({...})',
          description: 'Creates a WebView environment.',
          className: className,
          isStatic: true,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewEnvironmentMethod.getAvailableVersion.name,
          signature:
              'static Future<String?> getAvailableVersion({String? browserExecutableFolder})',
          description: 'Gets the available WebView2 version.',
          className: className,
          isStatic: true,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewEnvironmentMethod.getProcessInfos.name,
          signature: 'Future<List<AqutterBrowserProcessInfo>> getProcessInfos()',
          description: 'Gets running process information.',
          className: className,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewEnvironmentMethod.compareBrowserVersions.name,
          signature: 'static Future<int> compareBrowserVersions({...})',
          description: 'Compares browser versions.',
          className: className,
          isStatic: true,
        ),
        ApiMethodDefinition(
          name: AqutterPlatformWebViewEnvironmentMethod.dispose.name,
          signature: 'Future<void> dispose()',
          description: 'Disposes the environment.',
          className: className,
        ),
      ],
      events: [
        ApiEventDefinition(
          name: AqutterPlatformWebViewEnvironmentProperty.onBrowserProcessExited.name,
          description: 'Called when the browser process exits.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewEnvironmentProperty.onProcessInfosChanged.name,
          description: 'Called when process info changes.',
          className: className,
        ),
        ApiEventDefinition(
          name: AqutterPlatformWebViewEnvironmentProperty
              .onNewBrowserVersionAvailable
              .name,
          description: 'Called when a new browser version is available.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getProcessGlobalConfigDefinition() {
    final className = classNameOf(AqutterProcessGlobalConfig);
    return ApiClassDefinition(
      className: className,
      description: 'Global process configuration for Android.',
      isClassSupported: () => AqutterProcessGlobalConfig.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformProcessGlobalConfigMethod.apply.name,
          signature:
              'Future<void> ${AqutterPlatformProcessGlobalConfigMethod.apply.name}({required ${AqutterProcessGlobalConfigSettings} settings})',
          description: 'Applies global configuration settings.',
          className: className,
        ),
      ],
    );
  }

  static ApiClassDefinition _getWebMessageChannelDefinition() {
    final className = classNameOf(AqutterWebMessageChannel);
    return ApiClassDefinition(
      className: className,
      description: 'HTML5 message channel for two-way communication.',
      isClassSupported: () => AqutterWebMessageChannel.isClassSupported(),
      methods: [
        ApiMethodDefinition(
          name: AqutterPlatformWebMessageChannelMethod.dispose.name,
          signature: 'void dispose()',
          description: 'Disposes the channel.',
          className: className,
        ),
      ],
    );
  }
}
