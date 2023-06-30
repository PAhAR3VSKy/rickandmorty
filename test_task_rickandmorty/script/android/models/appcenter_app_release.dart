import 'package:json_annotation/json_annotation.dart';

part 'appcenter_app_release.g.dart';

@JsonSerializable()
class AppRelease {
  static const fromJson = _$AppReleaseFromJson;

  @JsonKey(name: 'origin')
  final String? origin;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'short_version')
  final String? shortVersion;

  @JsonKey(name: 'version')
  final String? version;

  @JsonKey(name: 'uploaded_at')
  final String? uploadedAt;

  @JsonKey(name: 'enabled')
  final bool? enabled;

  @JsonKey(name: 'is_external_build')
  final bool? isExternalBuild;

  @JsonKey(name: 'file_extension')
  final String? fileExtension;

  @JsonKey(name: 'destinations')
  final List? destinations;

  @JsonKey(name: 'distribution_groups')
  final List? distributionGroups;

  AppRelease({
    this.origin,
    this.id,
    this.shortVersion,
    this.version,
    this.uploadedAt,
    this.enabled,
    this.isExternalBuild,
    this.fileExtension,
    this.destinations,
    this.distributionGroups,
  });

  static List<AppRelease> listFromJson(List<dynamic> parsedJson) {
    var list = <AppRelease>[];
    list = parsedJson
        .map<AppRelease>(
          // ignore: avoid_annotating_with_dynamic
          (dynamic i) => AppRelease.fromJson(i as Map<String, dynamic>),
        )
        .toList();

    return list;
  }

  Map<String, dynamic> toJson() => _$AppReleaseToJson(this);
}
