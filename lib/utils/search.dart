import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/widgets/packages.dart';

class SearchPage extends StatefulWidget {
  static const id = '/search';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String search = '';
  final Stream<QuerySnapshot> packagesStream =
      FirebaseFirestore.instance.collection('packages').snapshots();
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(239, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          'Search Page',
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          autofocus: false,
                          obscureText: false,
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            // print(value);
                            // setState(() {
                            //   search = value;
                            // });
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: 'Search Here',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: kPrimaryColor, width: 1.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            search = searchController.text.toString();
                            if (kDebugMode) {
                              print(search);
                            }
                          });
                        },
                        child: const Text('search')),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Results for: $search',
                      style: GoogleFonts.laila(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
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
                  stream: (search != '' && search.isNotEmpty)
                      ? FirebaseFirestore.instance
                          .collection('packages')
                          .where('locationName', isEqualTo: search)
                          // .where('packageName', isEqualTo: search)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('packages')
                          .snapshots(),
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
                                borderRadius: BorderRadius.circular(0),
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
