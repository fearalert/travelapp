import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/model/usermodel.dart';
import 'package:travelapp/utils/utils.dart';

DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference usersReference = databaseReference.child('users');
DatabaseReference adminReference = databaseReference.child('admins');
DatabaseReference requestRefrence =
    FirebaseDatabase.instance.reference().child('requests');

final Stream<QuerySnapshot> requestStream =
    FirebaseFirestore.instance.collection('requests').snapshots();

int? userRequestCounter;

String? newRequestKey;

class Database {
  final firebaseUser = user;
  String userID = userAuthentication.getUid().toString();

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

  Future<void> totalUsersRequests() async {
    await usersReference
        .child(userAuthentication.getUid().toString())
        .child('requests')
        .once()
        .then((value) {
      // print(value.value);
      if (value.value != null) {
        userRequestCounter = Map.from(value.value).length;
        print(userRequestCounter);
      } else {
        userRequestCounter = 0;
      }
    });
  }

  // void addUserInfo({User? user, Map? userData}) {
  //   usersReference.child(userAuthentication.getUid().toString()).set(userData);
  // }

  // Future<String> saveRequest(
  //     {String? adminID,
  //     String? description,
  //     DateTime? dateTime,
  //     String? service,
  //     String? category,
  //     String? municipality,
  //     String? district,
  //     DateTime? date,
  //     TimeOfDay? time,
  //     String? requestKey}) async {
  //   await totalUsersRequests();
  //   if (userRequestCounter < 3) {
  //     String userID = userAuthentication.getUid().toString();
  //     // Map userInfo = database.getUserInfo();
  //     // userInfo.remove('userName');
  //     // userInfo.remove('userPhoneNo');
  //     Map userInfo = {};
  //     userInfo['requestedBy'] = {'userID': userID};
  //     userInfo['jobDescription'] = description;
  //     userInfo['requestedTo'] = {'proID': adminID};
  //     userInfo['dateTime'] = dateTime.toString();
  //     userInfo['category'] = category;
  //     userInfo['service'] = service;
  //     userInfo['userMunicipality'] = municipality;
  //     userInfo['userDistrict'] = district;
  //     userInfo['date'] = '${date!.year}/${date.month}/${date.day}';
  //     userInfo['time'] = '${formatTime(unformattedTime: time)}';
  //     userInfo['requestKey'] = '$requestKey';
  //     userInfo['state'] = 'pending';
  //     userInfo['isAccepted'] = false;
  //     userInfo['isRatingPending'] = false;

  //     await requestRefrence.child(requestKey).set(userInfo);

  //     await usersReference
  //         .child(userID)
  //         .child('requests')
  //         .child(requestKey)
  //         .set({'requestKey': requestKey});

  //     userRequestCounter++;
  //     await adminReference
  //         .child(adminID!)
  //         .child('requests')
  //         .child(requestKey!)
  //         .set({
  //       'requestKey': requestKey,
  //     });
  //   } else {
  //     print('3 request has already been made');
  //     return 'request-full';
  //   }
  //   await totalUsersRequests();
  //   return 'success';
  // }

  // Future<void> changeRatingState({String? requestKey, bool? state}) async {
  //   await usersReference
  //       .child(userAuthentication.getUid().toString())
  //       .child('requests')
  //       .child(requestKey!)
  //       // .child('isRatingPending')
  //       .update({'isRatingPending': state});
  // }

  // Future<String> getProsName(String proID) async {
  //   DataSnapshot snapshot =
  //       await adminReference.child(proID).child('prosName').once();
  //   return snapshot.value;
  // }

  // Future<void> deleteRequest({String? requestKey}) async {
  //   await usersReference
  //       .child(userID)
  //       .child('requests')
  //       .child(requestKey!)
  //       .remove();

  //   await requestRefrence.child(requestKey).remove();

  //   await totalUsersRequests();
  // }

  // Future<void> cancelRequest({String? requestKey, String? adminID}) async {
  //   try {
  //     await usersReference
  //         .child(userAuthentication.userID)
  //         .child('requests')
  //         .child(requestKey!)
  //         .remove();
  //   } catch (e) {
  //     print(e);
  //   }

  //   try {
  //     await adminReference
  //         .child(proID)
  //         .child('requests')
  //         .child(requestKey)
  //         .remove();
  //   } catch (e) {
  //     print(e);
  //   }

  //   try {
  //     await requestRefrence.child(requestKey).remove();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> cancelOnGoingRequest({String requestKey, String proID}) async {
  //   try {
  //     await usersReference
  //         .child(userAuthentication.userID)
  //         .child('requests')
  //         .child(requestKey)
  //         .remove();
  //   } catch (e) {
  //     print(e);
  //   }
  //   try {
  //     await adminReference
  //         .child(proID)
  //         .child('jobs')
  //         .child(requestKey)
  //         .remove();
  //   } catch (e) {
  //     print(e);
  //   }
  //   try {
  //     await requestRefrence.child(requestKey).remove();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<String> getToken(String proID) async {
  //   DataSnapshot snapshot =
  //       await adminReference.child(proID).child('token').once();

  //   String token = snapshot.value;
  //   return token;
  // }

  // Future<String> getMyToken() async {
  //   DataSnapshot snapshot = await usersReference
  //       .child(userAuthentication.userID)
  //       .child('token')
  //       .once();
  //   String token = snapshot.value;
  //   return token;
  // }

  // void saveToken(String token) async {
  //   await usersReference
  //       .child(userAuthentication.userID)
  //       .update({'token': token});
  // }

  // Stream<Map<String, Chat>> getChatData({String chatID}) {
  //   return messagesRefrence.child(chatID).onValue.map((Event event) {
  //     Map<String, Chat> chatData = {};
  //     try {
  //       Map.from(event.snapshot.value).forEach((key, value) {
  //         chatData[key] = Chat.fromData(value);
  //       });
  //     } catch (e) {}
  //     return chatData;
  //   });
  // }

  // Stream<List<ProsData>> proDataStream({String proID}) {
  //   return adminReference.child(proID).onValue.map((Event event) {
  //     List<ProsData> prosData = [];
  //     // print(event.snapshot.value);
  //     prosData.add(ProsData.fromData(event.snapshot.value));
  //     return prosData;
  //   });
  // }

  Stream<QuerySnapshot> userRequestsStream() {
    // return usersReference.child(userID).child('requests').onValue;
    return FirebaseFirestore.instance
        .doc(userID)
        .collection('requests')
        .snapshots();
  }

  // Stream requestDataStream({String? requestKey}) {
  //   return requestRefrence.child(requestKey!).onValue;
  // }

  // Future<bool> checkAccount(User user) async {
  //   bool accountExists = false;
  //   // Query query = usersReference.orderByChild('uid').equalTo(user.uid);
  //   await usersReference.child(user.uid).once().then((DataSnapshot snapshot) {
  //     if (snapshot.value != null) {
  //       accountExists = true;
  //     } else {
  //       accountExists = false;
  //     }
  //   });
  //   return accountExists;
  // }

  // // Future<bool> checkPhoneNumber(int phoneNo) async {
  // //   print('here');
  // //   bool isAlreadyUsed = true;
  // //   print(phoneNo);
  // //   Query query = usersReference.orderByChild('userPhoneNo').equalTo(phoneNo);
  // //   await query.once().then(
  // //     (DataSnapshot snapshot) {
  // //       if (snapshot.value != null) {
  // //         isAlreadyUsed = true;
  // //       } else {
  // //         isAlreadyUsed = false;
  // //       }
  // //     },
  // //   );
  // //   print(isAlreadyUsed);
  // //   return isAlreadyUsed;
  // // }

  Future<void> addService(
      {String? category, String? serviceName, String? imgUrl}) async {
    Map data = {
      'category': category,
      'service': serviceName,
      'imgUrl': imgUrl,
    };
    await serviceRefrence.child(category!).child(serviceName!).set(data);
  }

  Future<void> updateRatingAndReview(
      {String? adminID,
      String? review,
      double? rating,
      String? category,
      String? service}) async {
    DataSnapshot snapshot =
        await adminReference.child(adminID!).child('avgRating').once();

    double avgRating = (snapshot.value + rating) / 2;
    await adminReference.child(adminID).update(
      {
        'avgRating': avgRating,
      },
    );

    DataSnapshot serviceSnapshot = await serviceRefrence
        .child(category!)
        .child(service!)
        .child('rating')
        .once();

    double avgServiceRating = (serviceSnapshot.value + rating) / 2;
    await serviceRefrence.child(category).child(service).update(
      {
        'rating': avgServiceRating,
      },
    );

    if (review!.isNotEmpty) {
      DatabaseReference ref = adminReference.child(adminID).child('review');
      DatabaseReference key = ref.push();
      await key.set({'review': review});
    }
  }
}

Database database = Database();
