import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceController extends GetxController {
  // Keys for accessing the shared preferences
  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';
  static const String isUserLoggedKey = 'isUserLogged';

  static SharedPreferences? prefs;

  @override
  Future<void> onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  // Save tokens to shared preferences
  Future<void> saveToken({
    required String accessToken,
    required String refreshToken,
  }) async {
    await prefs?.setString(accessTokenKey, accessToken);
    await prefs?.setString(refreshTokenKey, refreshToken);
    await prefs?.setBool(isUserLoggedKey, true);
  }

  // get token
  String getAccessToken() {
    return prefs?.getString(accessTokenKey) ?? "";
  }

  // User logged or not
  bool isUserLogged() {
    print("Is User ${prefs?.getBool(isUserLoggedKey)}");
    return prefs?.getBool(isUserLoggedKey) ?? false;
  }

  // Clear tokens from shared preferences
  logOut() {
    prefs?.remove(accessTokenKey);
    prefs?.remove(refreshTokenKey);
    prefs?.setBool(isUserLoggedKey, false);
  }
}
