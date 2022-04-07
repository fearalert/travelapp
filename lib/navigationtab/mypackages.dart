import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/model/database.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:travelapp/screens/chats.dart';
import 'package:travelapp/widgets/snackbar.dart';
import 'package:rating_dialog/rating_dialog.dart';

class MyPackages extends StatefulWidget {
  const MyPackages({Key? key}) : super(key: key);

  @override
  State<MyPackages> createState() => _MyPackagesState();
}

class _MyPackagesState extends State<MyPackages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: Text('My Bookings',
              style: GoogleFonts.laila(
                  fontSize: 24.0, fontWeight: FontWeight.bold)),
          //   actions: [
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {},
          // ),
          // IconButton(
          //   icon: Icon(Icons.more_vert),
          //   onPressed: () {},
          // ),
          // ]
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: requestPackageStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Loading"));
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 20,
                              offset: const Offset(
                                  3, 5), // changes position of shadow
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                backgroundColor: kSecondaryColor,
                                radius: 30,
                                backgroundImage: Image.network(
                                  data['packageImg'],
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return const Icon(Icons.do_not_disturb);
                                  },
                                ).image,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['packageName']),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_month,
                                          size: 12),
                                      Text(DateFormat('yyyy-MM-dd')
                                          .format(DateTime.parse(
                                              data['date'].toDate().toString()))
                                          .toString()),

                                      // Text(data['status'])
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          String? token = await database
                                              .getToken(data['adminId']);
                                          await database.deleteRequest(
                                              data['requestedId']);
                                          getSnackBar(
                                            title: 'Bookings Cancelled',
                                            message:
                                                'Bookings Cancelled by user for ' +
                                                    data['packageName'],
                                            color: Colors.green.shade300,
                                          );
                                          try {
                                            http.post(
                                                Uri.parse(
                                                    'https://fcm.googleapis.com/fcm/send'),
                                                headers: <String, String>{
                                                  'Content-Type':
                                                      'application/json; charset=UTF-8',
                                                  'Authorization': key,
                                                },
                                                body: jsonEncode(
                                                  {
                                                    "notification": {
                                                      "body":
                                                          "Your request was cancelled",
                                                      "title":
                                                          "Request Cancelled",
                                                      "android_channel_id":
                                                          "high_importance_channel"
                                                    },
                                                    "priority": "high",
                                                    "data": {
                                                      "click_action":
                                                          "FLUTTER_NOTIFICATION_CLICK",
                                                      "status": "done"
                                                    },
                                                    "to": token
                                                  },
                                                ));
                                            if (kDebugMode) {
                                              print(
                                                  'FCM request for device sent!');
                                            }
                                          } catch (e) {
                                            if (kDebugMode) {
                                              print(e);
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 40.0,
                                          width: 70.0,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12)),
                                          ),
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(
                                                Icons.cancel,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                              Text(
                                                'Cancel',
                                                style: GoogleFonts.laila(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              )
                                            ],
                                          )),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.off(
                                            ChatScreen(
                                              packageName: data['packageId'],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 40.0,
                                          width: 70.0,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12)),
                                          ),
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(
                                                Icons.chat,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                              Text(
                                                'Chat',
                                                style: GoogleFonts.laila(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              )
                                            ],
                                          )),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            barrierDismissible:
                                                true, // set to false if you want to force a rating
                                            builder: (context) {
                                              return RatingDialog(
                                                initialRating: 1.0,
                                                // your app's name?
                                                title: const Text(
                                                  'Rating Dialog',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                // encourage your user to leave a high rating?
                                                message: const Text(
                                                  'Tap a star to set your rating. Add more description here if you want.',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),

                                                submitButtonText: 'Submit',
                                                commentHint:
                                                    'Set your custom comment hint',
                                                onCancelled: () =>
                                                    print('cancelled'),
                                                onSubmitted: (response) async {
                                                  await database.sendReview(
                                                      data['packageId'],
                                                      response.rating,
                                                      response.comment);

                                                  await database.updateRequest(
                                                      data['requestedId']);
                                                  Get.back();
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 40.0,
                                          width: 70.0,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12)),
                                          ),
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(
                                                Icons.rate_review,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                              Text(
                                                'Rate',
                                                style: GoogleFonts.laila(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              )
                                            ],
                                          )),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Center(
                                child: Text(
                                  'Booked',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              )
                            ]),
                      ),
                    ));
              }).toList(),
            );
          },
        ));
  }
}
