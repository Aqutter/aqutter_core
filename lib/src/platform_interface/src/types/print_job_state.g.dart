// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_job_state.dart';

// **************************************************************************
// ExchangeableEnumGenerator
// **************************************************************************

///Class representing the state of a [AqutterPlatformPrintJobController].
class AqutterPrintJobState {
  final int _value;
  final int? _nativeValue;
  const AqutterPrintJobState._internal(this._value, this._nativeValue);
  // ignore: unused_element
  factory AqutterPrintJobState._internalMultiPlatform(
    int value,
    Function nativeValue,
  ) => AqutterPrintJobState._internal(value, nativeValue());

  ///Print job state: The print job is blocked.
  ///
  ///Next valid states: [FAILED], [CANCELED], [STARTED].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterPrintJobInfo.STATE_BLOCKED](https://developer.android.com/reference/android/print/AqutterPrintJobInfo#STATE_BLOCKED))
  static final BLOCKED = AqutterPrintJobState._internalMultiPlatform(4, () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 4;
      default:
        break;
    }
    return null;
  });

  ///Print job state: The print job is canceled. This is a terminal state.
  ///
  ///Next valid states: None.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterPrintJobInfo.STATE_CANCELED](https://developer.android.com/reference/android/print/AqutterPrintJobInfo#STATE_CANCELED))
  ///- iOS WKWebView
  ///- macOS WKWebView
  static final CANCELED = AqutterPrintJobState._internalMultiPlatform(7, () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 7;
      case TargetPlatform.iOS:
        return 7;
      case TargetPlatform.macOS:
        return 7;
      default:
        break;
    }
    return null;
  });

  ///Print job state: The print job is successfully printed. This is a terminal state.
  ///
  ///Next valid states: None.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterPrintJobInfo.STATE_COMPLETED](https://developer.android.com/reference/android/print/AqutterPrintJobInfo#STATE_COMPLETED))
  ///- iOS WKWebView
  ///- macOS WKWebView
  static final COMPLETED = AqutterPrintJobState._internalMultiPlatform(5, () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 5;
      case TargetPlatform.iOS:
        return 5;
      case TargetPlatform.macOS:
        return 5;
      default:
        break;
    }
    return null;
  });

  ///Print job state: The print job is being created but not yet ready to be printed.
  ///
  ///Next valid states: [QUEUED].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterPrintJobInfo.STATE_CREATED](https://developer.android.com/reference/android/print/AqutterPrintJobInfo#STATE_CREATED))
  ///- iOS WKWebView
  ///- macOS WKWebView
  static final CREATED = AqutterPrintJobState._internalMultiPlatform(1, () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 1;
      case TargetPlatform.iOS:
        return 1;
      case TargetPlatform.macOS:
        return 1;
      default:
        break;
    }
    return null;
  });

  ///Print job state: The print job was printing but printing failed.
  ///
  ///Next valid states: None.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterPrintJobInfo.STATE_FAILED](https://developer.android.com/reference/android/print/AqutterPrintJobInfo#STATE_FAILED))
  ///- iOS WKWebView
  static final FAILED = AqutterPrintJobState._internalMultiPlatform(6, () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 6;
      case TargetPlatform.iOS:
        return 6;
      default:
        break;
    }
    return null;
  });

  ///Print job state: The print jobs is created, it is ready to be printed and should be processed.
  ///
  ///Next valid states: [STARTED], [FAILED], [CANCELED].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterPrintJobInfo.STATE_QUEUED](https://developer.android.com/reference/android/print/AqutterPrintJobInfo#STATE_QUEUED))
  static final QUEUED = AqutterPrintJobState._internalMultiPlatform(2, () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 2;
      default:
        break;
    }
    return null;
  });

  ///Print job state: The print job is being printed.
  ///
  ///Next valid states: [COMPLETED], [FAILED], [CANCELED], [BLOCKED].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView ([Official API - AqutterPrintJobInfo.STATE_STARTED](https://developer.android.com/reference/android/print/AqutterPrintJobInfo#STATE_STARTED))
  ///- iOS WKWebView
  ///- macOS WKWebView
  static final STARTED = AqutterPrintJobState._internalMultiPlatform(3, () {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 3;
      case TargetPlatform.iOS:
        return 3;
      case TargetPlatform.macOS:
        return 3;
      default:
        break;
    }
    return null;
  });

  ///Set of all values of [AqutterPrintJobState].
  static final Set<AqutterPrintJobState> values = [
    AqutterPrintJobState.BLOCKED,
    AqutterPrintJobState.CANCELED,
    AqutterPrintJobState.COMPLETED,
    AqutterPrintJobState.CREATED,
    AqutterPrintJobState.FAILED,
    AqutterPrintJobState.QUEUED,
    AqutterPrintJobState.STARTED,
  ].toSet();

  ///Gets a possible [AqutterPrintJobState] instance from [int] value.
  static AqutterPrintJobState? fromValue(int? value) {
    if (value != null) {
      try {
        return AqutterPrintJobState.values.firstWhere(
          (element) => element.toValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  ///Gets a possible [AqutterPrintJobState] instance from a native value.
  static AqutterPrintJobState? fromNativeValue(int? value) {
    if (value != null) {
      try {
        return AqutterPrintJobState.values.firstWhere(
          (element) => element.toNativeValue() == value,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Gets a possible [AqutterPrintJobState] instance value with name [name].
  ///
  /// Goes through [AqutterPrintJobState.values] looking for a value with
  /// name [name], as reported by [AqutterPrintJobState.name].
  /// Returns the first value with the given name, otherwise `null`.
  static AqutterPrintJobState? byName(String? name) {
    if (name != null) {
      try {
        return AqutterPrintJobState.values.firstWhere(
          (element) => element.name() == name,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Creates a map from the names of [AqutterPrintJobState] values to the values.
  ///
  /// The collection that this method is called on is expected to have
  /// values with distinct names, like the `values` list of an enum class.
  /// Only one value for each name can occur in the created map,
  /// so if two or more values have the same name (either being the
  /// same value, or being values of different enum type), at most one of
  /// them will be represented in the returned map.
  static Map<String, AqutterPrintJobState> asNameMap() =>
      <String, AqutterPrintJobState>{
        for (final value in AqutterPrintJobState.values) value.name(): value,
      };

  ///Gets [int] value.
  int toValue() => _value;

  ///Gets [int] native value if supported by the current platform, otherwise `null`.
  int? toNativeValue() => _nativeValue;

  ///Gets the name of the value.
  String name() {
    switch (_value) {
      case 4:
        return 'BLOCKED';
      case 7:
        return 'CANCELED';
      case 5:
        return 'COMPLETED';
      case 1:
        return 'CREATED';
      case 6:
        return 'FAILED';
      case 2:
        return 'QUEUED';
      case 3:
        return 'STARTED';
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
