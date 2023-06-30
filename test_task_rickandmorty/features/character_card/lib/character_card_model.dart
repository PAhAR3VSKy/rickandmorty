import 'package:elementary/elementary.dart';
import 'package:test_task_rickandmorty/tracked/tracked_notifaer.dart';

/// Модель карточки персонажа
class CharacterCardModel extends ElementaryModel {
  final ITrackedNotifier _trackedNotifier;

  /// Конструктор [CharacterCardModel]
  CharacterCardModel(
    this._trackedNotifier,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// добавить/убрать из избранного
  Future<void> onTracked(int id) async {
    await _trackedNotifier.onTracked(id);
  }

  /// проверка в избранном ли id (продукт)
  Future<bool> isTracked(int id) => _trackedNotifier.isTracked(id);
}
