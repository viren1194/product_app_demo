import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_app/controller/demo_controller.dart';

import 'package:product_app/view/product_details_page.dart';

class SearchDemo extends StatefulWidget {
  const SearchDemo({super.key});

  @override
  State<SearchDemo> createState() => _SearchDemoState();
}

class _SearchDemoState extends State<SearchDemo> {
  DemoController demoController = Get.find();

  @override
  void initState() {
    super.initState();
    demoController.getProduct();
    // demoController.searchItemController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    demoController.searchItemController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<DemoController>(builder: (demoController) {
        // print("Lenght = ${productController.productList.length}");
        return SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: demoController.searchItemController,
                onChanged: (value) {
                  print('Text changed: $value');
                  demoController.searchItem();
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
              // Loader while searching
              if (demoController.isLoading)
                Center(child: CircularProgressIndicator())
              else
                // Conditional message when no data is found
                demoController.dataNotFound
                    ? Center(
                        child: Text("No data found"),
                      )
                    : ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: demoController.productList.length,
                            itemBuilder: (context, index) {
                              var products = demoController.productList[index];

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
                                ),
                              );
                            },
                          ),
                        ],
                      ),
            ],
          ),
        );
      }),
    );
  }
}
