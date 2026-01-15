import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final List<Map<String, dynamic>> items;
  final double total;
  final DateTime date;
  final String status;

  OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['orderId'],
      items: List<Map<String, dynamic>>.from(json['items']),
      total: (json['totalAmount'] as num).toDouble(),
      date: (json['createdAt'] as Timestamp).toDate(),
      status: json['status'],
    );
  }
}
