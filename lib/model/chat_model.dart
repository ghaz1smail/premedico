import 'package:premedico/model/order_model.dart';
import 'package:premedico/model/user_model.dart';

class ChatModel {
  UserModel userData;
  OrderModel orderData;
  bool typing;
  bool clicked;
  String lastMessage;
  String updatedAt;
  ChatModel({
    required this.userData,
    required this.typing,
    required this.orderData,
    required this.clicked,
    required this.lastMessage,
    required this.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      userData: UserModel.fromJson(json['userData']),
      orderData: OrderModel.fromJson(json['orderData']),
      typing: json['typing'],
      clicked: json['clicked'],
      lastMessage: json['lastMessage'],
      updatedAt: json['updatedAt'].toString(),
    );
  }
}
