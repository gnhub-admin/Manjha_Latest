import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../languagetranslation/apptranslation.dart';
import '../screens/const.dart';
import '../model/getfourmdetailsresponse.dart';
import '../screens/localconst.dart';

class CustomLocation {
  String? place;
  String? city;
  String? state;
  String? country;
  String? lat;
  String? long;
  bool? isLocationEnable = true;
  setLocationDisable() {
    this.isLocationEnable = false;
    this.place = 'Hisar';
    this.place = 'Haryana';
  }

  CustomLocation();

  String getAreaCity() {
    return place! + ", " + city!;
  }

  // CustomLocation({this.place, this.city, this.state, this.country});
  factory CustomLocation.fromJson(Map<String, dynamic> json) {
    CustomLocation item = CustomLocation();
    item.place = json['place'] ?? "";
    item.city = json['city'] ?? "";
    item.state = json['state'] ?? "";
    item.country = json['country'] ?? "";
    item.lat = json['lat'] ?? "";
    item.long = json['long'] ?? "";
    return item;
  }

  Map<String, dynamic> toJson() => {
        "place": place,
        "city": city,
        "state": state,
        "country": country,
        "lat": lat,
        "long": long,
      };
}

class SaleItem {
  final String ACTION_CALL = 'call';
  final String ACTION_WHATSAPP = 'whatsapp';
  final String ACTION_SHARE = 'share';
  final int id;
  final int customer_id;
  final String seller_name;
  final String contactno;
  final String address;
  final String cityname;
  final String farm_address;
  final int fish_category_id;
  final String fish_category_name;
  final int fish_type_id;
  final String fish_type_name;
  final double weight_per_pcs;
  final String price;
  final String price_unit; //pcs/kg
  final String fish_size_type; // spawn/zero/inches
  final String fish_size_inches;
  final String fish_image;
  final String fish_image_other;
  final String fish_video;
  final String latitude;
  final String longitude;
  final String description;
  final String admin_remark;
  int isFavorite;
  final double distance;
  final bool is_active;
  final String expiry_date;
  final String created_at;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool showContinue = false;
  setShowContinue() {
    this.showContinue = true;
  }

  DateTime getDate() {
    return DateTime.parse(created_at);
  }

  DateTime getExpiryDate() {
    return DateTime.parse(expiry_date);
  }

  String getFormattedDate() {
    var formatter = new DateFormat('dd-MMM-yyyy'); //'yyyy-MM-dd'
    return formatter.format(getDate());
  }

  String getLastUpdateDate() {
    var formatter = new DateFormat('dd/MM/yy'); //'yyyy-MM-dd'
    return formatter.format(getDate());
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
    return formatter.format(getExpiryDate());
  }

  bool getIsExpired() {
    return getExpiryDate().isBefore(DateTime.now());
  }

  bool getIsExpiryingInAWeekOrExpired() {
    if (!this.is_active) return false;
    return getExpiryDate().isBefore(DateTime.now());
  }

  String getImageURL() {
    return image_fish_url +
        (this.hasImage()
            ? (this.fish_image.endsWith("mp4")
                ? "no-photo.png"
                : this.fish_image)
            : "no-photo.png");
  }

  bool hasImage() {
    return this.fish_image.isNotEmpty;
  }

  bool hasOtherImage() {
    return this.fish_image_other.isNotEmpty;
  }

  List<String> getImageList() {
    if (this.fish_image_other.isNotEmpty)
      return this.fish_image_other.split(",");
    return [];
  }

  String getPrice() {
    if (this.fish_size_type.toLowerCase().contains("spawn") ||
        this.fish_size_type.toLowerCase().contains("zero")) {
      return "${translate("Rs")}." +
          this.price.toString() +
          "/lakh " +
          this.price_unit;
    }
    return "${translate("Rs")}." +
        this.price.toString() +
        "/" +
        this.price_unit;
  }

  String getWeight() {
    // return this.weight_per_pcs.toString() + " / pcs" + this.price_unit;
    return this.weight_per_pcs.toString() + " " + Lang.get("gm/pc");
  }

  Position getLocation() {
    return
        // Position(
        //  latitude: Common.checkDouble(this.latitude),
        //  longitude: Common.checkDouble(this.longitude),);
        Position(
            latitude: Common.checkDouble(this.latitude),
            longitude: Common.checkDouble(this.longitude),
            timestamp: DateTime.now(),
            accuracy: 12,
            altitude: 10,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
            altitudeAccuracy: 10,
            headingAccuracy: 1);
  }

  String getDistance() {
    if (distance != '') return distance.toStringAsFixed(0) + Lang.get("km");
    return "";
  }

  String getAdminRemark({bool withSpace = false}) {
    if (this.admin_remark.isNotEmpty)
      return (withSpace ? ' ' : '') + this.admin_remark;
    return '';
  }

  bool is_favorite() {
    if (isFavorite != '') return isFavorite == 1;
    return false;
  }

  setFavorite(bool isFavorite) {
    this.isFavorite = (isFavorite) ? 1 : 0;
  }

  String getCity() {
    if (this.farm_address.isNotEmpty)
      return (this.farm_address.length <= 15)
          ? this.farm_address
          : this.farm_address.substring(0, 15) + "...";
    else
      return this.cityname;
  }

  String getShareText() {
    return 'Seller: $seller_name' +
        '\nFish: $fish_type_name' +
        '\nLocation: $farm_address' +
        '\nPrice: ' +
        getPrice() +
        '\nSize: $fish_size_type' +
        '\nWeight: ' +
        getWeight() +
        '\n\nअधिक जानकारी के लिए मांझा ऐप पर देखिए $app_link या हमारी वेबसाइट विजिट करे http://www.manjha.in';
  }

  SaleItem(
      {required this.id,
      required this.customer_id,
      required this.seller_name,
      required this.contactno,
      required this.address,
      required this.cityname,
      required this.farm_address,
      required this.fish_category_id,
      required this.fish_category_name,
      required this.fish_type_id,
      required this.fish_type_name,
      required this.weight_per_pcs,
      required this.price,
      required this.price_unit,
      required this.fish_size_type,
      required this.fish_size_inches,
      required this.fish_image,
      required this.fish_image_other,
      required this.fish_video,
      required this.latitude,
      required this.longitude,
      required this.description,
      required this.admin_remark,
      required this.isFavorite,
      required this.distance,
      required this.is_active,
      required this.expiry_date,
      required this.created_at,
      required this.createdAt,
      required this.updatedAt});

  factory SaleItem.fromJson(Map<String, dynamic> json) {
    return SaleItem(
      id: json['id'] as int,
      customer_id: json['customer_id'] as int,
      seller_name: json['seller_name'] as String,
      contactno: json['contactno'] as String,
      address: json['address'] as String,
      cityname: json['cityname'] as String,
      farm_address: json['farm_address'] as String,
      fish_category_id: json['fish_category_id'] as int,
      fish_category_name: json['fish_category_name'] as String,
      fish_type_id: json['fish_type_id'] as int,
      fish_type_name: json['fish_type_name'] as String,
      weight_per_pcs: Common.checkDouble(
          json['weight_per_pcs']), //double.parse(json['weight_per_pcs']),
      price: json['price'].toString(),
      price_unit: json['price_unit'] as String,
      fish_size_type: json['fish_size_type'] as String,
      fish_size_inches: json['fish_size_inches'].toString(),
      fish_image: json['fish_image'] as String,
      fish_image_other: json['fish_image_other'] as String,
      fish_video: json['fish_video'] ?? '',
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      description: json['description'] ?? '',
      admin_remark: json['admin_remark'] ?? '',
      isFavorite: json['isFavorite'] ?? 0,
      distance: Common.checkDouble(json['distance']),
      is_active: json['is_active'] as bool,
      expiry_date: json['expiry_date'] as String,
      created_at: json['created_at'] as String,
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null,
    );
  }
}

class FishTypeItem {
  final int id;
  final String name;
  bool isCheck = false;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  FishTypeItem({required this.id, required this.name});

  factory FishTypeItem.fromJson(Map<String, dynamic> json) {
    return FishTypeItem(
      id: json['id'] as int,
      name: json['fish_type_name'] as String,
    );
  }
}

class FishCategoryItem {
  final int id;
  final String name;
  bool isCheck = false;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  FishCategoryItem({required this.id, required this.name});

  factory FishCategoryItem.fromJson(Map<String, dynamic> json) {
    return FishCategoryItem(
      id: json['id'] as int,
      name: json['fish_category_name'] as String,
    );
  }
}

class FishSizeItem {
  final int? id;
  final String name;
  bool isCheck = false;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  FishSizeItem({required this.id, required this.name});

  factory FishSizeItem.fromJson(Map<String, dynamic> json) {
    return FishSizeItem(
      id: int.tryParse(json['id']),
      name: json['fish_size_type_name'] as String,
    );
  }
}

class ForumItem {
  final int id;
  final int likedId;
  final int customer_id;
  final String customer_name;
  final String customer_photo;
  final String question;
  final String description;
  final String forum_image;
  final String forum_video;
  final int total_liked;
  final int total_comments;
  final int total_viewed;
  final int forum_type;
  final String created_at;
  final String shareUrl;
  final List<ForumDetailItem> comments;

  DateTime getDate() {
    return DateTime.parse(created_at);
  }

  String getFormattedDate() {
    var formatter = new DateFormat('dd-MMM-yyyy'); //'yyyy-MM-dd'
    return formatter.format(getDate());
  }

  String getLikes() {
    if (this.total_liked == 0) return 'Likes';
    if (this.total_liked == 1) return '1 Like';
    return this.total_liked.toString() + ' Likes';
  }

  String getComments() {
    if (this.total_comments == 0) return 'Comments';
    if (this.total_comments == 1) return '1 Comment';
    return this.total_comments.toString() + ' Comments';
  }

  bool hasDescription() {
    return (this.description.isNotEmpty && this.description.isNotEmpty);
  }

  bool isLiked() {
    return (this.likedId != '' && this.likedId > 0);
  }

  String getCustomerPhoto() {
    return image_customer_url +
        (this.customer_photo.isNotEmpty && this.customer_photo.isNotEmpty
            ? this.customer_photo
            : "no-user.jpg");
  }

  bool hasImage() {
    return this.forum_image.isNotEmpty && this.forum_image.isNotEmpty;
  }

  String getImageURL() {
    return image_charcha_url +
        (this.forum_image.isNotEmpty && this.forum_image.isNotEmpty
            ? this.forum_image
            : "no-photo.png");
  }

  String getShareLink(String customerName) {
    return this.customer_name +
        ' ने मांझा पर  मत्स्य सवाल किया है, \n"${this.question}"' +
        '\n' +
        // this.shareUrl +
        '\n\nअधिक जानकारी के लिए मांझा ऐप पर देखिए $app_link या हमारी वेबसाइट विजिट करे http://www.manjha.in';
  }

  ForumItem(
      {required this.id,
      required this.likedId,
      required this.customer_id,
      required this.customer_name,
      required this.customer_photo,
      required this.question,
      required this.description,
      required this.forum_image,
      required this.forum_video,
      required this.total_liked,
      required this.total_comments,
      required this.total_viewed,
      required this.forum_type,
      required this.created_at,
      required this.shareUrl,
      required this.comments});

  factory ForumItem.fromJson(Map<String, dynamic> json) {
    return ForumItem(
        id: json['id'] as int,
        likedId: json['likedId'] == null ? 0 : json['likedId'] as int,
        customer_id: json['customer_id'] as int,
        customer_name: json['customer_name'] as String,
        customer_photo: json['customer_photo'] ?? '',
        question: json['question'] as String,
        description: json['description'] ?? '',
        forum_image: json['forum_image'] ?? '',
        forum_video: json['forum_video'] ?? '',
        total_liked: json['total_liked'] as int,
        total_comments: json['total_comments'] as int,
        total_viewed: json['total_viewed'] as int,
        forum_type: json['forum_type'] as int,
        created_at: json['created_at'] as String,
        shareUrl: json['shareUrl'] as String,
        comments: json['comments'] == null
            ? []
            : json['comments']
                .map<ForumDetailItem>(
                    (jsonItem) => ForumDetailItem.fromJson(jsonItem))
                .toList());
  }
}
