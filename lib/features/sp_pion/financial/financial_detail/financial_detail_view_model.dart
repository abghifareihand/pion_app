import 'package:dio/dio.dart';
import 'package:pion_app/core/api/financial_api.dart';
import 'package:pion_app/core/models/api_model.dart';
import 'package:pion_app/core/models/financial_model.dart';
import 'package:pion_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class FinancialDetailViewModel extends BaseViewModel {
  FinancialDetailViewModel({required this.financialApi, required this.id});

  final FinancialApi financialApi;
  final int id;

  FinancialDetailData? detailFinancial;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchDetailFinancial();
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  /// Fungsi untuk get detail financial
  Future<void> fetchDetailFinancial() async {
    setBusy(true);
    try {
      final HttpResponse<FinancialDetailResponse> response = await financialApi
          .getDetailFinancial(id);
      if (response.response.statusCode == 200) {
        detailFinancial = response.data.data;
      }
    } on DioException catch (e) {
      final apiResponse = ApiResponse.fromJson(e.response!.data);
      setError(apiResponse.message);
    }
    setBusy(false);
  }
}
