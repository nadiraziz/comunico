import 'package:app/helper/routes/approuter.dart';
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
    String? refreshToken,
  }) async {
    await prefs?.setString(accessTokenKey, accessToken);
    if (refreshToken != null) {
      await prefs?.setString(refreshTokenKey, refreshToken);
    }
    await prefs?.setBool(isUserLoggedKey, true);
  }

  // get token
  String getAccessToken() {
    return prefs?.getString(accessTokenKey) ?? "";
  }

  // get token
  String getRefreshToken() {
    return prefs?.getString(refreshTokenKey) ?? "";
  }

  // User logged or not
  bool isUserLogged() {
    return prefs?.getBool(isUserLoggedKey) ?? false;
  }

  // Clear tokens from shared preferences
  logOut() {
    prefs?.remove(accessTokenKey);
    prefs?.remove(refreshTokenKey);
    prefs?.setBool(isUserLoggedKey, false);
    AppRouter.goToSignIn();
  }
}
