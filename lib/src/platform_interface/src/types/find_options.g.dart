// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_options.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents find options for find-on-page operations.
class AqutterFindOptions {
  ///The text to find.
  String? findTerm;

  ///Whether to highlight all matches.
  bool? shouldHighlightAllMatches;

  ///Whether to match case.
  bool? shouldMatchCase;

  ///Whether to match whole word only.
  bool? shouldMatchWord;

  ///Whether to suppress the default find dialog.
  bool? suppressDefaultFindDialog;
  AqutterFindOptions({
    this.findTerm,
    this.shouldHighlightAllMatches,
    this.shouldMatchCase,
    this.shouldMatchWord,
    this.suppressDefaultFindDialog,
  });

  ///Gets a possible [AqutterFindOptions] instance from a [Map] value.
  static AqutterFindOptions? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterFindOptions(
      findTerm: map['findTerm'],
      shouldHighlightAllMatches: map['shouldHighlightAllMatches'],
      shouldMatchCase: map['shouldMatchCase'],
      shouldMatchWord: map['shouldMatchWord'],
      suppressDefaultFindDialog: map['suppressDefaultFindDialog'],
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "findTerm": findTerm,
      "shouldHighlightAllMatches": shouldHighlightAllMatches,
      "shouldMatchCase": shouldMatchCase,
      "shouldMatchWord": shouldMatchWord,
      "suppressDefaultFindDialog": suppressDefaultFindDialog,
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterFindOptions{findTerm: $findTerm, shouldHighlightAllMatches: $shouldHighlightAllMatches, shouldMatchCase: $shouldMatchCase, shouldMatchWord: $shouldMatchWord, suppressDefaultFindDialog: $suppressDefaultFindDialog}';
  }
}
