import 'package:get/get.dart';
import 'package:product_app/controller/auth_controller.dart';
import 'package:product_app/controller/demo_controller.dart';
import 'package:product_app/controller/product_controller.dart';
import 'package:product_app/controller/register_controller.dart';
import 'package:product_app/utils/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  // final ApiClient apiClient = ApiClient();
  // Get.lazyPut(() => apiClient);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  Get.lazyPut(
    () => AuthController(
      sharedPreferences: Get.find(),
      apiClient: Get.find(),
    ),
  );
  Get.lazyPut(() => RegisterController(apiClient: Get.find()));
  Get.lazyPut(() => ProductController(apiClient: Get.find()));
  Get.lazyPut(() => DemoController(apiClient: Get.find()));
}
