import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconController extends GetxController {
  var icon = Rx<IconData>(Icons.visibility_off);
  IconData get icons => icon.value;

  changeIcon(IconData newIcon) {
    icon.value = newIcon;
  }
}
