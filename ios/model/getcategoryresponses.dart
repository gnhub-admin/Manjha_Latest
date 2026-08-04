import 'dart:convert';

GetcategoryResponse getcategoryResponseFromJson(String str) => GetcategoryResponse.fromJson(json.decode(str));

String getcategoryResponseToJson(GetcategoryResponse data) => json.encode(data.toJson());

class GetcategoryResponse {
  bool? success;
  List<DatumCategory>? data;
  String? message;

  GetcategoryResponse({
    this.success,
    this.data,
    this.message,
  });

  factory GetcategoryResponse.fromJson(Map<String, dynamic> json) => GetcategoryResponse(
        success: json["success"],
        data: List<DatumCategory>.from(json["data"].map((x) => DatumCategory.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class DatumCategory {
  int? id;
  String? newsCategoryName;
  String? newsCategoryImage;
  String? categoryName;
  String? colorCode;

  DatumCategory({
    this.id,
    this.newsCategoryName,
    this.newsCategoryImage,
    this.categoryName,
    this.colorCode,
  });

  factory DatumCategory.fromJson(Map<String, dynamic> json) => DatumCategory(
        id: json["id"],
        newsCategoryName: json["news_category_name"],
        newsCategoryImage: json["news_category_image"],
        categoryName: json["category_name"],
        colorCode: json["color_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "news_category_name": newsCategoryName,
        "news_category_image": newsCategoryImage,
        "category_name": categoryName,
        "color_code": colorCode,
      };
}
