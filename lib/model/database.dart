import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:travelapp/authentication/userauthentication.dart';
import 'package:travelapp/model/placemodel.dart';
import 'package:travelapp/model/usermodel.dart';
import 'package:travelapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference usersReference = databaseReference.child('users');
 CollectionReference requestedPackage = FirebaseFirestore.instance.collection('requestedPackage');
 Stream<QuerySnapshot> requestPackageStream = FirebaseFirestore.instance.collection('requestedPackage').snapshots();

class Database {
 

  Future getCurrentUserData() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(UserAuthentication().getUid().toString())
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
  }

  Stream<List<UserModel>> userDataStream() {
    return usersReference
        .child(userAuthentication.getUid().toString())
        .onValue
        .map((Event event) {
      List<UserModel> userData = [];
      userData.add(UserModel.fromMap(event.snapshot.value));
      return userData;
    });
  }

Future<void> requestPackage(DateTime? date, int people, String paymentId, String userId, String packageId) {
     const uuid = Uuid();
     String uid = uuid.v4();
      // Call the user's CollectionReference to add a new user
      return requestedPackage.doc(uid)
          .set({
            'date': date,
            'people': people,
            'paymentId': paymentId,
            'userId': userId,
            'packageId': packageId,
            'status': 'pending',
            'requestedId': uid
            
          },SetOptions(merge: true))
          .then((value) => print("Requested Successfully"))
          .catchError((error) => print("Failed to request the package: $error"));
    }
  
Stream<List<PlacesDetails>> getPackages(){
  return FirebaseFirestore.instance.collection('places')
  .snapshots()
  .map((snapshot) {
    return snapshot.docs.map((doc)=> PlacesDetails.fromMap(doc.data())).toList();
});
}

Future<void> deleteUser(String requestId) {
  return requestedPackage.doc(requestId)
    .delete()
    .then((value) => print("User Deleted"))
    .catchError((error) => print("Failed to delete user: $error"));
}



}
Database database = Database();