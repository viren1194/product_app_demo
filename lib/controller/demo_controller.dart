import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:product_app/model/response/product_model.dart';
import 'package:product_app/utils/api_client.dart';

class DemoController extends GetxController implements GetxService {
  ApiClient apiClient;

  DemoController({required this.apiClient});
  bool isLoading = false;

  bool dataNotFound = false;
  ProductModel? productModel;

  List<ProductModel> productList = <ProductModel>[];

  TextEditingController searchItemController = TextEditingController();

  Future<void> searchItem() async {
     dataNotFound = false; // Reset dataNotFound flag
    isLoading = true;
    update(); // Notify the UI to show the loader
    final searchQuery = searchItemController.text;
    Response response = await apiClient.getData(
      'https://api.escuelajs.co/api/v1/products/?title=$searchQuery',
    );
  isLoading = false; // Hide the loader
    if (response.statusCode == 200) {
      // Parse and update the product list with the filtered results
      final List<dynamic> responseData = response.body;
      productList.clear(); // Clear the existing list
      if (responseData.isNotEmpty) {
        responseData.forEach(
          (element) {
            final productModel = ProductModel.fromJson(element);
            productList.add(productModel);
          },
        );
      } else {
        dataNotFound = true; // Set the flag if no data is found
      }

    } else {
      // Handle error appropriately
      print("Error");
    }
    update();
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

      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }
}
