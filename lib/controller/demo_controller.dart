import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

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
  final Debouncer _searchDebouncer =
      Debouncer(delay: Duration(milliseconds: 500));

  Future<void> searchItem() async {
    print('searchItem function called');
    dataNotFound = false; // Reset dataNotFound flag
    isLoading = true;
    update(); // Notify the UI to show the loader
    final searchQuery = searchItemController.text;
    // Use the Debouncer to delay the search API call
    print('Search Query: $searchQuery');
    _searchDebouncer.run(() async {
      Response response = await apiClient.getData(
        'https://api.escuelajs.co/api/v1/products/?title=$searchQuery',
      );
      print(
          'API URL: https://api.escuelajs.co/api/v1/products/?title=$searchQuery');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      isLoading = false;
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.body;
        productList.clear();
        if (responseData.isNotEmpty) {
          responseData.forEach(
            (element) {
              final productModel = ProductModel.fromJson(element);
              productList.add(productModel);
            },
          );
        } else {
          dataNotFound = true;
        }
      } else {
        // Handle error appropriately
        print("Error");
      }
      update();
    });
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

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
