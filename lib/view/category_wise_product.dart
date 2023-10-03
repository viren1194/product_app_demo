import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:product_app/controller/product_controller.dart';
import 'package:product_app/model/response/product_model.dart';

class CategoryWiseProduct extends StatefulWidget {
  const CategoryWiseProduct({super.key});

  @override
  State<CategoryWiseProduct> createState() => _CategoryWiseProductState();
}

class _CategoryWiseProductState extends State<CategoryWiseProduct> {
  ProductController productController = Get.find();
  String searchkeyword = "Search...";
  int isOne = 0;
  List<ProductModel> searchList = <ProductModel>[];

  void filterData(String searchText) {
    setState(() {
      searchList = productController.productList.where((data) {
        final searchName = (data.title)!.toLowerCase();
        return searchName.contains(searchText.toLowerCase());
      }).toList();
    });
  }

  void assignData() {
    searchList = productController.productList;
    isOne = 1;
  }

  @override
  void initState() {
    super.initState();

    productController.getAllCategory();
    productController.getCategoryWiseProduct(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<ProductController>(builder: (productController) {
        if (productController.isLoading == false &&
            isOne == 0 &&
            productController.isDataNull == false) {
          assignData();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 110,
                // color: Colors.blue,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: productController.categoryList.length,
                  itemBuilder: (context, index1) {
                    var categories = productController.categoryList[index1];
                    return GestureDetector(
                      onTap: () {
                        productController.selectCategory(index1);
                        productController
                            .getCategoryWiseProduct(categories.id ?? 0);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        productController.categoryId == index1
                                            ? Colors.amber
                                            : Colors.red),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                    radius: 38,
                                    backgroundImage:
                                        NetworkImage(categories.image ?? ''),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(categories.name ?? ''),
                        ],
                      ),
                    );
                  },
                ),
              ),

              TextField(
                // controller: productController.searchController,
                onChanged: (String a) {
                  filterData(a);
                },
                decoration: InputDecoration(
                  hintText: searchkeyword,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              // product list

              Expanded(
                child: productController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : !productController.isDataNull
                        ? ListView.builder(
                            itemCount: searchList.length,
                            itemBuilder: (context, index2) {
                              ProductModel product = searchList[index2];
                              return ListTile(
                                title: Text(product.title ?? ''),
                              );
                            },
                          )
                        : const Center(
                            child: Text("not found"),
                          ),
              )
            ],
          ),
        );
      }),
    );
  }
}
