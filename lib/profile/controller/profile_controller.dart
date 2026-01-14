import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/profile/page/Edit_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final user = Rx<User?>(FirebaseAuth.instance.currentUser);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    if (user.value != null) {
      try {
        isLoading.value = true;
        final doc =
        await _firestore.collection('users').doc(user.value!.uid).get();
        if (doc.exists) {
          final data = doc.data()!;
          nameController.text = data['name'] ?? '';
          emailController.text = data['email'] ?? '';
          phoneController.text = data['phone'] ?? '';
          addressController.text = data['address'] ?? '';
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to fetch user data');
      } finally {
        isLoading.value = false;
      }
    }
  }

  void updateProfile() async {
    if (user.value != null) {
      try {
        isLoading.value = true;
        await _firestore.collection('users').doc(user.value!.uid).update({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'address': addressController.text.trim(),
          'phone': phoneController.text.trim(),
        });
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white54,
          colorText: Colors.black,
          margin: const EdgeInsets.all(16),
          borderRadius: 14,
          icon: const Icon(Icons.check_circle, color: Colors.green),
          duration: const Duration(seconds: 2),
          animationDuration: const Duration(milliseconds: 300),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      } catch (e) {
        Get.snackbar('Error', 'Failed to update profile',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white54,
          colorText: Colors.black,
          margin: const EdgeInsets.all(16),
          borderRadius: 14,
          icon: const Icon(Icons.check_circle, color: Colors.green),
          duration: const Duration(seconds: 2),
          animationDuration: const Duration(milliseconds: 300),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
