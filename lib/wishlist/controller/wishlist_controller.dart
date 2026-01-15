import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/products/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  final wishlistItems = <ProductList>[].obs;
  final isLoading = false.obs;

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get uid => _auth.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    listenToWishlist();
  }

  void listenToWishlist() {
    isLoading.value = true;

    _firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist')
        .snapshots()
        .listen((snapshot) {
      wishlistItems.value = snapshot.docs.map((doc) {
        return ProductList.fromJson(
          Map<String, dynamic>.from(doc['product']),
        );
      }).toList();

      isLoading.value = false;
    });
  }

  Future<void> toggleWishlist(ProductList product) async {
    final docRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist')
        .doc(product.id.toString());

    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.delete();
    } else {
      await docRef.set({
        'product': product.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar("Wishlist", "Added to wishlist",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white54,
        colorText: Colors.black,
        margin: const EdgeInsets.all(16),
        borderRadius: 14,
        icon: const Icon(Icons.error_outline_outlined, color: Colors.red),
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 300),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }

  bool isInWishlist(ProductList product) {
    return wishlistItems.any((p) => p.id == product.id);
  }
}
