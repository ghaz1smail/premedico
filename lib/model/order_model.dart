import 'package:premedico/model/user_model.dart';

class OrderModel {
  String note;
  String id;
  UserModel doctorData;
  UserModel userData;
  String paymentMethod;
  String timestamp;
  String dateTime;

  OrderModel({
    required this.note,
    required this.id,
    required this.doctorData,
    required this.userData,
    required this.paymentMethod,
    required this.timestamp,
    required this.dateTime,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      note: json['note'] ?? '',
      id: json['id'] ?? '',
      doctorData: UserModel.fromJson(json['doctorData']),
      userData: UserModel.fromJson(json['userData']),
      paymentMethod: json['paymentMethod'] ?? '',
      timestamp: json['timestamp'] ?? '',
      dateTime: json['dateTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'note': note,
      'id': id,
      'doctorData': doctorData.toJson(),
      'userData': userData.toJson(),
      'paymentMethod': paymentMethod,
      'timestamp': timestamp,
      'dateTime': dateTime,
    };
  }
}
