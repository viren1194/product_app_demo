import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_slider/gradient_slider.dart';
import 'package:product_app/controller/theme_controller.dart';
import 'package:product_app/view/category_wise_product.dart';
import 'package:product_app/view/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GetBuilder<ThemeController>(
          builder: (themeController) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(const ProductListPage());
                  },
                  child: const Text("All products"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(const CategoryWiseProduct());
                  },
                  child: const Text("Category wise data"),
                ),
                Switch(
                  value: themeController.isDarkMode,
                  onChanged: (value) {
                    themeController.toggleTheme();
                  },
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
