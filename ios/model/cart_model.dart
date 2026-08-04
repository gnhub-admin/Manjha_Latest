import '../languagetranslation/apptranslation.dart';
import '../screens/const.dart';

class CartModel {
  CartModel({
    this.id,
    this.customerId,
    this.sessionId,
    this.productId,
    this.quantity,
    this.isWishlist,
    this.createdAt,
    this.updatedAt,
    this.productCode,
    this.productName,
    this.productDescription,
    this.productImage,
    this.productImageAlt,
    this.categoryId,
    this.brandId,
    this.itemSize,
    this.bagSize,
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
    this.quantityLiterKg,
    this.sortOrder,
    this.isActive,
    this.isDeleted,
  });

  int? id;
  int? customerId;
  String? sessionId;
  int? productId;
  int? quantity;
  bool? isWishlist;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? productCode;
  String? productName;
  String? productDescription;
  String? productImage;
  dynamic productImageAlt;
  int? categoryId;
  int? brandId;
  double? itemSize;
  double? bagSize;
  String? proteinPerFat;
  double? price;
  double? pricePerKg;
  int? isSpecial;
  double? specialPrice;
  double? weight;
  String? weightUnit;
  double? length;
  double? width;
  double? height;
  double? minQuantity;
  String? tags;
  double? quantityLiterKg;
  int? sortOrder;
  int? isActive;
  int? isDeleted;

  bool isInWishlist = false;
  String stock = "100";
  String total = "0";
  String coupon = "";
  // String cartId = "0";
  bool? flag;

  getQtyLot() {
    if (this.quantity! % 5 == 0) return 5;
    return 1;
  }

  getCouponApplied() {
    return coupon.isNotEmpty && coupon != '';
  }

  getQtyLiterKg() {
    return this.quantityLiterKg.toString() + " Kg/Ltr";
  }

  getWeight() {
    return this.weight.toString() + " " + this.weightUnit!;
  }

  getDimension() {
    return this.length.toString() + " x " + this.width.toString() + " x " + this.height.toString();
  }

  getName() {
    if (this.productName != null && this.productName!.isNotEmpty) return productName!.replaceAll('&amp;', '&');
    return '';
  }

  getPrice() {
    if (this.isSpecial == 1) {
      return this.specialPrice;
    }
    return this.price;
  }

  getPriceText() {
    return '${translate("Rs")}.' + this.getPrice().toString() + '/-';
  }

  getHeroTag() {
    return 'product_$id';
  }

  getTotal() {
    try {
      return this.getPrice() * quantity;
    } catch (e) {}
    return 0;
  }

  String getImageUrl() {
    return image_product_url + (productImage!.isEmpty ? "no-photo.png" : this.productImage!);
  }

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        customerId: json["customer_id"],
        sessionId: json["session_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        isWishlist: json["is_wishlist"],
        createdAt: DateTime.parse(json["created_at"]),
        //updatedAt: DateTime.parse(json["updated_at"]),
        productCode: json["product_code"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        productImage: json["product_image"],
        productImageAlt: json["product_image_alt"],
        categoryId: json["category_id"],
        brandId: json["brand_id"],
        itemSize: (json["item_size"] != null) ? json["item_size"] * 1.0 : 0,
        bagSize: json["bag_size"] * 1.0,
        proteinPerFat: json["protein_per_fat"],
        price: json["price"] * 1.0,
        pricePerKg: json["price_per_kg"] * 1.0,
        isSpecial: json["is_special"],
        specialPrice: json["special_price"] * 1.0,
        weight: json["weight"] * 1.0,
        weightUnit: json["weight_unit"],
        length: json["length"] * 1.0,
        width: json["width"] * 1.0,
        height: json["height"] * 1.0,
        minQuantity: json["min_quantity"] * 1.0,
        tags: json["tags"],
        quantityLiterKg: json["quantity_liter_kg"] * 1.0,
        sortOrder: json["sort_order"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "session_id": sessionId,
        "product_id": productId,
        "quantity": quantity,
        "is_wishlist": isWishlist,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "product_code": productCode,
        "product_name": productName,
        "product_description": productDescription,
        "product_image": productImage,
        "product_image_alt": productImageAlt,
        "category_id": categoryId,
        "brand_id": brandId,
        "item_size": itemSize,
        "bag_size": bagSize,
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
        "quantity_liter_kg": quantityLiterKg,
        "sort_order": sortOrder,
        "is_active": isActive,
        "is_deleted": isDeleted,
      };
}
