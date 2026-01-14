import 'package:e_commerce_app/auth/service/auth_service.dart';
import 'package:e_commerce_app/auth/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final AuthService _authService = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  final isLoading = false.obs;

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) return "Invalid email";
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  String? validatePhone(String value) {
    if (!GetUtils.isPhoneNumber(value)) return "Invalid phone number";
    return null;
  }

  Future<void> register() async {
    try {
      isLoading.value = true;
      await _authService.register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.snackbar("Success", "Registration successful");
      Get.offAll(() => LoginPage());
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      addressController.clear();
      passwordController.clear();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
