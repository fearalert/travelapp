import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextController extends GetxController {
  TextEditingController emailController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
  }
}
