import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/model/adminmodel.dart';
import 'package:travelapp/model/chat.dart';
import 'package:travelapp/model/usermodel.dart';
import 'package:travelapp/widgets/snackbar.dart';
import 'package:uuid/uuid.dart';

import '../authentication/userauthentication.dart';

DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');
CollectionReference packagesCollection =
    FirebaseFirestore.instance.collection('packages');

CollectionReference requestedPackage =
    FirebaseFirestore.instance.collection('requestedPackage');
CollectionReference favouritesRef =
    FirebaseFirestore.instance.collection('favourites');
Stream<QuerySnapshot> requestPackageStream = FirebaseFirestore.instance
    .collection('requestedPackage')
    .where('userId', isEqualTo: user!.uid)
    .snapshots();

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

//

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

//
  Future<void> deleteRequest(String requestId) {
    return requestedPackage
        .doc(requestId)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

//
  Future<void> deleteRequestAfterDate() {
    return requestedPackage
        .where(
          'date',
          isLessThanOrEqualTo: DateTime.now().day,
        )
        .get()
        .then((value) => value.docs.forEach((doc) => doc.reference.delete()));
  }

//

  Future<void> addPayment(Map<String, dynamic> data) {
    return FirebaseFirestore.instance.collection('payments').doc().set(data);
  }

  Future<void> sendMessage(String text, String packageName) async {
    final messageRef = FirebaseFirestore.instance
        .collection('messages')
        .doc(user!.uid)
        .collection(packageName);
    final message = Chat(
      message: text,
      userName: userDetail.name.toString(),
      time: Timestamp.now(),
      uid: user!.uid,
    );

    await messageRef.add(message.toMap());
  }

//
  Future<String?> getMyToken() async {
    final userQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: user!.uid)
        .get();

    final userQueryDocsSnap = userQuery.docs[0];
    String? token = userQueryDocsSnap.data()['token'];
    return token;
  }

//
  void saveToken(String token) async {
    final userQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: user!.uid)
        .get();
    final userQueryDocsSnap = userQuery.docs[0];
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userQueryDocsSnap.id);
    await userRef.update({'token': token});

    if (kDebugMode) {
      print("Token saved");
    }
  }

//
  getUserName() {
    return userDetail.name;
  }

//
  Future<String?> getToken(String? uid) async {
    final userQuery = await FirebaseFirestore.instance
        .collection('admins')
        .where('id', isEqualTo: uid)
        .get();

    final userQueryDocsSnap = userQuery.docs[0];

    return userQueryDocsSnap.data()['token'];
  }

//
  Future<void> changeRatingState({String? requestKey, bool? state}) async {
    final userQuery = await FirebaseFirestore.instance
        .collection('requestedPackage')
        .where('requestedId', isEqualTo: requestKey)
        .get();

    final userQueryDocsSnap = userQuery.docs[0];
    final userRef = FirebaseFirestore.instance
        .collection('requestedPackage')
        .doc(userQueryDocsSnap.id);
    await userRef.update({'ratingState': state});

    if (kDebugMode) {
      print("Rating state changed");
    }
  }

//
  Future<void> updateRatingAndReview({
    String? packageId,
    String? review,
    double? rating,
  }) async {
    final packageQuery = await FirebaseFirestore.instance
        .collection('packages')
        .where('id', isEqualTo: packageId)
        .get();
    final packageQueryDocsSnap = packageQuery.docs[0];
    final packageRef = FirebaseFirestore.instance
        .collection('users')
        .doc(packageQueryDocsSnap.id);
    await packageRef.update({
      'rating': rating,
      'review': review,
    });

    double avgRating = (packageQueryDocsSnap.data()['rating'] + rating) / 2;
    await packageRef.update({'rating': avgRating});
    if (kDebugMode) {
      print("Rating and review updated");
    }

    if (review!.isNotEmpty) {}
  }

  Future<void> favourites(String documentId, Map data) async {
    await packagesCollection
        .doc(documentId)
        .get()
        .then((value) => print("favourites Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    await favouritesRef.doc(documentId).set(data);

    await favouritesRef
        .doc(documentId)
        .update({'favourite': true, 'userId': user!.uid});
  }

  Future<void> removeFromFavourites(String documentId, Map data) async {
    await favouritesRef
        .doc(documentId)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> sendReview(
      String packageId, double rating, String comment) async {
    double newrating = rating;
    double totalUserRate = await FirebaseFirestore.instance
        .collection('packages')
        .doc(packageId)
        .collection('ratingReviews')
        .get()
        .then((value) => value.size.toDouble());

    var oldavg = await FirebaseFirestore.instance
        .collection('packages')
        .doc(packageId)
        .get()
        .then((value) => value.data()!['avgRating']);

    String a = oldavg.toString();

    double oldavgRating = double.parse(a);

    double newAvgRating =
        ((oldavgRating * totalUserRate) + newrating) / (totalUserRate + 1);
    await FirebaseFirestore.instance
        .collection('packages')
        .doc(packageId)
        .update({'avgRating': newAvgRating});

    await FirebaseFirestore.instance
        .collection('packages')
        .doc(packageId)
        .collection('ratingReviews')
        .add({'rating': rating, 'review': comment, 'userId': user!.uid});
  }
}

Database database = Database();
