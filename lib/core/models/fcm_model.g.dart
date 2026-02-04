// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmRequest _$FcmRequestFromJson(Map<String, dynamic> json) =>
    FcmRequest(fcmToken: json['fcm_token'] as String);

Map<String, dynamic> _$FcmRequestToJson(FcmRequest instance) =>
    <String, dynamic>{'fcm_token': instance.fcmToken};

FcmResponse _$FcmResponseFromJson(Map<String, dynamic> json) => FcmResponse(
  status: json['status'] as bool,
  message: json['message'] as String,
  fcmToken: json['fcm_token'] as String,
);

Map<String, dynamic> _$FcmResponseToJson(FcmResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'fcm_token': instance.fcmToken,
    };
