import 'package:auto_route/auto_route.dart';
import 'package:main_page/screen/main_screen.dart';
import 'package:navigation/domain/entity/app_route_names.dart';
import 'package:navigation/domain/entity/app_route_paths.dart';
import 'package:navigation/domain/entity/main/character_page/character_page_router.dart';
import 'package:navigation/domain/entity/main/favorite/favorite_page_router.dart';

/// All routes for the temp feature.
const mainRoutes = AutoRoute<dynamic>(
  initial: true,
  path: AppRoutePaths.mainPath,
  name: AppRouteNames.mainScreen,
  page: MainScreen,
  children: [
    characterPageRouter,
    favoritePageRouter,
  ],
);
