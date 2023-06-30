import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:main_page/di/main_scope.dart';
import 'package:main_page/screen/main_screen.dart';
import 'package:main_page/screen/main_screen_model.dart';
import 'package:navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:test_task_rickandmorty/generated/l10n.dart';

/// Interface of [MainScreenWidgetModel].
abstract class IDebugWidgetModel extends IWidgetModel {
  /// Routes for [AutoTabsRouter.tabBar].
  List<PageRouteInfo<dynamic>> get routes;

  /// Items for [BottomNavigationBar].
  List<BottomNavigationBarItem> get navigationBarItems;

  /// Локализация
  AppLocalizations get appLocalizations;

  /// Title for appbar, depends on current selected page.
  String appBarTitle(RouteData topRoute);
}

/// Factory for [MainScreenWidgetModel].
MainScreenWidgetModel initScreenWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IMainScope>();
  final model = scope.model;
  final appLocalizations = AppLocalizations.of(context);
  return MainScreenWidgetModel(
    model,
    appLocalizations,
  );
}

/// Widget model for [MainScreen].
class MainScreenWidgetModel extends WidgetModel<MainScreen, MainScreenModel> {
  final AppLocalizations _appLocalizations;

  final _defaultNavBarItems = [
    const BottomNavigationBarItem(
      label: 'character_page',
      icon: Icon(Icons.account_box),
    ),
    const BottomNavigationBarItem(
      label: 'favorite_page',
      icon: Icon(Icons.favorite),
    ),
  ];

  /// Роуты
  List<PageRouteInfo> get routes => _routes;

  /// Элементы бара навигации
  List<BottomNavigationBarItem> get navigationBarItems => _navigationBarItems;

  /// Локализация
  AppLocalizations get appLocalizations => _appLocalizations;

  List<PageRouteInfo> get _routes {
    final defaultRoutes = <PageRouteInfo>[
      CharacterPageRouter(),
      FavoritePageRouter(),
    ];
    return defaultRoutes;
  }

  List<BottomNavigationBarItem> get _navigationBarItems {
    final navBarItems = [..._defaultNavBarItems];
    return navBarItems;
  }

  /// Create an instance [MainScreenWidgetModel].
  /// Страница затычка для навигации по созданным страницам
  MainScreenWidgetModel(
    MainScreenModel model,
    AppLocalizations appLocalizations,
  )   : _appLocalizations = appLocalizations,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
