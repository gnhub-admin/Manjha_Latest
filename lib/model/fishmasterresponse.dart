// To parse this JSON data, do
//
//     final fishmasterresponse = fishmasterresponseFromJson(jsonString);

import 'dart:convert';

Fishmasterresponse fishmasterresponseFromJson(String str) => Fishmasterresponse.fromJson(json.decode(str));

String fishmasterresponseToJson(Fishmasterresponse data) => json.encode(data.toJson());

class Fishmasterresponse {
  bool? success;
  Data? data;
  String? message;

  Fishmasterresponse({
    this.success,
    this.data,
    this.message,
  });

  factory Fishmasterresponse.fromJson(Map<String, dynamic> json) => Fishmasterresponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
        "message": message,
      };
}

class Data {
  List<Fishtype>? fishtypes;
  List<Fishcategory>? fishcategories;
  List<Fishsize>? fishsizes;

  Data({
    this.fishtypes,
    this.fishcategories,
    this.fishsizes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fishtypes: List<Fishtype>.from(json["fishtypes"].map((x) => Fishtype.fromJson(x))),
        fishcategories: List<Fishcategory>.from(json["fishcategories"].map((x) => Fishcategory.fromJson(x))),
        fishsizes: List<Fishsize>.from(json["fishsizes"].map((x) => Fishsize.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fishtypes": List<dynamic>.from(fishtypes!.map((x) => x.toJson())),
        "fishcategories": List<dynamic>.from(fishcategories!.map((x) => x.toJson())),
        "fishsizes": List<dynamic>.from(fishsizes!.map((x) => x.toJson())),
      };
}

class Fishcategory {
  int? id;
  String? fishCategoryName;

  Fishcategory({
    this.id,
    this.fishCategoryName,
  });

  factory Fishcategory.fromJson(Map<String, dynamic> json) => Fishcategory(
        id: json["id"],
        fishCategoryName: json["fish_category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fish_category_name": fishCategoryName,
      };
}

class Fishsize {
  String? id;
  String? fishSizeTypeName;

  Fishsize({
    this.id,
    this.fishSizeTypeName,
  });

  factory Fishsize.fromJson(Map<String, dynamic> json) => Fishsize(
        id: json["id"],
        fishSizeTypeName: json["fish_size_type_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fish_size_type_name": fishSizeTypeName,
      };
}

class Fishtype {
  int? id;
  String? fishTypeName;

  Fishtype({
    this.id,
    this.fishTypeName,
  });

  factory Fishtype.fromJson(Map<String, dynamic> json) => Fishtype(
        id: json["id"],
        fishTypeName: json["fish_type_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fish_type_name": fishTypeName,
      };
}
