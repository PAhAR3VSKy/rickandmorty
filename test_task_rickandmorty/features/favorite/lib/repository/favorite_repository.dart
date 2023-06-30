import 'package:character_card/domain/character.dart';
import 'package:character_page/domain/character_mapper.dart';
import 'package:favorite/api/client.dart';

/// Репозиторий избранного
class FavoriteRepository {
  final FavoriteClient _favoriteClient;

  /// Конструктор [FavoriteRepository]
  FavoriteRepository(this._favoriteClient);

  /// Получить персонажа по id
  Future<CharacterCard> getCharactersId(int id) =>
      _favoriteClient.getCharactersId(id).then((value) {
        return characterMapper(value);
      });
}
