import 'package:json_annotation/json_annotation.dart';

part 'organization_model.g.dart';

// List Organization
@JsonSerializable(fieldRename: FieldRename.snake)
class OrganizationResponse {
  const OrganizationResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory OrganizationResponse.fromJson(Map<String, dynamic> json) =>
      _$OrganizationResponseFromJson(json);

  final bool status;
  final String message;
  final List<OrganizationData> data;
  final Meta meta;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class OrganizationData {
  const OrganizationData({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory OrganizationData.fromJson(Map<String, dynamic> json) =>
      _$OrganizationDataFromJson(json);

  final int id;
  final String title;
  final String createdAt;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Meta {
  const Meta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final String? nextPageUrl;
  final String? prevPageUrl;
}

// Detail Organization
@JsonSerializable(fieldRename: FieldRename.snake)
class OrganizationDetailResponse {
  const OrganizationDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OrganizationDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$OrganizationDetailResponseFromJson(json);

  final bool status;
  final String message;
  final OrganizationDetailData data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class OrganizationDetailData {
  const OrganizationDetailData({
    required this.id,
    required this.title,
    this.description,
    required this.fileUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrganizationDetailData.fromJson(Map<String, dynamic> json) =>
      _$OrganizationDetailDataFromJson(json);

  final int id;
  final String title;
  final String? description;
  final String fileUrl;
  final String createdAt;
  final String updatedAt;
}
