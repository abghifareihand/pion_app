import 'package:dio/dio.dart';
import 'package:pion_app/core/models/union_model.dart';
import 'package:retrofit/retrofit.dart';

part 'union_api.g.dart';

@RestApi()
abstract class UnionApi {
  factory UnionApi(Dio dio, {String baseUrl}) = _UnionApi;

  // Get List Union
  @GET('/api/unions')
  Future<HttpResponse<UnionResponse>> getListUnion(
    @Query('page') int? page,
    @Query('search') String? search,
  );

  // Get Detail Union
  @GET('/api/unions/{id}')
  Future<HttpResponse<UnionDetailResponse>> getDetailUnion(
    @Path('id') int id,
  );
}
