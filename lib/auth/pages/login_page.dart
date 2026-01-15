// import 'package:e_commerce_app/auth/controllers/login_controller.dart';
// import 'package:e_commerce_app/auth/pages/register_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});
//
//   final controller = Get.put(LoginController());
//   final _formKey = GlobalKey<FormState>();
//   final obscurePassword = true.obs;
//   final isForgotSelected = false.obs;
//
//   @override
//   Widget build(BuildContext context) {
//     controller.emailController.clear();
//     controller.passwordController.clear();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 40),
//                 const Text(
//                   "Welcome back!",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//
//                 // Email Field
//                 TextFormField(
//                   controller: controller.emailController,
//                   decoration: InputDecoration(
//                     hintText: "Email",
//                     prefixIcon: const Icon(Icons.email_outlined),
//                     filled: true,
//                     fillColor: Colors.grey.shade200,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   validator: (value) => controller.validateEmail(value!),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Password Field
//                 Obx(
//                       () => TextFormField(
//                     controller: controller.passwordController,
//                     obscureText: obscurePassword.value,
//                     decoration: InputDecoration(
//                       hintText: "Password",
//                       prefixIcon: const Icon(Icons.lock_outline),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           obscurePassword.value
//                               ? Icons.visibility_off
//                               : Icons.visibility,
//                         ),
//                         onPressed: () {
//                           obscurePassword.value = !obscurePassword.value;
//                         },
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey.shade200,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     validator: (value) => controller.validatePassword(value!),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//
//                 // Login Button
//                 Obx(
//                       () => controller.isLoading.value
//                       ? const CircularProgressIndicator()
//                       : SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurple,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           controller.login();
//                         }
//                       },
//                       child: const Text(
//                         "Sign in",
//                         style: TextStyle(fontSize: 16,color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//
//                 Obx(()=>
//                  SizedBox(
//                     width: double.infinity,
//                     height: 52,
//                     child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         backgroundColor: isForgotSelected.value
//                             ? Colors.white
//                             : Colors.grey.shade100,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         side: BorderSide(
//                           color: isForgotSelected.value
//                               ? Colors.grey
//                               : Colors.transparent,
//                         ),
//                       ),
//                       onPressed: () {
//                         isForgotSelected.value = true;
//                       },
//                       child: const Text(
//                         "Forgot password?",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//
//                 Obx(()=>
//                  SizedBox(
//                     width: double.infinity,
//                     height: 52,
//                     child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         backgroundColor: isForgotSelected.value
//                             ? Colors.grey.shade100
//                             : Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         side: BorderSide(
//                           color: isForgotSelected.value
//                               ? Colors.transparent
//                               : Colors.grey,
//                         ),
//                       ),
//                       onPressed: () {
//                           isForgotSelected.value = false;
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => RegisterPage()),
//                           );
//                         },
//
//                       child: const Text(
//                         "Create Account",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:e_commerce_app/auth/controllers/login_controller.dart';
import 'package:e_commerce_app/auth/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final obscurePassword = true.obs;
  final isForgotSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    controller.emailController.clear();
    controller.passwordController.clear();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Welcome back!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),

                // Email Field
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) => controller.validateEmail(value!),
                ),
                const SizedBox(height: 16),

                // Password Field
                Obx(
                      () => TextFormField(
                    controller: controller.passwordController,
                    obscureText: obscurePassword.value,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          obscurePassword.value = !obscurePassword.value;
                        },
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) => controller.validatePassword(value!),
                  ),
                ),
                const SizedBox(height: 24),

                Obx(
                      () => controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.login();
                        }
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(fontSize: 16,color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Obx(()=>
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: isForgotSelected.value
                              ? Colors.white
                              : Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: BorderSide(
                            color: isForgotSelected.value
                                ? Colors.grey
                                : Colors.transparent,
                          ),
                        ),
                        onPressed: () {
                          isForgotSelected.value = true;
                        },
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                ),
                const SizedBox(height: 12),

                Obx(()=>
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: isForgotSelected.value
                              ? Colors.grey.shade100
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: BorderSide(
                            color: isForgotSelected.value
                                ? Colors.transparent
                                : Colors.grey,
                          ),
                        ),
                        onPressed: () {
                          isForgotSelected.value = false;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },

                        child: const Text(
                          "Create Account",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}