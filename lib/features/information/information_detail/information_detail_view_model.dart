import 'package:dio/dio.dart';
import 'package:pion_app/core/api/information_api.dart';
import 'package:pion_app/core/models/api_model.dart';
import 'package:pion_app/core/models/information_model.dart';
import 'package:pion_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class InformationDetailViewModel extends BaseViewModel {
  InformationDetailViewModel({required this.informationApi, required this.id});

  final InformationApi informationApi;
  final int id;

  InformationDetailData? detailInformation;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchDetailInformation(); 
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  /// Fungsi untuk get detail information
  Future<void> fetchDetailInformation() async {
    setBusy(true);
    try {
      final HttpResponse<InformationDetailResponse> response =
          await informationApi.getDetailInformation(id);
      if (response.response.statusCode == 200) {
        detailInformation = response.data.data;
      }
    } on DioException catch (e) {
      final apiResponse = ApiResponse.fromJson(e.response!.data);
      setError(apiResponse.message);
    }
    setBusy(false);
  }
}
