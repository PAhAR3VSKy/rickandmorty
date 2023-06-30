part of '../theme.dart';

/// создание светлой темы
ThemeData createLightTheme() {
  return ThemeData(
    textTheme: createTextTheme(),
    scaffoldBackgroundColor: _AppColors.instance.white,
    extensions: <ThemeExtension<dynamic>>[
      ThemeColors.light(),
      ThemeTextStyles.light(),
    ],
  );
}
