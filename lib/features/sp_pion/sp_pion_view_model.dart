import 'package:dio/dio.dart';
import 'package:pion_app/core/api/feed_api.dart';
import 'package:pion_app/core/models/api_model.dart';
import 'package:pion_app/core/models/feed_model.dart';
import 'package:pion_app/features/base_view_model.dart';
import 'package:retrofit/retrofit.dart';

class SpPionViewModel extends BaseViewModel {
  SpPionViewModel({required this.feedApi});

  final FeedApi feedApi;
  List<FeedData> listFeed = [];

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchListFeed();
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  /// Fungsi untuk get list feed
  Future<void> fetchListFeed() async {
    setBusy(true);
    try {
      final HttpResponse<FeedResponse> response = await feedApi.getFeed();
      if (response.response.statusCode == 200) {
        listFeed = response.data.data;
      }
    } on DioException catch (e) {
      final apiResponse = ApiResponse.fromJson(e.response!.data);
      setError(apiResponse.message);
    }
    setBusy(false);
  }
}
