import 'package:json_annotation/json_annotation.dart';

part 'new_release_meta.g.dart';

@JsonSerializable()
class NewReleaseMeta {
  static const fromJson = _$NewReleaseMetaFromJson;

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'package_asset_id')
  final String? packageAssetId;

  @JsonKey(name: 'upload_domain')
  final String? uploadDomain;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'url_encoded_token')
  final String? urlEncodedToken;

  NewReleaseMeta({
    this.id,
    this.packageAssetId,
    this.uploadDomain,
    this.token,
    this.urlEncodedToken,
  });

  Map<String, dynamic> toJson() => _$NewReleaseMetaToJson(this);
}
