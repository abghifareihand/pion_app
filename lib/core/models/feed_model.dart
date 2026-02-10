import 'package:json_annotation/json_annotation.dart';

part 'feed_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FeedResponse {
  const FeedResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FeedResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedResponseFromJson(json);

  final bool status;
  final String message;
  final List<FeedData> data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FeedData {
  const FeedData({
    required this.id,
    required this.type,
    required this.title,
    required this.createdAt,
    this.imageUrl,
  });

  factory FeedData.fromJson(Map<String, dynamic> json) =>
      _$FeedDataFromJson(json);

  final int id;
  final String type;
  final String title;
  final String createdAt;
  final String? imageUrl;
}
