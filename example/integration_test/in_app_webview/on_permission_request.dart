part of 'main.dart';

void onPermissionRequest() {
  final shouldSkip = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onPermissionRequest,
  );

  skippableTestWidgets('onPermissionRequest', (WidgetTester tester) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();
    final Completer<List<AqutterPermissionResourceType>> onPermissionRequestCompleter =
        Completer<List<AqutterPermissionResourceType>>();
    final expectedValue = [AqutterPermissionResourceType.CAMERA];

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_PERMISSION_SITE),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onLoadStop: (controller, url) {
            if (!pageLoaded.isCompleted) {
              pageLoaded.complete();
            }
          },
          onPermissionRequest: (controller, permissionRequest) async {
            onPermissionRequestCompleter.complete(permissionRequest.resources);
            return AqutterPermissionResponse(
              resources: permissionRequest.resources,
              action: AqutterPermissionResponseAction.GRANT,
            );
          },
        ),
      ),
    );

    final AqutterWebViewController controller = await controllerCompleter.future;
    await pageLoaded.future;

    await tester.pump();

    await controller.evaluateJavascript(
      source: "document.querySelector('#camera').click();",
    );
    final List<AqutterPermissionResourceType> resources =
        await onPermissionRequestCompleter.future;

    expect(listEquals(resources, expectedValue), true);
  }, skip: shouldSkip);

  final shouldSkip2 = !AqutterWebView.isPropertySupported(
    AqutterPlatformWebViewCreationParamsProperty.onPermissionRequestCanceled,
  );

  skippableTestWidgets('onPermissionRequestCanceled', (
    WidgetTester tester,
  ) async {
    final Completer<AqutterWebViewController> controllerCompleter =
        Completer<AqutterWebViewController>();
    final Completer<void> pageLoaded = Completer<void>();
    final Completer<List<AqutterPermissionResourceType>> onPermissionRequestCompleter =
        Completer<List<AqutterPermissionResourceType>>();
    final Completer<List<AqutterPermissionResourceType>>
    onPermissionRequestCancelCompleter =
        Completer<List<AqutterPermissionResourceType>>();
    final expectedValue = [AqutterPermissionResourceType.MICROPHONE];

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialUrlRequest: AqutterURLRequest(url: TEST_PERMISSION_SITE),
          onWebViewCreated: (controller) {
            controllerCompleter.complete(controller);
          },
          onLoadStop: (controller, url) {
            if (!pageLoaded.isCompleted) {
              pageLoaded.complete();
            }
          },
          onPermissionRequest: (controller, permissionRequest) async {
            onPermissionRequestCompleter.complete(permissionRequest.resources);
            await Future.delayed(Duration(seconds: 5));
            return AqutterPermissionResponse(
              resources: permissionRequest.resources,
              action: AqutterPermissionResponseAction.GRANT,
            );
          },
          onPermissionRequestCanceled: (controller, permissionRequest) {
            onPermissionRequestCancelCompleter.complete(
              permissionRequest.resources,
            );
          },
        ),
      ),
    );

    final AqutterWebViewController controller = await controllerCompleter.future;
    await pageLoaded.future;

    await tester.pump();

    await controller.evaluateJavascript(
      source: "document.querySelector('#microphone').click();",
    );

    final List<AqutterPermissionResourceType> resources =
        await onPermissionRequestCompleter.future;
    expect(listEquals(resources, expectedValue), true);

    // Reload the webview to cancel the permission request
    controller.reload();

    final List<AqutterPermissionResourceType> canceledResources =
        await onPermissionRequestCancelCompleter.future;
    expect(listEquals(canceledResources, expectedValue), true);
  }, skip: shouldSkip2);
}
