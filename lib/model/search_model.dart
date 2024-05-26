import 'package:premedico/model/hospital_model.dart';
import 'package:premedico/model/user_model.dart';

class SearchModel {
  String types;
  String time;
  UserModel? users;
  HospitalModel? hospitals;

  SearchModel({
    this.types = 'doctor',
    this.time = '',
    this.users,
    this.hospitals,
  });

  factory SearchModel.fromJson(Map json, String type) {
    return SearchModel(
      types: type,
      time: json['time'] ?? '',
      users: type == 'doctor'
          ? UserModel.fromJson(json)
          : UserModel(name: '', image: ''),
      hospitals: type == 'hospital'
          ? HospitalModel.fromJson(json)
          : HospitalModel(name: '', image: ''),
    );
  }
}
