import 'package:character_page/dto/catalog_data.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// Клиент избранного
@RestApi()
abstract class FavoriteClient {
  /// Фабрика избранного
  factory FavoriteClient(Dio dio) = _FavoriteClient;

  /// Получение следующего каталога
  @GET('/character/{id}')
  Future<CharacterData> getCharactersId(
    @Path('id') int id,
  );
}
