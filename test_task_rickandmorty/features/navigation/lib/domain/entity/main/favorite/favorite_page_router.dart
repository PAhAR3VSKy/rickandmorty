import 'package:auto_route/auto_route.dart';
import 'package:favorite/favorite_widget.dart';
import 'package:navigation/domain/entity/app_route_names.dart';
import 'package:navigation/domain/entity/app_route_paths.dart';

/// путь страницы избранного
const favoritePageRouter = AutoRoute<dynamic>(
  path: AppRoutePaths.favoritePagePath,
  name: AppRouteNames.favoritePage,
  page: FavoritePageWidget,
);
