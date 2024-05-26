class HospitalModel {
  String? id;
  String? name;
  String? image;
  List? favorites;
  List? users;

  HospitalModel({
    this.id,
    this.name,
    this.image,
    this.favorites,
    this.users,
  });

  factory HospitalModel.fromJson(Map json) {
    return HospitalModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      id: json['id'] ?? '',
      favorites: json['favorites'] ?? [],
      users: json['users'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'id': id,
      'favorites': favorites,
      'users': users
    };
  }
}
