import 'package:character_page/character_page_export.dart';
import 'package:character_page/domain/request_info.dart';
import 'package:character_page/repository/character_repository.dart';
import 'package:elementary/elementary.dart';
import 'package:test_task_rickandmorty/util/exception_handler.dart';

/// Модель страницы персонажей
class CharacterPageModel extends ElementaryModel {
  final CharacterRepository _repository;

  /// Конструктор
  CharacterPageModel(this._repository, ErrorHandler errorHandler)
      : super(errorHandler: errorHandler);

  /// мультизапрос на получение данных
  Future<RequestInfo> getMultiFiltersInfo({
    Gender? gender,
    Status? status,
    String? name,
    String? species,
    required int page,
  }) async {
    late final RequestInfo res;
    String path = '/?page=${page}';
    if (gender != null && gender != Gender.none)
      path = '${path}&gender=${gender.name}';
    if (status != null && status != Status.none)
      path = '${path}&status=${status.name}';
    if (name != null && name.isNotEmpty) path = '${path}&name=${name}';
    if (species != null && species.isNotEmpty)
      path = '${path}&species=${species}';
    await ExceptionHandler.shellException(() async {
      res = await _repository.getMultiFiltersInfo(path);
    });
    return res;
  }
}
