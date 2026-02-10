import 'package:dio/dio.dart';
import 'package:pion_app/core/api/union_api.dart';
import 'package:pion_app/core/models/api_model.dart';
import 'package:pion_app/core/models/union_model.dart';
import 'package:pion_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class UnionDetailViewModel extends BaseViewModel {
  UnionDetailViewModel({required this.unionApi, required this.id});

  final UnionApi unionApi;
  final int id;

  UnionDetailData? detailUnion;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchDetailUnion();
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  Future<void> fetchDetailUnion() async {
    setBusy(true);
    try {
      final HttpResponse<UnionDetailResponse> response = await unionApi
          .getDetailUnion(id);
      if (response.response.statusCode == 200) {
        detailUnion = response.data.data;
      }
    } on DioException catch (e) {
      final apiResponse = ApiResponse.fromJson(e.response!.data);
      setError(apiResponse.message);
    }
    setBusy(false);
  }
}
