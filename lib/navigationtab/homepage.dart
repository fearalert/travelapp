import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/model/database.dart';
import 'package:travelapp/screens/favourites.dart';
import 'package:travelapp/screens/login.dart';
import 'package:travelapp/utils/search.dart';
import 'package:travelapp/utils/utils.dart';
import 'package:travelapp/widgets/packages.dart';
import 'package:travelapp/widgets/snackbar.dart';

import '../controllers/usercontroller.dart';

class HomePage extends StatefulWidget {
  static const id = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetxController userCont = Get.put(UserController());

  final Stream<QuerySnapshot> _packagestream =
      FirebaseFirestore.instance.collection('packages').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: kTextfieldColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        CategoryPageHeader(),
                        CategoryUserImage(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(SearchPage.id);
                        },
                        child: Container(
                          height: 45.0,
                          width: 260,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.search),
                                  Text('     Search Here',
                                      style: GoogleFonts.laila(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Explore Packages',
                      style: GoogleFonts.laila(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const Favourite())));
                      },
                      child: Container(
                        height: 45.0,
                        width: 70,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: const Icon(Icons.favorite),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(width: 160, child: Divider()),
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _packagestream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: Text("Loading"));
                    }

                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 20,
                                    offset: const Offset(
                                        3, 7), // changes position of shadow
                                  ),
                                ]),
                            child: ListTile(
                              onTap: () {
                                Get.off(PackageDetail(
                                  receivedMap: data,
                                ));
                              },
                              leading: CircleAvatar(
                                radius: 45,
                                backgroundImage: Image.network(
                                  data['imgUrl'],
                                  fit: BoxFit.cover,
                                  // scale: 1.0,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return const Icon(Icons.do_not_disturb);
                                  },
                                ).image,
                              ),
                              title: Text(data['packageName']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.location_city, size: 12),
                                      Text(data['locationName']),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.monetization_on,
                                        size: 12,
                                      ),
                                      Text(data['price'].toString()),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  database.favourites(data['packageId'], data);
                                  getSnackBar(
                                      color: Colors.green.shade300,
                                      title: 'Sucessful',
                                      message: 'Added to favourites');
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryPageHeader extends StatelessWidget {
  const CategoryPageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Where would\nyou like to travel?',
      style: GoogleFonts.alfaSlabOne(
        fontSize: 26,
        color: Colors.black,
      ),
    );
  }
}

class CategoryUserImage extends StatelessWidget {
  const CategoryUserImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: CircleAvatar(
          child: IconButton(
            onPressed: () {
              userAuthentication.logOut();
              Get.offAndToNamed(LogInScreen.id);
            },
            icon: const Icon(
              Icons.logout_rounded,
              // backgroundColor: Colors.red[200],
            ),
          ),
        ));
  }
}
