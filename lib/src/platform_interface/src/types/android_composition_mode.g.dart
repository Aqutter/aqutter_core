// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'android_composition_mode.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents how the Android WebView is composited with the Flutter UI,
///used by `AqutterWebViewSettings.androidCompositionMode`.
///
///Leaving that setting unset picks a mode automatically: [HYBRID_COMPOSITION_PLUS_PLUS] where
///it is available, [TEXTURE_LAYER_HYBRID_COMPOSITION] everywhere else. These members exist to
///pin one mode explicitly.
class AqutterAndroidCompositionMode {
  final int _value;
  final int? _nativeValue;
  const AqutterAndroidCompositionMode._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterAndroidCompositionMode._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterAndroidCompositionMode._internal(value, nativeValue());

  ///Hybrid Composition: the WebView is placed in the real Android view hierarchy and Flutter
  ///draws its own content into `FlutterImageView`s above it. Full native fidelity, but Flutter
  ///pays to composite everything drawn over the WebView and the raster and platform threads
  ///are merged.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  static final HYBRID_COMPOSITION =
      AqutterAndroidCompositionMode._internalMultiPlatform(1, () {
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            return 1;
          default:
            break;
        }
        return null;
      });

  ///Hybrid Composition++: the WebView and Flutter each draw into their own native Surface and
  ///SurfaceFlinger composites them. Full native fidelity without the thread merge.
  ///
  ///**Requires Android API 34+, Impeller running on Vulkan, and the embedding application to
  ///opt in.** A plugin cannot turn HCPP on for the application. The app opts in by declaring
  ///
  ///```xml
  ///<meta-data android:name="io.flutter.embedding.android.EnableHcpp" android:value="true" />
  ///```
  ///
  ///in its `AndroidManifest.xml` (this is what release builds use), or by running with
  ///`flutter run --enable-hcpp` during development.
  ///
  ///When any requirement is missing the WebView falls back to
  ///[TEXTURE_LAYER_HYBRID_COMPOSITION]; nothing throws and nothing goes blank.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 34+
  static final HYBRID_COMPOSITION_PLUS_PLUS =
      AqutterAndroidCompositionMode._internalMultiPlatform(2, () {
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            return 2;
          default:
            break;
        }
        return null;
      });

  ///Texture Layer Hybrid Composition: the WebView draws into a texture that Flutter composites.
  ///Flutter only pays for its own composition, and the raster and platform threads stay separate.
  ///This is the default.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  static final TEXTURE_LAYER_HYBRID_COMPOSITION =
      AqutterAndroidCompositionMode._internalMultiPlatform(0, () {
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            return 0;
          default:
            break;
        }
        return null;
      });

  ///Set of all values of [AqutterAndroidCompositionMode].
  static final Set<AqutterAndroidCompositionMode> values = [
    AqutterAndroidCompositionMode.HYBRID_COMPOSITION,
    AqutterAndroidCompositionMode.HYBRID_COMPOSITION_PLUS_PLUS,
    AqutterAndroidCompositionMode.TEXTURE_LAYER_HYBRID_COMPOSITION,
  ].toSet();

  ///Gets a possible [AqutterAndroidCompositionMode] instance from [int] value.
  static AqutterAndroidCompositionMode? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidCompositionMode.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterAndroidCompositionMode] instance from a native value.
  static AqutterAndroidCompositionMode? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterAndroidCompositionMode.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterAndroidCompositionMode] instance value with name [name].
  ///
  /// Goes through [AqutterAndroidCompositionMode.values] looking for a value with
  /// name [name], as reported by [AqutterAndroidCompositionMode.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterAndroidCompositionMode? byName(String? name) {
    if (name != null) {
      try {
        return AqutterAndroidCompositionMode.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterAndroidCompositionMode] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterAndroidCompositionMode> asNameMap() =>
      <String, AqutterAndroidCompositionMode>{
        for (final value in AqutterAndroidCompositionMode.values)
          value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 1:
        return 'HYBRID_COMPOSITION';
      case 2:
        return 'HYBRID_COMPOSITION_PLUS_PLUS';
      case 0:
        return 'TEXTURE_LAYER_HYBRID_COMPOSITION';
    }
    return _value.toString();
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(value) => value == _value;

  ///Checks if the value is supported by the [defaultTargetPlatform].
  bool isSupported() {
    return _nativeValue != null;
  }

  @override
  String toString() {
    return name();
  }
}
