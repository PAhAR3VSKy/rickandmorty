part of '../theme.dart';

/// Создание текстовых тем
TextTheme createTextTheme() {
  return TextTheme(
    displayLarge: _AppTextStyles.instance.headline1,
    displayMedium: _AppTextStyles.instance.headline2,
    displaySmall: _AppTextStyles.instance.headline3,
  );
}
