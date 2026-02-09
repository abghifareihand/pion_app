import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pion_app/core/api/financial_api.dart';
import 'package:pion_app/core/models/api_model.dart';
import 'package:pion_app/core/models/financial_model.dart';
import 'package:pion_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class FinancialViewModel extends BaseViewModel {
  FinancialViewModel({required this.financialApi});

  final FinancialApi financialApi;
  List<FinancialData> listFinancial = [];
  Timer? _debounce;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchListFinancial();
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    _debounce?.cancel();
    super.disposeModel();
  }

  /// Fungsi versi debounced search
  void onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchListFinancial(search: query.isEmpty ? null : query);
    });
  }

  /// Fungsi untuk get list information
  Future<void> fetchListFinancial({int? page, String? search}) async {
    setBusy(true);
    try {
      final HttpResponse<FinancialResponse> response = await financialApi
          .getListFinancial(page, search);
      if (response.response.statusCode == 200) {
        listFinancial = response.data.data;
      }
    } on DioException catch (e) {
      final apiResponse = ApiResponse.fromJson(e.response!.data);
      setError(apiResponse.message);
    }
    setBusy(false);
  }
}
