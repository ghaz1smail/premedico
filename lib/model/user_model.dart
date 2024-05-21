class UserModel {
  String? type;
  String? name;
  String? image;
  String? email;
  String? uid;
  String? major;
  List? favorites;
  String? rate;
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
      rate: json['rate'] ?? '0',
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
