// To parse this JSON data, do
//
//     final getcategoriesresponse = getcategoriesresponseFromJson(jsonString);

import 'dart:convert';

Getcategoriesresponse getcategoriesresponseFromJson(String str) => Getcategoriesresponse.fromJson(json.decode(str));

String getcategoriesresponseToJson(Getcategoriesresponse data) => json.encode(data.toJson());

class Getcategoriesresponse {
  bool? success;
  List<Categorys>? data;
  String? message;

  Getcategoriesresponse({
    this.success,
    this.data,
    this.message,
  });

  factory Getcategoriesresponse.fromJson(Map<String, dynamic> json) => Getcategoriesresponse(
        success: json["success"],
        data: List<Categorys>.from(json["data"].map((x) => Categorys.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Categorys {
  int? id;
  String? categoryName;
  String? categoryDescription;
  String? categoryImage;
  int? parentId;
  String? brandIds;
  int? sortOrder;
  bool? isActive;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryNameLang;
  String? categoryDescriptionLang;
  int? totalChildren;
  List<Brand>? brands;
  String? imageUrl;

  Categorys({
    this.id,
    this.categoryName,
    this.categoryDescription,
    this.categoryImage,
    this.parentId,
    this.brandIds,
    this.sortOrder,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.categoryNameLang,
    this.categoryDescriptionLang,
    this.totalChildren,
    this.brands,
    this.imageUrl,
  });

  factory Categorys.fromJson(Map<String, dynamic> json) => Categorys(
        id: json["id"],
        categoryName: json["category_name"],
        categoryDescription: json["category_description"],
        categoryImage: json["category_image"],
        parentId: json["parent_id"],
        brandIds: json["brand_ids"],
        sortOrder: json["sort_order"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoryNameLang: json["category_name_lang"],
        categoryDescriptionLang: json["category_description_lang"],
        totalChildren: json["total_children"],
        brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "category_description": categoryDescription,
        "category_image": categoryImage,
        "parent_id": parentId,
        "brand_ids": brandIds,
        "sort_order": sortOrder,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category_name_lang": categoryNameLang,
        "category_description_lang": categoryDescriptionLang,
        "total_children": totalChildren,
        "brands": List<dynamic>.from(brands!.map((x) => x.toJson())),
        "image_url": imageUrl,
      };
}

class Brand {
  int? id;
  String? brandNameLang;
  String? brandDescriptionLang;
  String? brandImage;
  int? sortOrder;
  bool? isActive;
  bool? isDeleted;
  String? imageUrl;

  Brand({
    this.id,
    this.brandNameLang,
    this.brandDescriptionLang,
    this.brandImage,
    this.sortOrder,
    this.isActive,
    this.isDeleted,
    this.imageUrl,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        brandNameLang: json["brand_name_lang"],
        brandDescriptionLang: json["brand_description_lang"],
        brandImage: json["brand_image"],
        sortOrder: json["sort_order"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand_name_lang": brandNameLang,
        "brand_description_lang": brandDescriptionLang,
        "brand_image": brandImage,
        "sort_order": sortOrder,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "image_url": imageUrl,
      };
}
