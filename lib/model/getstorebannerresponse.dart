// To parse this JSON data, do
//
//     final getbannerresponse = getbannerresponseFromJson(jsonString);

import 'dart:convert';

import 'package:manjha/languagetranslation/apptranslation.dart';

import '../screens/const.dart';

Getbannerresponse getbannerresponseFromJson(String str) => Getbannerresponse.fromJson(json.decode(str));

String getbannerresponseToJson(Getbannerresponse data) => json.encode(data.toJson());

class Getbannerresponse {
  bool? success;
  List<Banner>? data;
  String? message;

  Getbannerresponse({
    this.success,
    this.data,
    this.message,
  });

  factory Getbannerresponse.fromJson(Map<String, dynamic> json) => Getbannerresponse(
        success: json["success"],
        data: List<Banner>.from(json["data"].map((x) => Banner.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Banner {
  int? id;
  String? bannerTitle;
  String? bannerImage;
  int? bannerType;
  int? productId;
  int? categoryId;
  int? brandId;
  bool? isFeatured;
  int? sortOrder;
  bool? isActive;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;
  Product? product;
  dynamic category;
  dynamic brand;

  Banner({
    this.id,
    this.bannerTitle,
    this.bannerImage,
    this.bannerType,
    this.productId,
    this.categoryId,
    this.brandId,
    this.isFeatured,
    this.sortOrder,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.product,
    this.category,
    this.brand,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["id"],
        bannerTitle: json["banner_title"],
        bannerImage: json["banner_image"],
        bannerType: json["banner_type"],
        productId: json["product_id"],
        categoryId: json["category_id"],
        brandId: json["brand_id"],
        isFeatured: json["is_featured"],
        sortOrder: json["sort_order"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
        imageUrl: json["image_url"],
        product: json["product"] == "" ? Product() : Product.fromJson(json["product"]),
        category: json["category"],
        brand: json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "banner_title": bannerTitle,
        "banner_image": bannerImage,
        "banner_type": bannerType,
        "product_id": productId,
        "category_id": categoryId,
        "brand_id": brandId,
        "is_featured": isFeatured,
        "sort_order": sortOrder,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_url": imageUrl,
        "product": product?.toJson(),
        "category": category,
        "brand": brand,
      };
}

class Product {
  String? brandName;
  String? categoryName;
  int? id;
  String? productCode;
  String? productName;
  String? productDescription;
  String? benefits;
  String? directionForUse;
  String? productImage;
  dynamic productImageAlt;
  String? hsnCode;
  int? categoryId;
  int? brandId;
  dynamic itemSize;
  String? itemSizeUnit;
  int? bagSize;
  dynamic feedNature;
  dynamic proteinPerFat;
  dynamic price;
  dynamic pricePerKg;
  bool? isSpecial;
  dynamic specialPrice;
  dynamic weight;
  String? weightUnit;
  int? length;
  int? width;
  int? height;
  int? minQuantity;
  String? tags;
  int? noOfTest;
  String? parametersCovered;
  String? rangeCovered;
  int? quantityLiterKg;
  String? quantityUnit;
  dynamic voltage;
  dynamic motorPower;
  int? noOfFans;
  dynamic pumpSize;
  dynamic motorPhase;
  dynamic motorRpm;
  dynamic maxFlowRate;
  dynamic netColor;
  dynamic netSize;
  dynamic netMeshSize;
  dynamic youtubeLink;
  int? sortOrder;
  int? isStock;
  bool? isShippingApplicable;
  bool? isActive;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? parentId;
  dynamic quantity;
  dynamic finalPrice;
  int? rawDiscount;
  dynamic feedItemSize;
  bool? isFeed;
  bool? isMedicine;
  bool? isTestingkit;
  bool? isEquipment;
  int? discount;
  String? imageUrl;
  String? brandNameLanguage;
  String? productNameLang;
  String? benefitsLang;
  String? productDescriptionLang;
  String? directionForUseLang;

  String getItmSize() {
    if (itemSizeUnit != null && (itemSizeUnit!.contains("crumble") || itemSizeUnit!.contains("dust"))) {
      return itemSizeUnit!.toUpperCase();
    }
    if (itemSize is int) {
      return "${numbertranslate(itemSize as int)} ${itemSizeUnit ?? ''}";
    } else if (itemSize is double) {
      int intValue = itemSize.toInt();
      return "${numbertranslate(intValue)} ${itemSizeUnit ?? ''}";
    }
    return itemSize.toString();
  }

  // getItmSize() {
  //   if (itemSizeUnit != null &&
  //       (itemSizeUnit!.contains("crumble") || itemSizeUnit!.contains("dust"))) {
  //     return itemSizeUnit!.toUpperCase();
  //   }
  //   if (itemSizeUnit != null) {
  //     return "${numbertranslate(itemSize)} ${itemSizeUnit!}";
  //   }
  //   return itemSize.toString();
  // }

  // getItmSize() {
  //   if (itemSize is double) {
  //     // Handle case where itemSize is a double
  //     return "${numbertranslate(itemSize as int)} ${itemSizeUnit ?? ''}";
  //   } else if (itemSizeUnit != null && (itemSizeUnit!.contains("crumble") || itemSizeUnit!.contains("dust"))) {
  //     return itemSizeUnit!.toUpperCase();
  //   } else if (itemSizeUnit != null) {
  //     return "${numbertranslate(itemSize)} ${itemSizeUnit!}";
  //   } else {
  //     return itemSize.toString();
  //   }
  // }

  getIsTestingKitXX() {
    return (categoryId == 3);
  }

  getIsPrawnFeed() {
    return (categoryId == 6);
  }

  isEquipmentAerator() {
    return (categoryId == 38); //15
  }

  isEquipmentMudPumps() {
    return (categoryId == 39); //16
  }

  isEquipmentFishingNet() {
    return (categoryId == 40); //17
  }

  isEquipmentPlanktonNet() {
    return (categoryId == 41); //18
  }

  int getQtyLot() {
    if (isFeed == true) return 5;
    return 1;
  }

  getStockStatus() {
    if (isStock == 1) return translate("In Stock");
    return translate("Out of Stock");
  }

  getBagSize() {
    if (bagSize != null) return "$bagSize KG";
    return '';
  }

  getQtyLiterKg() {
    return "$quantityLiterKg $quantityUnit";
  }

  getWeight() {
    return "$weight $weightUnit";
  }

  getIsDiscount() {
    return (isSpecial == true && price > specialPrice);
  }

  getDiscount() {
    if (getIsDiscount()) return discount.toString();
    // return ((price - specialPrice) * 100 / price).round().toString();
    return '';
  }

  getDimension() {
    return "$length x $width x $height";
  }

  String getName() {
    if (productName != null && productName!.isNotEmpty) {
      return productName!.replaceAll('&amp;', '&');
    }
    return '';
  }

  getPriceText() {
    return '${translate("Rs")}.$price'; // + '/-';
  }

  getSpecialPriceText() {
    return '${translate("Rs")}.$specialPrice'; // + '/-';
  }

  getNetSize() {
    if (netSize != null) return "$netSize Feet";
    return '';
  }

  getMotorPower() {
    if (motorPower != null) return "$motorPower HP";
    return '';
  }

  getMotorSpeed() {
    if (motorRpm != null) return "$motorRpm RPM";
    return '';
  }

  getMaxFlowRate() {
    if (maxFlowRate != null) {
      return "$maxFlowRate Liter / Hour";
    }
    return '';
  }

  hasNoOfFans() {
    return (noOfFans! > 0);
  }

  hasYoutubeLink() {
    return (youtubeLink != null && youtubeLink.isNotEmpty);
  }

  getYoutuebImage() {
    // http://www.youtube.com/watch?v=C4kxS1ksqtw
    // "http://img.youtube.com/vi/C4kxS1ksqtw/maxresdefault.jpg"
    if (youtubeLink != null && youtubeLink.isNotEmpty) {
      return youtubeLink
              .split('&')[0]
              .replaceAll('http://', 'https://')
              .replaceAll('https://www.youtube.com/watch?v=', 'https://img.youtube.com/vi/') +
          '/maxresdefault.jpg';
    }
    return '';
  }

  getHeroTag() {
    return 'product_$id';
  }

  getTotal() {
    try {
      return price;
    } catch (e) {}
    return 0;
  }

  String getShareText() {
    String footer =
        '\n\nअधिक जानकारी के लिए मांझा ऐप पर जाये\nAndroid($app_link)\niOS($app_ios_link)\nया हमारी वेबसाइट विजिट करे http://www.manjha.in';
    if (isFeed == true) {
      if (isSpecial == true) {
        return "मांझा ऐप पर $brandName का ${getName()} ${getBagSize()} के Bag में ${getSpecialPriceText()} पर उपलब्ध है|$footer";
      } else {
        return "मांझा ऐप पर $brandName का ${getName()} ${getBagSize()} के Bag में ${getPriceText()} पर उपलब्ध है|$footer";
      }
    }
    if (isMedicine == true) {
      if (isSpecial == true) {
        return "मांझा ऐप पर $brandName का ${getName()}, ${getItmSize()}, ${getSpecialPriceText()} में उपलब्ध है|$footer";
      } else {
        return "मांझा ऐप पर $brandName का ${getName()}, ${getItmSize()}, ${getPriceText()} में उपलब्ध है|$footer";
      }
    }
    if (isTestingkit == true) {
      // मांझा ऐप पर <Brand Name>  का <product name> में <no of tests> , <price>में उपलब्ध है|
      if (isSpecial == true) {
        return "मांझा ऐप पर $brandName का ${getName()} ${getSpecialPriceText()} में उपलब्ध है|$footer";
      } else {
        return "मांझा ऐप पर $brandName का ${getName()} ${getPriceText()} में उपलब्ध है|$footer";
      }
    }
    if (isSpecial == true) {
      return "मांझा ऐप पर $brandName का ${getName()} ${getSpecialPriceText()} में उपलब्ध है|$footer";
    } else {
      return "मांझा ऐप पर $brandName का ${getName()} ${getPriceText()} में उपलब्ध है|$footer";
    }
  }

  String getImageUrl() {
    return image_product_url + (productImage == null || productImage!.isEmpty ? "no-photo.png" : productImage)!;
  }

  Product({
    this.brandName,
    this.categoryName,
    this.id,
    this.productCode,
    this.productName,
    this.productDescription,
    this.benefits,
    this.directionForUse,
    this.productImage,
    this.productImageAlt,
    this.hsnCode,
    this.categoryId,
    this.brandId,
    this.itemSize,
    this.itemSizeUnit,
    this.bagSize,
    this.feedNature,
    this.proteinPerFat,
    this.price,
    this.pricePerKg,
    this.isSpecial,
    this.specialPrice,
    this.weight,
    this.weightUnit,
    this.length,
    this.width,
    this.height,
    this.minQuantity,
    this.tags,
    this.noOfTest,
    this.parametersCovered,
    this.rangeCovered,
    this.quantityLiterKg,
    this.quantityUnit,
    this.voltage,
    this.motorPower,
    this.noOfFans,
    this.pumpSize,
    this.motorPhase,
    this.motorRpm,
    this.maxFlowRate,
    this.netColor,
    this.netSize,
    this.netMeshSize,
    this.youtubeLink,
    this.sortOrder,
    this.isStock,
    this.isShippingApplicable,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.parentId,
    this.quantity,
    this.finalPrice,
    this.rawDiscount,
    this.feedItemSize,
    this.isFeed,
    this.isMedicine,
    this.isTestingkit,
    this.isEquipment,
    this.discount,
    this.imageUrl,
    this.brandNameLanguage,
    this.productNameLang,
    this.benefitsLang,
    this.productDescriptionLang,
    this.directionForUseLang,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        brandName: json["brand_name"],
        categoryName: json["category_name"],
        id: json["id"],
        productCode: json["product_code"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        benefits: json["benefits"],
        directionForUse: json["direction_for_use"],
        productImage: json["product_image"],
        productImageAlt: json["product_image_alt"],
        hsnCode: json["hsn_code"],
        categoryId: json["category_id"],
        brandId: json["brand_id"],
        itemSize: json["item_size"],
        itemSizeUnit: json["item_size_unit"],
        bagSize: json["bag_size"],
        feedNature: json["feed_nature"],
        proteinPerFat: json["protein_per_fat"],
        price: json["price"],
        pricePerKg: json["price_per_kg"],
        isSpecial: json["is_special"],
        specialPrice: json["special_price"],
        weight: json["weight"],
        weightUnit: json["weight_unit"],
        length: json["length"],
        width: json["width"],
        height: json["height"],
        minQuantity: json["min_quantity"],
        tags: json["tags"],
        noOfTest: json["no_of_test"],
        parametersCovered: json["parameters_covered"],
        rangeCovered: json["range_covered"],
        quantityLiterKg: json["quantity_liter_kg"],
        quantityUnit: json["quantity_unit"],
        voltage: json["voltage"],
        motorPower: json["motor_power"],
        noOfFans: json["no_of_fans"],
        pumpSize: json["pump_size"],
        motorPhase: json["motor_phase"],
        motorRpm: json["motor_rpm"],
        maxFlowRate: json["max_flow_rate"],
        netColor: json["net_color"],
        netSize: json["net_size"],
        netMeshSize: json["net_mesh_size"],
        youtubeLink: json["youtube_link"],
        sortOrder: json["sort_order"],
        isStock: json["is_stock"],
        isShippingApplicable: json["is_shipping_applicable"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        parentId: json["parent_id"],
        quantity: json["quantity"],
        finalPrice: json["final_price"],
        rawDiscount: json["raw_discount"],
        feedItemSize: json["feed_item_size"],
        isFeed: json["is_feed"],
        isMedicine: json["is_medicine"],
        isTestingkit: json["is_testingkit"],
        isEquipment: json["is_equipment"],
        discount: json["discount"],
        imageUrl: json["image_url"],
        brandNameLanguage: json["brand_name_lang"] ?? "",
        productNameLang: json["product_name_lang"] ?? "",
        benefitsLang: json["benefits_lang"] ?? "",
        productDescriptionLang: json["product_description_lang"] ?? "",
        directionForUseLang: json["direction_for_use_lang"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "brand_name": brandName,
        "category_name": categoryName,
        "id": id,
        "product_code": productCode,
        "product_name": productName,
        "product_description": productDescription,
        "benefits": benefits,
        "direction_for_use": directionForUse,
        "product_image": productImage,
        "product_image_alt": productImageAlt,
        "hsn_code": hsnCode,
        "category_id": categoryId,
        "brand_id": brandId,
        "item_size": itemSize,
        "item_size_unit": itemSizeUnit,
        "bag_size": bagSize,
        "feed_nature": feedNature,
        "protein_per_fat": proteinPerFat,
        "price": price,
        "price_per_kg": pricePerKg,
        "is_special": isSpecial,
        "special_price": specialPrice,
        "weight": weight,
        "weight_unit": weightUnit,
        "length": length,
        "width": width,
        "height": height,
        "min_quantity": minQuantity,
        "tags": tags,
        "no_of_test": noOfTest,
        "parameters_covered": parametersCovered,
        "range_covered": rangeCovered,
        "quantity_liter_kg": quantityLiterKg,
        "quantity_unit": quantityUnit,
        "voltage": voltage,
        "motor_power": motorPower,
        "no_of_fans": noOfFans,
        "pump_size": pumpSize,
        "motor_phase": motorPhase,
        "motor_rpm": motorRpm,
        "max_flow_rate": maxFlowRate,
        "net_color": netColor,
        "net_size": netSize,
        "net_mesh_size": netMeshSize,
        "youtube_link": youtubeLink,
        "sort_order": sortOrder,
        "is_stock": isStock,
        "is_shipping_applicable": isShippingApplicable,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "parent_id": parentId,
        "quantity": quantity,
        "final_price": finalPrice,
        "raw_discount": rawDiscount,
        "feed_item_size": feedItemSize,
        "is_feed": isFeed,
        "is_medicine": isMedicine,
        "is_testingkit": isTestingkit,
        "is_equipment": isEquipment,
        "discount": discount,
        "image_url": imageUrl,
        "brand_name_lang": brandNameLanguage,
        "product_name_lang": productNameLang,
        "benefits_lang": benefitsLang,
        "product_description_lang": productDescriptionLang,
        "direction_for_use_lang": directionForUseLang,
      };
}
