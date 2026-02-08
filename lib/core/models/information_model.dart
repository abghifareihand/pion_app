import 'package:json_annotation/json_annotation.dart';

part 'information_model.g.dart';

// List Information
@JsonSerializable(fieldRename: FieldRename.snake)
class InformationResponse {
  const InformationResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory InformationResponse.fromJson(Map<String, dynamic> json) =>
      _$InformationResponseFromJson(json);

  final bool status;
  final String message;
  final List<InformationData> data;
  final Meta meta;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class InformationData {
  const InformationData({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory InformationData.fromJson(Map<String, dynamic> json) =>
      _$InformationDataFromJson(json);

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

// Detail Information
@JsonSerializable(fieldRename: FieldRename.snake)
class InformationDetailResponse {
  const InformationDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory InformationDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$InformationDetailResponseFromJson(json);

  final bool status;
  final String message;
  final InformationDetailData data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class InformationDetailData {
  const InformationDetailData({
    required this.id,
    required this.title,
    this.description,
    required this.fileUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InformationDetailData.fromJson(Map<String, dynamic> json) =>
      _$InformationDetailDataFromJson(json);

  final int id;
  final String title;
  final String? description;
  final String fileUrl;
  final String createdAt;
  final String updatedAt;
}
