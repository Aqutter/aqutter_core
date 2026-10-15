part of 'main.dart';

void findInteractions() {
  final shouldSkip = !AqutterFindInteractionController.isClassSupported();

  skippableTestWidgets('find interactions', (WidgetTester tester) async {
    final Completer<void> pageLoaded = Completer<void>();
    final findInteractionController = AqutterFindInteractionController();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialFile: "test_assets/in_app_webview_initial_file_test.html",
          findInteractionController: findInteractionController,
          initialSettings: AqutterWebViewSettings(
            clearCache: true,
            isFindInteractionEnabled: true,
          ),
          onLoadStop: (controller, url) {
            pageLoaded.complete();
          },
        ),
      ),
    );

    await pageLoaded.future;

    await tester.pump();
    await Future.delayed(Duration(seconds: 1));

    const firstSearchText = "AqutterWebViewInitialFileTest";
    await expectLater(
      findInteractionController.findAll(find: firstSearchText),
      completes,
    );
    expect(await findInteractionController.getSearchText(), firstSearchText);
    // Allow extra time for find results to be processed
    await Future.delayed(Duration(seconds: 1));
    final session = await findInteractionController.getActiveFindSession();
    expect(session!.resultCount, 2);
    await expectLater(
      findInteractionController.findNext(forward: true),
      completes,
    );
    await expectLater(
      findInteractionController.findNext(forward: false),
      completes,
    );
    await expectLater(findInteractionController.clearMatches(), completes);

    const secondSearchText = "text";
    await expectLater(
      findInteractionController.setSearchText(secondSearchText),
      completes,
    );
    if (AqutterFindInteractionController.isMethodSupported(
      AqutterPlatformFindInteractionControllerMethod.presentFindNavigator,
    )) {
      await expectLater(
        findInteractionController.presentFindNavigator(),
        completes,
      );
      expect(await findInteractionController.getSearchText(), secondSearchText);
      expect(await findInteractionController.isFindNavigatorVisible(), true);
      await expectLater(
        findInteractionController.updateResultCount(),
        completes,
      );
      await expectLater(
        findInteractionController.dismissFindNavigator(),
        completes,
      );
      expect(await findInteractionController.isFindNavigatorVisible(), false);
    }
  }, skip: shouldSkip);

  skippableTestWidgets('onFindResultReceived', (WidgetTester tester) async {
    final Completer<void> pageLoaded = Completer<void>();
    final Completer<int> numberOfMatchesCompleter = Completer<int>();
    final findInteractionController = AqutterFindInteractionController(
      onFindResultReceived:
          (
            controller,
            int activeMatchOrdinal,
            int numberOfMatches,
            bool isDoneCounting,
          ) async {
            if (isDoneCounting && !numberOfMatchesCompleter.isCompleted) {
              numberOfMatchesCompleter.complete(numberOfMatches);
            }
          },
    );

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: AqutterWebView(
          key: GlobalKey(),
          initialFile: "test_assets/in_app_webview_initial_file_test.html",
          initialSettings: AqutterWebViewSettings(
            clearCache: true,
            isFindInteractionEnabled: false,
          ),
          findInteractionController: findInteractionController,
          onLoadStop: (controller, url) {
            pageLoaded.complete();
          },
        ),
      ),
    );

    await pageLoaded.future;

    await tester.pump();
    await Future.delayed(Duration(seconds: 1));

    await findInteractionController.findAll(
      find: "AqutterWebViewInitialFileTest",
    );
    final int numberOfMatches = await numberOfMatchesCompleter.future;
    expect(numberOfMatches, 2);
    final session = await findInteractionController.getActiveFindSession();
    expect(session!.resultCount, 2);
  }, skip: shouldSkip);
}
