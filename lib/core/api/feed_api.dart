import 'package:dio/dio.dart';
import 'package:pion_app/core/models/feed_model.dart';
import 'package:retrofit/retrofit.dart';

part 'feed_api.g.dart';

@RestApi()
abstract class FeedApi {
  factory FeedApi(Dio dio, {String baseUrl}) = _FeedApi;

  // Get Feed
  @GET('/api/feed')
  Future<HttpResponse<FeedResponse>> getFeed();
}
