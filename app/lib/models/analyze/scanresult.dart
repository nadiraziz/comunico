// To parse this JSON data, do
//
//     final scanResultResponse = scanResultResponseFromJson(jsonString);

import 'dart:convert';

ScanResultResponse scanResultResponseFromJson(String str) =>
    ScanResultResponse.fromJson(json.decode(str));

String scanResultResponseToJson(ScanResultResponse data) =>
    json.encode(data.toJson());

class ScanResultResponse {
  int? id;
  String? video;
  String? voiceEmotion;
  String? faceEmotion;
  String? feedback;
  String? additionalFeedback;
  int? performanceScore;
  DateTime? createdAt;
  int? user;

  ScanResultResponse(
      {this.id,
      this.video,
      this.voiceEmotion,
      this.faceEmotion,
      this.feedback,
      this.additionalFeedback,
      this.createdAt,
      this.user,
      this.performanceScore});

  factory ScanResultResponse.fromJson(Map<String, dynamic> json) {
    return ScanResultResponse(
      id: json["id"],
      video: json["video"],
      voiceEmotion: json["voice_emotion"],
      faceEmotion: json["face_emotion"],
      feedback: json["feedback"],
      performanceScore: json["performance_score"],
      additionalFeedback: json["additional_feedback"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      user: json["user"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
        "voice_emotion": voiceEmotion,
        "face_emotion": faceEmotion,
        "feedback": feedback,
        "performance_score": performanceScore,
        "additional_feedback": additionalFeedback,
        "created_at": createdAt?.toIso8601String(),
        "user": user,
      };
}
