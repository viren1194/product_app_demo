import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import 'package:product_app/utils/api_client.dart';

class RegisterController extends GetxController implements GetxService {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? image;
  final ImagePicker picker = ImagePicker();
  ApiClient apiClient;
  RegisterController({required this.apiClient});

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);

      update();
    }
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      update();
    }
  }

  Future showOptions() async {
    Get.defaultDialog(
        content: Column(
      children: [
        ListTile(
          onTap: () async {
            Get.back();
            await getImageFromGallery();
          },
          title: const Text("Gallery"),
        ),
        ListTile(
          onTap: () async {
            Get.back();
            await getImageFromCamera();
          },
          title: const Text("Camera"),
        ),
      ],
    ));
  }

  ImageProvider getImage() {
    if (image == null) {
      return const AssetImage('assets/images/profile_img.jpg');
    } else {
      if (image != null) {
        return FileImage(File(image!.path));
      } else {
        return const AssetImage('assets/images/profile_img.jpg');
      }
    }
  }
}
