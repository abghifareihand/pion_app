import 'package:dio/dio.dart';
import 'package:pion_app/core/api/organization_api.dart';
import 'package:pion_app/core/models/api_model.dart';
import 'package:pion_app/core/models/organization_model.dart';
import 'package:pion_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class OrganizationDetailViewModel extends BaseViewModel {
  OrganizationDetailViewModel({required this.organizationApi, required this.id});

  final OrganizationApi organizationApi;
  final int id;

  OrganizationDetailData? detailOrganization;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchDetailOrganization();
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  Future<void> fetchDetailOrganization() async {
    setBusy(true);
    try {
      final HttpResponse<OrganizationDetailResponse> response = await organizationApi
          .getDetailOrganization(id);
      if (response.response.statusCode == 200) {
        detailOrganization = response.data.data;
      }
    } on DioException catch (e) {
      final apiResponse = ApiResponse.fromJson(e.response!.data);
      setError(apiResponse.message);
    }
    setBusy(false);
  }
}
