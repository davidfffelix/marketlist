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
  late TextEditingController editNameTextEditController;
  late TextEditingController editPriceTextEditController;

  bool isSorted = true;

  double totalPrice = 0;

  @override
  void onClose() {
    super.onClose();

    nameTextEditController.dispose();
    priceTextEditController.dispose();
    editNameTextEditController.dispose();
    editPriceTextEditController.dispose();
  }

  @override
  void onInit() async {
    super.onInit();
    readProducts();
    sortProducts();

    nameTextEditController = TextEditingController();
    priceTextEditController = TextEditingController();
    editNameTextEditController = TextEditingController();
    editPriceTextEditController = TextEditingController();

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

  void readProducts() async {
    await firestore.collection('products').get().then((value) {
      products.clear();
      totalPrice = 0;
      for (var element in value.docs) {
        final product = element.data();
        products.add(
          ProductModel(
            name: product['name'],
            price: double.parse(
              product['price'].toString(),
            ),
            id: element.id,
          ),
        );
        totalPrice += product['price'];
      }
    }).catchError((error) {});
    update();
  }

  void updateProducts(String productId, String newName, double newPrice) {
    firestore.collection('products').doc(productId).update({
      'name': newName,
      'price': newPrice,
    }).then(
      (value) {
        readProducts();
      },
    ).catchError(
      (error) {},
    );
  }

  void removeProducts(String productId) {
    firestore.collection('products').doc(productId).delete().then(
      (value) {
        readProducts();
      },
    ).catchError(
      (error) {},
    );
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
