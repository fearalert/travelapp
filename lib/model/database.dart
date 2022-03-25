import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelapp/model/usermodel.dart';
import 'package:travelapp/utils/utils.dart';

class Database {
  Future getCurrentUserData() async {
    final firebaseUser = user;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
  }
}
