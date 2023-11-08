import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_app/utils/get_di.dart' as di;
import 'package:product_app/view/demo.dart';
import 'package:product_app/view/home_page.dart';
import 'package:product_app/view/image_post.dart';

import 'package:product_app/view/login_page.dart';
import 'package:product_app/view/product_list.dart';
import 'package:product_app/view/search_demo.dart';
import 'package:product_app/view/upload_image.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData.dark(),
      theme: ThemeData.light(), // Set your initial theme here
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light, // Set your initial theme mode here
      home: const UploadImage(),
    );
  }
}
