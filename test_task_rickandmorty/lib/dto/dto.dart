import 'package:character_page/dto/catalog_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

/// Точка входа в DTO модели
@JsonSerializable()
class DTO {
  /// ответ
  final List<CharacterData> results;

  /// статус
  final InfoData info;

  /// Конструктор [DTO]
  DTO({
    required this.results,
    required this.info,
  });

  /// Преобразование из json
  factory DTO.fromJson(Map<String, dynamic> json) => _$DTOFromJson(json);

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$DTOToJson(this);
}

/// Сущность, в которую записывается метрика запроса
@JsonSerializable()
class InfoData {
  /// количество
  final int count;

  /// страница
  final int pages;

  /// следующая страница
  final String next;

  ///
  final dynamic prev;

  /// Конструктор [InfoData]
  InfoData({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  /// Преобразование из json
  factory InfoData.fromJson(Map<String, dynamic> json) =>
      _$InfoDataFromJson(json);

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$InfoDataToJson(this);
}
