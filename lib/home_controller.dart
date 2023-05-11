import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/product_model.dart';

class HomeController extends GetxController {
  Rx<List<ProductModel>> products = Rx<List<ProductModel>>([]);
  TextEditingController nameEditController = TextEditingController();
  TextEditingController priceEditController = TextEditingController();

  late ProductModel productModel;
  RxInt itemCount = 0.obs;

  @override
  void onClose() {
    super.onClose();
  }
}
