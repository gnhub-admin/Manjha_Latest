import 'dart:convert';

CartScreenModel cartScreenModelFromJson(String str) => CartScreenModel.fromJson(json.decode(str));

String cartScreenModelToJson(CartScreenModel data) => json.encode(data.toJson());

class CartScreenModel {
  final String warning;
  final bool success;
  final int weight;
  final List<CartData?> data;
  final List<Total?> total;
  final String coupon;
  final List<dynamic> postcode;
  final int payable;
  final String message;

  CartScreenModel({
    required this.warning,
    required this.success,
    required this.weight,
    required this.data,
    required this.total,
    required this.coupon,
    required this.postcode,
    required this.payable,
    required this.message,
  });

  factory CartScreenModel.fromJson(Map<String, dynamic> json) => CartScreenModel(
        warning: json["warning"],
        success: json["success"],
        weight: json["weight"],
        data: List<CartData>.from(json["data"].map((x) => CartData.fromJson(x))),
        total: List<Total>.from(json["total"].map((x) => Total.fromJson(x))),
        coupon: json["coupon"],
        postcode: List<dynamic>.from(json["postcode"].map((x) => x)),
        payable: json["payable"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "warning": warning,
        "success": success,
        "weight": weight,
        "data": List<dynamic>.from(data.map((x) => x?.toJson())),
        "total": List<dynamic>.from(total.map((x) => x?.toJson())),
        "coupon": coupon,
        "postcode": List<dynamic>.from(postcode.map((x) => x)),
        "payable": payable,
        "message": message,
      };
}

class CartData {
  final int id;
  final String productCode;
  final String productName;
  final String productDescription;
  final String? benefits;
  final String directionForUse;
  final String productImage;
  final String productImageAlt;
  final String hsnCode;
  final int categoryId;
  final int brandId;
  final int itemSize;
  final String itemSizeUnit;
  final int bagSize;
  final String feedNature;
  final String proteinPerFat;
  final int price;
  final double pricePerKg;
  final int isSpecial;
  final int specialPrice;
  final int weight;
  final String weightUnit;
  final int length;
  final int width;
  final int height;
  final int minQuantity;
  final String tags;
  final int noOfTest;
  final String parametersCovered;
  final String rangeCovered;
  final int quantityLiterKg;
  final String quantityUnit;
  final dynamic voltage;
  final dynamic motorPower;
  final int noOfFans;
  final dynamic pumpSize;
  final dynamic motorPhase;
  final dynamic motorRpm;
  final dynamic maxFlowRate;
  final dynamic netColor;
  final dynamic netSize;
  final dynamic netMeshSize;
  final dynamic youtubeLink;
  final int sortOrder;
  final int isStock;
  final int isShippingApplicable;
  final int isActive;
  final int isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int customerId;
  final String sessionId;
  final int productId;
  final int quantity;
  final bool isWishlist;
  final int finalPrice;

  CartData({
    required this.id,
    required this.productCode,
    required this.productName,
    required this.productDescription,
    required this.benefits,
    required this.directionForUse,
    required this.productImage,
    required this.productImageAlt,
    required this.hsnCode,
    required this.categoryId,
    required this.brandId,
    required this.itemSize,
    required this.itemSizeUnit,
    required this.bagSize,
    required this.feedNature,
    required this.proteinPerFat,
    required this.price,
    required this.pricePerKg,
    required this.isSpecial,
    required this.specialPrice,
    required this.weight,
    required this.weightUnit,
    required this.length,
    required this.width,
    required this.height,
    required this.minQuantity,
    required this.tags,
    required this.noOfTest,
    required this.parametersCovered,
    required this.rangeCovered,
    required this.quantityLiterKg,
    required this.quantityUnit,
    required this.voltage,
    required this.motorPower,
    required this.noOfFans,
    required this.pumpSize,
    required this.motorPhase,
    required this.motorRpm,
    required this.maxFlowRate,
    required this.netColor,
    required this.netSize,
    required this.netMeshSize,
    required this.youtubeLink,
    required this.sortOrder,
    required this.isStock,
    required this.isShippingApplicable,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.customerId,
    required this.sessionId,
    required this.productId,
    required this.quantity,
    required this.isWishlist,
    required this.finalPrice,
  });

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        id: json["id"],
        productCode: json["product_code"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        benefits: json["benefits"] ?? "",
        directionForUse: json["direction_for_use"] ?? "",
        productImage: json["product_image"],
        productImageAlt: json["product_image_alt"] ?? "",
        hsnCode: json["hsn_code"],
        categoryId: json["category_id"],
        brandId: json["brand_id"],
        itemSize: json["item_size"],
        itemSizeUnit: json["item_size_unit"],
        bagSize: json["bag_size"],
        feedNature: json["feed_nature"],
        proteinPerFat: json["protein_per_fat"],
        price: json["price"],
        pricePerKg: json["price_per_kg"].toDouble(),
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
        customerId: json["customer_id"],
        sessionId: json["session_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        isWishlist: json["is_wishlist"],
        finalPrice: json["final_price"],
      );

  Map<String, dynamic> toJson() => {
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "customer_id": customerId,
        "session_id": sessionId,
        "product_id": productId,
        "quantity": quantity,
        "is_wishlist": isWishlist,
        "final_price": finalPrice,
      };
}

class Total {
  final String title;
  final int text;

  Total({
    required this.title,
    required this.text,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        title: json["title"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
      };
}
