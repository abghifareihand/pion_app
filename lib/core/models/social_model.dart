import 'package:json_annotation/json_annotation.dart';

part 'social_model.g.dart';

// List Social
@JsonSerializable(fieldRename: FieldRename.snake)
class SocialResponse {
  const SocialResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory SocialResponse.fromJson(Map<String, dynamic> json) =>
      _$SocialResponseFromJson(json);

  final bool status;
  final String message;
  final List<SocialData> data;
  final Meta meta;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SocialData {
  const SocialData({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory SocialData.fromJson(Map<String, dynamic> json) =>
      _$SocialDataFromJson(json);

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

// Detail Social
@JsonSerializable(fieldRename: FieldRename.snake)
class SocialDetailResponse {
  const SocialDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SocialDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SocialDetailResponseFromJson(json);

  final bool status;
  final String message;
  final SocialDetailData data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SocialDetailData {
  const SocialDetailData({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    required this.fileUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SocialDetailData.fromJson(Map<String, dynamic> json) =>
      _$SocialDetailDataFromJson(json);

  final int id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String fileUrl;
  final String createdAt;
  final String updatedAt;
}
