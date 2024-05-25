import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:premedico/model/user_model.dart';

class ChatModel {
  UserModel userData;
  bool typing;
  bool clicked;
  String lastMessage;
  Timestamp updatedAt;

  ChatModel({
    required this.userData,
    required this.typing,
    required this.clicked,
    required this.lastMessage,
    required this.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      userData: UserModel.fromJson(json['userData']),
      typing: json['typing'],
      clicked: json['clicked'],
      lastMessage: json['lastMessage'],
      updatedAt: json['updatedAt'],
    );
  }
}
