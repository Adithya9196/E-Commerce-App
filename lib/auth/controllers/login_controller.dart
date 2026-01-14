import 'package:e_commerce_app/auth/service/auth_service.dart';
import 'package:e_commerce_app/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) return "Invalid email";
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  Future<void> login() async {
    try {
      isLoading.value = true;
      await _authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      Get.offAll(() => HomePage());
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      Get.snackbar("Login Failed", "Please enter valid email or password");
    } finally {
      isLoading.value = false;
    }
  }
}
