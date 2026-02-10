import 'package:dio/dio.dart';
import 'package:pion_app/core/api/social_api.dart';
import 'package:pion_app/core/models/api_model.dart';
import 'package:pion_app/core/models/social_model.dart';
import 'package:pion_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class SocialDetailViewModel extends BaseViewModel {
  SocialDetailViewModel({required this.socialApi, required this.id});

  final SocialApi socialApi;
  final int id;

  SocialDetailData? detailSocial;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchDetailSocial();
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  Future<void> fetchDetailSocial() async {
    setBusy(true);
    try {
      final HttpResponse<SocialDetailResponse> response = await socialApi
          .getDetailSocial(id);
      if (response.response.statusCode == 200) {
        detailSocial = response.data.data;
      }
    } on DioException catch (e) {
      final apiResponse = ApiResponse.fromJson(e.response!.data);
      setError(apiResponse.message);
    }
    setBusy(false);
  }
}
