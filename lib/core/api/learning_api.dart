import 'package:dio/dio.dart';
import 'package:pion_app/core/models/learning_model.dart';
import 'package:retrofit/retrofit.dart';

part 'learning_api.g.dart';

@RestApi()
abstract class LearningApi {
  factory LearningApi(Dio dio, {String baseUrl}) = _LearningApi;

  // Get List Learning
  @GET('/api/learnings')
  Future<HttpResponse<LearningResponse>> getListLearning(
    @Query('page') int? page,
    @Query('search') String? search,
  );

  // Get Detail Learning
  @GET('/api/learnings/{id}')
  Future<HttpResponse<LearningDetailResponse>> getDetailLearning(
    @Path('id') int id,
  );
}
