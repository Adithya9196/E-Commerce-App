import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/order/model/order_model.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderController extends GetxController {
  final orders = <OrderModel>[].obs;
  final isLoading = false.obs;

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get uid => _auth.currentUser?.uid;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
    listenToOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;

    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .get();

    orders.value = snapshot.docs
        .map((doc) => OrderModel.fromJson(doc.data()))
        .toList();

    isLoading.value = false;
  }

  void listenToOrders() {
    _firestore
        .collection('users')
        .doc(uid)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      orders.value = snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()))
          .toList();

      isLoading.value = false;
    });
  }

}
