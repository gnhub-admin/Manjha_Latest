import 'dart:convert';
import 'package:intl/intl.dart';
import '../screens/const.dart';
import '../services/apiconst.dart';

Getfourmdetails getfourmdetailsFromJson(String str) =>
    Getfourmdetails.fromJson(json.decode(str));

String getfourmdetailsToJson(Getfourmdetails data) =>
    json.encode(data.toJson());

class Getfourmdetails {
  bool? success;
  List<ForumDetailItem>? data;
  String? message;

  Getfourmdetails({
    this.success,
    this.data,
    this.message,
  });

  factory Getfourmdetails.fromJson(Map<String, dynamic> json) =>
      Getfourmdetails(
        success: json["success"],
        data: List<ForumDetailItem>.from(
            json["data"].map((x) => ForumDetailItem.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class ForumDetailItem {
  dynamic fullName;
  dynamic customerPhoto;
  int? id;
  int? questionId;
  dynamic customerId;
  int? adminId;
  String? answer;
  bool? isActive;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  ForumDetailItem({
    this.fullName,
    this.customerPhoto,
    this.id,
    this.questionId,
    this.customerId,
    this.adminId,
    this.answer,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  getName() {
    return (fullName == null) ? "Admin" : fullName;
  }

  String getCustomerPhoto() {
    return image_customer_url +
        (this.customerPhoto != null && this.customerPhoto.isNotEmpty
            ? this.customerPhoto
            : "no-user.jpg");
  }

  bool isDeletePermission() {
    return this.customerId != null && saveUser()?.data?.id == this.customerId;
  }

  String getFormattedDate() {
    var formatter = new DateFormat('dd-MMM-yyyy'); //'yyyy-MM-dd'
    return formatter.format(createdAt ?? DateTime.now());
  }

  factory ForumDetailItem.fromJson(Map<String, dynamic> json) =>
      ForumDetailItem(
        fullName: json["full_name"],
        customerPhoto: json["customer_photo"],
        id: json["id"],
        questionId: json["question_id"],
        customerId: json["customer_id"],
        adminId: json["admin_id"],
        answer: json["answer"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "customer_photo": customerPhoto,
        "id": id,
        "question_id": questionId,
        "customer_id": customerId,
        "admin_id": adminId,
        "answer": answer,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
