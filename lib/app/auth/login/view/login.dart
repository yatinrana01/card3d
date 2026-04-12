import 'package:cart3d/app/auth/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class Login extends GetView<Authcontroller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Login'),
            TextButton(
              onPressed: () {
                Get.toNamed('/signup');
              },
              child: Text('SignUP'),
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
