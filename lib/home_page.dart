import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (control) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: const Text('MarketList'),
              leading: const Icon(Icons.menu),
              actions: [
                IconButton(
                  icon: const Icon(Icons.swap_vert),
                  onPressed: () {
                    controller.sortProducts();
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 14,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      controller.searchProducts(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      suffixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: control.foundProducts.length,
                    itemBuilder: (context, index) {
                      if (control.foundProducts.isEmpty) {
                        return const Center(
                          child: Text('No products found.'),
                        );
                      }
                      return ListTile(
                        title: Text(control.foundProducts[index].name),
                        subtitle: Text('R\$ ${control.foundProducts[index].price.toStringAsFixed(2)}'),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  /// Preenche o campo com valor atual
                                  controller.editNameTextEditController.text = control.foundProducts[index].name;
                                  controller.editPriceTextEditController.text = control.foundProducts[index].price.toString();
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Edit Product',
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 4,
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Product',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),
                                          TextField(
                                            keyboardType: TextInputType.name,
                                            decoration: const InputDecoration(
                                              hintText: 'Enter a New Name',
                                              border: OutlineInputBorder(),
                                            ),
                                            controller: controller.editNameTextEditController,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 4,
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Price',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextField(
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              hintText: 'Enter New Price',
                                              border: OutlineInputBorder(),
                                            ),
                                            controller: controller.editPriceTextEditController,
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(
                                                    Colors.green,
                                                  ),
                                                ),
                                                child: const Text('Cancel'),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(
                                                    Colors.green,
                                                  ),
                                                ),
                                                child: const Text('Update'),
                                                onPressed: () {
                                                  double parsedPrice = double.tryParse(controller.editPriceTextEditController.value.text) ?? 0;
                                                  controller.updateProducts(controller.foundProducts[index].id, controller.editNameTextEditController.value.text, parsedPrice);
                                                  Get.back();
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  controller.removeProducts(
                                    controller.foundProducts[index].id,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            persistentFooterAlignment: AlignmentDirectional.centerStart,
            persistentFooterButtons: [
              Text('Total: R\$ ${controller.totalPrice.toStringAsFixed(2)}'),
            ],
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: FloatingActionButton.extended(
                icon: const Icon(Icons.add),
                label: const Text('Add Product'),
                backgroundColor: Colors.green,
                onPressed: () {
                  /// Reseta o valor dos controllers
                  controller
                    ..nameTextEditController.clear()
                    ..priceTextEditController.clear();
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Product and Price Registration',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 4,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Product',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          TextField(
                            controller: controller.nameTextEditController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              hintText: 'Enter the Product',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 4,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Price',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TextField(
                            controller: controller.priceTextEditController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'R\$',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.green,
                                  ),
                                ),
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.green,
                                  ),
                                ),
                                child: const Text('Register'),
                                onPressed: () {
                                  controller.addProducts(
                                    controller.nameTextEditController.text,
                                    double.tryParse(controller.priceTextEditController.text) ?? 0,
                                  );
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
