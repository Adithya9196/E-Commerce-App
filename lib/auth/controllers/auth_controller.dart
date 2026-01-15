import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce_app/auth/pages/login_page.dart';
import 'package:e_commerce_app/products/ui/products.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  Widget get initialScreen {
    return firebaseUser.value == null
        ? LoginPage()
        : ProductPage();
  }
}
