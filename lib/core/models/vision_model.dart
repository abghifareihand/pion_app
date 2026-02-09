import 'package:json_annotation/json_annotation.dart';

part 'vision_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VisionResponse {
  const VisionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VisionResponse.fromJson(Map<String, dynamic> json) =>
      _$VisionResponseFromJson(json);

  final bool status;
  final String message;
  final VisionData data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class VisionData {
  const VisionData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VisionData.fromJson(Map<String, dynamic> json) =>
      _$VisionDataFromJson(json);

  final int id;
  final String title;
  final String subtitle;
  final String createdAt;
  final String updatedAt;
}
