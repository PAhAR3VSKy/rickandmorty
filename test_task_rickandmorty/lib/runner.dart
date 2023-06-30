import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:surf_logger/surf_logger.dart';
import 'package:test_task_rickandmorty/app/app.dart';
import 'package:test_task_rickandmorty/app/di/app_scope.dart';
import 'package:test_task_rickandmorty/shortcut/shortcuts.dart';

/// App launch.
Future<void> run() async {
  /// It must be called so that the orientation does not fall.
  WidgetsFlutterBinding.ensureInitialized();

  /// Fix orientation.
  // TODO(init-project): change as needed or remove.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Hive.initFlutter();
  Hive.openBox('favorites');

  _initLogger();
  _runApp();
}

void _runApp() {
  runZonedGuarded<Future<void>>(
    () async {
      final appScope = AppScope();
      await appScope.init();
      await _initQuickActions(appScope);
      runApp(App(
        scope: appScope,
      ));
    },
    (exception, stack) {
      // TODO(init-project): Инициализировать Crashlytics.
      // FirebaseCrashlytics.instance.recordError(exception, stack);
    },
  );
}

Future<void> _initQuickActions(AppScope appScope) async {
  const quickActions = QuickActions();
  await quickActions.initialize((type) {
    if (type == ShortcutItems.actionDebugBottomSheet.type) {
      final g =
          appScope.router.buildPageRoutesStack('temp/debug_tab/bottom_sheet_t');
      appScope.router.pushAll(g!);
    }
    if (type == ShortcutItems.actionDetailDebug.type) {
      if (appScope.router.canNavigateBack) {
        appScope.router.pushNamed('temp/debug_tab/debug/detail');
      } else {
        final g =
            appScope.router.buildPageRoutesStack('temp/debug_tab/debug/detail');
        appScope.router.pushAll(g!);
      }
    }
  });
  await quickActions.setShortcutItems(ShortcutItems.items);
}

void _initLogger() {
  Logger.addStrategy(DebugLogStrategy());
  Logger.addStrategy(RemoteLogStrategy());
}
