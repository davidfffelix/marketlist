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
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            
          },
        ),
      ),
    );
  }
}


// Text('Nome do Produto'),
//             Padding(
//               padding: EdgeInsets.only(
//                 left: 20,
//                 right: 20,
//               ),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Inserir Nome',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text('Preço do Produto'),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Adicionar Preço',
//               ),
//             ),
