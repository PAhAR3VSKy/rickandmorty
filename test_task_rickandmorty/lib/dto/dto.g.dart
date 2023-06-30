// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTO _$DTOFromJson(Map<String, dynamic> json) => DTO(
      results: (json['results'] as List<dynamic>)
          .map((e) => CharacterData.fromJson(e as Map<String, dynamic>))
          .toList(),
      info: InfoData.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DTOToJson(DTO instance) => <String, dynamic>{
      'results': instance.results,
      'info': instance.info,
    };

InfoData _$InfoDataFromJson(Map<String, dynamic> json) => InfoData(
      count: json['count'] as int,
      pages: json['pages'] as int,
      next: json['next'] as String,
      prev: json['prev'],
    );

Map<String, dynamic> _$InfoDataToJson(InfoData instance) => <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };
