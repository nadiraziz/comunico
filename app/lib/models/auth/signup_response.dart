// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) =>
    SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  String? name;
  String? email;
  DateTime? dateOfBirth;
  String? gender;
  String? accessToken;
  String? refreshToken;
  String? message;

  SignUpResponse({
    this.name,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.accessToken,
    this.refreshToken,
    this.message,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        name: json["name"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "message": message,
      };
}
