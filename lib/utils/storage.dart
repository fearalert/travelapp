import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:travelapp/main.dart';
import 'package:travelapp/model/database.dart';
import 'package:travelapp/model/usermodel.dart';
import 'package:travelapp/navigationtab/profile.dart';
import 'package:travelapp/utils/utils.dart';

Storage storage = Storage();

class Storage {
  File? image;
  String? imageUrl;
  final instance = FirebaseStorage.instance;
  Reference reference = FirebaseStorage.instance
      .ref('userprofileimages/${DateTime.now().millisecondsSinceEpoch}')
      .child(user!.uid)
      .child('${userDetail.name}.jpg');

  Future uploadImage() async {
    try {
      ListResult? listResult;
      String? fileName;
      try {
        listResult = await reference.listAll();
        if (listResult.items.isNotEmpty) {
          fileName = listResult.items[0].name;
          deleteFile(fileName);
        }
        await reference.putFile(image!);
        // imageUrl = await imgUrl(fileName);
      } on PlatformException catch (error) {
        print(error);
      }
      // String dateTime = DateTime.now()
      //     .toString()
      //     .replaceAll('.', '')
      //     .replaceAll(':', '')
      //     .replaceAll('-', '')
      //     .replaceAll(' ', '');
      String url = await reference.getDownloadURL();
      print(url);
      // imageUrl = await imgUrl(fileName);
      // print(imageUrl);
      registrationController.profileController.text = url;
      await usersCollection.doc(user!.uid).update({
        'profileUrl': url,
      });
      // return true;
    } catch (e) {
      print(e);
      print('aaa');
      // return false;
    }
  }

  deleteFile(String fileName) {
    try {
      instance
          .ref('userprofileimages/${DateTime.now().millisecondsSinceEpoch}')
          .child(user!.uid)
          .child('${userDetail.name}.jpg')
          .delete();
    } catch (e) {
      print(e);
      print('object');
      return 'error';
    }
  }

  Future<String> imgUrl(String? name) async {
    try {
      return await instance
          .ref('userprofileimages/${DateTime.now().millisecondsSinceEpoch}')
          .child(user!.uid)
          .child('${userDetail.name}.jpg')
          .getDownloadURL();
    } catch (e) {
      print(e);
      print('o');
      return 'error';
    }
  }
}
