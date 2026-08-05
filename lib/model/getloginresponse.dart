// To parse this JSON data, do
//
//     final getloginresponse = getloginresponseFromJson(jsonString);

import 'dart:convert';

Getloginresponse getloginresponseFromJson(String str) =>
    Getloginresponse.fromJson(json.decode(str));

String getloginresponseToJson(Getloginresponse data) =>
    json.encode(data.toJson());

class Getloginresponse {
  bool? success;
  int? isnewuser;
  Data? data;
  String? message;

  Getloginresponse({
    this.success,
    this.isnewuser,
    this.data,
    this.message,
  });

  factory Getloginresponse.fromJson(Map<String, dynamic> json) =>
      Getloginresponse(
        success: json["success"],
        isnewuser: json["isnewuser"],
        data: (json["data"] is List && (json["data"] as List).isEmpty) || json["data"] == null
            ? null
            : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "isnewuser": isnewuser,
        "data": data!.toJson(),
        "message": message,
      };
}

class Data {
  int? id;
  String? fullName;
  String? mobileno;
  String? emailid;
  String? customerPhoto;
  String? address;
  String? cityname;

  Data({
    this.id,
    this.fullName,
    this.mobileno,
    this.emailid,
    this.customerPhoto,
    this.address,
    this.cityname,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        fullName: json["full_name"],
        mobileno: json["mobileno"],
        emailid: json["emailid"],
        customerPhoto: json["customer_photo"],
        address: json["address"],
        cityname: json["cityname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "mobileno": mobileno,
        "emailid": emailid,
        "customer_photo": customerPhoto,
        "address": address,
        "cityname": cityname,
      };
}
