import 'package:json_annotation/json_annotation.dart';

part 'catalog_data.g.dart';

/// категория
@JsonSerializable(explicitToJson: true)
class CatalogData {
  /// ответ
  final List<CharacterData> results;

  /// статус
  final InfoData info;

  ///конструтор [CatalogData]
  CatalogData({
    required this.results,
    required this.info,
  });

  /// Преобразование из json
  factory CatalogData.fromJson(Map<String, dynamic> json) =>
      _$CatalogDataFromJson(json);

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$CatalogDataToJson(this);
}

/// DTO информации
@JsonSerializable()
class InfoData {
  /// количество
  final int count;

  /// страница
  final int pages;

  /// следующая страница
  final String? next;

  /// предыдущая страница
  final String? prev;

  /// Конструктор [InfoData]
  InfoData({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  /// Преобразование из json
  factory InfoData.fromJson(Map<String, dynamic> json) =>
      _$InfoDataFromJson(json);

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$InfoDataToJson(this);
}

/// персонаж
@JsonSerializable()
class CharacterData {
  /// id
  @JsonKey(name: 'id')
  final int id;

  /// name
  @JsonKey(name: 'name')
  final String name;

  /// status
  @JsonKey(name: 'status')
  final String status;

  /// species
  @JsonKey(name: 'species')
  final String species;

  /// type
  @JsonKey(name: 'type')
  final String type;

  /// gender
  @JsonKey(name: 'gender')
  final String gender;

  /// origin
  @JsonKey(name: 'origin')
  final CharacterLocationData origin;

  /// location
  @JsonKey(name: 'location')
  final CharacterLocationData location;

  /// image
  @JsonKey(name: 'image')
  final String image;

  /// episode
  @JsonKey(name: 'episode')
  final List<String> episode;

  /// url
  @JsonKey(name: 'url')
  final String url;

  /// created
  @JsonKey(name: 'created')
  final String created;

  /// Конструктор [CharacterData]
  CharacterData({
    required this.name,
    required this.image,
    required this.id,
    required this.created,
    required this.url,
    required this.episode,
    required this.location,
    required this.origin,
    required this.gender,
    required this.type,
    required this.species,
    required this.status,
  });

  /// Преобразование из json
  factory CharacterData.fromJson(Map<String, dynamic> json) =>
      _$CharacterDataFromJson(json);

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$CharacterDataToJson(this);
}

/// локация
@JsonSerializable()
class CharacterLocationData {
  /// name
  @JsonKey(name: 'name')
  final String name;

  /// url
  @JsonKey(name: 'url')
  final String url;

  /// Конструктор [CharacterLocationData]
  CharacterLocationData({
    required this.url,
    required this.name,
  });

  /// Преобразование из json
  factory CharacterLocationData.fromJson(Map<String, dynamic> json) =>
      _$CharacterLocationDataFromJson(json);

  /// Преобразование в json
  Map<String, dynamic> toJson() => _$CharacterLocationDataToJson(this);
}
