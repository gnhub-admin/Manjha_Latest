import 'dart:convert';

PremiumSeedCrudResponseModel premiumSeedCrudResponseModelFromJson(String str) => PremiumSeedCrudResponseModel.fromJson(json.decode(str));

String premiumSeedCrudResponseModelToJson(PremiumSeedCrudResponseModel data) => json.encode(data.toJson());

class PremiumSeedCrudResponseModel {
  bool? success;
  String? message;

  PremiumSeedCrudResponseModel({
    this.success,
    this.message,
  });

  factory PremiumSeedCrudResponseModel.fromJson(Map<String, dynamic> json) => PremiumSeedCrudResponseModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
