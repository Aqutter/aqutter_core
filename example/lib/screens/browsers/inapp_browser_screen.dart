import 'package:flutter/material.dart';
import 'package:aqutter_core/aqutter_core.dart';
import 'package:aqutter_core_example/widgets/common/app_drawer.dart';
import 'package:aqutter_core_example/widgets/common/appbar_loading_indicator.dart';
import 'package:aqutter_core_example/widgets/common/event_log_card.dart';
import 'package:aqutter_core_example/widgets/common/method_card.dart';
import 'package:aqutter_core_example/widgets/common/status_card.dart';
import 'package:aqutter_core_example/utils/support_checker.dart';
import 'package:aqutter_core_example/utils/responsive_utils.dart';
import 'package:aqutter_core_example/widgets/common/parameter_dialog.dart';
import 'package:aqutter_core_example/widgets/common/method_result_history.dart';
import 'package:provider/provider.dart';
import 'package:aqutter_core_example/providers/event_log_provider.dart';
import 'package:aqutter_core_example/models/event_log_entry.dart';
import 'package:aqutter_core_example/providers/settings_manager.dart';
import 'package:aqutter_core_example/widgets/common/profile_selector_card.dart';

/// Custom AqutterBrowser implementation for testing
class AqutterTestBrowser extends AqutterBrowser {
  final void Function(String event, Map<String, dynamic>? data)? onEvent;

  AqutterTestBrowser({this.onEvent, AqutterWebViewEnvironment? webViewEnvironment})
    : super(webViewEnvironment: webViewEnvironment);

  @override
  void onBrowserCreated() {
    onEvent?.call(AqutterPlatformBrowserEventsMethod.onBrowserCreated.name, {
      'id': id,
    });
  }

  @override
  void onLoadStart(AqutterWebUri? url) {
    onEvent?.call(AqutterPlatformBrowserEventsMethod.onLoadStart.name, {
      'url': url?.toString(),
    });
  }

  @override
  void onLoadStop(AqutterWebUri? url) {
    onEvent?.call(AqutterPlatformBrowserEventsMethod.onLoadStop.name, {
      'url': url?.toString(),
    });
  }

  @override
  void onReceivedError(AqutterWebResourceRequest request, AqutterWebResourceError error) {
    onEvent?.call(AqutterPlatformBrowserEventsMethod.onReceivedError.name, {
      'url': request.url.toString(),
      'errorType': error.type.name(),
      'description': error.description,
    });
  }

  @override
  void onProgressChanged(int progress) {
    onEvent?.call(AqutterPlatformBrowserEventsMethod.onProgressChanged.name, {
      'progress': progress,
    });
  }

  @override
  void onExit() {
    onEvent?.call(AqutterPlatformBrowserEventsMethod.onExit.name, null);
  }

  @override
  void onMainWindowWillClose() {
    onEvent?.call(
      AqutterPlatformBrowserEventsMethod.onMainWindowWillClose.name,
      null,
    );
  }

  @override
  void onConsoleMessage(AqutterConsoleMessage consoleMessage) {
    onEvent?.call(AqutterPlatformBrowserEventsMethod.onConsoleMessage.name, {
      'message': consoleMessage.message,
      'level': consoleMessage.messageLevel.name,
    });
  }
}

/// Screen for testing AqutterBrowser functionality
class AqutterBrowserScreen extends StatefulWidget {
  const AqutterBrowserScreen({super.key});

  @override
  State<AqutterBrowserScreen> createState() => _AqutterBrowserScreenState();
}

class _AqutterBrowserScreenState extends State<AqutterBrowserScreen> {
  final TextEditingController _menuItemIdController = TextEditingController();
  final TextEditingController _menuItemTitleController = TextEditingController(
    text: 'Custom Menu Item',
  );

  AqutterTestBrowser? _browser;
  bool _isLoading = false;
  bool _browserOpened = false;
  final List<AqutterBrowserMenuItem> _menuItems = [];
  bool _isInitialized = false;
  int _lastEnvironmentRevision = -1;

  final Map<String, List<MethodResultEntry>> _methodHistory = {};
  final Map<String, int> _selectedHistoryIndex = {};
  static const int _maxHistoryEntries = 3;

  String get _initStatusKey => AqutterPlatformBrowserMethod.openUrlRequest.name;

  void _initBrowser(AqutterWebViewEnvironment? webViewEnvironment) {
    try {
      _browser = AqutterTestBrowser(
        webViewEnvironment: webViewEnvironment,
        onEvent: (event, data) {
          _logEvent(EventType.ui, event, data: data);
          if (event == AqutterPlatformBrowserEventsMethod.onExit.name) {
            setState(() => _browserOpened = false);
          }
        },
      );
    } catch (e) {
      _showInitError('Unable to create browser: $e');
    }
  }

  String _staticMethodName(AqutterPlatformBrowserMethod method) {
    return '${method.name} (static)';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final settingsManager = context.watch<SettingsManager>();

    if (!_isInitialized) {
      _isInitialized = true;
      _lastEnvironmentRevision = settingsManager.environmentRevision;
      _initBrowser(settingsManager.webViewEnvironment);
      return;
    }

    if (_lastEnvironmentRevision != settingsManager.environmentRevision) {
      _lastEnvironmentRevision = settingsManager.environmentRevision;
      _handleEnvironmentChange(settingsManager.webViewEnvironment);
    }
  }

  @override
  void dispose() {
    _menuItemIdController.dispose();
    _menuItemTitleController.dispose();
    _browser?.dispose();
    super.dispose();
  }

  void _logEvent(EventType type, String message, {Map<String, dynamic>? data}) {
    context.read<EventLogProvider>().addEvent(
      EventLogEntry(
        timestamp: DateTime.now(),
        eventType: type,
        message: message,
        data: data,
      ),
    );
  }

  Future<void> _openUrlRequest() async {
    final settingsManager = context.read<SettingsManager>();
    final params = await showParameterDialog(
      context: context,
      title: AqutterPlatformBrowserMethod.openUrlRequest.name,
      parameters: {
        'url': 'https://flutter.dev',
        'toolbarTopBackgroundColor': Colors.blue,
        'presentationStyle': 'FULL_SCREEN',
        'javaScriptEnabled': true,
      },
      requiredPaths: ['url'],
    );

    if (params == null) return;
    final url = params['url']?.toString() ?? '';
    if (url.isEmpty) {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.openUrlRequest.name,
        'Please enter a URL',
        isError: true,
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final baseSettings = settingsManager.buildSettings();
      final webViewSettings =
          AqutterWebViewSettings.fromMap({
            ...baseSettings.toMap(),
            'javaScriptEnabled':
                params['javaScriptEnabled'] as bool? ??
                baseSettings.javaScriptEnabled ??
                true,
          }) ??
          AqutterWebViewSettings();
      await _browser?.openUrlRequest(
        urlRequest: AqutterURLRequest(url: AqutterWebUri(url)),
        settings: AqutterBrowserClassSettings(
          browserSettings: AqutterBrowserSettings(
            toolbarTopBackgroundColor:
                params['toolbarTopBackgroundColor'] as Color?,
            presentationStyle: _parseModalPresentationStyle(
              params['presentationStyle']?.toString(),
            ),
          ),
          webViewSettings: webViewSettings,
        ),
      );
      setState(() => _browserOpened = true);
      _recordMethodResult(
        AqutterPlatformBrowserMethod.openUrlRequest.name,
        'Browser opened with URL',
        isError: false,
      );
    } catch (e) {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.openUrlRequest.name,
        'Error opening browser: $e',
        isError: true,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _openFile() async {
    final settingsManager = context.read<SettingsManager>();
    final params = await showParameterDialog(
      context: context,
      title: AqutterPlatformBrowserMethod.openFile.name,
      parameters: {
        'assetFilePath': 'assets/index.html',
        'toolbarTopBackgroundColor': Colors.green,
      },
      requiredPaths: ['assetFilePath'],
    );

    if (params == null) return;
    final assetFilePath = params['assetFilePath']?.toString() ?? '';
    if (assetFilePath.isEmpty) {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.openFile.name,
        'Please enter an asset file path',
        isError: true,
      );
      return;
    }
    setState(() => _isLoading = true);
    try {
      await _browser?.openFile(
        assetFilePath: assetFilePath,
        settings: AqutterBrowserClassSettings(
          browserSettings: AqutterBrowserSettings(
            toolbarTopBackgroundColor:
                params['toolbarTopBackgroundColor'] as Color?,
          ),
          webViewSettings: settingsManager.buildSettings(),
        ),
      );
      setState(() => _browserOpened = true);
      _recordMethodResult(
        AqutterPlatformBrowserMethod.openFile.name,
        'Browser opened with file',
        isError: false,
      );
    } catch (e) {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.openFile.name,
        'Error opening file: $e',
        isError: true,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _openData() async {
    final settingsManager = context.read<SettingsManager>();
    final params = await showParameterDialog(
      context: context,
      title: AqutterPlatformBrowserMethod.openData.name,
      parameters: {
        'data':
            '<html><body><h1>Hello ${AqutterBrowser}!</h1><p>This is HTML data.</p></body></html>',
        'mimeType': 'text/html',
        'encoding': 'utf8',
        'toolbarTopBackgroundColor': Colors.purple,
      },
      requiredPaths: ['data'],
    );

    if (params == null) return;
    final data = params['data']?.toString() ?? '';
    if (data.isEmpty) {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.openData.name,
        'Please enter HTML data',
        isError: true,
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _browser?.openData(
        data: data,
        mimeType: params['mimeType']?.toString() ?? 'text/html',
        encoding: params['encoding']?.toString() ?? 'utf8',
        settings: AqutterBrowserClassSettings(
          browserSettings: AqutterBrowserSettings(
            toolbarTopBackgroundColor:
                params['toolbarTopBackgroundColor'] as Color?,
          ),
          webViewSettings: settingsManager.buildSettings(),
        ),
      );
      setState(() => _browserOpened = true);
      _recordMethodResult(
        AqutterPlatformBrowserMethod.openData.name,
        'Browser opened with data',
        isError: false,
      );
    } catch (e) {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.openData.name,
        'Error opening data: $e',
        isError: true,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _openWithSystemBrowser() async {
    final params = await showParameterDialog(
      context: context,
      title: AqutterPlatformBrowserMethod.openWithSystemBrowser.name,
      parameters: {'url': 'https://flutter.dev'},
      requiredPaths: ['url'],
    );

    if (params == null) return;
    final url = params['url']?.toString() ?? '';
    if (url.isEmpty) {
      _recordMethodResult(
        _staticMethodName(AqutterPlatformBrowserMethod.openWithSystemBrowser),
        'Please enter a URL',
        isError: true,
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await AqutterBrowser.openWithSystemBrowser(url: AqutterWebUri(url));
      _recordMethodResult(
        _staticMethodName(AqutterPlatformBrowserMethod.openWithSystemBrowser),
        'Opened in system browser',
        isError: false,
      );
    } catch (e) {
      _recordMethodResult(
        _staticMethodName(AqutterPlatformBrowserMethod.openWithSystemBrowser),
        'Error opening system browser: $e',
        isError: true,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _addMenuItem() {
    final id = _menuItemIdController.text.trim();
    final title = _menuItemTitleController.text.trim();

    if (id.isEmpty || title.isEmpty) {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.addMenuItem.name,
        'Please enter menu item ID and title',
        isError: true,
      );
      return;
    }

    final menuItem = AqutterBrowserMenuItem(
      id: id.hashCode,
      title: title,
      onClick: () {
        _logEvent(EventType.ui, 'Menu item clicked', data: {'id': id});
        _recordMethodResult(
          AqutterPlatformBrowserMethod.addMenuItem.name,
          'Menu item "$title" clicked',
          isError: false,
        );
      },
    );

    _browser?.addMenuItem(menuItem);
    setState(() {
      _menuItems.add(menuItem);
    });
    _menuItemIdController.clear();
    _recordMethodResult(
      AqutterPlatformBrowserMethod.addMenuItem.name,
      'Menu item added',
      isError: false,
    );
  }

  void _removeMenuItem(AqutterBrowserMenuItem menuItem) {
    final removed = _browser?.removeMenuItem(menuItem) ?? false;
    if (removed) {
      setState(() {
        _menuItems.remove(menuItem);
      });
      _recordMethodResult(
        AqutterPlatformBrowserMethod.removeMenuItem.name,
        'Menu item removed',
        isError: false,
      );
    } else {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.removeMenuItem.name,
        'Failed to remove menu item',
        isError: true,
      );
    }
  }

  Future<void> _show() async {
    setState(() => _isLoading = true);
    try {
      await _browser?.show();
      _recordMethodResult(
        AqutterPlatformBrowserMethod.show.name,
        'Browser shown',
        isError: false,
      );
    } catch (e) {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.show.name,
        'Error showing browser: $e',
        isError: true,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _hide() async {
    setState(() => _isLoading = true);
    try {
      await _browser?.hide();
      _recordMethodResult(
        AqutterPlatformBrowserMethod.hide.name,
        'Browser hidden',
        isError: false,
      );
    } catch (e) {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.hide.name,
        'Error hiding browser: $e',
        isError: true,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _close() async {
    setState(() => _isLoading = true);
    try {
      await _browser?.close();
      setState(() => _browserOpened = false);
      _recordMethodResult(
        AqutterPlatformBrowserMethod.close.name,
        'Browser closed',
        isError: false,
      );
    } catch (e) {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.close.name,
        'Error closing browser: $e',
        isError: true,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _isHidden() async {
    setState(() => _isLoading = true);
    try {
      final hidden = await _browser?.isHidden();
      _recordMethodResult(
        AqutterPlatformBrowserMethod.isHidden.name,
        'Browser is hidden: $hidden',
        isError: false,
      );
    } catch (e) {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.isHidden.name,
        'Error checking hidden state: $e',
        isError: true,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _getSettings() async {
    setState(() => _isLoading = true);
    try {
      final settings = await _browser?.getSettings();
      _showSettingsDialog(settings);
      _recordMethodResult(
        AqutterPlatformBrowserMethod.getSettings.name,
        'Settings dialog opened',
        isError: false,
      );
    } catch (e) {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.getSettings.name,
        'Error getting settings: $e',
        isError: true,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _setSettings() async {
    final params = await showParameterDialog(
      context: context,
      title: AqutterPlatformBrowserMethod.setSettings.name,
      parameters: {
        'toolbarTopBackgroundColor': Colors.orange,
        'hideToolbarTop': false,
      },
    );

    if (params == null) return;
    setState(() => _isLoading = true);
    try {
      await _browser?.setSettings(
        settings: AqutterBrowserClassSettings(
          browserSettings: AqutterBrowserSettings(
            toolbarTopBackgroundColor:
                params['toolbarTopBackgroundColor'] as Color?,
            hideToolbarTop: params['hideToolbarTop'] as bool?,
          ),
        ),
      );
      _recordMethodResult(
        AqutterPlatformBrowserMethod.setSettings.name,
        'Settings updated',
        isError: false,
      );
    } catch (e) {
      _recordMethodResult(
        AqutterPlatformBrowserMethod.setSettings.name,
        'Error setting settings: $e',
        isError: true,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _checkIsOpened() {
    final opened = _browser?.isOpened() ?? false;
    _recordMethodResult(
      AqutterPlatformBrowserMethod.isOpened.name,
      'Browser is opened: $opened',
      isError: false,
    );
  }

  void _showSettingsDialog(AqutterBrowserClassSettings? settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Browser Settings'),
        content: SingleChildScrollView(
          child: Text(settings?.toMap().toString() ?? 'No settings'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _recordMethodResult(
    String methodName,
    String message, {
    required bool isError,
    dynamic value,
  }) {
    setState(() {
      final entries = List<MethodResultEntry>.from(
        _methodHistory[methodName] ?? const [],
      );
      entries.insert(
        0,
        MethodResultEntry(
          message: message,
          isError: isError,
          timestamp: DateTime.now(),
          value: value,
        ),
      );
      if (entries.length > _maxHistoryEntries) {
        entries.removeRange(_maxHistoryEntries, entries.length);
      }
      _methodHistory[methodName] = entries;
      _selectedHistoryIndex[methodName] = 0;
    });
  }

  Widget _buildMethodHistory(String methodName, {String? title}) {
    final entries = _methodHistory[methodName] ?? const [];
    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }
    return MethodResultHistory(
      entries: entries,
      selectedIndex: _selectedHistoryIndex[methodName],
      title: title ?? methodName,
      onSelected: (index) {
        setState(() => _selectedHistoryIndex[methodName] = index);
      },
    );
  }

  void _showInitError(String message) {
    _recordMethodResult(_initStatusKey, message, isError: true);
  }

  void _handleEnvironmentChange(AqutterWebViewEnvironment? environment) {
    if (_browserOpened) {
      _browser?.close();
    }
    _browser?.dispose();
    _initBrowser(environment);
    setState(() => _browserOpened = false);
  }

  Widget _buildInitStatusSection() {
    final entries = _methodHistory[_initStatusKey] ?? const [];
    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        _buildMethodHistory(_initStatusKey, title: 'Initialization'),
        const SizedBox(height: 16),
      ],
    );
  }

  AqutterModalPresentationStyle _parseModalPresentationStyle(String? value) {
    if (value == null || value.isEmpty) {
      return AqutterModalPresentationStyle.FULL_SCREEN;
    }
    return AqutterModalPresentationStyle.values.firstWhere(
      (style) => style.name().toLowerCase() == value.toLowerCase(),
      orElse: () => AqutterModalPresentationStyle.FULL_SCREEN,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$AqutterBrowser'),
        actions: [
          AppBarLoadingIndicator(isLoading: _isLoading),
          IconButton(
            icon: const Icon(Icons.clear_all),
            tooltip: 'Clear Events',
            onPressed: () {
              context.read<EventLogProvider>().clear();
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ListView(
        key: const Key('inapp_browser_main_list'),
        padding: const EdgeInsets.all(16),
        children: [
          ProfileSelectorCard(
            onEditSettingsProfile: () =>
                Navigator.pushNamed(context, '/settings'),
          ),
          const SizedBox(height: 16),
          _buildStatusCard(),
          const SizedBox(height: 16),
          _buildInitStatusSection(),
          _buildOpenMethods(),
          const SizedBox(height: 16),
          _buildMenuItemsSection(),
          const SizedBox(height: 16),
          _buildControlMethods(),
          const SizedBox(height: 16),
          _buildSettingsMethods(),
          const SizedBox(height: 16),
          const EventLogCard(maxEvents: 20, height: 200),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return StatusCard(
      isActive: _browserOpened,
      activeTitle: 'Browser Open',
      inactiveTitle: 'Browser Closed',
      activeIcon: Icons.web,
      inactiveIcon: Icons.web_asset_off,
      subtitle: 'ID: ${_browser?.id ?? "N/A"}',
    );
  }

  Widget _buildOpenMethods() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Open Methods',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildMethodTile(
              AqutterPlatformBrowserMethod.openUrlRequest.name,
              'Open browser with URL request',
              AqutterPlatformBrowserMethod.openUrlRequest,
              _openUrlRequest,
            ),
            _buildMethodTile(
              AqutterPlatformBrowserMethod.openFile.name,
              'Open browser with local file',
              AqutterPlatformBrowserMethod.openFile,
              _openFile,
            ),
            _buildMethodTile(
              AqutterPlatformBrowserMethod.openData.name,
              'Open browser with HTML data',
              AqutterPlatformBrowserMethod.openData,
              _openData,
            ),
            _buildMethodTile(
              _staticMethodName(
                AqutterPlatformBrowserMethod.openWithSystemBrowser,
              ),
              'Open URL in system browser',
              AqutterPlatformBrowserMethod.openWithSystemBrowser,
              _openWithSystemBrowser,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItemsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Menu Items',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = ResponsiveBreakpoints.isMobileWidth(
                  constraints.maxWidth,
                );
                const spacing = 8.0;
                const buttonWidth = 96.0;
                final availableWidth = constraints.maxWidth;
                final remainingWidth = isMobile
                    ? availableWidth
                    : (availableWidth - buttonWidth - spacing * 2);
                final idWidth = isMobile
                    ? availableWidth
                    : remainingWidth * 0.35;
                final titleWidth = isMobile
                    ? availableWidth
                    : remainingWidth * 0.65;

                return Wrap(
                  key: const Key('inapp_browser_menu_items_layout'),
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    SizedBox(
                      width: idWidth,
                      child: TextField(
                        key: const Key('inapp_browser_menu_id_field'),
                        controller: _menuItemIdController,
                        decoration: const InputDecoration(
                          labelText: 'ID',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: titleWidth,
                      child: TextField(
                        key: const Key('inapp_browser_menu_title_field'),
                        controller: _menuItemTitleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: isMobile ? availableWidth : buttonWidth,
                      child: ElevatedButton(
                        key: const Key('inapp_browser_menu_add_button'),
                        onPressed: _addMenuItem,
                        child: const Text('Add'),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            _buildMethodHistory(AqutterPlatformBrowserMethod.addMenuItem.name),
            _buildMethodHistory(AqutterPlatformBrowserMethod.removeMenuItem.name),
            const SizedBox(height: 12),
            if (_menuItems.isNotEmpty) ...[
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  return ListTile(
                    dense: true,
                    title: Text(item.title),
                    subtitle: Text('ID: ${item.id}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: () => _removeMenuItem(item),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildControlMethods() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Control Methods',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildMethodTile(
              AqutterPlatformBrowserMethod.show.name,
              'Show the browser',
              AqutterPlatformBrowserMethod.show,
              _browserOpened ? _show : null,
            ),
            _buildMethodTile(
              AqutterPlatformBrowserMethod.hide.name,
              'Hide the browser',
              AqutterPlatformBrowserMethod.hide,
              _browserOpened ? _hide : null,
            ),
            _buildMethodTile(
              AqutterPlatformBrowserMethod.close.name,
              'Close the browser',
              AqutterPlatformBrowserMethod.close,
              _browserOpened ? _close : null,
            ),
            _buildMethodTile(
              AqutterPlatformBrowserMethod.isHidden.name,
              'Check if browser is hidden',
              AqutterPlatformBrowserMethod.isHidden,
              _browserOpened ? _isHidden : null,
            ),
            _buildMethodTile(
              AqutterPlatformBrowserMethod.isOpened.name,
              'Check if browser is opened',
              AqutterPlatformBrowserMethod.isOpened,
              _checkIsOpened,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsMethods() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings Methods',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildMethodTile(
              AqutterPlatformBrowserMethod.getSettings.name,
              'Get current browser settings',
              AqutterPlatformBrowserMethod.getSettings,
              _browserOpened ? _getSettings : null,
            ),
            _buildMethodTile(
              AqutterPlatformBrowserMethod.setSettings.name,
              'Update browser settings',
              AqutterPlatformBrowserMethod.setSettings,
              _browserOpened ? _setSettings : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodTile(
    String methodName,
    String description,
    AqutterPlatformBrowserMethod method,
    VoidCallback? onPressed,
  ) {
    final supportedPlatforms = SupportCheckHelper.supportedPlatformsForMethod(
      method: method,
      checker: AqutterBrowser.isMethodSupported,
    );

    return MethodTile(
      methodName: methodName,
      description: description,
      supportedPlatforms: supportedPlatforms,
      onRun: !_isLoading ? onPressed : null,
      historyEntries: _methodHistory[methodName],
      selectedHistoryIndex: _selectedHistoryIndex[methodName],
      onHistorySelected: (index) {
        setState(() => _selectedHistoryIndex[methodName] = index);
      },
    );
  }
}
