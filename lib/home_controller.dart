import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/product_model.dart';

class HomeController extends GetxController {
  List<ProductModel> products = [];

  final nameTextEditController = TextEditingController();
  final priceTextEditController = TextEditingController();

  // late ProductModel productModel;
  // RxInt itemCount = 0.obs;

  @override
  void onClose() {
    super.onClose();
    nameTextEditController.dispose();
    priceTextEditController.dispose();
  }

  void addProducts(String name, double price) {
    products.add(ProductModel(name: name, price: price));
    update();
  }

  void removeProducts(int index) {
    products.removeAt(index);
    update();
  }
}
