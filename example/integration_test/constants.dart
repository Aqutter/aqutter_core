import 'package:aqutter_core/aqutter_core.dart';

final TEST_URL_ABOUT_BLANK = AqutterWebUri('about:blank');
final TEST_CROSS_PLATFORM_URL_1 = AqutterWebUri('https://flutter.dev/');
final TEST_CROSS_PLATFORM_URL_2 = AqutterWebUri('https://www.bing.com/');
final TEST_URL_1 = AqutterWebUri('https://github.com/flutter');
final TEST_URL_2 = AqutterWebUri('https://www.google.com/');
final TEST_URL_3 = AqutterWebUri(
  'https://github.com/pichillilorenzo/flutter_inappwebview',
);
final TEST_URL_4 = AqutterWebUri('https://www.youtube.com/');
final TEST_URL_EXAMPLE = AqutterWebUri('https://www.example.com/');
final TEST_URL_HTTP_EXAMPLE = AqutterWebUri('http://www.example.com/');
final TEST_URL_404 = AqutterWebUri('https://google.com/404');
final TEST_WEB_PLATFORM_BASE_URL = AqutterWebUri(
  Uri.base.toString().replaceFirst("/#/", "/"),
);
final TEST_WEB_PLATFORM_URL_1 = AqutterWebUri(
  TEST_WEB_PLATFORM_BASE_URL.toString() + 'page.html',
);
final TEST_WEB_PLATFORM_URL_2 = AqutterWebUri(
  TEST_WEB_PLATFORM_BASE_URL.toString() + 'page-2.html',
);
final TEST_WEB_PLATFORM_URL_3 = AqutterWebUri(
  TEST_WEB_PLATFORM_BASE_URL.toString() + 'heavy-page.html',
);
final TEST_NOT_A_WEBSITE_URL = AqutterWebUri('https://www.notawebsite..com/');
final TEST_CHROME_SAFE_BROWSING_MALWARE = AqutterWebUri(
  'chrome://safe-browsing/match?type=malware',
);
final TEST_PERMISSION_SITE = AqutterWebUri('https://permission.site/');
final TEST_SERVICE_WORKER_URL = AqutterWebUri(
  'https://mdn.github.io/dom-examples/service-worker/simple-service-worker/',
);
final TEST_WEBVIEW_ASSET_LOADER_DOMAIN = 'my.custom.domain.com';
final TEST_WEBVIEW_ASSET_LOADER_URL = AqutterWebUri(
  'https://$TEST_WEBVIEW_ASSET_LOADER_DOMAIN/assets/flutter_assets/test_assets/website/index.html',
);
final TEST_TWA_URL = AqutterWebUri(
  'https://inappwebview.dev/test-twa-postmessage.html',
);
final TEST_CUSTOM_TABS_POST_MESSAGE_URL = AqutterWebUri(
  'https://inappwebview.dev/test-twa-postmessage.html',
);
