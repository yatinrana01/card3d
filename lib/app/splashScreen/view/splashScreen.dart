import 'package:cart3d/app/splashScreen/controller/splashcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends GetView<Splashcontroller>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
