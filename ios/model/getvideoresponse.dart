// To parse this JSON data, do
//
//     final getVideoResponse = getVideoResponseFromJson(jsonString);

import 'dart:convert';

GetVideoResponse getVideoResponseFromJson(String str) => GetVideoResponse.fromJson(json.decode(str));

String getVideoResponseToJson(GetVideoResponse data) => json.encode(data.toJson());

class GetVideoResponse {
  bool? success;
  List<Datum>? data;
  String? message;

  GetVideoResponse({
    this.success,
    this.data,
    this.message,
  });

  factory GetVideoResponse.fromJson(Map<String, dynamic> json) => GetVideoResponse(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  String? videoTitle;
  String? videoUrl;
  String? videoTitleLang;
  int? id;
  String? languageCode;
  String? createdAt;
  String? videoImage;

  DateTime getDate() {
    return DateTime.parse(createdAt ?? "");
  }

  Datum({
    this.videoTitle,
    this.videoUrl,
    this.videoTitleLang,
    this.id,
    this.languageCode,
    this.createdAt,
    this.videoImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        videoTitle: json["video_title"],
        videoUrl: json["video_url"],
        videoTitleLang: json["video_title_lang"],
        id: json["id"],
        languageCode: json["language_code"],
        createdAt: json["created_at"].toString(),
        videoImage: json["video_image"],
      );

  Map<String, dynamic> toJson() => {
        "video_title": videoTitle,
        "video_url": videoUrl,
        "video_title_lang": videoTitleLang,
        "id": id,
        "language_code": languageCode,
        "created_at": createdAt,
        "video_image": videoImage,
      };
}
