import 'package:dio/dio.dart';
import 'package:pion_app/core/api/learning_api.dart';
import 'package:pion_app/core/models/api_model.dart';
import 'package:pion_app/core/models/learning_model.dart';
import 'package:pion_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class LearningDetailViewModel extends BaseViewModel {
  LearningDetailViewModel({required this.learningApi, required this.id});

  final LearningApi learningApi;
  final int id;

  LearningDetailData? detailLearning;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchDetailLearning();
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  Future<void> fetchDetailLearning() async {
    setBusy(true);
    try {
      final HttpResponse<LearningDetailResponse> response = await learningApi
          .getDetailLearning(id);
      if (response.response.statusCode == 200) {
        detailLearning = response.data.data;
      }
    } on DioException catch (e) {
      final apiResponse = ApiResponse.fromJson(e.response!.data);
      setError(apiResponse.message);
    }
    setBusy(false);
  }
}
