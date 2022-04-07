import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp/authentication/userauthentication.dart';
import 'package:travelapp/model/database.dart';
import 'package:travelapp/navigationtab/profile.dart';
import 'package:travelapp/widgets/snackbar.dart';

editProfile() async {
  if (textController.phoneController.text.trim().isEmpty &&
      textController.nameController.text.trim().isEmpty) {
    Get.back();
    return;
  } else if (textController.phoneController.text.trim().isEmpty) {
    Get.back();
    await usersCollection.doc(user!.uid).update({
      'name': textController.nameController.text.trim(),
    });
    await database.getCurrentUserData();
    getSnackBar(
        title: 'SUCCESS!',
        message: 'Your username was changed',
        color: Colors.green.shade300);
    textController.phoneController.clear();
    textController.nameController.clear();
    return;
  } else if (textController.nameController.text.trim().isEmpty) {
    if (textController.phoneController.text.trim().length != 10) {
      Get.back();
      getSnackBar(
          title: 'ERROR!',
          message: 'Invalid Phone Number',
          color: Colors.red.shade300);
      textController.phoneController.clear();
      textController.nameController.clear();
      return;
    }

    String phoneNo;
    try {
      phoneNo = textController.phoneController.text.trim();
    } catch (e) {
      Get.back();
      getSnackBar(
          title: 'ERROR!',
          message: 'Invalid Phone Number',
          color: Colors.red.shade300);
      textController.phoneController.clear();
      textController.nameController.clear();
      return;
    }
    await usersCollection.doc(user!.uid).update({
      'phoneNo': textController.phoneController.text.trim(),
    });
    await database.getCurrentUserData();

    print('phoneNo: $phoneNo');
    getSnackBar(
        title: 'SUCCESS!',
        message: 'Your phone number was changed',
        color: Colors.green.shade300);
    textController.phoneController.clear();
    textController.nameController.clear();
    return;
  } else {
    if (textController.phoneController.text.trim().length != 10) {
      Get.back();
      getSnackBar(
          title: 'ERROR!',
          message: 'Invalid Phone Number',
          color: Colors.red.shade300);
      textController.phoneController.clear();
      textController.nameController.clear();
      return;
    }

    String phoneNo;
    try {
      phoneNo = textController.phoneController.text.trim();
    } catch (e) {
      Get.back();
      getSnackBar(
          title: 'ERROR!',
          message: 'Invalid Phone Number',
          color: Colors.red.shade300);
      textController.phoneController.clear();
      textController.nameController.clear();
      return;
    }
    Get.back();
    await usersCollection.doc(user!.uid).update({
      'name': textController.nameController.text.trim(),
      'phoneNo': textController.phoneController.text.trim(),
    });
    await database.getCurrentUserData();

    getSnackBar(
        title: 'SUCCESS!',
        message: 'Your profile was updated',
        color: Colors.green.shade300);
    textController.phoneController.clear();
    textController.nameController.clear();
    return;
  }
}
