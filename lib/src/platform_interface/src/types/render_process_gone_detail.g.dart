// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'render_process_gone_detail.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that provides more specific information about why the render process exited.
///It is used by the [AqutterPlatformWebViewCreationParams.onRenderProcessGone] event.
class AqutterRenderProcessGoneDetail {
  ///Indicates whether the render process was observed to crash, or whether it was killed by the system.
  ///
  ///If the render process was killed, this is most likely caused by the system being low on memory.
  bool didCrash;

  /// Returns the renderer priority that was set at the time that the renderer exited. This may be greater than the priority that
  /// any individual `WebView` requested using [].
  AqutterRendererPriority? rendererPriorityAtExit;
  AqutterRenderProcessGoneDetail({
    required this.didCrash,
    this.rendererPriorityAtExit,
  });

  ///Gets a possible [AqutterRenderProcessGoneDetail] instance from a [Map] value.
  static AqutterRenderProcessGoneDetail? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterRenderProcessGoneDetail(
      didCrash: map['didCrash'],
      rendererPriorityAtExit: switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterRendererPriority.fromNativeValue(
            map['rendererPriorityAtExit'],
          ),
        AqutterEnumMethod.value => AqutterRendererPriority.fromValue(
          map['rendererPriorityAtExit'],
        ),
        AqutterEnumMethod.name => AqutterRendererPriority.byName(
          map['rendererPriorityAtExit'],
        ),
      },
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "didCrash": didCrash,
      "rendererPriorityAtExit": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          rendererPriorityAtExit?.toNativeValue(),
        AqutterEnumMethod.value => rendererPriorityAtExit?.toValue(),
        AqutterEnumMethod.name => rendererPriorityAtExit?.name(),
      },
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterRenderProcessGoneDetail{didCrash: $didCrash, rendererPriorityAtExit: $rendererPriorityAtExit}';
  }
}
