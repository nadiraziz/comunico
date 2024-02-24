// To parse this JSON data, do
//
//     final videoTipsResponse = videoTipsResponseFromJson(jsonString);

import 'dart:convert';

List<VideoTips> videoTipsResponseFromJson(String str) =>
    List<VideoTips>.from(json.decode(str).map((x) => VideoTips.fromJson(x)));

String videoTipsResponseToJson(List<VideoTips> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideoTips {
  int? id;
  String? videoTitle;
  String? videoDescription;
  String? videoLink;
  String? gender;
  int? minAge;
  int? maxAge;
  DateTime? createdAt;

  VideoTips({
    this.id,
    this.videoTitle,
    this.videoDescription,
    this.videoLink,
    this.gender,
    this.minAge,
    this.maxAge,
    this.createdAt,
  });

  factory VideoTips.fromJson(Map<String, dynamic> json) => VideoTips(
        id: json["id"],
        videoTitle: json["video_title"],
        videoDescription: json["video_description"],
        videoLink: json["video_link"],
        gender: json["gender"],
        minAge: json["min_age"],
        maxAge: json["max_age"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video_title": videoTitle,
        "video_description": videoDescription,
        "video_link": videoLink,
        "gender": gender,
        "min_age": minAge,
        "max_age": maxAge,
        "created_at": createdAt?.toIso8601String(),
      };
}
