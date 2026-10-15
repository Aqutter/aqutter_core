import 'types/main.dart';

///Class that represents a set of rules to use block content in the browser window.
///
///On iOS and MacOS, it uses [WKContentRuleListStore](https://developer.apple.com/documentation/webkit/wkcontentruleliststore).
///On Android, it uses a custom implementation because such functionality doesn't exist.
///
///In general, this [article](https://developer.apple.com/documentation/safariservices/creating_a_content_blocker) can be used to get an overview about this functionality
///but on Android there are two types of [action] that are unavailable: `block-cookies` and `ignore-previous-rules`.
class AqutterContentBlocker {
  ///Trigger of the content blocker. The trigger tells to the WebView when to perform the corresponding action.
  AqutterContentBlockerTrigger trigger;

  ///Action associated to the trigger. The action tells to the WebView what to do when the trigger is matched.
  AqutterContentBlockerAction action;

  AqutterContentBlocker({required this.trigger, required this.action});

  Map<String, Map<String, dynamic>> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "trigger": trigger.toMap(enumMethod: enumMethod),
      "action": action.toMap(enumMethod: enumMethod),
    };
  }

  static AqutterContentBlocker fromMap(
    Map<dynamic, Map<dynamic, dynamic>> map, {
    AqutterEnumMethod? enumMethod,
  }) {
    return AqutterContentBlocker(
      trigger: AqutterContentBlockerTrigger.fromMap(
        Map<String, dynamic>.from(map["trigger"]!),
        enumMethod: enumMethod,
      ),
      action: AqutterContentBlockerAction.fromMap(
        Map<String, dynamic>.from(map["action"]!),
        enumMethod: enumMethod,
      ),
    );
  }

  @override
  String toString() {
    return 'AqutterContentBlocker{trigger: $trigger, action: $action}';
  }
}

///Trigger of the content blocker. The trigger tells to the WebView when to perform the corresponding action.
///A trigger dictionary must include an [AqutterContentBlockerTrigger.urlFilter], which specifies a pattern to match the URL against.
///The remaining properties are optional and modify the behavior of the trigger.
///For example, you can limit the trigger to specific domains or have it not apply when a match is found on a specific domain.
class AqutterContentBlockerTrigger {
  ///A regular expression pattern to match the URL against.
  String urlFilter;

  ///A list of regular expressions to match iframes URL against.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS
  ///- MacOS
  List<String> ifFrameUrl;

  ///A Boolean value indicating if the URL matching should be case-sensitive.
  ///The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android native WebView
  ///- iOS
  ///- MacOS
  bool urlFilterIsCaseSensitive;

  ///A list of [AqutterContentBlockerTriggerResourceType] representing the resource types
  ///(how the browser intends to use the resource) that the rule should match.
  ///If not specified, the rule matches all resource types.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android native WebView
  ///- iOS
  ///- MacOS
  List<AqutterContentBlockerTriggerResourceType> resourceType;

  ///A list of strings matched to a URL's domain; limits action to a list of specific domains.
  ///Values must be lowercase ASCII, or punycode for non-ASCII.
  ///Add * in front to match domain and subdomains. Can't be used with [AqutterContentBlockerTrigger.unlessDomain].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android native WebView
  ///- iOS
  ///- MacOS
  List<String> ifDomain;

  ///A list of strings matched to a URL's domain; acts on any site except domains in a provided list.
  ///Values must be lowercase ASCII, or punycode for non-ASCII.
  ///Add * in front to match domain and subdomains. Can't be used with [AqutterContentBlockerTrigger.ifDomain].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android native WebView
  ///- iOS
  ///- MacOS
  List<String> unlessDomain;

  ///A list of [AqutterContentBlockerTriggerLoadType] that can include one of two mutually exclusive values.
  ///If not specified, the rule matches all load types.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android native WebView
  ///- iOS
  ///- MacOS
  List<AqutterContentBlockerTriggerLoadType> loadType;

  ///A list of strings matched to the entire main document URL; limits the action to a specific list of URL patterns.
  ///Values must be lowercase ASCII, or punycode for non-ASCII. Can't be used with [AqutterContentBlockerTrigger.unlessTopUrl].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android native WebView
  ///- iOS
  ///- MacOS
  List<String> ifTopUrl;

  ///An array of strings matched to the entire main document URL; acts on any site except URL patterns in provided list.
  ///Values must be lowercase ASCII, or punycode for non-ASCII. Can't be used with [AqutterContentBlockerTrigger.ifTopUrl].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android native WebView
  ///- iOS
  ///- MacOS
  List<String> unlessTopUrl;

  ///An array of strings that specify loading contexts.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS
  ///- MacOS
  List<AqutterContentBlockerTriggerLoadContext> loadContext;

  AqutterContentBlockerTrigger({
    required this.urlFilter,
    this.ifFrameUrl = const <String>[],
    this.urlFilterIsCaseSensitive = false,
    this.resourceType = const <AqutterContentBlockerTriggerResourceType>[],
    this.ifDomain = const <String>[],
    this.unlessDomain = const <String>[],
    this.loadType = const <AqutterContentBlockerTriggerLoadType>[],
    this.ifTopUrl = const <String>[],
    this.unlessTopUrl = const <String>[],
    this.loadContext = const <AqutterContentBlockerTriggerLoadContext>[],
  }) {
    assert(!(this.ifDomain.isEmpty || this.unlessDomain.isEmpty) == false);
    assert(this.loadType.length <= 2);
    assert(!(this.ifTopUrl.isEmpty || this.unlessTopUrl.isEmpty) == false);
  }

  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    List<String> resourceTypeStringList = [];
    resourceType.forEach((type) {
      switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        case AqutterEnumMethod.nativeValue:
          if (type.isSupported()) {
            resourceTypeStringList.add(type.toNativeValue()!);
          }
          break;
        case AqutterEnumMethod.value:
          resourceTypeStringList.add(type.toValue());
          break;
        case AqutterEnumMethod.name:
          resourceTypeStringList.add(type.name());
          break;
      }
    });
    List<String> loadTypeStringList = [];
    loadType.forEach((type) {
      switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        case AqutterEnumMethod.nativeValue:
          if (type.isSupported()) {
            loadTypeStringList.add(type.toNativeValue()!);
          }
          break;
        case AqutterEnumMethod.value:
          loadTypeStringList.add(type.toValue());
          break;
        case AqutterEnumMethod.name:
          loadTypeStringList.add(type.name());
          break;
      }
    });
    List<String> loadContextStringList = [];
    loadContext.forEach((type) {
      switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        case AqutterEnumMethod.nativeValue:
          if (type.isSupported()) {
            loadContextStringList.add(type.toNativeValue()!);
          }
          break;
        case AqutterEnumMethod.value:
          loadContextStringList.add(type.toValue());
          break;
        case AqutterEnumMethod.name:
          loadContextStringList.add(type.name());
          break;
      }
    });

    Map<String, dynamic> map = {
      "url-filter": urlFilter,
      "if-frame-url": ifFrameUrl,
      "url-filter-is-case-sensitive": urlFilterIsCaseSensitive,
      "if-domain": ifDomain,
      "unless-domain": unlessDomain,
      "resource-type": resourceTypeStringList,
      "load-type": loadTypeStringList,
      "if-top-url": ifTopUrl,
      "unless-top-url": unlessTopUrl,
      "load-context": loadContextStringList,
    };

    map.keys
        .where(
          (key) =>
              map[key] == null ||
              (map[key] is List && (map[key] as List).length == 0),
        ) // filter keys
        .toList() // create a copy to avoid concurrent modifications
        .forEach(map.remove);

    return map;
  }

  static AqutterContentBlockerTrigger fromMap(
    Map<String, dynamic> map, {
    AqutterEnumMethod? enumMethod,
  }) {
    List<AqutterContentBlockerTriggerResourceType> resourceType = [];
    List<AqutterContentBlockerTriggerLoadType> loadType = [];
    List<AqutterContentBlockerTriggerLoadContext> loadContext = [];

    List<String> resourceTypeStringList = List<String>.from(
      map["resource-type"] ?? [],
    );
    resourceTypeStringList.forEach((typeValue) {
      var type = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterContentBlockerTriggerResourceType.fromNativeValue(typeValue),
        AqutterEnumMethod.value => AqutterContentBlockerTriggerResourceType.fromValue(
          typeValue,
        ),
        AqutterEnumMethod.name => AqutterContentBlockerTriggerResourceType.byName(typeValue),
      };
      if (type != null) {
        resourceType.add(type);
      }
    });

    List<String> loadTypeStringList = List<String>.from(map["load-type"] ?? []);
    loadTypeStringList.forEach((typeValue) {
      var type = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterContentBlockerTriggerLoadType.fromNativeValue(
          typeValue,
        ),
        AqutterEnumMethod.value => AqutterContentBlockerTriggerLoadType.fromValue(typeValue),
        AqutterEnumMethod.name => AqutterContentBlockerTriggerLoadType.byName(typeValue),
      };
      if (type != null) {
        loadType.add(type);
      }
    });

    List<String> loadContextStringList = List<String>.from(
      map["load-context"] ?? [],
    );
    loadContextStringList.forEach((typeValue) {
      var context = switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterContentBlockerTriggerLoadContext.fromNativeValue(typeValue),
        AqutterEnumMethod.value => AqutterContentBlockerTriggerLoadContext.fromValue(
          typeValue,
        ),
        AqutterEnumMethod.name => AqutterContentBlockerTriggerLoadContext.byName(typeValue),
      };
      if (context != null) {
        loadContext.add(context);
      }
    });

    return AqutterContentBlockerTrigger(
      urlFilter: map["url-filter"],
      ifFrameUrl: List<String>.from(map["if-frame-url"] ?? []),
      urlFilterIsCaseSensitive: map["url-filter-is-case-sensitive"],
      ifDomain: List<String>.from(map["if-domain"] ?? []),
      unlessDomain: List<String>.from(map["unless-domain"] ?? []),
      resourceType: resourceType,
      loadType: loadType,
      ifTopUrl: List<String>.from(map["if-top-url"] ?? []),
      unlessTopUrl: List<String>.from(map["unless-top-url"] ?? []),
      loadContext: loadContext,
    );
  }

  @override
  String toString() {
    return 'AqutterContentBlockerTrigger{urlFilter: $urlFilter, ifFrameUrl: $ifFrameUrl, urlFilterIsCaseSensitive: $urlFilterIsCaseSensitive, resourceType: $resourceType, ifDomain: $ifDomain, unlessDomain: $unlessDomain, loadType: $loadType, ifTopUrl: $ifTopUrl, unlessTopUrl: $unlessTopUrl, loadContext: $loadContext}';
  }
}

///Action associated to the trigger. The action tells to the WebView what to do when the trigger is matched.
///When a trigger matches a resource, the browser queues the associated action for execution.
///The WebView evaluates all the triggers, it executes the actions in order.
///When a domain matches a trigger, all rules after the triggered rule that specify the same action are skipped.
///Group the rules with similar actions together to improve performance.
class AqutterContentBlockerAction {
  ///Type of the action.
  AqutterContentBlockerActionType type;

  ///If the action type is [AqutterContentBlockerActionType.CSS_DISPLAY_NONE], then also the [selector] property is required, otherwise it is ignored.
  ///It specify a string that defines a selector list. Use CSS identifiers as the individual selector values, separated by commas.
  String? selector;

  AqutterContentBlockerAction({required this.type, this.selector}) {
    if (this.type == AqutterContentBlockerActionType.CSS_DISPLAY_NONE) {
      assert(this.selector != null);
    }
  }

  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    Map<String, dynamic> map = {
      "type": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => type.toNativeValue(),
        AqutterEnumMethod.value => type.toValue(),
        AqutterEnumMethod.name => type.name(),
      },
      "selector": selector,
    };

    map.keys
        .where(
          (key) =>
              map[key] == null ||
              (map[key] is List && (map[key] as List).length == 0),
        ) // filter keys
        .toList() // create a copy to avoid concurrent modifications
        .forEach(map.remove);

    return map;
  }

  static AqutterContentBlockerAction fromMap(
    Map<String, dynamic> map, {
    AqutterEnumMethod? enumMethod,
  }) {
    return AqutterContentBlockerAction(
      type: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => AqutterContentBlockerActionType.fromNativeValue(
          map["type"],
        ),
        AqutterEnumMethod.value => AqutterContentBlockerActionType.fromValue(map["type"]),
        AqutterEnumMethod.name => AqutterContentBlockerActionType.byName(map["type"]),
      }!,
      selector: map["selector"],
    );
  }

  @override
  String toString() {
    return 'AqutterContentBlockerAction{type: $type, selector: $selector}';
  }
}
