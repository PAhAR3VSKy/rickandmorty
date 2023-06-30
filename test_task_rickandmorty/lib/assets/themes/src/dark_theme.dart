part of '../theme.dart';

/// создание темной темы
ThemeData createDarkTheme() {
  return ThemeData(
    textTheme: createTextTheme(),
    scaffoldBackgroundColor: _AppColors.instance.lighterDark,
    extensions: <ThemeExtension<dynamic>>[
      ThemeColors.dark(),
      ThemeTextStyles.dark(),
    ],
  );
}
