class HospitalModel {
  String? id;
  String? name;
  String? image;
  List? favorites;

  HospitalModel({
    this.id,
    this.name,
    this.image,
    this.favorites,
  });

  factory HospitalModel.fromJson(Map json) {
    return HospitalModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      id: json['id'] ?? '',
      favorites: json['favorites'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'image': image, 'id': id, 'favorites': favorites};
  }
}
