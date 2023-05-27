import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/product_model.dart';

class HomeController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<ProductModel> products = [];

  List<ProductModel> foundProducts = [];

  late TextEditingController nameTextEditController;
  late TextEditingController priceTextEditController;

  bool isSorted = true;

  @override
  void onClose() {
    super.onClose();
    nameTextEditController.dispose();
    priceTextEditController.dispose();
  }

  @override
  void onInit() async {
    super.onInit();
    nameTextEditController = TextEditingController();
    priceTextEditController = TextEditingController();
    readProducts();
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
    firestore.collection('products').add({
      'name': name,
      'price': price,
    }).then((value) {
      readProducts();
    }).catchError((error) {});
  }

  void readProducts() {
    firestore.collection('products').get().then((value) {
      products.clear();
      for (var element in value.docs) {
        final product = element.data();
        products.add(ProductModel(name: product['name'], price: double.parse(product['price'].toString())));
      }
    }).catchError((error) {});
    update();
  }

  // void updateProducts(int index, String newName, double newPrice) {
  //   ProductModel updatedProduct = ProductModel(name: newName, price: newPrice);
  //   products[index] = updatedProduct;
  //   update();
  // }

  // Exemplo de método para atualizar um produto no Firestore
  void updateProducts(String productId, String newName, double newPrice) {
    firestore.collection('products').doc(productId).update({
      'name': newName,
      'price': newPrice,
    }).then((value) {
      // Sucesso ao atualizar o produto no Firestore
    }).catchError((error) {
      // Lidar com o erro ao atualizar o produto no Firestore
    });
  }

  void removeProducts(int index) {
    products.removeAt(index);
    update();
  }

  // // Exemplo de método para excluir um produto do Firestore
  // void removeProducts(String productId) {
  //   firestore.collection('products').doc(productId).delete().then((value) {
  //     // Sucesso ao excluir o produto do Firestore
  //   }).catchError((error) {
  //     // Lidar com o erro ao excluir o produto do Firestore
  //   });
  // }

  void searchProducts(String searchTerm) {
    if (searchTerm.isEmpty) {
      foundProducts = products;
    } else {
      foundProducts = products.where((product) => product.name.toLowerCase().startsWith(searchTerm.toLowerCase())).toList();
    }
    update();
  }
}
