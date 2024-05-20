class UserModel {
  String? type;
  String? name;
  String? image;
  String? email;
  String? uid;

  UserModel({
    this.type,
    this.name,
    this.image,
    this.email,
    this.uid,
  });

  factory UserModel.fromJson(Map json) {
    return UserModel(
      type: json['type'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      uid: json['uid'],
    );
  }

  Map toJson() {
    return {
      'type': type,
      'name': name,
      'image': image,
      'email': email,
      'uid': uid,
    };
  }
}
