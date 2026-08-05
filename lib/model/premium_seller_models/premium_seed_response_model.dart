// To parse this JSON data, do
//
//     final premiumSeedGetResponseModel = premiumSeedGetResponseModelFromJson(jsonString);

import 'dart:convert';

PremiumSeedGetResponseModel premiumSeedGetResponseModelFromJson(String str) => PremiumSeedGetResponseModel.fromJson(json.decode(str));

String premiumSeedGetResponseModelToJson(PremiumSeedGetResponseModel data) => json.encode(data.toJson());

class PremiumSeedGetResponseModel {
  bool? success;
  List<PremiumSeedData>? data;

  PremiumSeedGetResponseModel({
    this.success,
    this.data,
  });

  factory PremiumSeedGetResponseModel.fromJson(Map<String, dynamic> json) => PremiumSeedGetResponseModel(
    success: json["success"],
    data: List<PremiumSeedData>.from(json["data"].map((x) => PremiumSeedData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PremiumSeedData {
  int? id;
  int? hatcheryId;
  String? seedName;
  int? seedWeight;
  String? seedSize;
  int? seedPrice;
  int? seedBonus;
  bool? isRtpcrTested;
  dynamic seedImage;
  dynamic seedVideo;
  String? description;
  int? sortOrder;
  bool? isActive;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  PremiumSeedData({
    this.id,
    this.hatcheryId,
    this.seedName,
    this.seedWeight,
    this.seedSize,
    this.seedPrice,
    this.seedBonus,
    this.isRtpcrTested,
    this.seedImage,
    this.seedVideo,
    this.description,
    this.sortOrder,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory PremiumSeedData.fromJson(Map<String, dynamic> json) => PremiumSeedData(
    id: json["id"],
    hatcheryId: json["hatchery_id"],
    seedName: json["seed_name"],
    seedWeight: json["seed_weight"],
    seedSize: json["seed_size"],
    seedPrice: json["seed_price"],
    seedBonus: json["seed_bonus"],
    isRtpcrTested: json["is_rtpcr_tested"],
    seedImage: json["seed_image"],
    seedVideo: json["seed_video"],
    description: json["description"],
    sortOrder: json["sort_order"],
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hatchery_id": hatcheryId,
    "seed_name": seedName,
    "seed_weight": seedWeight,
    "seed_size": seedSize,
    "seed_price": seedPrice,
    "seed_bonus": seedBonus,
    "is_rtpcr_tested": isRtpcrTested,
    "seed_image": seedImage,
    "seed_video": seedVideo,
    "description": description,
    "sort_order": sortOrder,
    "is_active": isActive,
    "is_deleted": isDeleted,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
