import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:product_app/model/response/category_model.dart';
import 'package:product_app/model/response/product_model.dart';
import 'package:product_app/utils/api_client.dart';
import 'package:product_app/utils/app_const.dart';

class ProductController extends GetxController implements GetxService {
  ApiClient apiClient;

  ProductController({required this.apiClient});
  bool isLoading = false;
  ProductModel? productModel;
  int limit = 20;
  int offset = 0;
  int page = 1;
  bool hasMoreData = true;
  List<ProductModel> productList = <ProductModel>[];
  List<ProductModel> originalProductList = <ProductModel>[];
  CategoryModel? categoryModel;
  List<CategoryModel> categoryList = <CategoryModel>[];
  int categoryId = 0;
  TextEditingController searchController = TextEditingController();
  bool isDataNull = false;
  TextEditingController searchItemController = TextEditingController();

  void selectCategory(int value) {
    categoryId = value;
    update();
  }

  Future<void> searchItem() async {
    Response response =
        await apiClient.getData(AppConstant.SEARCH + searchController.text);

    if (response.statusCode == 200) {
      print("sucssess");
    } else {
      print("errror");
    }
    update();
  }

  // get product list
  Future<void> getProduct({int page = 1}) async {
    // offset = offset + limit;
    if (page == 1) {
      isLoading = true;
      hasMoreData = true;
      productList = [];
      this.page = 1;
      offset = 0; // Reset offset for the first page
    } else {
      // Calculate the next offset based on the previous offset and limit
      offset = offset + limit;
    }
    isLoading = true;
    Response response = await apiClient.getData(
        '${AppConstant.GETPRODUCT}?offset=$offset&limit=$limit'); //?offset=10&limit=10

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.body;
      if (responseData.isNotEmpty) {
        responseData.forEach(
          (element) {
            ProductModel productModel = ProductModel.fromJson(element);
            productList.add(productModel);
          },
        );
        this.page++;
      } else {
        // No more data available
        hasMoreData = false;
      }

      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }

  // get single product

  Future<void> getSingleProduct(int id) async {
    isLoading = true;
    Response response =
        await apiClient.getData('${AppConstant.GETPRODUCT}/$id');

    if (response.statusCode == 200) {
      productModel = ProductModel.fromJson(response.body);

      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }

  // delete product

  Future<void> deleteProduct(int id) async {
    Response response = await apiClient.deleteData(
      '${AppConstant.GETPRODUCT}/$id',
    );

    if (response.statusCode == 200) {
      productList.removeWhere((element) => element.id == id);
      // Clear the product details after deletion
      productModel = null;
      update();
    }
  }

  // get all category

  Future<void> getAllCategory() async {
    Response response = await apiClient.getData(AppConstant.GETCATEGORY);

    if (response.statusCode == 200) {
      List<dynamic> categoryData = response.body;

      categoryData.forEach((element) {
        CategoryModel categoryModel = CategoryModel.fromJson(element);
        categoryList.add(categoryModel);
      });
      update();
    }
  }

  // get categorywise product

  Future<void> getCategoryWiseProduct(int id) async {
    isLoading = true;
    Response response =
        await apiClient.getData("${AppConstant.GETCATEGORY}/$id/products");

    if (response.statusCode == 200) {
      List<dynamic> productData = response.body;
      productList = [];
      if (productData.isNotEmpty) {
        productData.forEach(
          (element) {
            ProductModel productModel = ProductModel.fromJson(element);
            productList.add(productModel);
          },
        );
        isLoading = false;
        update();
      }
    } else {
      isDataNull = true;
      isLoading = false;
      update();
    }
  }

  Future<void> filterProduct(String title) async {
    isLoading = true;
    Response response =
        await apiClient.getData("${AppConstant.GETPRODUCT}/?title=$title");

    if (response.statusCode == 200) {
      List<dynamic> productData = response.body;
      productList = [];
      if (productData.isNotEmpty) {
        productData.forEach(
          (element) {
            ProductModel productModel = ProductModel.fromJson(element);
            productList.add(productModel);
          },
        );
        isLoading = false;
        update();
      }
    } else {
      isLoading = false;
      update();
    }
  }
}
