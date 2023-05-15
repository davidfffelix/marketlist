import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
                controller.sortLowerPrice();
              },
            ),
          ],
        ),
        body: GetBuilder<HomeController>(
          builder: (control) => ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.products[index].name),
                subtitle: Text('${controller.products[index].price}'),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    controller.removeProducts(index);
                  },
                ),
              );
            },
          ),
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
                      'Cadastro do Produto\n e do Preço',
                      textAlign: TextAlign.start,
                    ),
                    actions: [
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 4,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Produto',
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
                          hintText: 'Digite o Produto',
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
                            'Preço',
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
                          hintText: 'Digite o Preço',
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
                            child: const Text('Cancelar'),
                            onPressed: () {},
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
                            child: const Text('Cadastrar'),
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
