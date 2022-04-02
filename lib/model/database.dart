import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travelapp/authentication/userauthentication.dart';
import 'package:travelapp/model/paymentmodel.dart';
import 'package:travelapp/model/placemodel.dart';
import 'package:travelapp/model/usermodel.dart';
import 'package:travelapp/utils/utils.dart';
import 'package:travelapp/widgets/packages.dart';
import 'package:uuid/uuid.dart';

DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference usersReference = databaseReference.child('users');
CollectionReference requestedPackage =
    FirebaseFirestore.instance.collection('requestedPackage');
Stream<QuerySnapshot> requestPackageStream =
    FirebaseFirestore.instance.collection('requestedPackage').snapshots();

class Database {
  Future<void> getCurrentUserData() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userDetail = UserModel.fromMap(value.data());
      print(value.data());
    });
  }

  Future<void> requestPackage(
      DateTime? date,
      int people,
      // String paymentId,
      String userId,
      String packageId,
      String packageName,
      String packageImg) {
    const uuid = Uuid();
    String uid = uuid.v4();
    String idPayment = uuid.v4();
    // Call the user's CollectionReference to add a new user
    return requestedPackage
        .doc(uid)
        .set({
          'date': date,
          'people': people,
          'paymentId': idPayment,
          'userId': userId,
          'packageId': packageId,
          'packageName': packageName,
          'packageImg': packageImg,
          'status': 'pending',
          // 'price': placesDetails.price,
          'requestedId': uid,
          'userEmail': userDetail.email,
          'userPhone': userDetail.phoneNo,
          'userName': userDetail.name,
        }, SetOptions(merge: true))
        .then((value) => print("Requested Successfully"))
        .catchError((error) => print("Failed to request the package: $error"));
  }
  // Stream<List<PlacesDetails>> getPackages() {
  //   return FirebaseFirestore.instance
  //       .collection('packages')
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs
  //         .map((doc) => PlacesDetails.fromMap(doc.data()))
  //         .toList();
  //   });
  // }

  Future<void> deleteUser(String requestId) {
    return requestedPackage
        .doc(requestId)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> addPayment(Map<String, dynamic> data) {
// final paymentRef = FirebaseFirestore.instance.collection('payments').withConverter<PaymentSuccessModel>(
//       fromFirestore: (snapshot, _) => PaymentSuccessModel.fromMap(snapshot.data()!),
//       toFirestore: (paymentsuccessmodel, _) => paymentsuccessmodel.toMap(),
//     );

    //    return  paymentRef.add(
    //  data);

    return FirebaseFirestore.instance.collection('payments').doc().set(data);
  }
}

Database database = Database();
