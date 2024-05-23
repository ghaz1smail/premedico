import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id;
  String name;
  String profile;
  Timestamp? timestamp;
  String text;
  String type;
  String authorId;
  bool seen;

  MessageModel({
    this.id = '',
    this.name = '',
    this.type = '',
    this.profile = '',
    this.timestamp,
    this.text = '',
    this.authorId = '',
    this.seen = false,
  });

  factory MessageModel.fromJson(Map json, String id) {
    return MessageModel(
        id: id,
        name: json['name'] ?? '',
        profile: json['profile'] ?? '',
        timestamp: json['timestamp'] ?? Timestamp.now(),
        text: json['text'] ?? '',
        type: json['type'] ?? '',
        authorId: json['authorId'] ?? '',
        seen: json['seen'] ?? false);
  }
}
