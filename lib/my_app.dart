import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MarketList',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
