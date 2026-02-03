import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileResponse {
  const ProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  final bool status;
  final String message;
  final ProfileData data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileData {
  const ProfileData({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.role,
    required this.pin,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  final int id;
  final String name;
  final String username;
  final String email;
  final String role;
  final String pin;
  final String? phone;
  final String? createdAt;
  final String? updatedAt;
}
