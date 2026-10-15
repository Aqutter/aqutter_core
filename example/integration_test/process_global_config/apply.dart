part of 'main.dart';

void apply() {
  final shouldSkip = !AqutterProcessGlobalConfig.isMethodSupported(
    AqutterPlatformProcessGlobalConfigMethod.apply,
  );

  skippableTestWidgets('apply', (WidgetTester tester) async {
    await expectLater(
      AqutterProcessGlobalConfig.instance().apply(
        settings: AqutterProcessGlobalConfigSettings(
          dataDirectorySuffix:
              (await AqutterWebViewFeature.isStartupFeatureSupported(
                AqutterWebViewFeature.STARTUP_FEATURE_SET_DATA_DIRECTORY_SUFFIX,
              ))
              ? 'suffix_inappwebviewexample'
              : null,
          directoryBasePaths:
              (await AqutterWebViewFeature.isStartupFeatureSupported(
                AqutterWebViewFeature.STARTUP_FEATURE_SET_DIRECTORY_BASE_PATHS,
              ))
              ? AqutterProcessGlobalConfigDirectoryBasePaths(
                  cacheDirectoryBasePath:
                      (await getApplicationDocumentsDirectory()).absolute.path +
                      '/inappwebviewexample/cache',
                  dataDirectoryBasePath:
                      (await getApplicationDocumentsDirectory()).absolute.path +
                      '/inappwebviewexample/data',
                )
              : null,
        ),
      ),
      completes,
    );
  }, skip: shouldSkip);
}
