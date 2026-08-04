// To parse this JSON data, do
//
//     final getbrandresponse = getbrandresponseFromJson(jsonString);

import 'dart:convert';

import '../screens/const.dart';

Getbrandresponse getbrandresponseFromJson(String str) => Getbrandresponse.fromJson(json.decode(str));

String getbrandresponseToJson(Getbrandresponse data) => json.encode(data.toJson());

class Getbrandresponse {
  bool? success;
  List<Brands>? data;
  String? message;

  Getbrandresponse({
    this.success,
    this.data,
    this.message,
  });

  factory Getbrandresponse.fromJson(Map<String, dynamic> json) => Getbrandresponse(
        success: json["success"],
        data: List<Brands>.from(json["data"].map((x) => Brands.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Brands {
  int? id;
  String? brandNameLang;
  String? brandDescriptionLang;
  String? brandImage;
  int? sortOrder;
  bool? isActive;
  bool? isDeleted;
  int? moqLotSize;

  String? getName() {
    if (brandNameLang!.isEmpty) {
      return brandNameLang?.replaceAll('&amp;', '&');
    }
    return '';
  }

  String getImageUrl() {
    return image_brand_url + (brandImage!.isEmpty ? "no-photo.png" : brandImage!);
  }

  Brands({
    this.id,
    this.brandNameLang,
    this.brandDescriptionLang,
    this.brandImage,
    this.sortOrder,
    this.isActive,
    this.isDeleted,
    this.moqLotSize,
  });

  factory Brands.fromJson(Map<String, dynamic> json) => Brands(
        id: json["id"],
        brandNameLang: json["brand_name_lang"],
        brandDescriptionLang: json["brand_description_lang"],
        brandImage: json["brand_image"],
        sortOrder: json["sort_order"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        moqLotSize: json["moq_lot_size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand_name_lang": brandNameLang,
        "brand_description_lang": brandDescriptionLang,
        "brand_image": brandImage,
        "sort_order": sortOrder,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "moq_lot_size": moqLotSize,
      };
}
