import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../languagetranslation/apptranslation.dart';
import '../screens/const.dart';
import '../screens/localconst.dart';

Searchfishresponse searchfishresponseFromJson(String str) =>
    Searchfishresponse.fromJson(json.decode(str));

String searchfishresponseToJson(Searchfishresponse data) =>
    json.encode(data.toJson());

class Searchfishresponse {
  bool? success;
  Data? data;
  String? message;

  Searchfishresponse({
    this.success,
    this.data,
    this.message,
  });

  factory Searchfishresponse.fromJson(Map<String, dynamic> json) =>
      Searchfishresponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
        "message": message,
      };
}

class Data {
  int? currentPage;
  List<Fishes>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  String? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Fishes>.from(json["data"].map((x) => Fishes.fromJson(x))),
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

class Fishes {
  int? id;
  int? customerId;
  String? sellerName;
  String? contactno;
  String? address;
  String? cityname;
  String? farmAddress;
  int? fishCategoryId;
  String? fishCategoryName;
  int? fishTypeId;
  String? fishTypeName;
  double? weightPerPcs;
  double? price;
  String? priceUnit;
  String? fishSizeType;
  int? fishSizeInches;
  String? fishImage;
  String? fishImageOther;
  dynamic fishVideo;
  String? latitude;
  String? longitude;
  dynamic description;
  dynamic adminRemark;
  bool? isActive;
  bool? isDeleted;
  DateTime? expiryDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isFavorite;
  double? distance;

  String getFormattedDate() {
    var formatter = new DateFormat('dd-MMM-yyyy'); //'yyyy-MM-dd'
    return formatter.format(createdAt!);
  }

  String getLastUpdateDate() {
    var formatter = new DateFormat('dd/MM/yy'); //'yyyy-MM-dd'
    return formatter.format(updatedAt!);
  }

  // String getFormattedDateExpiry() {
  //   var formatter = new DateFormat('dd-MMM-yyyy'); //'yyyy-MM-dd'
  //   return formatter.format(getDate().add(new Duration(days: 30)));
  // }

  // bool getIsExpired() {
  //   return getDate().add(new Duration(days: 30)).isBefore(DateTime.now());
  // }

  // bool getIsExpiryingInAWeekOrExpired() {
  //   if (!this.is_active) return false;
  //   return getDate().add(new Duration(days: 30 - 7)).isBefore(DateTime.now());
  // }

  String getFormattedDateExpiry() {
    var formatter = new DateFormat('dd-MMM-yyyy'); //'yyyy-MM-dd'
    return formatter.format(expiryDate!);
  }

  bool getIsExpired() {
    return expiryDate!.isBefore(DateTime.now());
  }

  bool getIsExpiryingInAWeekOrExpired() {
    if (!isActive!) return false;
    return expiryDate!.isBefore(DateTime.now());
  }

  String getImageURL() {
    return image_fish_url +
        (hasImage()
            ? (fishImage!.endsWith("mp4") ? "no-photo.png" : fishImage!)
            : "no-photo.png");
  }

  bool hasImage() {
    return fishImage != null && fishImage!.isNotEmpty;
  }

  bool hasOtherImage() {
    return fishImageOther!.isNotEmpty && fishImageOther!.isNotEmpty;
  }

  List<String> getImageList() {
    if (fishImageOther!.isNotEmpty) {
      return fishImageOther!.split(",");
    }
    return [];
  }

  String getPrice() {
    if (fishSizeType!.toLowerCase().contains("spawn") ||
        fishSizeType!.toLowerCase().contains("zero")) {
      return "${translate("Rs")}.$price/lakh ${priceUnit!}";
    }
    return "${translate("Rs")}.$price/${priceUnit!}";
  }

  String getWeight() {
    // return this.weight_per_pcs.toString() + " / pcs" + this.price_unit;
    return "$weightPerPcs ${"gm/pc"}";
  }

  Position getLocation() {
    return
        // Position(
        //  latitude: Common.checkDouble(this.latitude),
        //  longitude: Common.checkDouble(this.longitude),);
        Position(
            latitude: Common.checkDouble(latitude),
            longitude: Common.checkDouble(longitude),
            timestamp: DateTime.now(),
            accuracy: 12,
            altitude: 10,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
            altitudeAccuracy: 0,
            headingAccuracy: 2);
  }

  String getDistance() {
    if (distance != null) return distance?.toStringAsFixed(0) ?? "${"km"}";
    return "";
  }

  String getAdminRemark({bool withSpace = false}) {
    if (adminRemark != null && adminRemark.isNotEmpty) {
      return (withSpace ? ' ' : '') + adminRemark;
    }
    return '';
  }

  bool is_favorite() {
    if (isFavorite != null) return isFavorite == 1;
    return false;
  }

  setFavorite(bool isFavorite) {
    this.isFavorite = (isFavorite) ? 1 : 0;
  }

  String getCity() {
    if (farmAddress != null && farmAddress!.isNotEmpty) {
      return (farmAddress!.length <= 15)
          ? farmAddress!
          : "${farmAddress?.substring(0, 15)}...";
    } else {
      return cityname!;
    }
  }

  String getShareText() {
    return 'Seller: $sellerName\nFish: $fishTypeName\nLocation: $farmAddress\nPrice: ${getPrice()}\nSize: $fishSizeType\nWeight: ${getWeight()}\n\nअधिक जानकारी के लिए मांझा ऐप पर देखिए $app_link या हमारी वेबसाइट विजिट करे http://www.manjha.in';
  }

  Fishes({
    this.id,
    this.customerId,
    this.sellerName,
    this.contactno,
    this.address,
    this.cityname,
    this.farmAddress,
    this.fishCategoryId,
    this.fishCategoryName,
    this.fishTypeId,
    this.fishTypeName,
    this.weightPerPcs,
    this.price,
    this.priceUnit,
    this.fishSizeType,
    this.fishSizeInches,
    this.fishImage,
    this.fishImageOther,
    this.fishVideo,
    this.latitude,
    this.longitude,
    this.description,
    this.adminRemark,
    this.isActive,
    this.isDeleted,
    this.expiryDate,
    this.createdAt,
    this.updatedAt,
    this.isFavorite,
    this.distance,
  });

  factory Fishes.fromJson(Map<String, dynamic> json) => Fishes(
        id: json["id"],
        customerId: json["customer_id"],
        sellerName: json["seller_name"],
        contactno: json["contactno"],
        address: json["address"],
        cityname: json["cityname"],
        farmAddress: json["farm_address"],
        fishCategoryId: json["fish_category_id"],
        fishCategoryName: json["fish_category_name"],
        fishTypeId: json["fish_type_id"],
        fishTypeName: json["fish_type_name"],
        weightPerPcs: json["weight_per_pcs"].toDouble(),
        price: json["price"].toDouble(),
        priceUnit: json["price_unit"],
        fishSizeType: json["fish_size_type"],
        fishSizeInches: json["fish_size_inches"],
        fishImage: json["fish_image"],
        fishImageOther: json["fish_image_other"],
        fishVideo: json["fish_video"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        description: json["description"],
        adminRemark: json["admin_remark"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        expiryDate: DateTime.parse(json["expiry_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isFavorite: json["isFavorite"],
        distance: json["distance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "seller_name": sellerName,
        "contactno": contactno,
        "address": address,
        "cityname": cityname,
        "farm_address": farmAddress,
        "fish_category_id": fishCategoryId,
        "fish_category_name": fishCategoryName,
        "fish_type_id": fishTypeId,
        "fish_type_name": fishTypeName,
        "weight_per_pcs": weightPerPcs,
        "price": price,
        "price_unit": priceUnit,
        "fish_size_type": fishSizeType,
        "fish_size_inches": fishSizeInches,
        "fish_image": fishImage,
        "fish_image_other": fishImageOther,
        "fish_video": fishVideo,
        "latitude": latitude,
        "longitude": longitude,
        "description": description,
        "admin_remark": adminRemark,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "expiry_date": expiryDate?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "isFavorite": isFavorite,
        "distance": distance,
      };
}

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
