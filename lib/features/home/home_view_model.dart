import 'package:pion_app/core/api/auth_api.dart';
import 'package:pion_app/core/api/information_api.dart';
import 'package:pion_app/core/api/vision_api.dart';
import 'package:pion_app/core/models/api_model.dart';
import 'package:pion_app/core/models/information_model.dart';
import 'package:pion_app/core/models/profile_model.dart';
import 'package:pion_app/core/models/vision_model.dart';
import 'package:pion_app/features/base_view_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel({
    required this.authApi,
    required this.visionApi,
    required this.informationApi,
  });

  final AuthApi authApi;
  final VisionApi visionApi;
  final InformationApi informationApi;

  ProfileData? profile;
  VisionData? vision;
  List<InformationData> listInformation = [];

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchProfile();
    await fetchVision();
    await fetchListInformation();
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }

  Future<void> fetchProfile() async {
    try {
      final HttpResponse<ProfileResponse> response = await authApi.getProfile();
      if (response.response.statusCode == 200) {
        final profileResponse = response.data.data;
        profile = profileResponse;
      }
    } on DioException catch (e) {
      final apiResponse = ApiResponse.fromJson(e.response!.data);
      setError(apiResponse.message);
    }
    setBusy(false);
  }

  Future<void> fetchVision() async {
    try {
      final HttpResponse<VisionResponse> response = await visionApi.getVision();
      if (response.response.statusCode == 200) {
        final visionResponse = response.data.data;
        vision = visionResponse;
      }
    } on DioException catch (e) {
      final apiResponse = ApiResponse.fromJson(e.response!.data);
      setError(apiResponse.message);
    }
    setBusy(false);
  }

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
