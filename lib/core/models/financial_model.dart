import 'package:json_annotation/json_annotation.dart';

part 'financial_model.g.dart';

// List Financial
@JsonSerializable(fieldRename: FieldRename.snake)
class FinancialResponse {
  const FinancialResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory FinancialResponse.fromJson(Map<String, dynamic> json) =>
      _$FinancialResponseFromJson(json);

  final bool status;
  final String message;
  final List<FinancialData> data;
  final Meta meta;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FinancialData {
  const FinancialData({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory FinancialData.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataFromJson(json);

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

// Detail Financial
@JsonSerializable(fieldRename: FieldRename.snake)
class FinancialDetailResponse {
  const FinancialDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FinancialDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$FinancialDetailResponseFromJson(json);

  final bool status;
  final String message;
  final FinancialDetailData data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FinancialDetailData {
  const FinancialDetailData({
    required this.id,
    required this.title,
    this.description,
    required this.fileUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FinancialDetailData.fromJson(Map<String, dynamic> json) =>
      _$FinancialDetailDataFromJson(json);

  final int id;
  final String title;
  final String? description;
  final String fileUrl;
  final String createdAt;
  final String updatedAt;
}
