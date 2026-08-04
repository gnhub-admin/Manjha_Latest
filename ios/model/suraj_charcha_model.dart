import 'dart:convert';
import 'package:intl/intl.dart';
import '../Screens/const.dart';
import '../languagetranslation/apptranslation.dart';

CharchaModel charchaModelFromJson(String str) =>
    CharchaModel.fromJson(json.decode(str));

String charchaModelToJson(CharchaModel data) => json.encode(data.toJson());

class CharchaModel {
  bool? success;
  ForumData? data;
  String? message;

  CharchaModel({
    this.success,
    this.data,
    this.message,
  });

  factory CharchaModel.fromJson(Map<String, dynamic> json) => CharchaModel(
        success: json["success"],
        data: ForumData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
        "message": message,
      };
}

class ForumData {
  int? currentPage;
  List<Forumdd>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ForumData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory ForumData.fromJson(Map<String, dynamic> json) => ForumData(
        currentPage: json["current_page"],
        data: List<Forumdd>.from(json["data"].map((x) => Forumdd.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Forumdd {
  String? customerPhoto;
  int? likedId;
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
  String? shareUrl;
  List<Comment>? comments;

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
    return (likedId != null && (likedId)! > 0);
  }

  String getCustomerPhoto() {
    return image_customer_url +
        (customerPhoto != null && customerPhoto!.isNotEmpty
            ? customerPhoto!
            : "no-user.jpg");
  }

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

  Forumdd({
    this.customerPhoto,
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
    this.shareUrl,
    this.comments,
  });

  factory Forumdd.fromJson(Map<String, dynamic> json) => Forumdd(
        customerPhoto: json["customer_photo"],
        likedId: json["likedId"] ?? 0,
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
        shareUrl: json["shareUrl"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "customer_photo": customerPhoto,
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
        "shareUrl": shareUrl,
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
      };
}

class Comment {
  String? fullName;
  String? customerPhoto;
  int? id;
  int? questionId;
  int? customerId;
  int? adminId;
  String? answer;
  bool? isActive;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  String getCustomerPhoto() {
    return image_customer_url +
        (customerPhoto != null && customerPhoto!.isNotEmpty
            ? customerPhoto!
            : "no-user.jpg");
  }

  getName() {
    return (fullName == null) ? "Admin" : fullName;
  }

  String getFormattedDate() {
    var formatter = new DateFormat('dd-MMM-yyyy'); //'yyyy-MM-dd'
    return formatter.format(getName());
  }

  Comment({
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

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
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

enum Emailid { INFO_MANJHA_COM }

final emailidValues = EnumValues({"info@manjha.com": Emailid.INFO_MANJHA_COM});

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
