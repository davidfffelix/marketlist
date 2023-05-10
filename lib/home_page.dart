import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final List _shopping = List[];

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
          children: const [
            Text('Nome do Produto: '),
            TextField(
              decoration: InputDecoration(
                hintText: 'Inserir Nome',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Preço do Produto'),
            TextField(
              decoration: InputDecoration(
                hintText: 'Adicionar Preço',
              ),
            ),
            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: 10,
            //   itemBuilder: (context, index) {
            //     return const ListTile(
            //       title: Text('Produto'),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
