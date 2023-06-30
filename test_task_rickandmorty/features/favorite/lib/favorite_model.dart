import 'package:character_card/domain/character.dart';
import 'package:elementary/elementary.dart';
import 'package:favorite/repository/favorite_repository.dart';
import 'package:test_task_rickandmorty/tracked/tracked_notifaer.dart';
import 'package:test_task_rickandmorty/util/exception_handler.dart';

/// Модель страницы избранного
class FavoritePageModel extends ElementaryModel {
  final FavoriteRepository _repository;
  final ITrackedNotifier _trackedNotifier;

  /// Конструктор
  FavoritePageModel(
    this._trackedNotifier,
    this._repository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Запрос по id
  Future<CharacterCard> getCharactersId(int id) async {
    late final CharacterCard res;
    await ExceptionHandler.shellException(() async {
      res = await _repository.getCharactersId(id);
    });
    return res;
  }

  /// добавить/убрать из избранного
  Future<void> onTracked(int id) async {
    await _trackedNotifier.onTracked(id);
  }

  /// проверка в избранном ли id (продукт)
  Future<bool> isTracked(int id) => _trackedNotifier.isTracked(id);

  /// загрузка id
  Future<List<dynamic>> loadId() => _trackedNotifier.load();
}
