part of '../theme.dart';

/// Сущность унаследованная от [ThemeExtension]
/// хранит в себе задаваемые цвета для
/// светлой и темной темы
class ThemeColors extends ThemeExtension<ThemeColors> with ConstStyles {
  /// Цвет N
  late final Color appContainerBackground;

  /// Цвет N
  late final Color appContainerShadow;

  /// Цвет N
  late final Color selectedLabel;

  /// Цвет N
  late final Color unselectedLabel;

  /// Цвет N
  late final Color cursorColor;

  /// Цвет N
  late final Color micIcon;

  /// Цвет N
  late final Color settingsDialogLanguage;

  /// Цвет N
  late final Color buttonColor;

  /// Конструктор [ThemeColors]
  ThemeColors({
    required this.appContainerBackground,
    required this.appContainerShadow,
    required this.selectedLabel,
    required this.unselectedLabel,
    required this.cursorColor,
    required this.micIcon,
    required this.settingsDialogLanguage,
    required this.buttonColor,
  });

  /// Конструктор цветов для светлой темы
  ThemeColors.light() {
    appContainerBackground = appColors.white;
    appContainerShadow = appColors.grey.withOpacity(0.5);
    selectedLabel = appColors.darkestGrey;
    unselectedLabel = appColors.darkestGrey.withOpacity(0.7);
    cursorColor = appColors.pink;
    micIcon = appColors.lightGrey;
    settingsDialogLanguage = appColors.white;
    buttonColor = appColors.grey;
  }

  /// Конструктор цветов для темной темы
  ThemeColors.dark() {
    appContainerBackground = appColors.lightDark;
    appContainerShadow = appColors.darkerGrey.withOpacity(0.2);
    selectedLabel = appColors.darkestGrey;
    unselectedLabel = appColors.darkestGrey.withOpacity(0.7);
    cursorColor = appColors.pink;
    micIcon = appColors.lightGrey;
    settingsDialogLanguage = appColors.lighterDark;
    buttonColor = appColors.pink;
  }

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? appContainerBackground,
    Color? appContainerShadow,
    Color? selectedLabel,
    Color? unselectedLabel,
    Color? cursorColor,
    Color? micIcon,
    Color? settingsDialogLanguage,
    Color? buttonColor,
  }) {
    return ThemeColors(
      appContainerBackground:
          appContainerBackground ?? this.appContainerBackground,
      appContainerShadow: appContainerShadow ?? this.appContainerShadow,
      selectedLabel: selectedLabel ?? this.selectedLabel,
      unselectedLabel: unselectedLabel ?? this.unselectedLabel,
      cursorColor: cursorColor ?? this.cursorColor,
      micIcon: micIcon ?? this.micIcon,
      settingsDialogLanguage:
          settingsDialogLanguage ?? this.settingsDialogLanguage,
      buttonColor: buttonColor ?? this.buttonColor,
    );
  }

  @override
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(
      appContainerBackground:
          Color.lerp(appContainerBackground, other.appContainerBackground, t)!,
      appContainerShadow:
          Color.lerp(appContainerShadow, other.appContainerShadow, t)!,
      selectedLabel: Color.lerp(selectedLabel, other.selectedLabel, t)!,
      unselectedLabel: Color.lerp(unselectedLabel, other.unselectedLabel, t)!,
      cursorColor: Color.lerp(cursorColor, other.cursorColor, t)!,
      micIcon: Color.lerp(micIcon, other.micIcon, t)!,
      settingsDialogLanguage:
          Color.lerp(settingsDialogLanguage, other.settingsDialogLanguage, t)!,
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t)!,
    );
  }
}
