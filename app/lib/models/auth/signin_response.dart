// To parse this JSON data, do
//
//     final signInResponse = signInResponseFromJson(jsonString);

import 'dart:convert';

SignInResponse signInResponseFromJson(String str) =>
    SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  String? message;
  int? userId;
  String? accessToken;
  String? refreshToken;

  SignInResponse({
    this.message,
    this.userId,
    this.accessToken,
    this.refreshToken,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        message: json["message"],
        userId: json["user_id"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user_id": userId,
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
