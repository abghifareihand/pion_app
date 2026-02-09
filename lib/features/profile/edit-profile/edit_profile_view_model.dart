import 'package:pion_app/core/api/auth_api.dart';
import 'package:pion_app/core/models/api_model.dart';
import 'package:pion_app/core/models/profile_model.dart';
import 'package:pion_app/features/base_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

class EditProfileViewModel extends BaseViewModel {
  EditProfileViewModel({required this.profile, required this.authApi});
  final AuthApi authApi;
  final ProfileData profile;

  late TextEditingController nameController;
  String name = '';
  String? nameError;

  late TextEditingController usernameController;
  String username = '';
  String? usernameError;

  late TextEditingController emailController;
  String email = '';
  String? emailError;

  @override
  Future<void> initModel() async {
    setBusy(true);
    fetchUserData(profile);
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.disposeModel();
  }

  void updateName(String value) {
    name = value;
    nameError = name.isEmpty ? 'Nama tidak boleh kosong' : null;
    notifyListeners();
  }

  void updateUsername(String value) {
    username = value;
    usernameError = username.isEmpty ? 'Username tidak boleh kosong' : null;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    emailError = email.isEmpty ? 'Email tidak boleh kosong' : null;
    notifyListeners();
  }


  bool get isFormValid => name.isNotEmpty && username.isNotEmpty && email.isNotEmpty;

  void fetchUserData(ProfileData profile) {
    // isi controller
    nameController = TextEditingController(text: profile.name);
    usernameController = TextEditingController(text: profile.username);
    emailController = TextEditingController(text: profile.email);

    // isi variabel model juga
    name = profile.name;
    username = profile.username;
    email = profile.email;
  }

  // Future<void> saveProfile() async {
  //   setBusy(true);
  //   try {
  //     final HttpResponse<ApiResponse> response = await authApi.updateProfile(
  //       request: UpdateProfileRequest(
  //         name: name,
  //         username: username,
  //       ),
  //     );

  //     if (response.response.statusCode == 200) {
  //       setSuccess(response.data.message);
  //     }
  //   } on DioException catch (e) {
  //     final apiResponse = ApiResponse.fromJson(e.response?.data);
  //     setError(apiResponse.message);
  //   }
  //   setBusy(false);
  // }
}
