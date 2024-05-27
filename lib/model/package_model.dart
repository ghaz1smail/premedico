import 'package:premedico/model/user_model.dart';

class PackageModel {
  String? id;
  String? name;
  String? price;
  String? pre;
  String? post;
  String? into;
  String? image;
  UserModel? doctorData;

  PackageModel({
    this.id,
    this.name,
    this.price,
    this.pre,
    this.post,
    this.into,
    this.image,
    this.doctorData,
  });

  PackageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    pre = json['pre'];
    post = json['post'];
    into = json['into'];
    image = json['image'];
    doctorData = UserModel.fromJson(json['doctorData']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'pre': pre,
      'post': post,
      'into': into,
      'image': image,
      'doctorData': doctorData?.toJson(),
    };
  }
}

class HistoryPackageModel {
  String? timestamp;
  UserModel? userData;

  PackageModel? packageData;

  HistoryPackageModel({
    this.timestamp,
    this.userData,
    this.packageData,
  });

  HistoryPackageModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    userData = UserModel.fromJson(json['userData']);
    packageData = PackageModel.fromJson(json['package']);
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'userData': userData?.toJson(),
      'package': packageData?.toJson(),
    };
  }
}
