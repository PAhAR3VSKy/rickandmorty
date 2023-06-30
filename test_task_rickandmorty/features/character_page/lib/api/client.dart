import 'package:character_page/dto/catalog_data.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// Клиент персонажа
@RestApi()
abstract class CharacterClient {
  /// Фабрика клиента
  factory CharacterClient(Dio dio) = _CharacterClient;

  /// Получение следующего каталога
  @GET('/character/{path}')
  Future<CatalogData> getMultiFiltersInfo(
    @Path('path') String path,
  );
}
