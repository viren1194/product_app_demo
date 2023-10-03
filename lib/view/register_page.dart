import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:product_app/controller/register_controller.dart';
import 'package:product_app/widgets/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController registerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<RegisterController>(builder: (registerController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _profileImg(),
                const SizedBox(
                  height: 35,
                ),
                CustomTextfield(
                    controller: registerController.nameController,
                    hintText: "Enter Name"),
                const SizedBox(
                  height: 15,
                ),
                CustomTextfield(
                    controller: registerController.emailController,
                    hintText: "Enter Email"),
                const SizedBox(
                  height: 15,
                ),
                CustomTextfield(
                    controller: registerController.passwordController,
                    hintText: "Enter Password"),
                const SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  _profileImg() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.transparent,
            backgroundImage: registerController.getImage(),
          ),
          Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height * 0.15 / 2 + 35,
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: InkWell(
                  onTap: () async {
                    await registerController.showOptions();
                  },
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
