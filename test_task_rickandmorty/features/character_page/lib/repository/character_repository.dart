import 'package:character_page/api/client.dart';
import 'package:character_page/domain/request_info.dart';
import 'package:character_page/domain/request_info_mapper.dart';

/// Репозиторий персонажей
class CharacterRepository {
  final CharacterClient _characterClient;

  /// Конструктор [CharacterRepository]
  CharacterRepository(this._characterClient);

  /// Мультизапрос на получение информации
  Future<RequestInfo> getMultiFiltersInfo(String path) =>
      _characterClient.getMultiFiltersInfo(path).then((value) {
        return mapRequestInfo(value);
      });
}
