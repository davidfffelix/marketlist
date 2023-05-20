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

  List<ProductModel> foundProducts = [];

  final nameTextEditController = TextEditingController();
  final priceTextEditController = TextEditingController();

  bool isSorted = true;

  // var sortType = sortLowerPrice();

  // late ProductModel productModel;
  // RxInt itemCount = 0.obs;

  @override
  void onClose() {
    super.onClose();
    nameTextEditController.dispose();
    priceTextEditController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    sortProducts();
    foundProducts = products;
  }

  void sortProducts() {
    products.sort(
      (a, b) {
        return isSorted ? b.price.compareTo(a.price) : a.price.compareTo(b.price);
      },
    );
    isSorted = !isSorted;
    update();
  }

  void addProducts(String name, double price) {
    products.add(ProductModel(name: name, price: price));
    update();
  }

  void updateProducts(int index, String newName, double newPrice) {
    products[index].name = newName;
    products[index].price = newPrice;
    update();
  }

  void removeProducts(int index) {
    products.removeAt(index);
    update();
  }

  void searchProducts(String searchTerm) {
    if (searchTerm.isEmpty) {
      foundProducts = products;
    } else {
      foundProducts = products.where((product) => product.name.toLowerCase().startsWith(searchTerm.toLowerCase())).toList();
    }
    update();
  }
}
