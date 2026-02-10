// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationResponse _$OrganizationResponseFromJson(
  Map<String, dynamic> json,
) => OrganizationResponse(
  status: json['status'] as bool,
  message: json['message'] as String,
  data:
      (json['data'] as List<dynamic>)
          .map((e) => OrganizationData.fromJson(e as Map<String, dynamic>))
          .toList(),
  meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OrganizationResponseToJson(
  OrganizationResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
  'meta': instance.meta,
};

OrganizationData _$OrganizationDataFromJson(Map<String, dynamic> json) =>
    OrganizationData(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$OrganizationDataToJson(OrganizationData instance) =>
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

OrganizationDetailResponse _$OrganizationDetailResponseFromJson(
  Map<String, dynamic> json,
) => OrganizationDetailResponse(
  status: json['status'] as bool,
  message: json['message'] as String,
  data: OrganizationDetailData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OrganizationDetailResponseToJson(
  OrganizationDetailResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

OrganizationDetailData _$OrganizationDetailDataFromJson(
  Map<String, dynamic> json,
) => OrganizationDetailData(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  fileUrl: json['file_url'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$OrganizationDetailDataToJson(
  OrganizationDetailData instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'file_url': instance.fileUrl,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
