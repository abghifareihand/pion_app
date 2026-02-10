import 'package:dio/dio.dart';
import 'package:pion_app/core/models/social_model.dart';
import 'package:retrofit/retrofit.dart';

part 'social_api.g.dart';

@RestApi()
abstract class SocialApi {
  factory SocialApi(Dio dio, {String baseUrl}) = _SocialApi;

  // Get List Social
  @GET('/api/socials')
  Future<HttpResponse<SocialResponse>> getListSocial(
    @Query('page') int? page,
    @Query('search') String? search,
  );

  // Get Detail Social
  @GET('/api/socials/{id}')
  Future<HttpResponse<SocialDetailResponse>> getDetailSocial(
    @Path('id') int id,
  );
}
