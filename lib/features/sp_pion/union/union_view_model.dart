import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pion_app/core/api/union_api.dart';
import 'package:pion_app/core/models/api_model.dart';
import 'package:pion_app/core/models/union_model.dart';
import 'package:pion_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class UnionViewModel extends BaseViewModel {
  UnionViewModel({required this.unionApi});

  final UnionApi unionApi;
  List<UnionData> listUnion = [];
  Timer? _debounce;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchListUnion();
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    _debounce?.cancel();
    super.disposeModel();
  }

  void onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchListUnion(search: query.isEmpty ? null : query);
    });
  }

  Future<void> fetchListUnion({int? page, String? search}) async {
    setBusy(true);
    try {
      final HttpResponse<UnionResponse> response = await unionApi
          .getListUnion(page, search);
      if (response.response.statusCode == 200) {
        listUnion = response.data.data;
      }
    } on DioException catch (e) {
      final apiResponse = ApiResponse.fromJson(e.response!.data);
      setError(apiResponse.message);
    }
    setBusy(false);
  }
}
