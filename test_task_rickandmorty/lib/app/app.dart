import 'package:character_page/di/character_page_scope.dart';
import 'package:common/widgets/di_scope/di_scope.dart';
import 'package:favorite/di/favorite_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:main_page/di/main_scope.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:test_task_rickandmorty/app/di/app_scope.dart';
import 'package:test_task_rickandmorty/assets/themes/theme.dart';
import 'package:test_task_rickandmorty/config/app_config.dart';
import 'package:test_task_rickandmorty/config/debug_options.dart';
import 'package:test_task_rickandmorty/config/environment/environment.dart';
import 'package:test_task_rickandmorty/generated/l10n.dart';

/// App widget.
class App extends StatefulWidget {
  /// Scope приложения
  final AppScope scope;

  /// Create an instance App.
  const App({required this.scope, Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final quickActions = const QuickActions();

  late IAppScope _scope;

  @override
  void initState() {
    super.initState();
    _scope = widget.scope..applicationRebuilder = _rebuildApplication;
    final environment = Environment<AppConfig>.instance();
    if (!environment.isRelease) {
      environment.createLogHistoryStrategy();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DiScope<IAppScope>(
      key: ObjectKey(_scope),
      factory: () {
        return _scope;
      },
      child: MultiDiScope(
        scopes: [
          MultiDiScopeItem<IMainScope>(
            factory: () {
              return MainScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),
          MultiDiScopeItem<ICharacterPageScope>(
            factory: () {
              return CharacterPageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
              );
            },
          ),
          MultiDiScopeItem<IFavoritePageScope>(
            factory: () {
              return FavoritePageScope(
                dio: _scope.dio,
                errorHandler: _scope.errorHandler,
                trackedNotifier: _scope.trackedNotifier,
              );
            },
          ),
        ],
        child: MaterialApp.router(
          /// Localization.
          locale: _localizations.first,
          localizationsDelegates: _localizationsDelegates,
          supportedLocales: _localizations,

          /// Init themes
          darkTheme: createDarkTheme(),
          theme: createLightTheme(),

          /// Debug configuration.
          showPerformanceOverlay: _getDebugConfig().showPerformanceOverlay,
          debugShowMaterialGrid: _getDebugConfig().debugShowMaterialGrid,
          checkerboardRasterCacheImages:
              _getDebugConfig().checkerboardRasterCacheImages,
          checkerboardOffscreenLayers:
              _getDebugConfig().checkerboardOffscreenLayers,
          showSemanticsDebugger: _getDebugConfig().showSemanticsDebugger,
          debugShowCheckedModeBanner:
              _getDebugConfig().debugShowCheckedModeBanner,

          /// This is for navigation.
          routeInformationParser: _scope.router.defaultRouteParser(),
          routerDelegate: _scope.router.delegate(),
        ),
      ),
    );
  }

  DebugOptions _getDebugConfig() {
    return Environment<AppConfig>.instance().config.debugOptions;
  }

  void _rebuildApplication() {
    setState(() {
      _scope = widget.scope..applicationRebuilder = _rebuildApplication;
    });
  }
}

// You need to customize for your project.
const _localizations = [Locale('ru', 'RU')];

const _localizationsDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  AppLocalizations.delegate,
];
