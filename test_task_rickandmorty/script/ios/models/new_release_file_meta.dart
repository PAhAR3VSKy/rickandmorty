import 'package:json_annotation/json_annotation.dart';

part 'new_release_file_meta.g.dart';

@JsonSerializable()
class NewReleaseFileMeta {
  static const fromJson = _$NewReleaseFileMetaFromJson;

  @JsonKey(name: 'error')
  final bool? error;

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'chunk_size')
  final int? chunkSize;

  @JsonKey(name: 'resume_restart')
  final bool? resumeRestart;

  @JsonKey(name: 'chunk_list')
  final List<int>? chunkList;

  @JsonKey(name: 'blob_partitions')
  final int? blobPartitions;

  @JsonKey(name: 'status_code')
  final String? statusCode;

  NewReleaseFileMeta({
    this.error,
    this.id,
    this.chunkSize,
    this.resumeRestart,
    this.chunkList,
    this.blobPartitions,
    this.statusCode,
  });

  Map<String, dynamic> toJson() => _$NewReleaseFileMetaToJson(this);
}
