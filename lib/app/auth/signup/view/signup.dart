import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('SignUp'),
            TextButton(
              onPressed: () {
                Get.toNamed('/login');
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed('/home');
              },
              child: Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
