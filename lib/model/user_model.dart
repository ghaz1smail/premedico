class UserModel {
  String? type;
  String? name;
  String? image;
  String? email;
  String? uid;
  String? major;
  String? gender;
  String? birth;
  String? phone;
  List? favorites;
  String? rate;
  double? price;
  String? bio;
  HospitalModel? hospital;

  UserModel({
    this.type,
    this.name,
    this.image,
    this.email,
    this.uid,
    this.favorites,
    this.rate,
    this.major,
    this.hospital,
    this.bio,
    this.price,
    this.phone,
    this.birth,
    this.gender,
  });

  factory UserModel.fromJson(Map json) {
    var hospitalx = json['hospital'] != null
        ? HospitalModel.fromJson(json['hospital'])
        : null;
    return UserModel(
      type: json['type'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      uid: json['uid'],
      major: json['major'] ?? '',
      gender: json['gender'] ?? '',
      birth: json['birth'] ?? '',
      phone: json['phone'] ?? '',
      bio: json['bio'] ?? '',
      rate: json['rate'] ?? '0',
      price: json['price'] == null ? 0 : double.parse(json['price'].toString()),
      hospital: hospitalx,
      favorites: json['favorites'] ?? [],
    );
  }

  Map toJson() {
    return {
      'type': type,
      'name': name,
      'image': image,
      'email': email,
      'uid': uid,
      'phone': phone,
      'birth': birth,
      'gender': gender,
    };
  }
}

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
      name: json['name'],
      image: json['image'],
      id: json['id'],
      favorites: json['favorites'] ?? [],
    );
  }
}
