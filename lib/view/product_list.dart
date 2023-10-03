import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_app/controller/product_controller.dart';

import 'package:product_app/view/product_details_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // final ApiClient apiClient = ApiClient();
  ProductController productController = Get.find();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    productController.getProduct();
    scrollController.addListener(scrollListner);
  }

  void scrollListner() {
    if (scrollController.positions.isNotEmpty) {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !productController.isLoading &&
          productController.hasMoreData) {
        productController.getProduct(page: productController.page);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<ProductController>(builder: (productController) {
        // print("Lenght = ${productController.productList.length}");
        return SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: productController.searchItemController,
                onChanged: (value) {
                  
                },
                decoration: InputDecoration(
                  hintText: 'search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),

              //***************************************************** */
              productController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      shrinkWrap: true,
                      controller: scrollController,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productController.productList.length,
                          itemBuilder: (context, index) {
                            var products = productController.productList[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                onTap: () {
                                  Get.to(ProductDetailsPage(
                                    id: products.id ?? 0,
                                  ));
                                },
                                tileColor: Colors.deepPurpleAccent,
                                leading: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image.network(
                                    products.images?.first ??
                                        products.images!.last,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(products.title ?? ""),
                                trailing: IconButton(
                                  onPressed: () {
                                    productController
                                        .deleteProduct(products.id!.toInt());
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            );
                          },
                        ),
                        if (productController.hasMoreData &&
                            productController.productList.isNotEmpty) ...{
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        }
                      ],
                    ),
            ],
          ),
        );
      }),
    );
  }
}
