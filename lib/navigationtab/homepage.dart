import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:travelapp/components/customTextField.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/model/usermodel.dart';

class HomePage extends StatefulWidget {
  static const id = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final List<String> categoryName = [
      'Pokhara',
      'Mustang',
      'Lumbini',
      'Kanyam',
      'Taplejung',
      'Mirik',
      'Sikkim',
      'Karnali',
      'GOA',
      'Bhutan',
      'Haridwar',
      'Koshi',
    ];

    // final List<String> categoryImages = [
    //   "assets/images/img-1.jpg",
    //   "assets/images/img-2.jpg",
    //   "assets/images/img-3.jpg",
    //   "assets/images/img-4.jpg",
    //   "assets/images/img-5.jpg",
    //   "assets/images/img-6.jpg",
    //   "assets/images/img-7.jpg",
    //   "assets/images/img-8.jpg",
    //   "assets/images/img-9.jpg",
    //   "assets/images/img-10.jpg",
    //   "assets/images/paris.jpg",
    //   "assets/images/img-12.jpg",
    // ];

    final List<int> prices = [
      120,
      270,
      340,
      500,
      450,
      700,
      120,
      456,
      320,
      780,
      111,
      700
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: const [
                  CategoryPageHeader(),
                  CategoryUserImage(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                icon: Icons.search,
                hintText: "Type to Search",
                textController: searchController,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    itemCount: categoryName.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        color: kPrimaryColor,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 5),
                            child: Text(
                              categoryName[index],
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 19),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: StaggeredGridView.countBuilder(
                    itemCount: categoryName.length,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 300,
                        height: 200,
                        decoration: const BoxDecoration(
                          // backgroundBlendMode: BlendMode.colorBurn,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: kSecondaryColor,
                          // image: DecorationImage(
                          //     image: AssetImage(categoryImages[index]),
                          //     fit: BoxFit.cover,
                          //     colorFilter: ColorFilter.mode(
                          //         Colors.red.withOpacity(0.5),
                          //         BlendMode.overlay)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20.0, left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 2,
                                // child: Padding(
                                //   padding: const EdgeInsets.only(left: 8.0),
                                child: Text(categoryName[index],
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      // fontWeight: FontWeight.bold,
                                    )),
                                // ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 5.0),
                              //   child:
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: const StadiumBorder()),
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    '\$${prices[index]}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              // )
                            ],
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) {
                      return StaggeredTile.count(1, index.isOdd ? 1.2 : 1.6);
                    }),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 0.2),
            ]),
        child: BottomNavigationBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: kPrimaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_mall_outlined, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined, color: Colors.grey),
            label: '',
          ),
        ]),

        // )
        // child: ClipRRect(
        //   borderRadius: const BorderRadius.only(
        //     topLeft: Radius.circular(30.0),
        //     topRight: Radius.circular(30.0),
        //   ),

        // ),
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
