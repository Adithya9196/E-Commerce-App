import 'package:e_commerce_app/auth/controllers/login_controller.dart';
import 'package:e_commerce_app/auth/controllers/reg_controller.dart';
import 'package:e_commerce_app/auth/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  final obscurePassword = true.obs;

  @override
  Widget build(BuildContext context) {
    controller.emailController.clear();
    controller.passwordController.clear();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (validate) {
                  return controller.validateEmail(validate!);
                },
              ),
              Obx(
                () => TextFormField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
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
                  ),
                  obscureText: obscurePassword.value,
                  validator: (validate) {
                    return controller.validatePassword(validate!);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.login();
                          }
                        },
                        child: const Text("Login"),
                      ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => RegisterPage());
                },
                child: const Text("Create new account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
