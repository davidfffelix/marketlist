import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/product_model.dart';

class HomeController extends GetxController {
  Rx<List<ProductModel>> products = Rx<List<ProductModel>>([]);
  TextEditingController nameTextEditController = TextEditingController();
  TextEditingController priceTextEditController = TextEditingController();

  late ProductModel productModel;
  RxInt itemCount = 0.obs;

  @override
  void onClose() {
    super.onClose();
    nameTextEditController.dispose();
    priceTextEditController.dispose();
  }

  addProducts(String name, double price) {
    productModel = ProductModel(name: name, price: price);
    products.value.add(productModel);
    itemCount.value = products.value.length;
  }
}
