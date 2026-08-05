import 'dart:convert';

GalleryUploadModel galleryUploadModelFromJson(String str) => GalleryUploadModel.fromJson(json.decode(str));

String galleryUploadModelToJson(GalleryUploadModel data) => json.encode(data.toJson());

class GalleryUploadModel {
  bool? success;
  String? message;

  GalleryUploadModel({
    this.success,
    this.message,
  });

  factory GalleryUploadModel.fromJson(Map<String, dynamic> json) => GalleryUploadModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
