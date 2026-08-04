import 'dart:convert';
import 'dart:ui';

import 'package:intl/intl.dart';

import '../Screens/const.dart';
import '../Screens/localconst.dart';

GetNewsDescriptionResponse getNewsDescriptionResponseFromJson(String str) =>
    GetNewsDescriptionResponse.fromJson(json.decode(str));

String getNewsDescriptionResponseToJson(GetNewsDescriptionResponse data) => json.encode(data.toJson());

class GetNewsDescriptionResponse {
  bool? success;
  List<NewsDescriptionModel>? data;
  String? message;

  GetNewsDescriptionResponse({
    this.success,
    this.data,
    this.message,
  });

  factory GetNewsDescriptionResponse.fromJson(Map<String, dynamic> json) => GetNewsDescriptionResponse(
        success: json["success"],
        data: List<NewsDescriptionModel>.from(json["data"].map((x) => NewsDescriptionModel.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class NewsDescriptionModel {
  String? newsTitleLang;
  String? newsDescriptionLang;
  String? newsTitle;
  int? id;
  String? newsImage;
  int? newsCategoryId;
  String? createdAt;
  dynamic language;
  dynamic languageCode;
  String? imageUrl;
  String? shareUrl;
  String? colorCode;

  DateTime getDate() {
    return DateTime.parse(createdAt ?? "");
  }

  String getImageUrl() {
    return image_news_url + (this.newsImage!.isEmpty || this.newsImage!.isEmpty ? "no-photo.png" : this.newsImage ?? "");
  }

  String getShareLink() {
    return this.newsTitle! +
        '\n' +
        // this.shareUrl +
        '\n\nअधिक जानकारी के लिए मांझा ऐप पर देखिए $app_link या हमारी वेबसाइट विजिट करे http://www.manjha.in';
  }

  Color getColor() {
    if (this.colorCode!.isEmpty || this.colorCode!.isEmpty) return kitembg;

    return Common.getHaxColor(this.colorCode);
  }

  String getFormattedDate() {
    var formatter = new DateFormat('MMM dd, yyyy'); //'yyyy-MM-dd'
    return formatter.format(getDate());
  }

  NewsDescriptionModel({
    this.newsTitleLang,
    this.newsDescriptionLang,
    this.newsTitle,
    this.id,
    this.newsImage,
    this.newsCategoryId,
    this.createdAt,
    this.language,
    this.languageCode,
    this.imageUrl,
    this.shareUrl,
    this.colorCode,
  });

  factory NewsDescriptionModel.fromJson(Map<String, dynamic> json) => NewsDescriptionModel(
        newsTitleLang: json["news_title_lang"],
        newsDescriptionLang: json["news_description_lang"],
        newsTitle: json["news_title"],
        id: json["id"],
        newsImage: json["news_image"],
        newsCategoryId: json["news_category_id"],
        createdAt: json["created_at"].toString(),
        language: json["language"],
        languageCode: json["language_code"],
        imageUrl: json["image_url"],
        shareUrl: json["shareUrl"],
        colorCode: json["color_code"],
      );

  Map<String, dynamic> toJson() => {
        "news_title_lang": newsTitleLang,
        "news_description_lang": newsDescriptionLang,
        "news_title": newsTitle,
        "id": id,
        "news_image": newsImage,
        "news_category_id": newsCategoryId,
        "created_at": createdAt,
        "language": language,
        "language_code": languageCode,
        "image_url": imageUrl,
        "shareUrl": shareUrl,
        "color_code": colorCode,
      };
}
