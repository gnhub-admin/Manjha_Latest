import 'dart:convert';

import 'package:intl/intl.dart';

import '../Screens/const.dart';
import '../languagetranslation/apptranslation.dart';

MyForumResponse myForumResponseFromJson(String str) =>
    MyForumResponse.fromJson(json.decode(str));

String myForumResponseToJson(MyForumResponse data) =>
    json.encode(data.toJson());

class MyForumResponse {
  bool? success;
  List<MyForum>? data;
  String? message;

  MyForumResponse({
    this.success,
    this.data,
    this.message,
  });

  factory MyForumResponse.fromJson(Map<String, dynamic> json) =>
      MyForumResponse(
        success: json["success"],
        data: json["data"] != null
            ? List<MyForum>.from(json["data"].map((x) => MyForum.fromJson(x)))
            : [],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class MyForum {
  dynamic likedId;
  int? id;
  int? customerId;
  String? customerName;
  String? emailid;
  String? question;
  String? description;
  String? forumImage;
  String? forumVideo;
  int? totalLiked;
  int? totalComments;
  int? totalViewed;
  int? forumType;
  bool? isActive;
  bool? isDeleted;
  int? adminId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;
  String? shareUrl;

  String getFormattedDate() {
    var formatter = new DateFormat('dd-MMM-yyyy'); //'yyyy-MM-dd'
    return formatter.format(createdAt ?? DateTime.now());
  }

  String getLikes() {
    if (totalLiked == 0) return '0 ${translate("Likes")}';
    if (totalLiked == 1) return '1 ${translate("Like")}';
    // if (totalLiked! > 1) return '${totalLiked} Likes';
    return '$totalLiked ${translate("Likes")}';
  }

  String getComments() {
    if (totalComments == 0) return '0 ${translate("Comments")}';
    if (totalComments == 1) return '1 ${translate("Comment")}';
    // if (totalComments! > 1) return '${totalComments} Comments';
    return '$totalComments ${translate("Comments")}';
  }

  bool hasDescription() {
    return (description != null && description!.isNotEmpty);
  }

  bool isLiked() {
    return (likedId != null && likedId > 0);
  }

  // String getCustomerPhoto() {
  //   return image_customer_url +
  //       (customerPhoto != null && customerPhoto!.isNotEmpty
  //           ? customerPhoto!
  //           : "no-user.jpg");
  // }

  bool hasImage() {
    return forumImage != null && forumImage!.isNotEmpty;
  }

  String getImageURL() {
    return image_charcha_url +
        (forumImage != null && forumImage!.isNotEmpty
            ? forumImage!
            : "no-photo.png");
  }

  String getShareLink(String customerName) {
    return '${this.customerName} ने मांझा पर  मत्स्य सवाल किया है, \n"${question}"\n\n\nअधिक जानकारी के लिए मांझा ऐप पर देखिए $app_link या हमारी वेबसाइट विजिट करे http://www.manjha.in';
  }

  MyForum({
    this.likedId,
    this.id,
    this.customerId,
    this.customerName,
    this.emailid,
    this.question,
    this.description,
    this.forumImage,
    this.forumVideo,
    this.totalLiked,
    this.totalComments,
    this.totalViewed,
    this.forumType,
    this.isActive,
    this.isDeleted,
    this.adminId,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.shareUrl,
  });

  factory MyForum.fromJson(Map<String, dynamic> json) => MyForum(
        likedId: json["likedId"],
        id: json["id"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        emailid: json["emailid"],
        question: json["question"],
        description: json["description"],
        forumImage: json["forum_image"],
        forumVideo: json["forum_video"],
        totalLiked: json["total_liked"],
        totalComments: json["total_comments"],
        totalViewed: json["total_viewed"],
        forumType: json["forum_type"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        adminId: json["admin_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
        shareUrl: json["shareUrl"],
      );

  Map<String, dynamic> toJson() => {
        "likedId": likedId,
        "id": id,
        "customer_id": customerId,
        "customer_name": customerName,
        "emailid": emailid,
        "question": question,
        "description": description,
        "forum_image": forumImage,
        "forum_video": forumVideo,
        "total_liked": totalLiked,
        "total_comments": totalComments,
        "total_viewed": totalViewed,
        "forum_type": forumType,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "admin_id": adminId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_url": imageUrl,
        "shareUrl": shareUrl,
      };
}
