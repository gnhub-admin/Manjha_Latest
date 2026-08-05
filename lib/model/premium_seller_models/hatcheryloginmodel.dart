// To parse this JSON data, do
//
//     final hatcheryloginmodel = hatcheryloginmodelFromJson(jsonString);

import 'dart:convert';

Hatcheryloginmodel hatcheryloginmodelFromJson(String str) =>
    Hatcheryloginmodel.fromJson(json.decode(str));

String hatcheryloginmodelToJson(Hatcheryloginmodel data) =>
    json.encode(data.toJson());

class Hatcheryloginmodel {
  bool? success;
  String? message;
  String? error;
  Hatchery? hatchery;

  Hatcheryloginmodel({
    this.success,
    this.message,
    this.error,
    this.hatchery,
  });

  factory Hatcheryloginmodel.fromJson(Map<String, dynamic> json) =>
      Hatcheryloginmodel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        error: json["error"] ?? "",
        hatchery: json["hatchery"] == null
            ? null
            : Hatchery.fromJson(json["hatchery"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "error": error,
        "hatchery": hatchery?.toJson(),
      };
}

class Hatchery {
  int? id;
  int? hatcheryZoneId;
  int? hatcheryTypeId;
  String? hatcheryName;
  String? subtitle;
  String? ownerName;
  String? mobileno;
  String? password;
  String? emailid;
  String? address;
  String? cityname;
  String? statename;
  bool? isManjhaTrusted;
  String? manjhaCertPhoto;
  bool? isNfbdApproved;
  String? nfbdCertPhoto;
  bool? isCaaApproved;
  dynamic caaCertPhoto;
  dynamic gstNo;
  dynamic gstPhoto;
  dynamic aadharNo;
  dynamic aadharPhoto1;
  dynamic aadharPhoto2;
  dynamic panNo;
  dynamic panPhoto;
  String? hatcheryPhoto;
  dynamic hatcheryVideo;
  DateTime? expiryDate;
  int? amountPaid;
  dynamic priority;
  bool? isActive;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  Hatchery({
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
  });

  factory Hatchery.fromJson(Map<String, dynamic> json) => Hatchery(
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
        expiryDate: json["expiry_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["expiry_date"]),
        amountPaid: json["amount_paid"],
        priority: json["priority"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
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
      };
}
