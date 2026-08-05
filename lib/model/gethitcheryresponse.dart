// To parse this JSON data, do
//
//     final gethitcheryresponse = gethitcheryresponseFromJson(jsonString);

import 'dart:convert';

import 'package:manjha/screens/const.dart';

Gethitcheryresponse gethitcheryresponseFromJson(String str) => Gethitcheryresponse.fromJson(json.decode(str));

String gethitcheryresponseToJson(Gethitcheryresponse data) => json.encode(data.toJson());

class Gethitcheryresponse {
  bool? success;
  List<dynamic>? data;
  List<Fish>? fish;
  List<Fish>? shrimp;
  String? message;

  Gethitcheryresponse({
    this.success,
    this.data,
    this.fish,
    this.shrimp,
    this.message,
  });

  factory Gethitcheryresponse.fromJson(Map<String, dynamic> json) => Gethitcheryresponse(
        success: json["success"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        fish: List<Fish>.from(json["fish"].map((x) => Fish.fromJson(x))),
        shrimp: List<Fish>.from(json["shrimp"].map((x) => Fish.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x)),
        "fish": List<dynamic>.from(fish!.map((x) => x.toJson())),
        "shrimp": List<dynamic>.from(shrimp!.map((x) => x.toJson())),
        "message": message,
      };
}

class Fish {
  String? zoneName;
  int? id;
  int? hatcheryZoneId;
  int? hatcheryTypeId;
  String? hatcheryName;
  dynamic subtitle;
  String? ownerName;
  String? mobileno;
  String? password;
  String? emailid;
  String? address;
  String? cityname;
  String? statename;
  bool? isManjhaTrusted;
  dynamic manjhaCertPhoto;
  bool? isNfbdApproved;
  String? nfbdCertPhoto;
  bool? isCaaApproved;
  String? caaCertPhoto;
  String? gstNo;
  String? gstPhoto;
  String? aadharNo;
  String? aadharPhoto1;
  String? aadharPhoto2;
  String? panNo;
  String? panPhoto;
  String? hatcheryPhoto;
  String? hatcheryVideo;
  DateTime? expiryDate;
  int? amountPaid;
  double? priority;
  bool? isActive;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;
  List<Seed>? seeds;
  List<String>? images;

  bool isFish() {
    return hatcheryTypeId == 1;
  }

  bool isShrimp() {
    return hatcheryTypeId == 2;
  }

  String getLocation() {
    return "${cityname}, ${statename}";
  }

  String getMessage() {
    return "Hello ${ownerName}, I am interested for ${hatcheryName}. Please reply soon. ";
  }

  String getSubTitle() {
    if (subtitle != null && subtitle.isNotEmpty) return subtitle;
    return "";
  }

  String getShareText() {
    return "Please checkout ${hatcheryName} premium listing on Manjha.in.";
  }

  String getImageUrl() {
    return image_hatchery_url + (hatcheryPhoto == null || hatcheryPhoto!.isEmpty ? "no-photo.png" : hatcheryPhoto!);
  }

  bool hasVideo() {
    return (hatcheryVideo != null && hatcheryVideo!.isNotEmpty);
  }

  String getVideoUrl() {
    return image_hatchery_url + (hatcheryVideo == null || hatcheryVideo!.isEmpty ? "no-photo.png" : hatcheryVideo!);
  }

  String getMediaUrl(String mediaName) {
    return image_hatchery_url + (mediaName.isEmpty || mediaName.isEmpty ? "no-photo.png" : mediaName);
  }

  Fish({
    this.zoneName,
    this.id,
    this.hatcheryZoneId,
    this.hatcheryTypeId,
    this.hatcheryName,
    this.subtitle,
    this.ownerName,
    this.mobileno,
    this.password,
    this.emailid,
    this.address,
    this.cityname,
    this.statename,
    this.isManjhaTrusted,
    this.manjhaCertPhoto,
    this.isNfbdApproved,
    this.nfbdCertPhoto,
    this.isCaaApproved,
    this.caaCertPhoto,
    this.gstNo,
    this.gstPhoto,
    this.aadharNo,
    this.aadharPhoto1,
    this.aadharPhoto2,
    this.panNo,
    this.panPhoto,
    this.hatcheryPhoto,
    this.hatcheryVideo,
    this.expiryDate,
    this.amountPaid,
    this.priority,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.seeds,
    this.images,
  });

  factory Fish.fromJson(Map<String, dynamic> json) => Fish(
        zoneName: json["zone_name"],
        id: json["id"],
        hatcheryZoneId: json["hatchery_zone_id"],
        hatcheryTypeId: json["hatchery_type_id"],
        hatcheryName: json["hatchery_name"],
        subtitle: json["subtitle"],
        ownerName: json["owner_name"],
        mobileno: json["mobileno"],
        password: json["password"],
        emailid: json["emailid"],
        address: json["address"],
        cityname: json["cityname"],
        statename: json["statename"],
        isManjhaTrusted: json["is_manjha_trusted"],
        manjhaCertPhoto: json["manjha_cert_photo"],
        isNfbdApproved: json["is_nfbd_approved"],
        nfbdCertPhoto: json["nfbd_cert_photo"],
        isCaaApproved: json["is_caa_approved"],
        caaCertPhoto: json["caa_cert_photo"],
        gstNo: json["gst_no"],
        gstPhoto: json["gst_photo"],
        aadharNo: json["aadhar_no"],
        aadharPhoto1: json["aadhar_photo_1"],
        aadharPhoto2: json["aadhar_photo_2"],
        panNo: json["pan_no"],
        panPhoto: json["pan_photo"],
        hatcheryPhoto: json["hatchery_photo"],
        hatcheryVideo: json["hatchery_video"],
        expiryDate: DateTime.parse(json["expiry_date"]),
        amountPaid: json["amount_paid"],
        priority: json["priority"].toDouble(),
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
        seeds: List<Seed>.from(json["seeds"].map((x) => Seed.fromJson(x))),
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "zone_name": zoneName,
        "id": id,
        "hatchery_zone_id": hatcheryZoneId,
        "hatchery_type_id": hatcheryTypeId,
        "hatchery_name": hatcheryName,
        "subtitle": subtitle,
        "owner_name": ownerName,
        "mobileno": mobileno,
        "password": password,
        "emailid": emailid,
        "address": address,
        "cityname": cityname,
        "statename": statename,
        "is_manjha_trusted": isManjhaTrusted,
        "manjha_cert_photo": manjhaCertPhoto,
        "is_nfbd_approved": isNfbdApproved,
        "nfbd_cert_photo": nfbdCertPhoto,
        "is_caa_approved": isCaaApproved,
        "caa_cert_photo": caaCertPhoto,
        "gst_no": gstNo,
        "gst_photo": gstPhoto,
        "aadhar_no": aadharNo,
        "aadhar_photo_1": aadharPhoto1,
        "aadhar_photo_2": aadharPhoto2,
        "pan_no": panNo,
        "pan_photo": panPhoto,
        "hatchery_photo": hatcheryPhoto,
        "hatchery_video": hatcheryVideo,
        "expiry_date": expiryDate?.toIso8601String(),
        "amount_paid": amountPaid,
        "priority": priority,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_url": imageUrl,
        "seeds": List<dynamic>.from(seeds!.map((x) => x.toJson())),
        "images": List<dynamic>.from(images!.map((x) => x)),
      };
}

class Seed {
  int? id;
  int? hatcheryId;
  String? seedName;
  int? seedWeight;
  String? seedSize;
  double? seedPrice;
  int? seedBonus;
  bool? isRtpcrTested;
  String? seedImage;
  String? seedVideo;
  dynamic description;
  int? sortOrder;
  bool? isActive;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;
  String? videoUrl;

  String getImageUrl() {
    return image_hatcheryseed_url + (seedImage == null || seedImage!.isEmpty ? "no-photo.png" : seedImage!);
  }

  bool hasVideo() {
    return (seedVideo != null && seedVideo!.isNotEmpty);
  }

  String getVideoUrl() {
    return image_hatcheryseed_url + (seedVideo == null || seedVideo!.isEmpty ? "no-photo.png" : seedVideo!);
  }

  getPrice() {
    return "${seedPrice}/pcs";
  }

  getSize() {
    return "${seedSize}"; //  in
  }

  getBonus() {
    return "${seedBonus}%";
  }

  getWeight() {
    return "${seedWeight} pc/kg";
  }

  Seed({
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
    this.imageUrl,
    this.videoUrl,
  });

  factory Seed.fromJson(Map<String, dynamic> json) => Seed(
        id: json["id"],
        hatcheryId: json["hatchery_id"],
        seedName: json["seed_name"],
        seedWeight: json["seed_weight"],
        seedSize: json["seed_size"],
        seedPrice: json["seed_price"].toDouble(),
        seedBonus: json["seed_bonus"],
        isRtpcrTested: json["is_rtpcr_tested"],
        seedImage: json["seed_image"],
        seedVideo: json["seed_video"],
        description: json["description"],
        sortOrder: json["sort_order"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
        videoUrl: json["video_url"],
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_url": imageUrl,
        "video_url": videoUrl,
      };
}
