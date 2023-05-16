import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/product_model.dart';

class HomeController extends GetxController {
  List<ProductModel> products = [
    ProductModel(name: 'Farinha', price: 20),
    ProductModel(name: 'Arroz', price: 12),
    ProductModel(name: 'Feijão', price: 15),
    ProductModel(name: 'Óleo', price: 5),
    ProductModel(name: 'Macarrão', price: 2),
    ProductModel(name: 'Café', price: 8),
  ];

  final nameTextEditController = TextEditingController();
  final priceTextEditController = TextEditingController();

  bool isSorted = false;
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
    if (!isSorted) {
      products.sort(
        (a, b) {
          return b.price.compareTo(a.price);
        },
      );
      isSorted = true;
    } else {
      products.reversed.toList();
    }
    update();
  }

  // void sortHigherPrice() {
  //   products.sort(
  //     (a, b) {
  //       return b.price.compareTo(a.price);
  //     },
  //   );
  //   update();
  // }

  void addProducts(String name, double price) {
    products.add(ProductModel(name: name, price: price));
    update();
  }

  void removeProducts(int index) {
    products.removeAt(index);
    update();
  }
}
