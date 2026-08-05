// To parse this JSON data, do
//
//     final getsession = getsessionFromJson(jsonString);

import 'dart:convert';

Getsession getsessionFromJson(String str) => Getsession.fromJson(json.decode(str));

String getsessionToJson(Getsession data) => json.encode(data.toJson());

class Getsession {
  bool? success;
  String? token;
  String? cookie;
  String? sessionId;
  String? sessionId2;
  Data? data;
  int? session;
  bool? ftoken;
  String? message;

  Getsession({
    this.success,
    this.token,
    this.cookie,
    this.sessionId,
    this.sessionId2,
    this.data,
    this.session,
    this.ftoken,
    this.message,
  });

  factory Getsession.fromJson(Map<String, dynamic> json) => Getsession(
        success: json["success"],
        token: json["token"],
        cookie: json["cookie"],
        sessionId: json["session_id"],
        sessionId2: json["session_id2"] == false ? "" : json["session_id2"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : Data(),
        session: json["session"],
        ftoken: json["ftoken"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "token": token,
        "cookie": cookie,
        "session_id": sessionId,
        "session_id2": sessionId2,
        "data": data?.toJson(),
        "session": session,
        "ftoken": ftoken,
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
