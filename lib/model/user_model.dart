import 'package:get/get.dart';
import 'package:premedico/model/hospital_model.dart';

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
  bool online;
  List<SchedulingModel>? scheduling;

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
    this.scheduling,
    this.online = false,
  });

  factory UserModel.fromJson(Map json) {
    List s = json['scheduling'] ?? [];
    var hospitalx = json['hospital'] != null
        ? HospitalModel.fromJson(json['hospital'])
        : null;
    var schedulingx = s.map((e) => SchedulingModel.fromJson(e)).toList();
    return UserModel(
      type: json['type'],
      name: (json['type'] == 'doctor' ? '${'dr'.tr} ' : '') +
          json['name']
              .toString()
              .replaceFirst('Dr', '')
              .replaceFirst('دكتور', ''),
      image: json['image'] == null
          ? 'https://i.sstatic.net/l60Hf.png'
          : json['image'].toString().isEmpty
              ? 'https://i.sstatic.net/l60Hf.png'
              : json['image'],
      email: json['email'] ?? '',
      scheduling: schedulingx,
      uid: json['uid'],
      online: json['online'] ?? false,
      major: json['major'] ?? '',
      gender: json['gender'] ?? '',
      birth: json['birth'] == null
          ? DateTime.now().toString()
          : json['birth'].toString().isEmpty
              ? DateTime.now().toString()
              : json['birth'],
      phone: json['phone'] ?? '',
      bio: json['bio'] ?? '',
      rate: json['rate'] ?? '0',
      price: json['price'] == null ? 0 : double.parse(json['price'].toString()),
      hospital: hospitalx,
      favorites: json['favorites'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'image': image,
      'email': email,
      'uid': uid,
      'major': major,
      'rate': rate ?? '',
      'favorites': favorites ?? [],
      'bio': bio ?? '',
      'price': price,
      'phone': phone ?? '',
      'birth': birth ?? '',
      'gender': gender ?? '',
      if (type == 'doctor') 'hospital': hospital!.toJson()
    };
  }
}

class SchedulingModel {
  String? date;
  String? user;

  SchedulingModel({
    this.date,
    this.user,
  });

  factory SchedulingModel.fromJson(Map json) {
    return SchedulingModel(
      date: json['date'] ?? '',
      user: json['user'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'user': user,
    };
  }
}
