import 'package:premedico/model/order_model.dart';

class NotificationModel {
  final String timestamp;
  final bool clicked;
  final String title;
  final OrderModel? orderData;

  NotificationModel({
    required this.timestamp,
    required this.clicked,
    required this.title,
    required this.orderData,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      timestamp: json['timestamp'],
      clicked: json['clicked'],
      title: json['title'],
      orderData: OrderModel.fromJson(json['orderData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'clicked': clicked,
      'title': title,
      'orderData': orderData!.toJson(),
    };
  }
}
