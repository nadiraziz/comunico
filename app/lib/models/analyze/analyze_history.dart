// To parse this JSON data, do
//
//     final analyzeHistoryResponse = analyzeHistoryResponseFromJson(jsonString);

import 'dart:convert';

List<AnalyzeHistoryResponse> analyzeHistoryResponseFromJson(String str) =>
    List<AnalyzeHistoryResponse>.from(
        json.decode(str).map((x) => AnalyzeHistoryResponse.fromJson(x)));

String analyzeHistoryResponseToJson(List<AnalyzeHistoryResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnalyzeHistoryResponse {
  int? id;
  String? video;
  String? voiceEmotion;
  String? faceEmotion;
  String? feedback;
  String? additionalFeedback;
  DateTime? createdAt;

  AnalyzeHistoryResponse({
    this.id,
    this.video,
    this.voiceEmotion,
    this.faceEmotion,
    this.feedback,
    this.additionalFeedback,
    this.createdAt,
  });

  factory AnalyzeHistoryResponse.fromJson(Map<String, dynamic> json) =>
      AnalyzeHistoryResponse(
        id: json["id"],
        video: json["video"],
        voiceEmotion: json["voice_emotion"],
        faceEmotion: json["face_emotion"],
        feedback: json["feedback"],
        additionalFeedback: json["additional_feedback"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
        "voice_emotion": voiceEmotion,
        "face_emotion": faceEmotion,
        "feedback": feedback,
        "additional_feedback": additionalFeedback,
        "created_at": createdAt?.toIso8601String(),
      };
}
