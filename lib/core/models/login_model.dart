import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginRequest {
  const LoginRequest({required this.username, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  final String username;
  final String password;

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResponse {
  const LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  final bool status;
  final String message;
  final LoginData data;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginData {
  const LoginData({required this.user, required this.token});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  final User user;
  final String token;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.role,
    required this.pin,
    this.phone,
    this.fcmToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String name;
  final String username;
  final String email;
  final String role;
  final String pin;
  final String? phone;
  final String? fcmToken;
}
