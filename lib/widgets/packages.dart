import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/components/buttons.dart';
import 'package:travelapp/components/customTextField.dart';
import 'package:travelapp/constants/constants.dart';

class PackageDetail extends StatefulWidget {
  const PackageDetail({Key? key}) : super(key: key);

  @override
  State<PackageDetail> createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
  final _descriptionController = TextEditingController();
  final adultController = TextEditingController();
  DateTime? _pickedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print(widget);
    _pickedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // _bottomSheet(context);
          showModalBottomSheet(
              context: context,
              builder: (BuildContext c) {
                return Container(
                  color: kTextfieldColor,
                  child: Column(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: kTextfieldColor),
                          child: ListTile(
                            // tileColor: Colors.blue,
                            title: Text(
                              "Fill Out Details",
                              style: GoogleFonts.juliusSansOne(
                                  fontSize: 15.0,
                                  letterSpacing: 1.3,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 225.0,
                      child: Divider(
                        thickness: 1,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        textController: adultController,
                        hintText: 'Enter no of peoples',
                        icon: Icons.person,
                        isNumber: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: ListTile(
                          // tileColor: Colors.blue,
                          title: Text(
                            "Date: ${_pickedDate!.year}/${_pickedDate!.month}/${_pickedDate!.day}",
                            style: GoogleFonts.juliusSansOne(
                                fontSize: 15.0,
                                letterSpacing: 1.3,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          onTap: _pickDate,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: ListTile(
                          // tileColor: Colors.blue,
                          title: Text(
                            "Time: ${formatTime(unformattedTime: _selectedTime)}",
                            style: GoogleFonts.juliusSansOne(
                                fontSize: 15.0,
                                letterSpacing: 1.3,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          onTap: _selectTime,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                            ontap: () {},
                            text: 'text',
                            height: 55.0,
                            width: 160.0,
                            color: kPrimaryColor)),
                  ]),
                );
              });
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
            SizedBox(
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
            ),
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

  _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _pickedDate!,
      firstDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      lastDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 29,
      ),
    );
    if (date != null) {
      setState(() {
        _pickedDate = date;
      });
    }
  }

  _selectTime() async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: _selectedTime!);
    // builder: (BuildContext context, Widget child) async {
    //   return MediaQuery(
    //     data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
    //     child: child,
    //   );
    // });

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }
}

String formatTime({TimeOfDay? unformattedTime}) {
  String time = '';

  if (unformattedTime!.hourOfPeriod <= 9) {
    if (unformattedTime.hour == 12) {
      time += '${unformattedTime.hour}';
    } else {
      time += '0${unformattedTime.hourOfPeriod}';
    }
  } else {
    time += '${unformattedTime.hourOfPeriod}';
  }

  if (unformattedTime.minute <= 9) {
    time += ':0${unformattedTime.minute}';
  } else {
    time += ':${unformattedTime.minute}';
  }
  String periodOfDay = unformattedTime.period == DayPeriod.am ? ' am' : ' pm';
  return time + periodOfDay;
}
