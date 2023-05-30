import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'firebase_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseLogin firebaseLogin = Get.put(FirebaseLogin());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: const Text('MarketList'),
        ),
        body: Center(
          child: SizedBox(
            height: 48,
            child: SignInButton(
              Buttons.Google,
              onPressed: () async {
                final userId = await firebaseLogin.signInWithGoogle();
                if (userId != null) {
                  Get.toNamed('/home');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
