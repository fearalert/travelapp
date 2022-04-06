import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/authentication/userauthentication.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/model/database.dart';
import 'package:travelapp/widgets/packages.dart';
import 'package:travelapp/widgets/snackbar.dart';

class Favourite extends StatefulWidget {
  static const id = '/favourite';
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final Stream<QuerySnapshot> favouriteStream = FirebaseFirestore.instance
      .collection('favourites')
      .doc(user!.uid)
      .collection('newFavourites')
      .where('userId', isEqualTo: user!.uid)
      .snapshots();
  // .where('userId', isEqualTo: user!.uid)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Explore favourites',
            style: GoogleFonts.laila(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: favouriteStream,
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
                                  database.removeFromFavourites(
                                      data['packageId'], data);

                                  getSnackBar(
                                      color: Colors.green.shade300,
                                      title: 'Removed',
                                      message: 'Removed from favourites');
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.grey,
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
