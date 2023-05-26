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
              child: GetBuilder<HomeController>(
                builder: (control) {
                  if (control.foundProducts.isEmpty) {
                    return const Center(
                      child: Text('No products found.'),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: control.foundProducts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(control.foundProducts[index].name),
                        subtitle: Text('${control.foundProducts[index].price}'),
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
                                            onChanged: (newName) {
                                              // Atualizar o nome do produto na lista
                                              controller.updateProducts(newName, newName, controller.products[index].price);
                                            },
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
                                            onChanged: (newPrice) {
                                              // Atualizar o preço do produto na lista
                                              double parsedPrice = double.tryParse(newPrice) ?? 0;
                                              controller.updateProducts(newPrice, controller.products[index].name, parsedPrice);
                                            },
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
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  controller.removeProducts(index as String);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: const Text('Add Product'),
            backgroundColor: Colors.green,
            onPressed: () {
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
                          // TODO: Verificar!
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
                          hintText: 'Enter Price',
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
                                // TODO: Estudar!
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
  }
}
