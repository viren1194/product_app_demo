import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_app/controller/product_controller.dart';


class ProductDetailsPage extends StatefulWidget {
  int id;

  ProductDetailsPage({required this.id, super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductController productController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.getSingleProduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      var productData = productController.productModel;
      return Scaffold(
        appBar: AppBar(
          title: Text(productController.productModel?.category?.name ?? ''),
          actions: [
            productData == null
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      productController.deleteProduct(
                          productController.productModel?.id ?? 0);
                    },
                    icon: const Icon(Icons.delete),
                  ),
          ],
        ),
        body: productController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : productData == null
                ? const Center(
                    child: Text('Data not available'),
                  )
                : Column(
                    children: [
                      Text(productData.title ?? ''),
                      SizedBox(
                        height: 400,
                        width: 400,
                        child: Image.network(productData.images?.first ??
                            productData.images?.last ??
                            ''),
                      ),
                      Text(productData.description ?? ''),
                      Text(productData.price.toString()),
                    ],
                  ),
      );
    });
  }
}
