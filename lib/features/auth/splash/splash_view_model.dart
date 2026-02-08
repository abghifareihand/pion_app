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

    // Cek notification
    hasNotificationPermission = await _checkNotificationPermissions();

    // Cek token pakai fungsi baru
    hasToken = await _checkToken();

    // Delay splash 2 detik
    await Future.delayed(const Duration(seconds: 2));

    setBusy(false);
  }

  /// ✅ Cek permission notifikasi
  Future<bool> _checkNotificationPermissions() async {
    final status = await Permission.notification.status;
    if (status.isGranted) return true;

    final result = await Permission.notification.request();
    return result.isGranted;
  }

  

  /// ✅ Cek token
  Future<bool> _checkToken() async {
    final token = await _prefService.getToken();
    print('🔑 Token : $token');
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }
}

