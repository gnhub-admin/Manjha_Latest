import 'dart:convert';

GalleryDeleteModel galleryDeleteModelFromJson(String str) => GalleryDeleteModel.fromJson(json.decode(str));

String galleryDeleteModelToJson(GalleryDeleteModel data) => json.encode(data.toJson());

class GalleryDeleteModel {
  bool? success;
  String? message;

  GalleryDeleteModel({
    this.success,
    this.message,
  });

  factory GalleryDeleteModel.fromJson(Map<String, dynamic> json) => GalleryDeleteModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
