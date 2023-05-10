import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _shopping = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('MarketList'),
          leading: const Icon(Icons.menu),
        ),
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: _shopping.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_shopping[index]),
                );
              },
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
                      'Cadastro do Produto e do Preço',
                    ),
                    actions: [
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 4,
                        ),
                        child: Text(
                          'Nome do Produto',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'Inserir Nome',
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
                        child: Text(
                          'Preço do Produto',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'Inserir Valor',
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
                            child: const Text('Cancelar'),
                            onPressed: () {},
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          ElevatedButton(
                            child: const Text('Cadastrar'),
                            onPressed: () {},
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
