// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:travelapp/model/chat.dart';
import 'package:travelapp/model/usermodel.dart';
import 'package:uuid/uuid.dart';

import '../authentication/userauthentication.dart';

DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

CollectionReference requestedPackage =
    FirebaseFirestore.instance.collection('requestedPackage');
Stream<QuerySnapshot> requestPackageStream =
    FirebaseFirestore.instance.collection('requestedPackage').where('userId', isEqualTo: user!.uid).snapshots();

     

class Database {
  Future<Stream> getCurrentUserData() async {
    final userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      userDetail = UserModel.fromMap(value.data());
      print(value.data());
    });
    return userData;
  }

  Future<void> requestPackage(
      DateTime? date,
      // TimeOfDay? time,
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
          // 'time': time,
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

  //   Future<String?> getToken() async {
  //   await FirebaseFirestore.instance
  //       .collection('collectionPath')
  //       .doc()
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.data()!['token'];
  //   });
  // }

  void saveToken(String token) async {
    await usersCollection.doc(user!.uid).update({'token': token});
  }

  Future<void> deleteRequest(String requestId) {
    return requestedPackage
        .doc(requestId)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> deleteRequestAfterDate() {
    return requestedPackage
        .where(
          'date',
          isLessThanOrEqualTo: DateTime.now().day,
        )
        .get()
        .then((value) => value.docs.forEach((doc) => doc.reference.delete()));
  }

  Future<void> updatePhoneNo(String userId) {
    return usersCollection
        .doc(userId)
        .update({})
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

  Future<void> sendMessage(String text, String packageName)async{
   final messageRef =  FirebaseFirestore.instance.collection('messages').doc(user!.uid).collection(packageName);
  final message = Chat(
    message: text,
    userName: userDetail.name.toString(),
    time: Timestamp.now(),
    uid: user!.uid,
    
  );

  await messageRef.add(message.toMap());

 }


}

Database database = Database();
