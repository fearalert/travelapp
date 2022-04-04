import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/model/placemodel.dart';
import 'package:travelapp/widgets/packages.dart';

final Stream<QuerySnapshot> packagesStream =
    FirebaseFirestore.instance.collection('packages').snapshots();

class SearchFunctionality extends SearchDelegate<String> {
  SearchFunctionality({Key? key});
  List<String?> data = [];
  String? selectedResult;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = " ";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(selectedResult!),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String?> datafromCloud = [];
    query.isEmpty
        ? datafromCloud = data
        : datafromCloud.addAll(data.where(
            (element) => element.toString().contains(query.toLowerCase())));

    return StreamBuilder<QuerySnapshot>(
      stream: packagesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Loading"));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
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
                        offset:
                            const Offset(3, 7), // changes position of shadow
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
                      errorBuilder: (BuildContext context, Object exception,
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
    );
  }
}

class SearchPage extends StatefulWidget {
  static const id = '/search';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Stream<QuerySnapshot> packagestream =
      FirebaseFirestore.instance.collection('packages').snapshots();

  String? searchName = "";

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
              TextField(
                  obscureText: false,
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  onChanged: (val) {
                    setState(() {
                      searchName = val;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: 'Search for a package',
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: (searchName != "")
                      ? firebaseFirestore
                          .collection('packages')
                          .where('placeName', isEqualTo: searchName)
                          .snapshots()
                      : packagestream,
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
