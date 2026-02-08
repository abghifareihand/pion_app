import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pion_app/core/api/information_api.dart';
import 'package:pion_app/core/models/api_model.dart';
import 'package:pion_app/core/models/information_model.dart';
import 'package:pion_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class InformationViewModel extends BaseViewModel {
  InformationViewModel({required this.informationApi});

  final InformationApi informationApi;
  List<InformationData> listInformation = [];
  Timer? _debounce;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchListInformation();
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
      fetchListInformation(search: query.isEmpty ? null : query);
    });
  }

  /// Fungsi untuk get list information
  Future<void> fetchListInformation({int? page, String? search}) async {
    setBusy(true);
    try {
      final HttpResponse<InformationResponse> response = await informationApi
          .getListInformation(page, search);
      if (response.response.statusCode == 200) {
        listInformation = response.data.data;
      }
    } on DioException catch (e) {
      final apiResponse = ApiResponse.fromJson(e.response!.data);
      setError(apiResponse.message);
    }
    setBusy(false);
  }
}
