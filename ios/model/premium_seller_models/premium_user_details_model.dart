import 'dart:convert';

PremiumUserDetailModel premiumUserDetailModelFromJson(String str) => PremiumUserDetailModel.fromJson(json.decode(str));

String premiumUserDetailModelToJson(PremiumUserDetailModel data) => json.encode(data.toJson());

class PremiumUserDetailModel {
  bool? success;
  PremiumUserData? premiumUserData;

  PremiumUserDetailModel({
    this.success,
    this.premiumUserData,
  });

  factory PremiumUserDetailModel.fromJson(Map<String, dynamic> json) => PremiumUserDetailModel(
    success: json["success"],
    premiumUserData: PremiumUserData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": premiumUserData?.toJson(),
  };
}

class PremiumUserData {
  int? currentPage;
  List<PreUserDataList>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<UserDetailsLink>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  PremiumUserData({
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

  factory PremiumUserData.fromJson(Map<String, dynamic> json) => PremiumUserData(
    currentPage: json["current_page"],
    data: List<PreUserDataList>.from(json["data"].map((x) => PreUserDataList.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<UserDetailsLink>.from(json["links"].map((x) => UserDetailsLink.fromJson(x))),
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

class PreUserDataList {
  int? id;
  int? customerId;
  int? hatcheryId;
  int? hatcherySeedId;
  String? action;
  dynamic ipAddress;
  String? createdAt;
  String? updatedAt;
  dynamic seedName;
  dynamic seedSize;
  dynamic seedWeight;
  dynamic seedPrice;
  String? fullName;
  String? mobileno;
  String? cityname;

  PreUserDataList({
    this.id,
    this.customerId,
    this.hatcheryId,
    this.hatcherySeedId,
    this.action,
    this.ipAddress,
    this.createdAt,
    this.updatedAt,
    this.seedName,
    this.seedSize,
    this.seedWeight,
    this.seedPrice,
    this.fullName,
    this.mobileno,
    this.cityname,
  });

  factory PreUserDataList.fromJson(Map<String, dynamic> json) => PreUserDataList(
    id: json["id"],
    customerId: json["customer_id"],
    hatcheryId: json["hatchery_id"],
    hatcherySeedId: json["hatchery_seed_id"],
    action: json["action"],
    ipAddress: json["ip_address"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    seedName: json["seed_name"],
    seedSize: json["seed_size"],
    seedWeight: json["seed_weight"],
    seedPrice: json["seed_price"],
    fullName: json["full_name"],
    mobileno: json["mobileno"],
    cityname: json["cityname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "hatchery_id": hatcheryId,
    "hatchery_seed_id": hatcherySeedId,
    "action": action,
    "ip_address": ipAddress,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "seed_name": seedName,
    "seed_size": seedSize,
    "seed_weight": seedWeight,
    "seed_price": seedPrice,
    "full_name": fullName,
    "mobileno": mobileno,
    "cityname": cityname,
  };
}

class UserDetailsLink {
  String? url;
  String? label;
  bool? active;

  UserDetailsLink({
    this.url,
    this.label,
    this.active,
  });

  factory UserDetailsLink.fromJson(Map<String, dynamic> json) => UserDetailsLink(
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
