class APIUrl {
  // static String baseUrl = 'http://10.0.2.2:8000/api'; // For android emulator
  static String baseUrl = 'http://127.0.0.1:8000/api';

  static String signIn = '/users/signin/';
  static String signUp = '/users/signup/';
  static String profile = '/users/profile/';
  static String logOut = '/users/logout/';
  static String analyzeHistory = '/app/videos/';
  static String scanVideo = '/app/videos/';
  static String videoTips = '/app/videotips/';
  static String refreshToken = '/users/token/refresh/';
  static String feedback = '/feedback/create/';
}
