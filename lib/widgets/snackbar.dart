import 'package:flutter/material.dart';
import 'package:get/get.dart';

void getSnackBar({String? title, String? message, Color? color}) {
  Get.snackbar(
    title!,
    message!,
    backgroundColor: color,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 3),
    borderRadius: 10.0,
  );
}
