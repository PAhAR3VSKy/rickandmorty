import 'package:hive_flutter/hive_flutter.dart';

/// Интерфейс TrackedNotifier
abstract class ITrackedNotifier {
  /// Конструктор [ITrackedNotifier]
  ITrackedNotifier();

  /// Добавление/удаление из избранного
  Future<void> onTracked(int id);

  /// Загрузка списка
  Future<List<dynamic>> load();

  /// очистка
  void clear();

  /// Проверка
  Future<bool> isTracked(int id);
}

/// TrackedNotifier
class TrackedNotifier extends ITrackedNotifier {
  /// Конструктор [TrackedNotifier]
  TrackedNotifier();

  @override
  Future<void> clear() async {
    var box = await Hive.openBox('favorites');
    if (box.isEmpty || box.values.isEmpty) return;
    await box.clear();
    await box.close();
  }

  @override
  Future<bool> isTracked(int id) async {
    var box = await Hive.openBox('favorites');
    if (box.get(id) != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<dynamic>> load() async {
    var box = await Hive.openBox('favorites');
    return await box.values.toList();
  }

  @override
  Future<void> onTracked(int id) async {
    var box = await Hive.openBox('favorites');
    if (box.get(id) != null) {
      await box.delete(id);
    } else {
      await box.put(id, id);
    }
  }
}
