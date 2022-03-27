import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/constants.dart';

class MyPackages extends StatelessWidget {
  const MyPackages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text('My Packages',
            style:
                GoogleFonts.laila(fontSize: 24.0, fontWeight: FontWeight.bold)),
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
      body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return ListView(
              children: [
                Column(
                  children: [],
                ),
              ],
            );
          }),
    );
  }
}
