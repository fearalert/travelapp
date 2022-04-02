import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/components/customTextField.dart';
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
                                backgroundImage: NetworkImage(data['imgUrl']),
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

              // StreamBuilder(
              //   stream: database.getPackages(),
              //   builder: (context, snapshot) {
              //     List packages = snapshot.data;
              //     return StaggeredGridView.countBuilder(
              //         itemCount: packages.length,
              //         crossAxisCount: 2,
              //         crossAxisSpacing: 10,
              //         mainAxisSpacing: 12,
              //         itemBuilder: (context, index) {
              //           return Container(
              //             width: 300,
              //             height: 200,
              //             decoration: const BoxDecoration(
              //               // backgroundBlendMode: BlendMode.colorBurn,
              //               borderRadius: BorderRadius.all(Radius.circular(20)),
              //               color: kSecondaryColor,
              //               // image: DecorationImage(
              //               //     image: AssetImage(categoryImages[index]),
              //               //     fit: BoxFit.cover,
              //               //     colorFilter: ColorFilter.mode(
              //               //         Colors.red.withOpacity(0.5),
              //               //         BlendMode.overlay)),
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.only(
              //                   bottom: 20.0, left: 5, right: 5),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                 crossAxisAlignment: CrossAxisAlignment.end,
              //                 children: [
              //                   Expanded(
              //                     flex: 2,
              //                     // child: Padding(
              //                     //   padding: const EdgeInsets.only(left: 8.0),
              //                     child: Text(categoryName[index],
              //                         style: GoogleFonts.poppins(
              //                           fontSize: 20,
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.w500,
              //                           // fontWeight: FontWeight.bold,
              //                         )),
              //                     // ),
              //                   ),
              //                   // Padding(
              //                   //   padding: const EdgeInsets.only(right: 5.0),
              //                   //   child:
              //                   ElevatedButton(
              //                     style: ElevatedButton.styleFrom(
              //                         primary: Colors.white,
              //                         shape: const StadiumBorder()),
              //                     onPressed: () {
              //                       Get.off(
              //                         const PackageDetail(),
              //                       );
              //                     },
              //                     child: Padding(
              //                       padding: const EdgeInsets.only(top: 2),
              //                       child: Text(
              //                         '\Rs${prices[index]}',
              //                         style: const TextStyle(color: Colors.black),
              //                       ),
              //                     ),
              //                   ),
              //                   // )
              //                 ],
              //               ),
              //             ),
              //           );
              //         },
              //         staggeredTileBuilder: (index) {
              //           return StaggeredTile.count(1, index.isOdd ? 1.2 : 1.6);
              //         });

              //    }
              // )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   decoration: const BoxDecoration(
      //       borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(30.0),
      //         topRight: Radius.circular(30.0),
      //       ),
      //       // ignore: prefer_const_literals_to_create_immutables
      //       boxShadow: [
      //         BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 0.2),
      //       ]),
      //   child: BottomNavigationBar(items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home_filled,
      //         color: kPrimaryColor,
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite, color: Colors.grey),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.local_mall_outlined, color: Colors.grey),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person_outlined, color: Colors.grey),
      //       label: '',
      //     ),
      //   ]),

      //   // )
      // child: ClipRRect(
      //   borderRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(30.0),
      //     topRight: Radius.circular(30.0),
      //   ),

      // ),
      // ),
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
