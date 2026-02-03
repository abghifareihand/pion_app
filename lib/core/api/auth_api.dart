import 'package:dio/dio.dart';
import 'package:pion_app/core/models/fcm_model.dart';
import 'package:pion_app/core/models/login_model.dart';
import 'package:pion_app/core/models/profile_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:pion_app/core/models/api_model.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/api/auth/login')
  Future<HttpResponse<LoginResponse>> login({
    @Body() required LoginRequest request,
  });

  @GET('/api/auth/profile')
  Future<HttpResponse<ProfileResponse>> profile();

  @POST('/api/auth/logout')
  Future<HttpResponse<ApiResponse>> logout();
}
