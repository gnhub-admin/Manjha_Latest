// To parse this JSON data, do
//
//     final copenListResponse = copenListResponseFromJson(jsonString);

import 'dart:convert';

CopenListResponse copenListResponseFromJson(String str) => CopenListResponse.fromJson(json.decode(str));

String copenListResponseToJson(CopenListResponse data) => json.encode(data.toJson());

class CopenListResponse {
  bool? success;
  List<CouponData>? coupons;

  CopenListResponse({
    this.success,
    this.coupons,
  });

  factory CopenListResponse.fromJson(Map<String, dynamic> json) => CopenListResponse(
    success: json["success"],
    coupons: json["coupons"] == null ? [] :List<CouponData>.from(json["coupons"].map((x) => CouponData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "coupons": List<dynamic>.from(coupons!.map((x) => x.toJson())),
  };
}

class CouponData {
  String? code;
  String? message;

  CouponData({
    this.code,
    this.message,
  });

  factory CouponData.fromJson(Map<String, dynamic> json) => CouponData(
    code: json["code"] ?? "",
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
