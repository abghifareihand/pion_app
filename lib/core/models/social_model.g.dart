// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialResponse _$SocialResponseFromJson(Map<String, dynamic> json) =>
    SocialResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data:
          (json['data'] as List<dynamic>)
              .map((e) => SocialData.fromJson(e as Map<String, dynamic>))
              .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SocialResponseToJson(SocialResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'meta': instance.meta,
    };

SocialData _$SocialDataFromJson(Map<String, dynamic> json) => SocialData(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$SocialDataToJson(SocialData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'created_at': instance.createdAt,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
  currentPage: (json['current_page'] as num).toInt(),
  lastPage: (json['last_page'] as num).toInt(),
  perPage: (json['per_page'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  nextPageUrl: json['next_page_url'] as String?,
  prevPageUrl: json['prev_page_url'] as String?,
);

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
  'current_page': instance.currentPage,
  'last_page': instance.lastPage,
  'per_page': instance.perPage,
  'total': instance.total,
  'next_page_url': instance.nextPageUrl,
  'prev_page_url': instance.prevPageUrl,
};

SocialDetailResponse _$SocialDetailResponseFromJson(
  Map<String, dynamic> json,
) => SocialDetailResponse(
  status: json['status'] as bool,
  message: json['message'] as String,
  data: SocialDetailData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SocialDetailResponseToJson(
  SocialDetailResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

SocialDetailData _$SocialDetailDataFromJson(Map<String, dynamic> json) =>
    SocialDetailData(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      fileUrl: json['file_url'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$SocialDetailDataToJson(SocialDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'file_url': instance.fileUrl,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
