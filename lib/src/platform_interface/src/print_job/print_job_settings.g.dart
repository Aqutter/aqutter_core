// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_job_settings.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents the settings of a [AqutterPlatformPrintJobController].
///
///**Officially Supported Platforms/Implementations**:
///- Android WebView
///- iOS WKWebView
///- macOS WKWebView
///- Windows WebView2
class AqutterPrintJobSettings {
  ///`true` to animate the display of the sheet, `false` to display the sheet immediately.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  bool? animated;

  ///Whether the print operation should spawn a separate thread in which to run itself.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? canSpawnSeparateThread;

  ///Whether printed pages should be collated.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  bool? collate;

  ///The color mode.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- macOS WKWebView
  ///- Windows WebView2
  AqutterPrintJobColorMode? colorMode;

  ///How many copies to print.
  ///The default value is `1`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///- Windows WebView2
  int? copies;

  ///If `true`, produce detailed reports when an error occurs.
  ///The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? detailedErrorReporting;

  ///The duplex mode to use for the print job.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 23+
  ///- iOS WKWebView
  ///- Windows WebView2
  AqutterPrintJobDuplexMode? duplexMode;

  ///A fax number.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  String? faxNumber;

  ///An integer value that specifies the first page in the print job.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  int? firstPage;

  ///The height of the page footer.
  ///
  ///The footer is measured in points from the bottom of [printableRect] and is below the content area.
  ///The default footer height is `0.0`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  double? footerHeight;

  ///The URI in the footer when [shouldPrintHeaderAndFooter] is `true`.
  ///The default value is the current URI.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  String? footerUri;

  ///Force rendering quality.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 14.5+
  AqutterPrintJobRenderingQuality? forceRenderingQuality;

  ///Set this to `true` to handle the [AqutterPlatformPrintJobController].
  ///Otherwise, it will be handled and disposed automatically by the system.
  ///The default value is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  bool? handledByClient;

  ///If `true`, a standard header and footer are added outside the margins of each page.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///- Windows WebView2
  bool? headerAndFooter;

  ///The height of the page header.
  ///
  ///The header is measured in points from the top of [printableRect] and is above the content area.
  ///The default header height is `0.0`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  double? headerHeight;

  ///The title in the header when [shouldPrintHeaderAndFooter] is `true`.
  ///The default value is the title of the current document.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  String? headerTitle;

  ///The horizontal pagination mode.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  AqutterPrintJobPaginationMode? horizontalPagination;

  ///Indicates whether the image is centered horizontally.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? isHorizontallyCentered;

  ///Indicates whether the image is centered vertically.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? isVerticallyCentered;

  ///The action specified for the job.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  AqutterPrintJobDisposition? jobDisposition;

  ///The name of the print job.
  ///An application should set this property to a name appropriate to the content being printed.
  ///The default job name is the current webpage title concatenated with the "Document" word at the end.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  String? jobName;

  ///An URL containing the location to which the job file will be saved when the [jobDisposition] is [AqutterPrintJobDisposition.SAVE].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  AqutterWebUri? jobSavingURL;

  ///An integer value that specifies the last page in the print job.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  int? lastPage;

  ///The margins for each printed page.
  ///Margins define the white space around the content where the left margin defines
  ///the amount of white space on the left of the content and so on.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
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
  ///- Windows WebView2
  AqutterPrintJobMediaSize? mediaSize;

  ///If `true`, collates output.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? mustCollate;

  ///The number of pages to render.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  int? numberOfPages;

  ///The orientation of the printed content, portrait or landscape.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  AqutterPrintJobOrientation? orientation;

  ///The kind of printable content.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  AqutterPrintJobOutputType? outputType;

  ///The page height in inches.
  ///The default height is 11 inches.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  double? pageHeight;

  ///The print order for the pages of the operation.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  AqutterPrintJobPageOrder? pageOrder;

  ///The page ranges to print.
  ///Pages are specified as a comma-separated list of page ranges where each page range specifies
  ///a start and end inclusive page numbers. For example "1-5, 13, 17-19".
  ///Use an empty string to specify printing all the pages.
  ///The default value is empty string.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  String? pageRanges;

  ///The page width in inches.
  ///The default width is 8.5 inches.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  double? pageWidth;

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

  ///The number of pages to print on each sheet.
  ///The value must be 1, 2, 4, 6, 9, or 16.
  ///The default value is `1`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  int? pagesPerSide;

  ///The name of the currently selected paper size.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  String? paperName;

  ///The print dialog kind to show when [showUI] is `true`.
  ///The default value is [AqutterPrintJobDialogKind.BROWSER].
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  AqutterPrintJobDialogKind? printDialogKind;

  ///The name of the printer to use.
  ///Defaults to the user default printer.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  String? printerName;

  ///The supported resolution in DPI (dots per inch).
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  AqutterPrintJobResolution? resolution;

  ///The current scaling factor. From `0.0` to `1.0`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///- Windows WebView2
  double? scalingFactor;

  ///`true` if background colors and images should be printed.
  ///The default is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  bool? shouldPrintBackgrounds;

  ///`true` if header and footer should be printed.
  ///The default is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  bool? shouldPrintHeaderAndFooter;

  ///`true` if only the current selection of HTML in the document should be printed.
  ///The default is `false`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  bool? shouldPrintSelectionOnly;

  ///A Boolean value that determines whether the print UI should be shown.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  bool? showUI;

  ///A Boolean value that determines whether the printing options include the number of copies.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  bool? showsNumberOfCopies;

  ///A Boolean value that determines whether the Print panel includes a set of fields for manipulating the range of pages being printed.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? showsPageRange;

  ///A Boolean value that determines whether the Print panel includes a separate accessory view for manipulating the paper size, orientation, and scaling attributes.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? showsPageSetupAccessory;

  ///A Boolean value that determines whether the printing options include the paper orientation control when available.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 15.0+
  ///- macOS WKWebView
  bool? showsPaperOrientation;

  ///A Boolean value that determines whether the paper selection menu displays.
  ///The default value of this property is `false`.
  ///Setting the value to `true` enables a paper selection menu on printers that support different types of paper and have more than one paper type loaded.
  ///On printers where only one paper type is available, no paper selection menu is displayed, regardless of the value of this property.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  bool? showsPaperSelectionForLoadedPapers;

  ///A Boolean value that determines whether the print panel includes a control for manipulating the paper size of the printer.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? showsPaperSize;

  ///A Boolean value that determines whether the Print panel displays a built-in preview of the document contents.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? showsPreview;

  ///A Boolean value that determines whether the print operation displays a print panel.
  ///The default value is `true`.
  ///
  ///This property does not affect the display of a progress panel;
  ///that operation is controlled by the [showsProgressPanel] property.
  ///Operations that generate EPS or PDF data do no display a progress panel, regardless of the value in the flag parameter.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? showsPrintPanel;

  ///A Boolean value that determines whether the Print panel includes an additional selection option for paper range.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? showsPrintSelection;

  ///A Boolean value that determines whether the print operation displays a progress panel.
  ///The default value is `true`.
  ///
  ///This property does not affect the display of a print panel;
  ///that operation is controlled by the [showsPrintPanel] property.
  ///Operations that generate EPS or PDF data do no display a progress panel, regardless of the value in the flag parameter.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? showsProgressPanel;

  ///A Boolean value that determines whether the Print panel includes a control for scaling the printed output.
  ///The default value is `true`.
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  bool? showsScaling;

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

  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  AqutterPrintJobSettings({
    this.animated = true,
    this.canSpawnSeparateThread = true,
    this.collate,
    this.colorMode,
    this.copies = 1,
    this.detailedErrorReporting = false,
    this.duplexMode,
    this.faxNumber,
    this.firstPage,
    this.footerHeight,
    this.footerUri,
    this.forceRenderingQuality,
    this.handledByClient = false,
    this.headerAndFooter = true,
    this.headerHeight,
    this.headerTitle,
    this.horizontalPagination,
    this.isHorizontallyCentered = true,
    this.isVerticallyCentered = true,
    this.jobDisposition,
    this.jobName,
    this.jobSavingURL,
    this.lastPage,
    this.margins,
    this.maximumContentHeight,
    this.maximumContentWidth,
    this.mediaSize,
    this.mustCollate,
    this.numberOfPages,
    this.orientation,
    this.outputType,
    this.pageHeight,
    this.pageOrder,
    this.pageRanges,
    this.pageWidth,
    this.pagesAcross,
    this.pagesDown,
    this.pagesPerSide,
    this.paperName,
    AqutterPrintJobDialogKind? printDialogKind,
    this.printerName,
    this.resolution,
    this.scalingFactor,
    this.shouldPrintBackgrounds,
    this.shouldPrintHeaderAndFooter,
    this.shouldPrintSelectionOnly,
    this.showUI = true,
    this.showsNumberOfCopies = true,
    this.showsPageRange = true,
    this.showsPageSetupAccessory = true,
    this.showsPaperOrientation = true,
    this.showsPaperSelectionForLoadedPapers = false,
    this.showsPaperSize = true,
    this.showsPreview = true,
    this.showsPrintPanel = true,
    this.showsPrintSelection = true,
    this.showsProgressPanel = true,
    this.showsScaling = true,
    this.time,
    this.verticalPagination,
  }) : printDialogKind = printDialogKind ?? AqutterPrintJobDialogKind.BROWSER;

  ///Gets a possible [AqutterPrintJobSettings] instance from a [Map] value.
  static AqutterPrintJobSettings? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterPrintJobSettings(
      collate: map['collate'],
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
      duplexMode: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterPrintJobDuplexMode.fromNativeValue(map['duplexMode']),
        AqutterEnumMethod.value => AqutterPrintJobDuplexMode.fromValue(
          map['duplexMode'],
        ),
        AqutterEnumMethod.name => AqutterPrintJobDuplexMode.byName(
          map['duplexMode'],
        ),
      },
      faxNumber: map['faxNumber'],
      firstPage: map['firstPage'],
      footerHeight: map['footerHeight'],
      footerUri: map['footerUri'],
      forceRenderingQuality: switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterPrintJobRenderingQuality.fromNativeValue(
            map['forceRenderingQuality'],
          ),
        AqutterEnumMethod.value => AqutterPrintJobRenderingQuality.fromValue(
          map['forceRenderingQuality'],
        ),
        AqutterEnumMethod.name => AqutterPrintJobRenderingQuality.byName(
          map['forceRenderingQuality'],
        ),
      },
      headerHeight: map['headerHeight'],
      headerTitle: map['headerTitle'],
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
      jobName: map['jobName'],
      jobSavingURL: map['jobSavingURL'] != null
          ? AqutterWebUri(map['jobSavingURL'])
          : null,
      lastPage: map['lastPage'],
      margins: MapEdgeInsets.fromMap(map['margins']?.cast<String, dynamic>()),
      maximumContentHeight: map['maximumContentHeight'],
      maximumContentWidth: map['maximumContentWidth'],
      mediaSize: AqutterPrintJobMediaSize.fromMap(
        map['mediaSize']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      mustCollate: map['mustCollate'],
      numberOfPages: map['numberOfPages'],
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
      outputType: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterPrintJobOutputType.fromNativeValue(map['outputType']),
        AqutterEnumMethod.value => AqutterPrintJobOutputType.fromValue(
          map['outputType'],
        ),
        AqutterEnumMethod.name => AqutterPrintJobOutputType.byName(
          map['outputType'],
        ),
      },
      pageHeight: map['pageHeight'],
      pageOrder: switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue =>
          AqutterPrintJobPageOrder.fromNativeValue(map['pageOrder']),
        AqutterEnumMethod.value => AqutterPrintJobPageOrder.fromValue(
          map['pageOrder'],
        ),
        AqutterEnumMethod.name => AqutterPrintJobPageOrder.byName(
          map['pageOrder'],
        ),
      },
      pageRanges: map['pageRanges'],
      pageWidth: map['pageWidth'],
      pagesAcross: map['pagesAcross'],
      pagesDown: map['pagesDown'],
      pagesPerSide: map['pagesPerSide'],
      paperName: map['paperName'],
      printerName: map['printerName'],
      resolution: AqutterPrintJobResolution.fromMap(
        map['resolution']?.cast<String, dynamic>(),
        enumMethod: enumMethod,
      ),
      scalingFactor: map['scalingFactor'],
      shouldPrintBackgrounds: map['shouldPrintBackgrounds'],
      shouldPrintHeaderAndFooter: map['shouldPrintHeaderAndFooter'],
      shouldPrintSelectionOnly: map['shouldPrintSelectionOnly'],
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
    instance.animated = map['animated'];
    instance.canSpawnSeparateThread = map['canSpawnSeparateThread'];
    instance.copies = map['copies'];
    instance.detailedErrorReporting = map['detailedErrorReporting'];
    instance.handledByClient = map['handledByClient'];
    instance.headerAndFooter = map['headerAndFooter'];
    instance.isHorizontallyCentered = map['isHorizontallyCentered'];
    instance.isVerticallyCentered = map['isVerticallyCentered'];
    instance.printDialogKind = switch (enumMethod ??
        AqutterEnumMethod.nativeValue) {
      AqutterEnumMethod.nativeValue =>
        AqutterPrintJobDialogKind.fromNativeValue(map['printDialogKind']),
      AqutterEnumMethod.value => AqutterPrintJobDialogKind.fromValue(
        map['printDialogKind'],
      ),
      AqutterEnumMethod.name => AqutterPrintJobDialogKind.byName(
        map['printDialogKind'],
      ),
    };
    instance.showUI = map['showUI'];
    instance.showsNumberOfCopies = map['showsNumberOfCopies'];
    instance.showsPageRange = map['showsPageRange'];
    instance.showsPageSetupAccessory = map['showsPageSetupAccessory'];
    instance.showsPaperOrientation = map['showsPaperOrientation'];
    instance.showsPaperSelectionForLoadedPapers =
        map['showsPaperSelectionForLoadedPapers'];
    instance.showsPaperSize = map['showsPaperSize'];
    instance.showsPreview = map['showsPreview'];
    instance.showsPrintPanel = map['showsPrintPanel'];
    instance.showsPrintSelection = map['showsPrintSelection'];
    instance.showsProgressPanel = map['showsProgressPanel'];
    instance.showsScaling = map['showsScaling'];
    return instance;
  }

  ///Check if the given [property] is supported by the [defaultTargetPlatform] or a specific [platform].
  static bool isPropertySupported(
    AqutterPrintJobSettingsProperty property, {
    TargetPlatform? platform,
  }) => _AqutterPrintJobSettingsPropertySupported.isPropertySupported(
    property,
    platform: platform,
  );

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {
      "animated": animated,
      "canSpawnSeparateThread": canSpawnSeparateThread,
      "collate": collate,
      "colorMode": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => colorMode?.toNativeValue(),
        AqutterEnumMethod.value => colorMode?.toValue(),
        AqutterEnumMethod.name => colorMode?.name(),
      },
      "copies": copies,
      "detailedErrorReporting": detailedErrorReporting,
      "duplexMode": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => duplexMode?.toNativeValue(),
        AqutterEnumMethod.value => duplexMode?.toValue(),
        AqutterEnumMethod.name => duplexMode?.name(),
      },
      "faxNumber": faxNumber,
      "firstPage": firstPage,
      "footerHeight": footerHeight,
      "footerUri": footerUri,
      "forceRenderingQuality": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => forceRenderingQuality?.toNativeValue(),
        AqutterEnumMethod.value => forceRenderingQuality?.toValue(),
        AqutterEnumMethod.name => forceRenderingQuality?.name(),
      },
      "handledByClient": handledByClient,
      "headerAndFooter": headerAndFooter,
      "headerHeight": headerHeight,
      "headerTitle": headerTitle,
      "horizontalPagination": switch (enumMethod ??
          AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => horizontalPagination?.toNativeValue(),
        AqutterEnumMethod.value => horizontalPagination?.toValue(),
        AqutterEnumMethod.name => horizontalPagination?.name(),
      },
      "isHorizontallyCentered": isHorizontallyCentered,
      "isVerticallyCentered": isVerticallyCentered,
      "jobDisposition": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => jobDisposition?.toNativeValue(),
        AqutterEnumMethod.value => jobDisposition?.toValue(),
        AqutterEnumMethod.name => jobDisposition?.name(),
      },
      "jobName": jobName,
      "jobSavingURL": jobSavingURL?.toString(),
      "lastPage": lastPage,
      "margins": margins?.toMap(),
      "maximumContentHeight": maximumContentHeight,
      "maximumContentWidth": maximumContentWidth,
      "mediaSize": mediaSize?.toMap(enumMethod: enumMethod),
      "mustCollate": mustCollate,
      "numberOfPages": numberOfPages,
      "orientation": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => orientation?.toNativeValue(),
        AqutterEnumMethod.value => orientation?.toValue(),
        AqutterEnumMethod.name => orientation?.name(),
      },
      "outputType": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => outputType?.toNativeValue(),
        AqutterEnumMethod.value => outputType?.toValue(),
        AqutterEnumMethod.name => outputType?.name(),
      },
      "pageHeight": pageHeight,
      "pageOrder": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => pageOrder?.toNativeValue(),
        AqutterEnumMethod.value => pageOrder?.toValue(),
        AqutterEnumMethod.name => pageOrder?.name(),
      },
      "pageRanges": pageRanges,
      "pageWidth": pageWidth,
      "pagesAcross": pagesAcross,
      "pagesDown": pagesDown,
      "pagesPerSide": pagesPerSide,
      "paperName": paperName,
      "printDialogKind": switch (enumMethod ?? AqutterEnumMethod.nativeValue) {
        AqutterEnumMethod.nativeValue => printDialogKind?.toNativeValue(),
        AqutterEnumMethod.value => printDialogKind?.toValue(),
        AqutterEnumMethod.name => printDialogKind?.name(),
      },
      "printerName": printerName,
      "resolution": resolution?.toMap(enumMethod: enumMethod),
      "scalingFactor": scalingFactor,
      "shouldPrintBackgrounds": shouldPrintBackgrounds,
      "shouldPrintHeaderAndFooter": shouldPrintHeaderAndFooter,
      "shouldPrintSelectionOnly": shouldPrintSelectionOnly,
      "showUI": showUI,
      "showsNumberOfCopies": showsNumberOfCopies,
      "showsPageRange": showsPageRange,
      "showsPageSetupAccessory": showsPageSetupAccessory,
      "showsPaperOrientation": showsPaperOrientation,
      "showsPaperSelectionForLoadedPapers": showsPaperSelectionForLoadedPapers,
      "showsPaperSize": showsPaperSize,
      "showsPreview": showsPreview,
      "showsPrintPanel": showsPrintPanel,
      "showsPrintSelection": showsPrintSelection,
      "showsProgressPanel": showsProgressPanel,
      "showsScaling": showsScaling,
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

  ///Returns a copy of AqutterPrintJobSettings.
  AqutterPrintJobSettings copy() {
    return AqutterPrintJobSettings.fromMap(toMap()) ??
        AqutterPrintJobSettings();
  }

  @override
  String toString() {
    return 'AqutterPrintJobSettings{animated: $animated, canSpawnSeparateThread: $canSpawnSeparateThread, collate: $collate, colorMode: $colorMode, copies: $copies, detailedErrorReporting: $detailedErrorReporting, duplexMode: $duplexMode, faxNumber: $faxNumber, firstPage: $firstPage, footerHeight: $footerHeight, footerUri: $footerUri, forceRenderingQuality: $forceRenderingQuality, handledByClient: $handledByClient, headerAndFooter: $headerAndFooter, headerHeight: $headerHeight, headerTitle: $headerTitle, horizontalPagination: $horizontalPagination, isHorizontallyCentered: $isHorizontallyCentered, isVerticallyCentered: $isVerticallyCentered, jobDisposition: $jobDisposition, jobName: $jobName, jobSavingURL: $jobSavingURL, lastPage: $lastPage, margins: $margins, maximumContentHeight: $maximumContentHeight, maximumContentWidth: $maximumContentWidth, mediaSize: $mediaSize, mustCollate: $mustCollate, numberOfPages: $numberOfPages, orientation: $orientation, outputType: $outputType, pageHeight: $pageHeight, pageOrder: $pageOrder, pageRanges: $pageRanges, pageWidth: $pageWidth, pagesAcross: $pagesAcross, pagesDown: $pagesDown, pagesPerSide: $pagesPerSide, paperName: $paperName, printDialogKind: $printDialogKind, printerName: $printerName, resolution: $resolution, scalingFactor: $scalingFactor, shouldPrintBackgrounds: $shouldPrintBackgrounds, shouldPrintHeaderAndFooter: $shouldPrintHeaderAndFooter, shouldPrintSelectionOnly: $shouldPrintSelectionOnly, showUI: $showUI, showsNumberOfCopies: $showsNumberOfCopies, showsPageRange: $showsPageRange, showsPageSetupAccessory: $showsPageSetupAccessory, showsPaperOrientation: $showsPaperOrientation, showsPaperSelectionForLoadedPapers: $showsPaperSelectionForLoadedPapers, showsPaperSize: $showsPaperSize, showsPreview: $showsPreview, showsPrintPanel: $showsPrintPanel, showsPrintSelection: $showsPrintSelection, showsProgressPanel: $showsProgressPanel, showsScaling: $showsScaling, time: $time, verticalPagination: $verticalPagination}';
  }
}

// **************************************************************************
// SupportedPlatformsGenerator
// **************************************************************************

///List of [AqutterPrintJobSettings]'s properties that can be used to check i they are supported or not by the current platform.
enum AqutterPrintJobSettingsProperty {
  ///Can be used to check if the [AqutterPrintJobSettings.animated] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.animated.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  animated,

  ///Can be used to check if the [AqutterPrintJobSettings.canSpawnSeparateThread] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.canSpawnSeparateThread.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  canSpawnSeparateThread,

  ///Can be used to check if the [AqutterPrintJobSettings.collate] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.collate.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  collate,

  ///Can be used to check if the [AqutterPrintJobSettings.colorMode] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.colorMode.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  colorMode,

  ///Can be used to check if the [AqutterPrintJobSettings.copies] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.copies.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  copies,

  ///Can be used to check if the [AqutterPrintJobSettings.detailedErrorReporting] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.detailedErrorReporting.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  detailedErrorReporting,

  ///Can be used to check if the [AqutterPrintJobSettings.duplexMode] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.duplexMode.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView 23+
  ///- iOS WKWebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  duplexMode,

  ///Can be used to check if the [AqutterPrintJobSettings.faxNumber] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.faxNumber.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  faxNumber,

  ///Can be used to check if the [AqutterPrintJobSettings.firstPage] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.firstPage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  firstPage,

  ///Can be used to check if the [AqutterPrintJobSettings.footerHeight] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.footerHeight.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  footerHeight,

  ///Can be used to check if the [AqutterPrintJobSettings.footerUri] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.footerUri.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  footerUri,

  ///Can be used to check if the [AqutterPrintJobSettings.forceRenderingQuality] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.forceRenderingQuality.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 14.5+
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  forceRenderingQuality,

  ///Can be used to check if the [AqutterPrintJobSettings.handledByClient] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.handledByClient.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  handledByClient,

  ///Can be used to check if the [AqutterPrintJobSettings.headerAndFooter] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.headerAndFooter.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  headerAndFooter,

  ///Can be used to check if the [AqutterPrintJobSettings.headerHeight] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.headerHeight.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  headerHeight,

  ///Can be used to check if the [AqutterPrintJobSettings.headerTitle] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.headerTitle.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  headerTitle,

  ///Can be used to check if the [AqutterPrintJobSettings.horizontalPagination] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.horizontalPagination.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  horizontalPagination,

  ///Can be used to check if the [AqutterPrintJobSettings.isHorizontallyCentered] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.isHorizontallyCentered.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  isHorizontallyCentered,

  ///Can be used to check if the [AqutterPrintJobSettings.isVerticallyCentered] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.isVerticallyCentered.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  isVerticallyCentered,

  ///Can be used to check if the [AqutterPrintJobSettings.jobDisposition] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.jobDisposition.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  jobDisposition,

  ///Can be used to check if the [AqutterPrintJobSettings.jobName] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.jobName.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  jobName,

  ///Can be used to check if the [AqutterPrintJobSettings.jobSavingURL] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.jobSavingURL.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  jobSavingURL,

  ///Can be used to check if the [AqutterPrintJobSettings.lastPage] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.lastPage.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  lastPage,

  ///Can be used to check if the [AqutterPrintJobSettings.margins] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.margins.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  margins,

  ///Can be used to check if the [AqutterPrintJobSettings.maximumContentHeight] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.maximumContentHeight.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  maximumContentHeight,

  ///Can be used to check if the [AqutterPrintJobSettings.maximumContentWidth] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.maximumContentWidth.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  maximumContentWidth,

  ///Can be used to check if the [AqutterPrintJobSettings.mediaSize] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.mediaSize.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  mediaSize,

  ///Can be used to check if the [AqutterPrintJobSettings.mustCollate] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.mustCollate.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  mustCollate,

  ///Can be used to check if the [AqutterPrintJobSettings.numberOfPages] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.numberOfPages.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  numberOfPages,

  ///Can be used to check if the [AqutterPrintJobSettings.orientation] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.orientation.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  orientation,

  ///Can be used to check if the [AqutterPrintJobSettings.outputType] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.outputType.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  outputType,

  ///Can be used to check if the [AqutterPrintJobSettings.pageHeight] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.pageHeight.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  pageHeight,

  ///Can be used to check if the [AqutterPrintJobSettings.pageOrder] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.pageOrder.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  pageOrder,

  ///Can be used to check if the [AqutterPrintJobSettings.pageRanges] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.pageRanges.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  pageRanges,

  ///Can be used to check if the [AqutterPrintJobSettings.pageWidth] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.pageWidth.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  pageWidth,

  ///Can be used to check if the [AqutterPrintJobSettings.pagesAcross] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.pagesAcross.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  pagesAcross,

  ///Can be used to check if the [AqutterPrintJobSettings.pagesDown] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.pagesDown.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  pagesDown,

  ///Can be used to check if the [AqutterPrintJobSettings.pagesPerSide] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.pagesPerSide.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  pagesPerSide,

  ///Can be used to check if the [AqutterPrintJobSettings.paperName] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.paperName.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  paperName,

  ///Can be used to check if the [AqutterPrintJobSettings.printDialogKind] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.printDialogKind.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  printDialogKind,

  ///Can be used to check if the [AqutterPrintJobSettings.printerName] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.printerName.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  printerName,

  ///Can be used to check if the [AqutterPrintJobSettings.resolution] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.resolution.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Android WebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  resolution,

  ///Can be used to check if the [AqutterPrintJobSettings.scalingFactor] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.scalingFactor.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  scalingFactor,

  ///Can be used to check if the [AqutterPrintJobSettings.shouldPrintBackgrounds] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.shouldPrintBackgrounds.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  shouldPrintBackgrounds,

  ///Can be used to check if the [AqutterPrintJobSettings.shouldPrintHeaderAndFooter] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.shouldPrintHeaderAndFooter.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  shouldPrintHeaderAndFooter,

  ///Can be used to check if the [AqutterPrintJobSettings.shouldPrintSelectionOnly] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.shouldPrintSelectionOnly.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  shouldPrintSelectionOnly,

  ///Can be used to check if the [AqutterPrintJobSettings.showUI] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.showUI.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- Windows WebView2
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  showUI,

  ///Can be used to check if the [AqutterPrintJobSettings.showsNumberOfCopies] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.showsNumberOfCopies.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  showsNumberOfCopies,

  ///Can be used to check if the [AqutterPrintJobSettings.showsPageRange] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.showsPageRange.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  showsPageRange,

  ///Can be used to check if the [AqutterPrintJobSettings.showsPageSetupAccessory] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.showsPageSetupAccessory.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  showsPageSetupAccessory,

  ///Can be used to check if the [AqutterPrintJobSettings.showsPaperOrientation] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.showsPaperOrientation.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView 15.0+
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  showsPaperOrientation,

  ///Can be used to check if the [AqutterPrintJobSettings.showsPaperSelectionForLoadedPapers] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.showsPaperSelectionForLoadedPapers.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- iOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  showsPaperSelectionForLoadedPapers,

  ///Can be used to check if the [AqutterPrintJobSettings.showsPaperSize] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.showsPaperSize.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  showsPaperSize,

  ///Can be used to check if the [AqutterPrintJobSettings.showsPreview] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.showsPreview.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  showsPreview,

  ///Can be used to check if the [AqutterPrintJobSettings.showsPrintPanel] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.showsPrintPanel.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  showsPrintPanel,

  ///Can be used to check if the [AqutterPrintJobSettings.showsPrintSelection] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.showsPrintSelection.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  showsPrintSelection,

  ///Can be used to check if the [AqutterPrintJobSettings.showsProgressPanel] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.showsProgressPanel.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  showsProgressPanel,

  ///Can be used to check if the [AqutterPrintJobSettings.showsScaling] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.showsScaling.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  showsScaling,

  ///Can be used to check if the [AqutterPrintJobSettings.time] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.time.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  time,

  ///Can be used to check if the [AqutterPrintJobSettings.verticalPagination] property is supported at runtime.
  ///
  ///{@template aqutter_core.AqutterPrintJobSettings.verticalPagination.supported_platforms}
  ///
  ///**Officially Supported Platforms/Implementations**:
  ///- macOS WKWebView
  ///
  ///Use the [AqutterPrintJobSettings.isPropertySupported] method to check if this property is supported at runtime.
  ///{@endtemplate}
  verticalPagination,
}

extension _AqutterPrintJobSettingsPropertySupported on AqutterPrintJobSettings {
  static bool isPropertySupported(
    AqutterPrintJobSettingsProperty property, {
    TargetPlatform? platform,
  }) {
    switch (property) {
      case AqutterPrintJobSettingsProperty.animated:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.canSpawnSeparateThread:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.collate:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.colorMode:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.copies:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.detailedErrorReporting:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.duplexMode:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.faxNumber:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.firstPage:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.footerHeight:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.footerUri:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.forceRenderingQuality:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.handledByClient:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.headerAndFooter:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.headerHeight:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.headerTitle:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.horizontalPagination:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.isHorizontallyCentered:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.isVerticallyCentered:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.jobDisposition:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.jobName:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.jobSavingURL:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.lastPage:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.margins:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.maximumContentHeight:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.maximumContentWidth:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.mediaSize:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.mustCollate:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.numberOfPages:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.orientation:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
              TargetPlatform.iOS,
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.outputType:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.pageHeight:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.pageOrder:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.pageRanges:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.pageWidth:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.pagesAcross:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.pagesDown:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.pagesPerSide:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.paperName:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.printDialogKind:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.printerName:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.resolution:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.android,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.scalingFactor:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.macOS,
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.shouldPrintBackgrounds:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.shouldPrintHeaderAndFooter:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.shouldPrintSelectionOnly:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.showUI:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.windows,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.showsNumberOfCopies:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.showsPageRange:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.showsPageSetupAccessory:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.showsPaperOrientation:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [
              TargetPlatform.iOS,
              TargetPlatform.macOS,
            ].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.showsPaperSelectionForLoadedPapers:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.iOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.showsPaperSize:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.showsPreview:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.showsPrintPanel:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.showsPrintSelection:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.showsProgressPanel:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.showsScaling:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.time:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
      case AqutterPrintJobSettingsProperty.verticalPagination:
        return ((kIsWeb && platform != null) || !kIsWeb) &&
            [TargetPlatform.macOS].contains(platform ?? defaultTargetPlatform);
    }
  }
}
