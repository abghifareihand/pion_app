// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisionResponse _$VisionResponseFromJson(Map<String, dynamic> json) =>
    VisionResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: VisionData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VisionResponseToJson(VisionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

VisionData _$VisionDataFromJson(Map<String, dynamic> json) => VisionData(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  subtitle: json['subtitle'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$VisionDataToJson(VisionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
