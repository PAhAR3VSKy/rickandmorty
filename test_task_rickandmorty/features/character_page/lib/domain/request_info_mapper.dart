import 'package:character_page/domain/character_mapper.dart';
import 'package:character_page/domain/info.dart';
import 'package:character_page/domain/request_info.dart';
import 'package:character_page/dto/catalog_data.dart';

/// мапа запроса
RequestInfo mapRequestInfo(CatalogData data) {
  return RequestInfo(
    characters: data.results.map(characterMapper).toList(),
    info: mapInfo(data.info),
  );
}

/// мапа информации
Info mapInfo(InfoData data) {
  return Info(
    count: data.count,
    pages: data.pages,
    next: data.next ?? '',
    prev: data.prev ?? '',
  );
}
