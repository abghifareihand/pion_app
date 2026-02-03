import 'package:json_annotation/json_annotation.dart';

part 'fcm_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FcmRequest {
  const FcmRequest({required this.fcmToken});

  factory FcmRequest.fromJson(Map<String, dynamic> json) =>
      _$FcmRequestFromJson(json);

  final String fcmToken;

  Map<String, dynamic> toJson() => _$FcmRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FcmResponse {
  const FcmResponse({
    required this.status,
    required this.message,
    required this.fcmToken,
  });

  factory FcmResponse.fromJson(Map<String, dynamic> json) =>
      _$FcmResponseFromJson(json);

  final bool status;
  final String message;
  final String fcmToken;
}
