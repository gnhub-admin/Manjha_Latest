class StateModel {
  StateModel({
    this.id,
    this.stateName,
  });

  int? id;
  String? stateName;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        id: json["id"],
        stateName: json["state_name_lang"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state_name_lang": stateName,
      };
}

class CityModel {
  CityModel({
    this.id,
    this.cityName,
  });

  int? id;
  String? cityName;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_name": cityName,
      };
}
