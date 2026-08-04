class OrderModel {
  OrderModel({
   required this.orderStatus,
   required this.id,
   required this.invoiceNo,
   required this.customerId,
   required this.customerName,
   required this.email,
   required this.contactNumber,
   required this.gstNo,
   required this.paymentFirstname,
   required this.paymentLastname,
   required this.paymentCompany,
   required this.paymentAddress1,
   required this.paymentAddress2,
   required this.paymentCity,
   required this.paymentPostcode,
   required this.paymentCountry,
   required this.paymentZone,
   required this.paymentMethod,
   required this.paymentCode,
   required this.shippingFirstname,
   required this.shippingLastname,
   required this.shippingCompany,
   required this.shippingAddress1,
   required this.shippingAddress2,
   required this.shippingCity,
   required this.shippingPostcode,
   required this.shippingCountry,
   required this.shippingZone,
   required this.shippingMethod,
   required this.shippingCode,
   required this.comment,
   required this.total,
   required this.orderStatusId,
   required this.commission,
   required this.tracking,
   required this.currencyId,
   required this.currencyCode,
   required this.currencyValue,
   required this.ip,
   required this.userAgent,
   required this.deviceType,
   required this.acceptLanguage,
   required this.isDeleted,
   required this.createdAt,
    this.updatedAt,
  });

  String orderStatus;
  int id;
  int invoiceNo;
  int customerId;
  String customerName;
  String email;
  String contactNumber;
  String gstNo;
  String paymentFirstname;
  String paymentLastname;
  String paymentCompany;
  String paymentAddress1;
  String paymentAddress2;
  String paymentCity;
  String paymentPostcode;
  String paymentCountry;
  String paymentZone;
  String paymentMethod;
  String paymentCode;
  String shippingFirstname;
  String shippingLastname;
  String shippingCompany;
  String shippingAddress1;
  String shippingAddress2;
  String shippingCity;
  String shippingPostcode;
  String shippingCountry;
  String shippingZone;
  String shippingMethod;
  String shippingCode;
  String comment;
  double total;
  int orderStatusId;
  int commission;
  String tracking;
  int currencyId;
  String currencyCode;
  int currencyValue;
  String ip;
  String userAgent;
  String deviceType;
  String acceptLanguage;
  bool isDeleted;
  DateTime createdAt;
  dynamic updatedAt;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderStatus: json["order_status"],
        id: json["id"],
        invoiceNo: json["invoice_no"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        email: json["email"],
        contactNumber: json["contact_number"],
        gstNo: json["gst_no"] ?? '',
        paymentFirstname: json["payment_firstname"],
        paymentLastname: json["payment_lastname"],
        paymentCompany: json["payment_company"] ?? '',
        paymentAddress1: json["payment_address_1"],
        paymentAddress2: json["payment_address_2"] ?? '',
        paymentCity: json["payment_city"],
        paymentPostcode: json["payment_postcode"],
        paymentCountry: json["payment_country"],
        paymentZone: json["payment_zone"],
        paymentMethod: json["payment_method"],
        paymentCode: json["payment_code"],
        shippingFirstname: json["shipping_firstname"],
        shippingLastname: json["shipping_lastname"],
        shippingCompany: json["shipping_company"] ?? '',
        shippingAddress1: json["shipping_address_1"] ?? '',
        shippingAddress2: json["shipping_address_2"] ?? '',
        shippingCity: json["shipping_city"],
        shippingPostcode: json["shipping_postcode"],
        shippingCountry: json["shipping_country"],
        shippingZone: json["shipping_zone"],
        shippingMethod: json["shipping_method"],
        shippingCode: json["shipping_code"],
        comment: json["comment"],
        total: json["total"] * 1.0,
        orderStatusId: json["order_status_id"],
        commission: json["commission"],
        tracking: json["tracking"],
        currencyId: json["currency_id"],
        currencyCode: json["currency_code"],
        currencyValue: json["currency_value"],
        ip: json["ip"],
        userAgent: json["user_agent"],
        deviceType: json["device_type"],
        acceptLanguage: json["accept_language"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "order_status": orderStatus,
        "id": id,
        "invoice_no": invoiceNo,
        "customer_id": customerId,
        "customer_name": customerName,
        "email": email,
        "contact_number": contactNumber,
        "gst_no": gstNo,
        "payment_firstname": paymentFirstname,
        "payment_lastname": paymentLastname,
        "payment_company": paymentCompany,
        "payment_address_1": paymentAddress1,
        "payment_address_2": paymentAddress2,
        "payment_city": paymentCity,
        "payment_postcode": paymentPostcode,
        "payment_country": paymentCountry,
        "payment_zone": paymentZone,
        "payment_method": paymentMethod,
        "payment_code": paymentCode,
        "shipping_firstname": shippingFirstname,
        "shipping_lastname": shippingLastname,
        "shipping_company": shippingCompany,
        "shipping_address_1": shippingAddress1,
        "shipping_address_2": shippingAddress2,
        "shipping_city": shippingCity,
        "shipping_postcode": shippingPostcode,
        "shipping_country": shippingCountry,
        "shipping_zone": shippingZone,
        "shipping_method": shippingMethod,
        "shipping_code": shippingCode,
        "comment": comment,
        "total": total,
        "order_status_id": orderStatusId,
        "commission": commission,
        "tracking": tracking,
        "currency_id": currencyId,
        "currency_code": currencyCode,
        "currency_value": currencyValue,
        "ip": ip,
        "user_agent": userAgent,
        "device_type": deviceType,
        "accept_language": acceptLanguage,
        "is_deleted": isDeleted,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}
