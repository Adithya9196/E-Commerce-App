import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/products/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartController extends GetxController {
  RxList<ProductList> cartItems = <ProductList>[].obs;
  RxList<int> quantities = <int>[].obs;
  final isLoading = true.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  String get uid => _auth.currentUser!.uid;

  // Fetch Cart Items from Firestore
  void fetchCartItems() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('cart')
        .get();

    isLoading.value = false;

    cartItems.clear();
    quantities.clear();

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final productMap = Map<String, dynamic>.from(data['product']!);
      final product = ProductList.fromJson(productMap);
      final qty = data['quantity'] ?? 1;
      cartItems.add(product);
      quantities.add(qty);
    }
  }

  // Add product to cart
  void addToCart(ProductList product) async {
    final index = cartItems.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      quantities[index]++;
    } else {
      cartItems.add(product);
      quantities.add(1);
    }

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(product.id.toString())
        .set({
      'product': product.toJson(),
      'quantity': getQuantity(product),
    });

    Get.snackbar("Cart", "${product.title} added to cart",
        snackPosition: SnackPosition.BOTTOM);
  }

  int getQuantity(ProductList product) {
    final index = cartItems.indexWhere((p) => p.id == product.id);
    if (index >= 0) return quantities[index];
    return 1;
  }

  void incrementQuantity(ProductList product) async {
    final index = cartItems.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      quantities[index]++;
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(product.id.toString())
          .update({'quantity': quantities[index]});
    }
  }

  void decrementQuantity(ProductList product) async {
    final index = cartItems.indexWhere((p) => p.id == product.id);
    if (index >= 0 && quantities[index] > 1) {
      quantities[index]--;
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(product.id.toString())
          .update({'quantity': quantities[index]});
    }
  }

  double get totalPrice {
    double total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      total += cartItems[i].price * quantities[i];
    }
    return total;
  }

  Future<void> confirmOrder() async {
    if (cartItems.isEmpty) return;

    final orderId = _firestore.collection('tmp').doc().id;

    final orderItems = List.generate(cartItems.length, (index) {
      return {
        'product': cartItems[index].toJson(),
        'quantity': quantities[index],
      };
    });

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('orders')
        .doc(orderId)
        .set({
      'orderId': orderId,
      'items': orderItems,
      'totalAmount': totalPrice,
      'status': 'confirmed',
      'createdAt': FieldValue.serverTimestamp(),
    });
    await clearCartFromFirestore();

    cartItems.clear();
    quantities.clear();

    Get.snackbar(
      "Order Confirmed",
      "Your order has been placed successfully",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.black,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.check_circle, color: Colors.green),
    );
  }

  Future<void> removeFromCart(ProductList product) async {
    final index = cartItems.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      cartItems.removeAt(index);
      quantities.removeAt(index);
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(product.id.toString())
          .delete();
    }
  }
  Future<void> clearCartFromFirestore() async {
    final cartSnapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('cart')
        .get();

    WriteBatch batch = _firestore.batch();

    for (var doc in cartSnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();

    cartItems.clear();
    quantities.clear();
  }

  bool isInCart(ProductList product) {
    return cartItems.any((p) => p.id == product.id);
  }

}
