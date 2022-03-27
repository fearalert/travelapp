import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/constants.dart';

class PackageDetail extends StatelessWidget {
  const PackageDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _bottomSheet(context);
        },
        label: const Text(
          'Book Now',
        ),
        icon: const Icon(Icons.book_online_outlined),
        backgroundColor: kPrimaryColor,
      ),
      body: Stack(children: [
        ListView(
          children: <Widget>[
            buildSlider(),
            const SizedBox(height: 20),
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Excitement for 5 days",
                        style: GoogleFonts.cabin(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.bookmark,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.blueGrey[300],
                    ),
                    const SizedBox(width: 3),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pokhara Nepal",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.blueGrey[300],
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Rs. 1000",
                    style: GoogleFonts.abel(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: kPrimaryColor),
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 10),
                const RatingStars(
                  value: 3.5,
                  starCount: 5,
                  starSize: 16,
                ),
                const SizedBox(height: 30),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Details",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: const [
                      Text(
                        "Pellentesque in ipsum id orci porta dapibus. "
                        "Nulla porttitor accumsan tincidunt. Donec rutrum "
                        "congue leo eget malesuada. "
                        "\n\nPraesent sapien massa, convallis a pellentesque "
                        "nec, egestas non nisi. Donec rutrum congue leo eget malesuada. "
                        "Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. "
                        "Sed porttitor lectus nibh. Donec sollicitudin molestie malesuada. "
                        "\nCurabitur arcu erat, accumsan id imperdiet et, porttitor at sem. "
                        "Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui."
                        "Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. "
                        "Sed porttitor lectus nibh. Donec sollicitudin molestie malesuada. "
                        "\nCurabitur arcu erat, accumsan id imperdiet et, porttitor at sem. "
                        "Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui.",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 112, 109, 109)),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 50.0),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}

buildSlider() {
  return SizedBox(
    // padding: EdgeInsets.only(left: 20),
    height: 250.0,

    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      primary: false,
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              "https://th.bing.com/th/id/OIP.dDOhUNRfRwEjkwp0O8ItawHaF1?pid=ImgDet&rs=1",
              height: 250.0,
              width: MediaQuery.of(context).size.width - 40.0,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    ),
  );
}

_bottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext c) {
        return Expanded(
          child: Column(children: [
            ElevatedButton(
                onPressed: () {},
                child: const Center(
                  child: Text('Select date'),
                ))
          ]),
        );
      });
}
