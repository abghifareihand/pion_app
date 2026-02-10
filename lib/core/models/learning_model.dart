import 'package:json_annotation/json_annotation.dart';

part 'learning_model.g.dart';

// List Learning
@JsonSerializable(fieldRename: FieldRename.snake)
class LearningResponse {
  const LearningResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory LearningResponse.fromJson(Map<String, dynamic> json) =>
      _$LearningResponseFromJson(json);

  final bool status;
  final String message;
  final List<LearningData> data;
  final Meta meta;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LearningData {
  const LearningData({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory LearningData.fromJson(Map<String, dynamic> json) =>
      _$LearningDataFromJson(json);

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

// Detail Learning
@JsonSerializable(fieldRename: FieldRename.snake)
class LearningDetailResponse {
  const LearningDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LearningDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$LearningDetailResponseFromJson(json);

  final bool status;
  final String message;
  final LearningDetailData data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LearningDetailData {
  const LearningDetailData({
    required this.id,
    required this.title,
    this.description,
    required this.fileUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LearningDetailData.fromJson(Map<String, dynamic> json) =>
      _$LearningDetailDataFromJson(json);

  final int id;
  final String title;
  final String? description;
  final String fileUrl;
  final String createdAt;
  final String updatedAt;
}
