// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedResponse _$FeedResponseFromJson(Map<String, dynamic> json) => FeedResponse(
  status: json['status'] as bool,
  message: json['message'] as String,
  data:
      (json['data'] as List<dynamic>)
          .map((e) => FeedData.fromJson(e as Map<String, dynamic>))
          .toList(),
);


FeedData _$FeedDataFromJson(Map<String, dynamic> json) => FeedData(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String,
  title: json['title'] as String,
  createdAt: json['created_at'] as String,
  imageUrl: json['image_url'] as String?,
);

Map<String, dynamic> _$FeedDataToJson(FeedData instance) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'title': instance.title,
  'created_at': instance.createdAt,
  'image_url': instance.imageUrl,
};
