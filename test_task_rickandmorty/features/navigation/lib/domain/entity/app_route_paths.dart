/// List of all the paths that are used to navigate in temp feature.
///
/// Have to been filled with the entries like this:
/// ```dart
/// /// Path description.
/// static const String screenPath = 'screenPath';
/// ```
abstract class AppRoutePaths {
  /// Path to main screen.
  static const String mainPath = 'main';

  /// Путь до страницы с персонажами
  static const String characterPagePath = 'character_page_path';

  /// Путь до страницы избранного
  static const String favoritePagePath = 'favorite_page_path';
}
