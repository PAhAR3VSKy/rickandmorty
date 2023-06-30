import 'package:flutter/material.dart';
import 'package:test_task_rickandmorty/assets/themes/theme.dart';
import 'package:test_task_rickandmorty/generated/l10n.dart';

/// Расширение BuildContext
extension BuildContextExt on BuildContext {
  /// Глобальная локализация приложения
  AppLocalizations get localizations => AppLocalizations.of(this);

  /// [ThemeTextStyles]
  ThemeTextStyles get text => Theme.of(this).extension<ThemeTextStyles>()!;

  /// [ThemeTextStyles]
  ThemeColors get color => Theme.of(this).extension<ThemeColors>()!;

  /// флаг показывающий - какая сейчас системная тема
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
