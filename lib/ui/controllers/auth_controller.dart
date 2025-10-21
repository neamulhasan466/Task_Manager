import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart';

class AuthController {
  static const String _userKey = 'user_data';
  static const String _tokenKey = 'token';

  /// ✅ Save user model and token locally
  static Future<void> saveUserData(UserModel model, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(model.toJson());
    await prefs.setString(_userKey, userJson);
    await prefs.setString(_tokenKey, token);
  }

  /// ✅ Load user model from local storage
  static Future<UserModel?> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString(_userKey);

    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  /// ✅ Load token from local storage
  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// ✅ Clear user data (for logout)
  static Future<void> clearUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// ✅ Check if the user is already logged in
  static Future<bool> isUserAlreadyLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(_tokenKey);
    return token != null;
  }
}
