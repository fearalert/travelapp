import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelapp/models/database.dart';

class UserAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  String get userID {
    User? user = currentUser;
    return user!.uid;
  }

  Future<String?> signUp({
    String? email,
    String? password,
    int? phoneNo,
    String? name,
  }) async {
    String code;
    try {
      final firebaseUser = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      if (firebaseUser != null) {
        //user created
        Map userData = {
          'userID': firebaseUser.user?.uid,
          'userName': name,
          'userEmail': email,
          'userPhoneNo': phoneNo,
        };

        // usersRefrence.child(firebaseUser.user.uid).set(userData);

        // Database.addUserInfo(user: firebaseUser.user, userData: userData);
        code = 'success';
      } else {
        code = 'error';
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      code = e.code;
    }
    return code;
  }

  Future<String?> signIn({String? email, String? password}) async {
    String? code;
//  if (_formKey.currentState!.validate()) {
    try {
      final firebaseUser = await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);

      // bool? accountExists = await Database.checkAccount(firebaseUser.user);
      // code = accountExists ? 'success' : 'record-not-found';
    } on FirebaseAuthException catch (e) {
      print(e.code);
      code = e.code;
    }

    return code;
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
    print(code);
    return code;
  }

  Future<String?> passwordReset({required String? email}) async {
    String? code;
    try {
      await _auth.sendPasswordResetEmail(email: email!);
    } on FirebaseAuthException catch (e) {
      print(code);
      code = e.code;
    }
    return code;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
