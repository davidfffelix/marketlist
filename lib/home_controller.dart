import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  List<ProductModel> products = [
    // ProductModel(name: 'Farinha', price: 20),
    // ProductModel(name: 'Arroz', price: 12),
    // ProductModel(name: 'Feijão', price: 15),
    // ProductModel(name: 'Óleo', price: 5),
    // ProductModel(name: 'Macarrão', price: 2),
    // ProductModel(name: 'Café', price: 8),
  ];

  List<ProductModel> foundProducts = [];

  final nameTextEditController = TextEditingController();
  final priceTextEditController = TextEditingController();

  bool isSorted = true;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onClose() {
    super.onClose();
    nameTextEditController.dispose();
    priceTextEditController.dispose();
  }

  @override
  void onInit() async {
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
      value.docs.forEach((element) {
        final product = element.data();
        products.add(ProductModel(name: product['name'], price: product['price']));
      });
    }).catchError((error) {});
  }

  void updateProducts(int index, String newName, double newPrice) {
    ProductModel updatedProduct = ProductModel(name: newName, price: newPrice);
    products[index] = updatedProduct;
    update();
  }

  // Exemplo de método para atualizar um produto no Firestore
  // void updateProducts(String productId, String newName, double newPrice) {
  //   firestore.collection('products').doc(productId).update({
  //     'name': newName,
  //     'price': newPrice,
  //   }).then((value) {
  //     // Sucesso ao atualizar o produto no Firestore
  //   }).catchError((error) {
  //     // Lidar com o erro ao atualizar o produto no Firestore
  //   });
  // }

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
