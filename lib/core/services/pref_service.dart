import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static const String _tokenKey = 'key_token';
  static const String _fcmTokenKey = 'key_fcm_token';

  // ===== Login token =====
  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<bool> isLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString(_tokenKey);
    return authToken != null;
  }

  // ===== FCM token =====
  Future<void> saveFcmToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fcmTokenKey, token);
  }

  Future<String?> getFcmToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_fcmTokenKey);
  }

  Future<void> removeFcmToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_fcmTokenKey);
  }

  // ===== Remove all =====
  Future<void> removeAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_fcmTokenKey);
  }
}
