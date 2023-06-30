// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_release_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewReleaseMeta _$NewReleaseMetaFromJson(Map<String, dynamic> json) =>
    NewReleaseMeta(
      id: json['id'] as String?,
      packageAssetId: json['package_asset_id'] as String?,
      uploadDomain: json['upload_domain'] as String?,
      token: json['token'] as String?,
      urlEncodedToken: json['url_encoded_token'] as String?,
    );

Map<String, dynamic> _$NewReleaseMetaToJson(NewReleaseMeta instance) =>
    <String, dynamic>{
      'id': instance.id,
      'package_asset_id': instance.packageAssetId,
      'upload_domain': instance.uploadDomain,
      'token': instance.token,
      'url_encoded_token': instance.urlEncodedToken,
    };
