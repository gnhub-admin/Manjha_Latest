import 'dart:convert';

Getnewsdiscriptionresponse getnewsdiscriptionresponseFromJson(String str) =>
    Getnewsdiscriptionresponse.fromJson(json.decode(str));

String getnewsdiscriptionresponseToJson(Getnewsdiscriptionresponse data) => json.encode(data.toJson());

class Getnewsdiscriptionresponse {
  bool? success;
  List<NewsDiscription>? data;
  String? message;

  Getnewsdiscriptionresponse({
    this.success,
    this.data,
    this.message,
  });

  factory Getnewsdiscriptionresponse.fromJson(Map<String, dynamic> json) => Getnewsdiscriptionresponse(
        success: json["success"],
        data: List<NewsDiscription>.from(json["data"].map((x) => NewsDiscription.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class NewsDiscription {
  String? newsTitleLang;
  String? newsDescriptionLang;
  String? newsTitle;
  int? id;
  int? newsCategoryId;
  DateTime? createdAt;
  dynamic language;
  dynamic languageCode;
  String? shareUrl;
  String? colorCode;

  NewsDiscription({
    this.newsTitleLang,
    this.newsDescriptionLang,
    this.newsTitle,
    this.id,
    this.newsCategoryId,
    this.createdAt,
    this.language,
    this.languageCode,
    this.shareUrl,
    this.colorCode,
  });

  factory NewsDiscription.fromJson(Map<String, dynamic> json) => NewsDiscription(
        newsTitleLang: json["news_title_lang"],
        newsDescriptionLang: json["news_description_lang"],
        newsTitle: json["news_title"],
        id: json["id"],
        newsCategoryId: json["news_category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        language: json["language"],
        languageCode: json["language_code"],
        shareUrl: json["shareUrl"],
        colorCode: json["color_code"],
      );

  Map<String, dynamic> toJson() => {
        "news_title_lang": newsTitleLang,
        "news_description_lang": newsDescriptionLang,
        "news_title": newsTitle,
        "id": id,
        "news_category_id": newsCategoryId,
        "created_at": createdAt?.toIso8601String(),
        "language": language,
        "language_code": languageCode,
        "shareUrl": shareUrl,
        "color_code": colorCode,
      };
}
