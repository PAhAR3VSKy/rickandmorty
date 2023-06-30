// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_release_file_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewReleaseFileMeta _$NewReleaseFileMetaFromJson(Map<String, dynamic> json) =>
    NewReleaseFileMeta(
      error: json['error'] as bool?,
      id: json['id'] as String?,
      chunkSize: json['chunk_size'] as int?,
      resumeRestart: json['resume_restart'] as bool?,
      chunkList:
          (json['chunk_list'] as List<dynamic>?)?.map((e) => e as int).toList(),
      blobPartitions: json['blob_partitions'] as int?,
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$NewReleaseFileMetaToJson(NewReleaseFileMeta instance) =>
    <String, dynamic>{
      'error': instance.error,
      'id': instance.id,
      'chunk_size': instance.chunkSize,
      'resume_restart': instance.resumeRestart,
      'chunk_list': instance.chunkList,
      'blob_partitions': instance.blobPartitions,
      'status_code': instance.statusCode,
    };
