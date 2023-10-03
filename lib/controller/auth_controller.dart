import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:product_app/model/body/login_body.dart';
import 'package:product_app/utils/api_client.dart';
import 'package:product_app/utils/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController implements GetxService {
  SharedPreferences sharedPreferences;
  ApiClient apiClient;
  AuthController({required this.sharedPreferences, required this.apiClient});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login({required LoginBody loginBody}) async {
    Response response = await apiClient.postData(
      AppConstant.LOGINURL,
      body: jsonDecode(
        jsonEncode(
          loginBody.toJson(),
        ),
      ),
    );
    if (response.statusCode == 201) {
      String token = response.body['access_token'];

      await sharedPreferences.setString(AppConstant.USERTOKEN, token);

      apiClient.addHeader();
    } else {
      if (kDebugMode) {
        print("Login failed: ${response.status}");
      }
    }
  }

  void userLogin() {
    LoginBody loginBody = LoginBody(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    login(loginBody: loginBody);
  }


}
