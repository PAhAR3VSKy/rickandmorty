// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogData _$CatalogDataFromJson(Map<String, dynamic> json) => CatalogData(
      results: (json['results'] as List<dynamic>)
          .map((e) => CharacterData.fromJson(e as Map<String, dynamic>))
          .toList(),
      info: InfoData.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CatalogDataToJson(CatalogData instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
      'info': instance.info.toJson(),
    };

InfoData _$InfoDataFromJson(Map<String, dynamic> json) => InfoData(
      count: json['count'] as int,
      pages: json['pages'] as int,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );

Map<String, dynamic> _$InfoDataToJson(InfoData instance) => <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };

CharacterData _$CharacterDataFromJson(Map<String, dynamic> json) =>
    CharacterData(
      name: json['name'] as String,
      image: json['image'] as String,
      id: json['id'] as int,
      created: json['created'] as String,
      url: json['url'] as String,
      episode:
          (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
      location: CharacterLocationData.fromJson(
          json['location'] as Map<String, dynamic>),
      origin: CharacterLocationData.fromJson(
          json['origin'] as Map<String, dynamic>),
      gender: json['gender'] as String,
      type: json['type'] as String,
      species: json['species'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$CharacterDataToJson(CharacterData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.image,
      'episode': instance.episode,
      'url': instance.url,
      'created': instance.created,
    };

CharacterLocationData _$CharacterLocationDataFromJson(
        Map<String, dynamic> json) =>
    CharacterLocationData(
      url: json['url'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CharacterLocationDataToJson(
        CharacterLocationData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
