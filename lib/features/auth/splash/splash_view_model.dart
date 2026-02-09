import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';
import 'package:pion_app/core/services/pref_service.dart';
import 'package:pion_app/features/base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  final PrefService _prefService = PrefService();

  bool hasNotificationPermission = false;
  bool hasToken = false;

  @override
  Future<void> initModel() async {
    setBusy(true);

    // 1️⃣ Cek dan request notification permission
    await requestNotificationPermission();

    // 2️⃣ Cek token
    hasToken = await _checkToken();

    // 3️⃣ Delay splash 2 detik
    await Future.delayed(const Duration(seconds: 2));

    setBusy(false);
  }

  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status.isGranted) {
      log('Notification permission granted');
    } else {
      log('Notification permission denied');
    }
  }

  /// ✅ Cek token
  Future<bool> _checkToken() async {
    final token = await _prefService.getToken();
    log('🔑 Token : $token');
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }
}
