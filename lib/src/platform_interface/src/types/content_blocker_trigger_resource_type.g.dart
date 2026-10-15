// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_blocker_trigger_resource_type.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class that represents the possible resource type defined for a [AqutterContentBlockerTrigger].
class AqutterContentBlockerTriggerResourceType {
  final String _value;
  final String? _nativeValue;
  const AqutterContentBlockerTriggerResourceType._internal(
    this._value,
    this._nativeValue,
  );
  // ignore: unused_element
  factory AqutterContentBlockerTriggerResourceType._internalMultiPlatform(
    String value,
    Function nativeValue,
  ) => AqutterContentBlockerTriggerResourceType._internal(value, nativeValue());
  static const DOCUMENT = AqutterContentBlockerTriggerResourceType._internal(
    'document',
    'document',
  );
  static const FONT = AqutterContentBlockerTriggerResourceType._internal(
    'font',
    'font',
  );
  static const IMAGE = AqutterContentBlockerTriggerResourceType._internal(
    'image',
    'image',
  );
  static const MEDIA = AqutterContentBlockerTriggerResourceType._internal(
    'media',
    'media',
  );

  ///Any untyped load
  static const RAW = AqutterContentBlockerTriggerResourceType._internal(
    'raw',
    'raw',
  );
  static const SCRIPT = AqutterContentBlockerTriggerResourceType._internal(
    'script',
    'script',
  );
  static const STYLE_SHEET = AqutterContentBlockerTriggerResourceType._internal(
    'style-sheet',
    'style-sheet',
  );
  static const SVG_DOCUMENT =
      AqutterContentBlockerTriggerResourceType._internal(
        'svg-document',
        'svg-document',
      );

  ///Set of all values of [AqutterContentBlockerTriggerResourceType].
  static final Set<AqutterContentBlockerTriggerResourceType> values = [
    AqutterContentBlockerTriggerResourceType.DOCUMENT,
    AqutterContentBlockerTriggerResourceType.FONT,
    AqutterContentBlockerTriggerResourceType.IMAGE,
    AqutterContentBlockerTriggerResourceType.MEDIA,
    AqutterContentBlockerTriggerResourceType.RAW,
    AqutterContentBlockerTriggerResourceType.SCRIPT,
    AqutterContentBlockerTriggerResourceType.STYLE_SHEET,
    AqutterContentBlockerTriggerResourceType.SVG_DOCUMENT,
  ].toSet();

  ///Gets a possible [AqutterContentBlockerTriggerResourceType] instance from [String] value.
  static AqutterContentBlockerTriggerResourceType? fromValue(String? value) {
    if (value != null) {
      try {
        return AqutterContentBlockerTriggerResourceType.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterContentBlockerTriggerResourceType] instance from a native value.
  static AqutterContentBlockerTriggerResourceType? fromNativeValue(
    String? value,
  ) {
    if (value != null) {
      try {
        return AqutterContentBlockerTriggerResourceType.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterContentBlockerTriggerResourceType] instance value with name [name].
  ///
  /// Goes through [AqutterContentBlockerTriggerResourceType.values] looking for a value with
  /// name [name], as reported by [AqutterContentBlockerTriggerResourceType.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterContentBlockerTriggerResourceType? byName(String? name) {
    if (name != null) {
      try {
        return AqutterContentBlockerTriggerResourceType.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterContentBlockerTriggerResourceType] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterContentBlockerTriggerResourceType> asNameMap() =>
      <String, AqutterContentBlockerTriggerResourceType>{
        for (final value in AqutterContentBlockerTriggerResourceType.values)
          value.name(): value,
      };

  ///Gets [String] value.
  String toValue() => _value;

  ///Gets [String] native value if supported by the current platform, otherwise `null`.
  String? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 'document':
        return 'DOCUMENT';
      case 'font':
        return 'FONT';
      case 'image':
        return 'IMAGE';
      case 'media':
        return 'MEDIA';
      case 'raw':
        return 'RAW';
      case 'script':
        return 'SCRIPT';
      case 'style-sheet':
        return 'STYLE_SHEET';
      case 'svg-document':
        return 'SVG_DOCUMENT';
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
    return _value;
  }
}
