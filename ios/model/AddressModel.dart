class AddressModel {
  AddressModel({
    required this.id,
    required this.customerId,
    required this.firstname,
    required this.lastname,
    this.company,
    required this.contactNumber,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.country,
    required this.zone,
    required this.createdAt,
    required this.updatedAt,
  });

  getIsInitialized() {
    return id != '' && id > 0;
  }

  int id;
  int customerId;
  String firstname;
  String lastname;
  dynamic company;
  String contactNumber;
  String address1;
  String address2;
  String city;
  String postcode;
  String country;
  String zone;
  DateTime createdAt;
  DateTime updatedAt;

  getName() {
    return this.firstname + " " + this.lastname;
  }

  getAddress() {
    return [this.address1, ', ', this.address2, '\n', this.city, ', ', this.zone, ', ', this.postcode].join('');
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        customerId: json["customer_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        company: json["company"],
        contactNumber: json["contact_number"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        postcode: json["postcode"],
        country: json["country"],
        zone: json["zone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "firstname": firstname,
        "lastname": lastname,
        "company": company,
        "contact_number": contactNumber,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "postcode": postcode,
        "country": country,
        "zone": zone,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
