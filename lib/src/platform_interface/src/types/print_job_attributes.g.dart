// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_job_attributes.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class representing the attributes of a [AqutterPlatformPrintJobController].
///These attributes describe how the printed content should be laid out.
class AqutterPrintJobAttributes {
  ///The color mode.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- macOS WKWebView
  AqutterPrintJobColorMode? colorMode;

  ///If `true`, produce detailed reports when an error occurs.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? detailedErrorReporting;

  ///The duplex mode to use for the print job.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 23+
  ///- iOS WKWebView
  ///- macOS WKWebView
  AqutterPrintJobDuplexMode? duplex;

  ///A fax number.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  String? faxNumber;

  ///The height of the page footer.
  ///
  ///The footer is measured in points from the bottom of [printableRect] and is below the content area.
  ///The default footer height is `0.0`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  double? footerHeight;

  ///If `true`, a standard header and footer are added outside the margins of each page.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? headerAndFooter;

  ///The height of the page header.
  ///
  ///The header is measured in points from the top of [printableRect] and is above the content area.
  ///The default header height is `0.0`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  double? headerHeight;

  ///The horizontal pagination mode.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  AqutterPrintJobPaginationMode? horizontalPagination;

  ///Indicates whether the image is centered horizontally.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? isHorizontallyCentered;

  ///Indicates whether only the currently selected contents should be printed.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? isSelectionOnly;

  ///Indicates whether the image is centered vertically.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? isVerticallyCentered;

  ///The action specified for the job.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  AqutterPrintJobDisposition? jobDisposition;

  ///An URL containing the location to which the job file will be saved when the [jobDisposition] is [AqutterPrintJobDisposition.SAVE].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  AqutterWebUri? jobSavingURL;

  ///The human-readable name of the currently selected paper size, suitable for presentation in user interfaces.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  String? localizedPaperName;

  ///The margins for each printed page.
  ///Margins define the white space around the content where the left margin defines
  ///the amount of white space on the left of the content and so on.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  EdgeInsets? margins;

  ///The maximum height of the content area.
  ///
  ///The Print Formatter uses this value to determine where the content rectangle begins on the first page.
  ///It compares the value of this property with the printing rectangle’s height minus the header and footer heights and
  ///the top inset value; it uses the lower of the two values.
  ///The default value of this property is the maximum float value.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  double? maximumContentHeight;

  ///The maximum width of the content area.
  ///
  ///The Print Formatter uses this value to determine the maximum width of the content rectangle.
  ///It compares the value of this property with the printing rectangle’s width minus the left and right inset values and uses the lower of the two.
  ///The default value of this property is the maximum float value.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  double? maximumContentWidth;

  ///The media size.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  AqutterPrintJobMediaSize? mediaSize;

  ///If `true`, collates output.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? mustCollate;

  ///The orientation of the printed content, portrait or landscape.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  AqutterPrintJobOrientation? orientation;

  ///The number of logical pages to be tiled horizontally on a physical sheet of paper.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  int? pagesAcross;

  ///The number of logical pages to be tiled vertically on a physical sheet of paper.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  int? pagesDown;

  ///The name of the currently selected paper size.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  String? paperName;

  ///The size of the paper used for printing.
  ///
  ///The value of this property is a rectangle that defines the size of paper chosen for the print job.
  ///The origin is always (0,0).
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  AqutterWebViewRect? paperRect;

  ///The area in which printing can occur.
  ///
  ///The value of this property is a rectangle that defines the area in which the printer can print content.
  ///Sometimes this is referred to as the imageable area of the paper.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  AqutterWebViewRect? printableRect;

  ///The supported resolution in DPI (dots per inch).
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  AqutterPrintJobResolution? resolution;

  ///The current scaling factor.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  double? scalingFactor;

  ///A timestamp that specifies the time at which printing should begin.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  int? time;

  ///The vertical pagination to the specified mode.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  AqutterPrintJobPaginationMode? verticalPagination;
  AqutterPrintJobAttributes({
    this.colorMode,
    this.detailedErrorReporting,
    this.duplex,
    this.faxNumber,
    this.footerHeight,
    this.headerAndFooter,
    this.headerHeight,
    this.horizontalPagination,
    this.isHorizontallyCentered,
    this.isSelectionOnly,
    this.isVerticallyCentered,
    this.jobDisposition,
    this.jobSavingURL,
    this.localizedPaperName,
    this.margins,
    this.maximumContentHeight,
    this.maximumContentWidth,
    this.mediaSize,
    this.mustCollate,
    this.orientation,
    this.pagesAcross,
    this.pagesDown,
    this.paperName,
    this.paperRect,
    this.printableRect,
    this.resolution,
    this.scalingFactor,
    this.time,
    this.verticalPagination,
  });

  ///Gets a possible [AqutterPrintJobAttributes] instance from a [Map] value.
  static AqutterPrintJobAttributes? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterPrintJobAttributes(
      colorMode: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterPrintJobColorMode.fromNativeValue(map['colorMode']),
        AqutterEnumMethod.value => AqutterPrintJobColorMode.fromValue(
          map['colorMode'],
        ),
        AqutterEnumMethod.name => AqutterPrintJobColorMode.byName(
          map['colorMode'],
        ),
      },
      detailedErrorReporting: map['detailedErrorReporting'],
      duplex: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterPrintJobDuplexMode.fromNativeValue(map['duplex']),
        AqutterEnumMethod.value => AqutterPrintJobDuplexMode.fromValue(
          map['duplex'],
        ),
        AqutterEnumMethod.name => AqutterPrintJobDuplexMode.byName(
          map['duplex'],
        ),
      },
      faxNumber: map['faxNumber'],
      footerHeight: map['footerHeight'],
      headerAndFooter: map['headerAndFooter'],
      headerHeight: map['headerHeight'],
      horizontalPagination: switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterPrintJobPaginationMode.fromNativeValue(
            map['horizontalPagination'],
          ),
        AqutterEnumMethod.value => AqutterPrintJobPaginationMode.fromValue(
          map['horizontalPagination'],
        ),
        AqutterEnumMethod.name => AqutterPrintJobPaginationMode.byName(
          map['horizontalPagination'],
        ),
      },
      isHorizontallyCentered: map['isHorizontallyCentered'],
      isSelectionOnly: map['isSelectionOnly'],
      isVerticallyCentered: map['isVerticallyCentered'],
      jobDisposition: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterPrintJobDisposition.fromNativeValue(map['jobDisposition']),
        AqutterEnumMethod.value => AqutterPrintJobDisposition.fromValue(
          map['jobDisposition'],
        ),
        AqutterEnumMethod.name => AqutterPrintJobDisposition.byName(
          map['jobDisposition'],
        ),
      },
      jobSavingURL: map['jobSavingURL'] != null
          ? AqutterWebUri(map['jobSavingURL'])
          : null,
      localizedPaperName: map['localizedPaperName'],
      margins: MapEdgeInsets.fromMap(map['margins']?.cast<String, dynamic>()),
      maximumContentHeight: map['maximumContentHeight'],
      maximumContentWidth: map['maximumContentWidth'],
      mediaSize: AqutterPrintJobMediaSize.fromMap(
        map['mediaSize']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      mustCollate: map['mustCollate'],
      orientation: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterPrintJobOrientation.fromNativeValue(map['orientation']),
        AqutterEnumMethod.value => AqutterPrintJobOrientation.fromValue(
          map['orientation'],
        ),
        AqutterEnumMethod.name => AqutterPrintJobOrientation.byName(
          map['orientation'],
        ),
      },
      pagesAcross: map['pagesAcross'],
      pagesDown: map['pagesDown'],
      paperName: map['paperName'],
      paperRect: AqutterWebViewRect.fromMap(
        map['paperRect']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      printableRect: AqutterWebViewRect.fromMap(
        map['printableRect']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      resolution: AqutterPrintJobResolution.fromMap(
        map['resolution']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      scalingFactor: map['scalingFactor'],
      time: map['time'],
      verticalPagination: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterPrintJobPaginationMode.fromNativeValue(
            map['verticalPagination'],
          ),
        AqutterEnumMethod.value => AqutterPrintJobPaginationMode.fromValue(
          map['verticalPagination'],
        ),
        AqutterEnumMethod.name => AqutterPrintJobPaginationMode.byName(
          map['verticalPagination'],
        ),
      },
    );
    return instance;
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "colorMode": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => colorMode?.toNativeValue(),
        AqutterEnumMethod.value => colorMode?.toValue(),
        AqutterEnumMethod.name => colorMode?.name(),
      },
      "detailedErrorReporting": detailedErrorReporting,
      "duplex": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => duplex?.toNativeValue(),
        AqutterEnumMethod.value => duplex?.toValue(),
        AqutterEnumMethod.name => duplex?.name(),
      },
      "faxNumber": faxNumber,
      "footerHeight": footerHeight,
      "headerAndFooter": headerAndFooter,
      "headerHeight": headerHeight,
      "horizontalPagination": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => horizontalPagination?.toNativeValue(),
        AqutterEnumMethod.value => horizontalPagination?.toValue(),
        AqutterEnumMethod.name => horizontalPagination?.name(),
      },
      "isHorizontallyCentered": isHorizontallyCentered,
      "isSelectionOnly": isSelectionOnly,
      "isVerticallyCentered": isVerticallyCentered,
      "jobDisposition": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => jobDisposition?.toNativeValue(),
        AqutterEnumMethod.value => jobDisposition?.toValue(),
        AqutterEnumMethod.name => jobDisposition?.name(),
      },
      "jobSavingURL": jobSavingURL?.toString(),
      "localizedPaperName": localizedPaperName,
      "margins": margins?.toMap(),
      "maximumContentHeight": maximumContentHeight,
      "maximumContentWidth": maximumContentWidth,
      "mediaSize": mediaSize?.toMap(enumMethod: enumMethod),
      "mustCollate": mustCollate,
      "orientation": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => orientation?.toNativeValue(),
        AqutterEnumMethod.value => orientation?.toValue(),
        AqutterEnumMethod.name => orientation?.name(),
      },
      "pagesAcross": pagesAcross,
      "pagesDown": pagesDown,
      "paperName": paperName,
      "paperRect": paperRect?.toMap(enumMethod: enumMethod),
      "printableRect": printableRect?.toMap(enumMethod: enumMethod),
      "resolution": resolution?.toMap(enumMethod: enumMethod),
      "scalingFactor": scalingFactor,
      "time": time,
      "verticalPagination": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => verticalPagination?.toNativeValue(),
        AqutterEnumMethod.value => verticalPagination?.toValue(),
        AqutterEnumMethod.name => verticalPagination?.name(),
      },
    };
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterPrintJobAttributes{colorMode: $colorMode, detailedErrorReporting: $detailedErrorReporting, duplex: $duplex, faxNumber: $faxNumber, footerHeight: $footerHeight, headerAndFooter: $headerAndFooter, headerHeight: $headerHeight, horizontalPagination: $horizontalPagination, isHorizontallyCentered: $isHorizontallyCentered, isSelectionOnly: $isSelectionOnly, isVerticallyCentered: $isVerticallyCentered, jobDisposition: $jobDisposition, jobSavingURL: $jobSavingURL, localizedPaperName: $localizedPaperName, margins: $margins, maximumContentHeight: $maximumContentHeight, maximumContentWidth: $maximumContentWidth, mediaSize: $mediaSize, mustCollate: $mustCollate, orientation: $orientation, pagesAcross: $pagesAcross, pagesDown: $pagesDown, paperName: $paperName, paperRect: $paperRect, printableRect: $printableRect, resolution: $resolution, scalingFactor: $scalingFactor, time: $time, verticalPagination: $verticalPagination}';
  }
}
