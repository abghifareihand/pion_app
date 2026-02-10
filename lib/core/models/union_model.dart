import 'package:json_annotation/json_annotation.dart';

part 'union_model.g.dart';

// List Union
@JsonSerializable(fieldRename: FieldRename.snake)
class UnionResponse {
  const UnionResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory UnionResponse.fromJson(Map<String, dynamic> json) =>
      _$UnionResponseFromJson(json);

  final bool status;
  final String message;
  final List<UnionData> data;
  final Meta meta;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UnionData {
  const UnionData({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory UnionData.fromJson(Map<String, dynamic> json) =>
      _$UnionDataFromJson(json);

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

// Detail Union
@JsonSerializable(fieldRename: FieldRename.snake)
class UnionDetailResponse {
  const UnionDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UnionDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$UnionDetailResponseFromJson(json);

  final bool status;
  final String message;
  final UnionDetailData data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UnionDetailData {
  const UnionDetailData({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    required this.fileUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UnionDetailData.fromJson(Map<String, dynamic> json) =>
      _$UnionDetailDataFromJson(json);

  final int id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String fileUrl;
  final String createdAt;
  final String updatedAt;
}
