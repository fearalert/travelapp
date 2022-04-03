import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/widgets/packages.dart';

class HomePage extends StatefulWidget {
  static const id = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _packagestream =
      FirebaseFirestore.instance.collection('packages').snapshots();
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(239, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  CategoryPageHeader(),
                  CategoryUserImage(),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // CustomTextField(
              //   icon: Icons.search,
              //   hintText: "Type to Search",
              //   textController: searchController,
              //   isNumber: false,
              // ),
              // const SizedBox(
              //   height: 15,
              // ),

              const SizedBox(
                height: 25,
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
                                borderRadius: BorderRadius.circular(15),
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
                                radius: 25,
                                backgroundImage: Image.network(
                                  data['imgUrl'],
                                  fit: BoxFit.cover,
                                  scale: 1.0,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return const Icon(Icons.do_not_disturb);
                                  },
                                ).image,
                              ),
                              title: Text(data['packageName']),
                              subtitle: Text(data['locationName']),
                              trailing: Text(data['price'].toString()),
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
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: CircleAvatar(
          // backgroundColor: Colors.red[200],
          ),
    );
  }
}
