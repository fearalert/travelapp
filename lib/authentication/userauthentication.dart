import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelapp/model/usermodel.dart';
import 'package:travelapp/main.dart';
import 'package:travelapp/navigationtab/homepage.dart';
import 'package:travelapp/screens/confirmverification.dart';
import 'package:travelapp/widgets/snackbar.dart';

// user signin authentication
final FirebaseAuth _auth = FirebaseAuth.instance;

User? get currentUser => _auth.currentUser;

class UserAuthentication {
  Future<String?> signIn(String? email, String? password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((uid) => {
                print("Login Successful"),
                getSnackBar(
                  title: "Sucessful",
                  message: 'Login Sucessful',
                  color: Colors.green.shade300,
                ),
                // Fluttertoast.showToast(msg: "Login Sucessful"),
                Get.offAllNamed(HomePage.id)
              });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-not-found':
          getSnackBar(
            title: "Error",
            message: 'user not found.',
            color: Colors.red.shade300,
          );
          break;
        case 'wrong-password':
          getSnackBar(
            title: "Error",
            message: 'Password doesnot match.',
            color: Colors.red.shade300,
          );
          break;
        case 'invalid-email':
          getSnackBar(
            title: "Error",
            message: 'Invalid Email.',
            color: Colors.red.shade300,
          );
          break;
        default:
          getSnackBar(
            title: "Error",
            message: 'Something went wrong.',
            color: Colors.red.shade300,
          );
          print(error.code);
      }
      // Fluttertoast.showToast(
      //     msg: "Either password is incorrect\n or the account does not exist.");
    }
    return null;
  }

  Future<String?> signUp(String? email, String? password) async {
    try {
      String? code = await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((value) => postDetailsToFirestore());
      if (code == 'success') {
        sendEmailVerification();
        Get.toNamed(ConfirmEmailVerification.id);
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'email-already-in-use':
          getSnackBar(
            title: "Error",
            message: 'Email already in use.',
            color: Colors.red.shade300,
          );
          break;
        case 'invalid-email':
          getSnackBar(
            title: "Error",
            message: 'Invalid Email.',
            color: Colors.red.shade300,
          );
          break;
        case 'weak-password':
          getSnackBar(
            title: "Error",
            message: 'Weak Password.',
            color: Colors.red.shade300,
          );
          break;
        default:
          getSnackBar(
            title: "Error",
            message: 'Something went wrong.',
            color: Colors.red.shade300,
          );
          print(error.code);
      }
      // print(error);
      // Fluttertoast.showToast(msg: 'Error in SignUp. Please try again.');
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
    String? code;
    try {
      await user?.sendEmailVerification();
      code = 'success';
    } on FirebaseAuthException catch (e) {
      code = e.code;
      switch (e.code) {
        case 'too-many-requests':
          getSnackBar(
            title: "Alert!",
            message:
                'Too many requests. We have blocked all requests from this device due to unusual activity. Try again later.',
            color: Colors.red.shade300,
          );
          break;
        default:
          getSnackBar(
            title: "Error",
            message: 'Something went wrong.',
            color: Colors.red.shade300,
          );
          print(e.code);
      }
    }
    return code;
  }

  Future<String?> passwordReset({required String? email}) async {
    String? code;
    try {
      await _auth.sendPasswordResetEmail(email: email!);
    } on FirebaseAuthException catch (e) {
      code = e.code;
      switch (e.code) {
        case 'user-not-found':
          getSnackBar(
            title: "Error!",
            message: 'user not found.',
            color: Colors.red.shade300,
          );
          break;
        case 'invalid-email':
          getSnackBar(
            title: "Error",
            message: 'Invalid Email.',
            color: Colors.red.shade300,
          );
          break;

        default:
          getSnackBar(
            title: "Error",
            message: 'Something went wrong.',
            color: Colors.red.shade300,
          );
          print(e.code);
      }
    }
    return code;
  }

// Google SignIn Auth
  Future<User?> signInWithGoogle() async {
    try {
      // trigger the authentication dialog display google accounts
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        // Obtain the auth detail from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create A New credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Once the SignIn return the user data from the firebase
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (error) {
      getSnackBar(
        title: "Error",
        message: 'Something went wrong.',
        color: Colors.red.shade300,
      );
      Text(error.toString());
    }
    return null;
  }

  Future<void> logOut() async {
    await GoogleSignIn().signOut();
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
    getSnackBar(
      title: "Congratulations",
      message: 'Account created Sucessfully',
      color: Colors.green.shade300,
    );
    print('Registration Sucessful');
  }
}
