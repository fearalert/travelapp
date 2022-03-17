import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travelapp/model/usermodel.dart';
import 'package:travelapp/navigationtab/homepage.dart';

import '../controllers/registrationcontroller.dart';

// user signin authentication

class UserAuthentication {
  final RegistrationController registrationController =
      RegistrationController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<String?> signIn(String? email, String? password) async {
    try {
      final firebaseUser = await _auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((uid) => {
                print("Login Successful"),
                Fluttertoast.showToast(msg: "Login Sucessful"),
                Get.offAllNamed(HomePage.id)
              });
    } on FirebaseAuthException catch (error) {
      print(error);
      Fluttertoast.showToast(
          msg: "Either password is incorrect\n or the account does not exist.");
    }
    return null;
  }

  Future<String?> signUp(String? email, String? password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((value) => postDetailsToFirestore());
    } on FirebaseAuthException catch (error) {
      print(error);
      Fluttertoast.showToast(msg: 'Error in SignUp. Please try again.');
    }
    return null;
  }

  Future<bool?> isEmailVerified() async {
    User? user = currentUser;
    await user?.reload();
    if (user!.emailVerified) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> reload() async {
    User? user = currentUser;
    return await user?.reload();
  }

  Future<String?> sendEmailVerification({String? email}) async {
    User? user = currentUser;
    String code;
    try {
      await user?.sendEmailVerification();
      code = 'success';
    } on FirebaseAuthException catch (e) {
      code = e.code;
    }
    return code;
  }

  Future<String?> passwordReset({required String? email}) async {
    String? code;
    try {
      await _auth.sendPasswordResetEmail(email: email!);
    } on FirebaseAuthException catch (e) {
      code = e.code;
    }
    return code;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = registrationController.nameController.text;
    userModel.phoneNo = registrationController.phoneController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created Sucessfully");
    print('Registration Sucessful');
    Get.toNamed(HomePage.id);
  }
}
