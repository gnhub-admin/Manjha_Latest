// To parse this JSON data, do
//
//     final galleryResponseModel = galleryResponseModelFromJson(jsonString);

import 'dart:convert';

GalleryResponseModel galleryResponseModelFromJson(String str) => GalleryResponseModel.fromJson(json.decode(str));

String galleryResponseModelToJson(GalleryResponseModel data) => json.encode(data.toJson());

class GalleryResponseModel {
  bool? success;
  String? message;
  List<GalleryDataList>? data;

  GalleryResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory GalleryResponseModel.fromJson(Map<String, dynamic> json) => GalleryResponseModel(
    success: json["success"],
    message: json["message"],
    data: List<GalleryDataList>.from(json["data"].map((x) => GalleryDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GalleryDataList {
  int? id;
  int? hatcheryId;
  String? mediaTitle;
  String? mediaName;
  String? mediaType;
  int? sortOrder;
  bool? isActive;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  GalleryDataList({
    this.id,
    this.hatcheryId,
    this.mediaTitle,
    this.mediaName,
    this.mediaType,
    this.sortOrder,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory GalleryDataList.fromJson(Map<String, dynamic> json) => GalleryDataList(
    id: json["id"],
    hatcheryId: json["hatchery_id"],
    mediaTitle: json["media_title"],
    mediaName: json["media_name"],
    mediaType: json["media_type"],
    sortOrder: json["sort_order"],
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hatchery_id": hatcheryId,
    "media_title": mediaTitle,
    "media_name": mediaName,
    "media_type": mediaType,
    "sort_order": sortOrder,
    "is_active": isActive,
    "is_deleted": isDeleted,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class GalleryLinks {
  String? url;
  String? label;
  bool? active;

  GalleryLinks({
    this.url,
    this.label,
    this.active,
  });

  factory GalleryLinks.fromJson(Map<String, dynamic> json) => GalleryLinks(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
