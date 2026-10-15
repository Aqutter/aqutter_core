// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_toolbar_items.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class used to customize the PDF toolbar items.
class AqutterPdfToolbarItems {
  final int _value;
  final int? _nativeValue;
  const AqutterPdfToolbarItems._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterPdfToolbarItems._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterPdfToolbarItems._internal(value, nativeValue());

  ///The bookmarks button.
  static const BOOKMARKS = AqutterPdfToolbarItems._internal(256, 256);

  ///The fit page button.
  static const FIT_PAGE = AqutterPdfToolbarItems._internal(64, 64);

  ///The full screen button.
  static const FULL_SCREEN = AqutterPdfToolbarItems._internal(2048, 2048);

  ///The more settings button.
  static const MORE_SETTINGS = AqutterPdfToolbarItems._internal(4096, 4096);

  ///No item.
  static const NONE = AqutterPdfToolbarItems._internal(0, 0);

  ///The page layout button.
  static const PAGE_LAYOUT = AqutterPdfToolbarItems._internal(128, 128);

  ///The page select button.
  static const PAGE_SELECTOR = AqutterPdfToolbarItems._internal(512, 512);

  ///The print button.
  static const PRINT = AqutterPdfToolbarItems._internal(2, 2);

  ///The rotate button.
  static const ROTATE = AqutterPdfToolbarItems._internal(32, 32);

  ///The save button.
  static const SAVE = AqutterPdfToolbarItems._internal(1, 1);

  ///The save as button.
  static const SAVE_AS = AqutterPdfToolbarItems._internal(4, 4);

  ///The search button.
  static const SEARCH = AqutterPdfToolbarItems._internal(1024, 1024);

  ///The zoom in button.
  static const ZOOM_IN = AqutterPdfToolbarItems._internal(8, 8);

  ///The zoom out button.
  static const ZOOM_OUT = AqutterPdfToolbarItems._internal(16, 16);

  ///Set of all values of [AqutterPdfToolbarItems].
  static final Set<AqutterPdfToolbarItems> values = [
    AqutterPdfToolbarItems.BOOKMARKS,
    AqutterPdfToolbarItems.FIT_PAGE,
    AqutterPdfToolbarItems.FULL_SCREEN,
    AqutterPdfToolbarItems.MORE_SETTINGS,
    AqutterPdfToolbarItems.NONE,
    AqutterPdfToolbarItems.PAGE_LAYOUT,
    AqutterPdfToolbarItems.PAGE_SELECTOR,
    AqutterPdfToolbarItems.PRINT,
    AqutterPdfToolbarItems.ROTATE,
    AqutterPdfToolbarItems.SAVE,
    AqutterPdfToolbarItems.SAVE_AS,
    AqutterPdfToolbarItems.SEARCH,
    AqutterPdfToolbarItems.ZOOM_IN,
    AqutterPdfToolbarItems.ZOOM_OUT,
  ].toSet();

  ///Gets a possible [AqutterPdfToolbarItems] instance from [int] value.
  static AqutterPdfToolbarItems? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterPdfToolbarItems.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return AqutterPdfToolbarItems._internal(value, value);
      }
    }
    return null;
  }

  ///Gets a possible [AqutterPdfToolbarItems] instance from a native value.
  static AqutterPdfToolbarItems? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterPdfToolbarItems.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterPdfToolbarItems] instance value with name [name].
  ///
  /// Goes through [AqutterPdfToolbarItems.values] looking for a value with
  /// name [name], as reported by [AqutterPdfToolbarItems.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterPdfToolbarItems? byName(String? name) {
    if (name != null) {
      try {
        return AqutterPdfToolbarItems.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterPdfToolbarItems] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterPdfToolbarItems> asNameMap() =>
      <String, AqutterPdfToolbarItems>{
        for (final value in AqutterPdfToolbarItems.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 256:
        return 'BOOKMARKS';
      case 64:
        return 'FIT_PAGE';
      case 2048:
        return 'FULL_SCREEN';
      case 4096:
        return 'MORE_SETTINGS';
      case 0:
        return 'NONE';
      case 128:
        return 'PAGE_LAYOUT';
      case 512:
        return 'PAGE_SELECTOR';
      case 2:
        return 'PRINT';
      case 32:
        return 'ROTATE';
      case 1:
        return 'SAVE';
      case 4:
        return 'SAVE_AS';
      case 1024:
        return 'SEARCH';
      case 8:
        return 'ZOOM_IN';
      case 16:
        return 'ZOOM_OUT';
    }
    return _value.toString();
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(value) => value == _value;

  AqutterPdfToolbarItems operator |(AqutterPdfToolbarItems value) =>
      AqutterPdfToolbarItems._internal(
        value.toValue() | _value,
        value.toNativeValue() != null && _nativeValue != null
            ? value.toNativeValue()! | _nativeValue!
            : null,
      );

  ///Checks if the value is supported by the [defaultTargetPlatform].
  bool isSupported() {
    return _nativeValue != null;
  }

  @override
  String toString() {
    return name();
  }
}
