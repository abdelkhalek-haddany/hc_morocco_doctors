class CityModel {

  final String id, name;

  CityModel({
    required this.id,
    required this.name,
  });

  factory CityModel.fromJson(Map <String, dynamic> map){
    return CityModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}