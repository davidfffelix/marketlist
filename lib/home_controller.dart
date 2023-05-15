import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/product_model.dart';

class HomeController extends GetxController {
  List<ProductModel> products = [
    ProductModel(name: 'farinha', price: 20),
    ProductModel(name: 'arroz', price: 12),
    ProductModel(name: 'feijão', price: 15),
    ProductModel(name: 'óleo', price: 5),
  ];

  final nameTextEditController = TextEditingController();
  final priceTextEditController = TextEditingController();
  // var sortType = sortLowerPrice();

  // late ProductModel productModel;
  // RxInt itemCount = 0.obs;

  @override
  void onClose() {
    super.onClose();
    nameTextEditController.dispose();
    priceTextEditController.dispose();
  }

  void sortLowerPrice() {
    products.sort(
      (a, b) {
        return a.price.compareTo(b.price);
      },
    );
    update();
  }

  void sortHigherPrice() {
    products.sort(
      (a, b) {
        return b.price.compareTo(a.price);
      },
    );
    update();
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
