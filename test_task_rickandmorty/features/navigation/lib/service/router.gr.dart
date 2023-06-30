// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MainRouter.name: (routeData) {
      final args = routeData.argsAs<MainRouterArgs>(
          orElse: () => const MainRouterArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: MainScreen(
          key: args.key,
          wmFactory: args.wmFactory,
        ),
      );
    },
    CharacterPageRouter.name: (routeData) {
      final args = routeData.argsAs<CharacterPageRouterArgs>(
          orElse: () => const CharacterPageRouterArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CharacterPageWidget(
          key: args.key,
          wmFactory: args.wmFactory,
        ),
      );
    },
    FavoritePageRouter.name: (routeData) {
      final args = routeData.argsAs<FavoritePageRouterArgs>(
          orElse: () => const FavoritePageRouterArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: FavoritePageWidget(
          key: args.key,
          wmFactory: args.wmFactory,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'main',
          fullMatch: true,
        ),
        RouteConfig(
          MainRouter.name,
          path: 'main',
          children: [
            RouteConfig(
              CharacterPageRouter.name,
              path: 'character_page_path',
              parent: MainRouter.name,
            ),
            RouteConfig(
              FavoritePageRouter.name,
              path: 'favorite_page_path',
              parent: MainRouter.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [MainScreen]
class MainRouter extends PageRouteInfo<MainRouterArgs> {
  MainRouter({
    Key? key,
    WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel> Function(
            BuildContext)
        wmFactory = initScreenWidgetModelFactory,
    List<PageRouteInfo>? children,
  }) : super(
          MainRouter.name,
          path: 'main',
          args: MainRouterArgs(
            key: key,
            wmFactory: wmFactory,
          ),
          initialChildren: children,
        );

  static const String name = 'MainRouter';
}

class MainRouterArgs {
  const MainRouterArgs({
    this.key,
    this.wmFactory = initScreenWidgetModelFactory,
  });

  final Key? key;

  final WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel> Function(
      BuildContext) wmFactory;

  @override
  String toString() {
    return 'MainRouterArgs{key: $key, wmFactory: $wmFactory}';
  }
}

/// generated route for
/// [CharacterPageWidget]
class CharacterPageRouter extends PageRouteInfo<CharacterPageRouterArgs> {
  CharacterPageRouter({
    Key? key,
    WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel> Function(
            BuildContext)
        wmFactory = initCharacterPageWidgetModelFactory,
  }) : super(
          CharacterPageRouter.name,
          path: 'character_page_path',
          args: CharacterPageRouterArgs(
            key: key,
            wmFactory: wmFactory,
          ),
        );

  static const String name = 'CharacterPageRouter';
}

class CharacterPageRouterArgs {
  const CharacterPageRouterArgs({
    this.key,
    this.wmFactory = initCharacterPageWidgetModelFactory,
  });

  final Key? key;

  final WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel> Function(
      BuildContext) wmFactory;

  @override
  String toString() {
    return 'CharacterPageRouterArgs{key: $key, wmFactory: $wmFactory}';
  }
}

/// generated route for
/// [FavoritePageWidget]
class FavoritePageRouter extends PageRouteInfo<FavoritePageRouterArgs> {
  FavoritePageRouter({
    Key? key,
    WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel> Function(
            BuildContext)
        wmFactory = initFavoritePageWidgetModelFactory,
  }) : super(
          FavoritePageRouter.name,
          path: 'favorite_page_path',
          args: FavoritePageRouterArgs(
            key: key,
            wmFactory: wmFactory,
          ),
        );

  static const String name = 'FavoritePageRouter';
}

class FavoritePageRouterArgs {
  const FavoritePageRouterArgs({
    this.key,
    this.wmFactory = initFavoritePageWidgetModelFactory,
  });

  final Key? key;

  final WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel> Function(
      BuildContext) wmFactory;

  @override
  String toString() {
    return 'FavoritePageRouterArgs{key: $key, wmFactory: $wmFactory}';
  }
}
