import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:product_app/model/response/product_model.dart';
import 'package:product_app/utils/api_client.dart';

class DemoController extends GetxController implements GetxService {
  ApiClient apiClient;

  DemoController({required this.apiClient});
  bool isLoading = false;
  ProductModel? productModel;

  List<ProductModel> productList = <ProductModel>[];
  List<ProductModel> filteredProductList = <ProductModel>[];

  TextEditingController searchItemController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    searchItemController.addListener(filterProducts); // Listen for text changes
  }

  // get product list
  Future<void> getProduct() async {
    isLoading = true;
    Response response =
        await apiClient.getData('https://api.escuelajs.co/api/v1/products');

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.body;
      if (responseData.isNotEmpty) {
        responseData.forEach(
          (element) {
            ProductModel productModel = ProductModel.fromJson(element);
            productList.add(productModel);
          },
        );
      }
      filteredProductList.addAll(productList);
      // searchItemController.clear();
      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }

  // Filter products based on the search query
  void filterProducts() {
    final searchQuery = searchItemController.text.toLowerCase();
    filteredProductList = productList
        .where((product) =>
            product.title != null &&
            product.title!.toLowerCase().contains(searchQuery))
        .toList();
    update();
  }

  @override
  void onClose() {
    searchItemController.dispose();
    super.onClose();
  }
}