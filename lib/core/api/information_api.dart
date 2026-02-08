import 'package:dio/dio.dart';
import 'package:pion_app/core/models/information_model.dart';
import 'package:retrofit/retrofit.dart';

part 'information_api.g.dart';

@RestApi()
abstract class InformationApi {
  factory InformationApi(Dio dio, {String baseUrl}) = _InformationApi;

  // Get List Information
  @GET('/api/informations')
  Future<HttpResponse<InformationResponse>> getListInformation(
    @Query('page') int? page,
    @Query('search') String? search,
  );

  // Get Detail Information
  @GET('/api/informations/{id}')
  Future<HttpResponse<InformationDetailResponse>> getDetailInformation(
    @Path('id') int id,
  );
}
