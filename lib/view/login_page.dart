import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:product_app/controller/auth_controller.dart';
import 'package:product_app/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthController authController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextfield(
              controller: authController.emailController,
              hintText: "Enter Email",
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextfield(
              controller: authController.passwordController,
              hintText: "Enter Password",
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                authController.userLogin();
              },
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
