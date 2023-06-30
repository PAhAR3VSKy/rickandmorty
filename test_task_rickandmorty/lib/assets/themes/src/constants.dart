// ignore_for_file: public_member_api_docs

part of '../theme.dart';

/// mixin для передачи стилей в фичи
mixin ConstStyles {
  /// Константные цвета проекта
  @protected
  _AppColors get appColors => _AppColors.instance;

  /// Константные стили проекта
  @protected
  _AppTextStyles get appTextStyles => _AppTextStyles.instance;
}

/// Текстовые стили
class _AppTextStyles {
  static _AppTextStyles? _instance;

  final headline1 = const TextStyle(fontWeight: FontWeight.w400, fontSize: 16);
  final headline2 = const TextStyle(fontWeight: FontWeight.w400, fontSize: 14);
  final headline3 = const TextStyle(fontWeight: FontWeight.w400, fontSize: 12);

  //ignore: prefer_constructors_over_static_methods
  static _AppTextStyles get instance {
    _instance ??= _AppTextStyles();
    return _instance!;
  }
}

/// Цвета для приложения
class _AppColors {
  static _AppColors? _instance;

  final white = Colors.white;
  final black = Colors.black;
  final grey = Colors.grey;
  final pink = Colors.pink;

  final darkerGrey = const Color(0xFF6C6C6C);
  final darkestGrey = const Color(0xFF626262);
  final lighterGrey = const Color(0xFF959595);
  final lightGrey = const Color(0xFF5d5d5d);

  final lighterDark = const Color(0xFF272727);
  final lightDark = const Color(0xFF1b1b1b);

  //ignore: prefer_constructors_over_static_methods
  static _AppColors get instance {
    _instance ??= _AppColors();
    return _instance!;
  }
}
