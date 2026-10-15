// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'renderer_priority_policy.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the priority policy will be used to determine whether an out of process renderer should be considered to be a target for OOM killing.
///When a WebView is destroyed it will cease to be considerered when calculating the renderer priority.
///Once no WebViews remain associated with the renderer, the priority of the renderer will be reduced to [AqutterRendererPriority.RENDERER_PRIORITY_WAIVED].
///The default policy is to set the priority to [AqutterRendererPriority.RENDERER_PRIORITY_IMPORTANT] regardless of visibility,
///and this should not be changed unless the caller also handles renderer crashes with [AqutterPlatformWebViewCreationParams.onRenderProcessGone].
///Any other setting will result in WebView renderers being killed by the system more aggressively than the application.
class AqutterRendererPriorityPolicy {
  ///The minimum priority at which this WebView desires the renderer process to be bound.
  AqutterRendererPriority? rendererRequestedPriority;

  ///If `true`, this flag specifies that when this WebView is not visible, it will be treated as if it had requested a priority of [AqutterRendererPriority.RENDERER_PRIORITY_WAIVED].
  bool waivedWhenNotVisible;
  AqutterRendererPriorityPolicy({
    this.rendererRequestedPriority,
    required this.waivedWhenNotVisible,
  });

  ///Gets a possible [AqutterRendererPriorityPolicy] instance from a [Map] value.
  static AqutterRendererPriorityPolicy? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterRendererPriorityPolicy(
      rendererRequestedPriority: switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterRendererPriority.fromNativeValue(
            map['rendererRequestedPriority'],
          ),
        AqutterEnumMethod.value => AqutterRendererPriority.fromValue(
          map['rendererRequestedPriority'],
        ),
        AqutterEnumMethod.name => AqutterRendererPriority.byName(
          map['rendererRequestedPriority'],
        ),
      },
      waivedWhenNotVisible: map['waivedWhenNotVisible'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "rendererRequestedPriority": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          rendererRequestedPriority?.toNativeValue(),
        AqutterEnumMethod.value => rendererRequestedPriority?.toValue(),
        AqutterEnumMethod.name => rendererRequestedPriority?.name(),
      },
      "waivedWhenNotVisible": waivedWhenNotVisible,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterRendererPriorityPolicy{rendererRequestedPriority: $rendererRequestedPriority, waivedWhenNotVisible: $waivedWhenNotVisible}';
  }
}
