// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appcenter_app_release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppRelease _$AppReleaseFromJson(Map<String, dynamic> json) => AppRelease(
      origin: json['origin'] as String?,
      id: json['id'] as int?,
      shortVersion: json['short_version'] as String?,
      version: json['version'] as String?,
      uploadedAt: json['uploaded_at'] as String?,
      enabled: json['enabled'] as bool?,
      isExternalBuild: json['is_external_build'] as bool?,
      fileExtension: json['file_extension'] as String?,
      destinations: json['destinations'] as List<dynamic>?,
      distributionGroups: json['distribution_groups'] as List<dynamic>?,
    );

Map<String, dynamic> _$AppReleaseToJson(AppRelease instance) =>
    <String, dynamic>{
      'origin': instance.origin,
      'id': instance.id,
      'short_version': instance.shortVersion,
      'version': instance.version,
      'uploaded_at': instance.uploadedAt,
      'enabled': instance.enabled,
      'is_external_build': instance.isExternalBuild,
      'file_extension': instance.fileExtension,
      'destinations': instance.destinations,
      'distribution_groups': instance.distributionGroups,
    };
