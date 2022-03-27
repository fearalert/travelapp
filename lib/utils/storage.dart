import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:travelapp/model/usermodel.dart';
import 'package:travelapp/utils/utils.dart';

UserModel userModel = UserModel();
Storage storage = Storage();

class Storage {
  File? image;
  String? imageUrl;
  final instance = FirebaseStorage.instance;
  Reference ref = FirebaseStorage.instance
      .ref('userprofileimages/${DateTime.now().millisecondsSinceEpoch}')
      .child('${userModel.id}')
      .child('${userModel.id}.jpg');

  Future uploadImage() async {
    try {
      ListResult? listResult;
      String? fileName;
      try {
        listResult = await ref.listAll();
        if (listResult.items.isNotEmpty) {
          fileName = listResult.items[0].name;
          deleteFile(fileName);
        }
        await ref.putFile(image!);
        // imageUrl = await imgUrl(fileName);
      } on PlatformException catch (error) {
        print(error);
      }
      String dateTime = DateTime.now()
          .toString()
          .replaceAll('.', '')
          .replaceAll(':', '')
          .replaceAll('-', '')
          .replaceAll(' ', '');

      imageUrl = await imgUrl(fileName);
      print(imageUrl);
      // uploadPlaceController.imgUrlController.text = imageUrl!;

      userAuthentication.postDetailsToFirestore();
      // return true;
    } catch (e) {
      print(e);
      // return false;
    }
  }

  deleteFile(String fileName) {
    try {
      instance
          .ref('userprofileimages/${DateTime.now().millisecondsSinceEpoch}')
          .child('${userModel.id}')
          .child('${userModel.id}.jpg')
          .delete();
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  Future<String> imgUrl(String? name) async {
    try {
      return await instance
          .ref('userprofileimages/${DateTime.now().millisecondsSinceEpoch}')
          .child('${userModel.id}')
          .child('${userModel.id}.jpg')
          .getDownloadURL();
    } catch (e) {
      print(e);
      return 'error';
    }
  }
}
