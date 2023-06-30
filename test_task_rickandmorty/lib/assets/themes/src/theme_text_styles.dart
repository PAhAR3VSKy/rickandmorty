part of '../theme.dart';

/// Сущность наследованая от [ThemeExtension]
/// хранит в себе задаваемые текстовые стили для интерпритации
/// в светлой и темной теме
class ThemeTextStyles extends ThemeExtension<ThemeTextStyles> with ConstStyles {
  /// Название приложения
  late final TextStyle appTitle;

  /// N стиль
  late final TextStyle appDescription;

  /// N стиль
  late final TextStyle labelStyle;

  /// N стиль
  late final TextStyle searchHint;

  /// N стиль
  late final TextStyle searchInput;

  /// N стиль
  late final TextStyle settingsDialogLanguage;

  /// Конструктор [ThemeTextStyles]
  ThemeTextStyles({
    required this.appTitle,
    required this.appDescription,
    required this.labelStyle,
    required this.searchHint,
    required this.searchInput,
    required this.settingsDialogLanguage,
  });

  /// Текстовые стили, соответсвующие светлой теме
  ThemeTextStyles.light() {
    appTitle = appTextStyles.headline1.copyWith(
      color: appColors.darkerGrey,
      fontWeight: FontWeight.w700,
    );
    appDescription = appTextStyles.headline3.copyWith(
      color: appColors.darkerGrey,
      fontWeight: FontWeight.w500,
    );
    labelStyle = appTextStyles.headline1.copyWith(
      fontWeight: FontWeight.w500,
    );
    searchHint = appTextStyles.headline1.copyWith(
      color: appColors.white,
      fontSize: 18,
    );
    searchInput = appTextStyles.headline1.copyWith(
      fontSize: 18,
    );
    settingsDialogLanguage = appTextStyles.headline2.copyWith(
      color: appColors.black,
    );
  }

  /// Текстовые стили, соответсвующие темной теме
  ThemeTextStyles.dark() {
    appTitle = appTextStyles.headline1.copyWith(
      color: appColors.lighterGrey,
      fontWeight: FontWeight.w700,
    );
    appDescription = appTextStyles.headline3.copyWith(
      color: appColors.lightGrey,
      fontWeight: FontWeight.w500,
    );
    labelStyle = appTextStyles.headline1.copyWith(
      fontWeight: FontWeight.w500,
    );
    searchHint = appTextStyles.headline1.copyWith(
      color: appColors.lighterGrey,
      fontSize: 18,
    );
    searchInput = appTextStyles.headline1.copyWith(
      fontSize: 18,
      color: appColors.grey,
    );
    settingsDialogLanguage = appTextStyles.headline2.copyWith(
      color: appColors.grey,
    );
  }

  @override
  ThemeExtension<ThemeTextStyles> copyWith({
    TextStyle? appBarTitle,
    TextStyle? appTitle,
    TextStyle? appDescription,
    TextStyle? labelStyle,
    TextStyle? searchHint,
    TextStyle? searchInput,
  }) {
    return ThemeTextStyles(
      appTitle: appTitle ?? this.appTitle,
      appDescription: appDescription ?? this.appDescription,
      labelStyle: labelStyle ?? this.labelStyle,
      searchHint: searchHint ?? this.searchHint,
      searchInput: searchInput ?? this.searchInput,
      settingsDialogLanguage: settingsDialogLanguage,
    );
  }

  @override
  ThemeExtension<ThemeTextStyles> lerp(
    ThemeExtension<ThemeTextStyles>? other,
    double t,
  ) {
    if (other is! ThemeTextStyles) {
      return this;
    }

    return ThemeTextStyles(
      appTitle: TextStyle.lerp(appTitle, other.appTitle, t)!,
      appDescription: TextStyle.lerp(appDescription, other.appDescription, t)!,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
      searchHint: TextStyle.lerp(searchHint, other.searchHint, t)!,
      searchInput: TextStyle.lerp(searchInput, other.searchInput, t)!,
      settingsDialogLanguage: TextStyle.lerp(
        settingsDialogLanguage,
        other.settingsDialogLanguage,
        t,
      )!,
    );
  }
}
