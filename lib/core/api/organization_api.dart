import 'package:dio/dio.dart';
import 'package:pion_app/core/models/organization_model.dart';
import 'package:retrofit/retrofit.dart';

part 'organization_api.g.dart';

@RestApi()
abstract class OrganizationApi {
  factory OrganizationApi(Dio dio, {String baseUrl}) = _OrganizationApi;

  // Get List Organization
  @GET('/api/organizations')
  Future<HttpResponse<OrganizationResponse>> getListOrganization(
    @Query('page') int? page,
    @Query('search') String? search,
  );

  // Get Detail Organization
  @GET('/api/organizations/{id}')
  Future<HttpResponse<OrganizationDetailResponse>> getDetailOrganization(
    @Path('id') int id,
  );
}
