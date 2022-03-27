import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:travelapp/model/usermodel.dart';
import 'package:travelapp/utils/utils.dart';

DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference usersReference = databaseReference.child('users');

class Database {
  final firebaseUser = user;

  Future getCurrentUserData() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
  }

  // Stream<List<UserModel>> userDataStream() {
  //   return usersReference.child(firebaseUser!.uid).onValue.map((Event event) {
  //     List<UserModel> userData = [];
  //     userData.add(UserModel.fromMap(event.snapshot.value));
  //     return userData;
  //   });
  // }
}

Database database = Database();
