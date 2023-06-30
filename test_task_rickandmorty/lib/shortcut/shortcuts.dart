import 'package:quick_actions/quick_actions.dart';

/// Класс,
class ShortcutItems {
  /// Быстрый переход на боттом щит дебага
  static const actionDebugBottomSheet =
      ShortcutItem(type: 'debug_bottom_sheet', localizedTitle: 'Debug sheet');

  /// Быстрый переход на страницу с подробным дебагом
  static const actionDetailDebug =
      ShortcutItem(type: 'detail_debug', localizedTitle: 'Detail debug');

  /// Лист [ShortcutItem] для приложения
  static final items = [
    actionDebugBottomSheet,
    actionDetailDebug,
  ];
}
