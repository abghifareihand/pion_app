import 'package:dio/dio.dart';
import 'package:pion_app/core/models/financial_model.dart';
import 'package:pion_app/core/models/information_model.dart';
import 'package:retrofit/retrofit.dart';

part 'financial_api.g.dart';

@RestApi()
abstract class FinancialApi {
  factory FinancialApi(Dio dio, {String baseUrl}) = _FinancialApi;

  // Get List Financial
  @GET('/api/financials')
  Future<HttpResponse<FinancialResponse>> getListFinancial(
    @Query('page') int? page,
    @Query('search') String? search,
  );

  // Get Detail Financial
  @GET('/api/financials/{id}')
  Future<HttpResponse<FinancialDetailResponse>> getDetailFinancial(
    @Path('id') int id,
  );
}
