import 'package:dio/dio.dart';
import 'package:pion_app/core/models/vision_model.dart';
import 'package:retrofit/retrofit.dart';

part 'vision_api.g.dart';

@RestApi()
abstract class VisionApi {
  factory VisionApi(Dio dio, {String baseUrl}) = _VisionApi;

  // Get Vision
  @GET('/api/vision')
  Future<HttpResponse<VisionResponse>> getVision();
}
