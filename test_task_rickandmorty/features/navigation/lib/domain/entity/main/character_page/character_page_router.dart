import 'package:auto_route/auto_route.dart';
import 'package:character_page/character_page_export.dart';
import 'package:navigation/domain/entity/app_route_names.dart';
import 'package:navigation/domain/entity/app_route_paths.dart';

/// Путь до страницы персонажа
const characterPageRouter = AutoRoute<dynamic>(
  path: AppRoutePaths.characterPagePath,
  name: AppRouteNames.characterPage,
  page: CharacterPageWidget,
);
