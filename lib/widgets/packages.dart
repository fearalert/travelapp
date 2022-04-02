import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:travelapp/components/buttons.dart';
import 'package:travelapp/components/customTextField.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/model/database.dart';
import 'package:travelapp/screens/homescreen.dart';
import 'package:travelapp/utils/utils.dart';
import 'package:travelapp/widgets/snackbar.dart';

class PackageDetail extends StatefulWidget {
  final Map<String, dynamic> receivedMap;
  // ignore: use_key_in_widget_constructors
  const PackageDetail({Key? key, required this.receivedMap});

  @override
  State<PackageDetail> createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
  final _descriptionController = TextEditingController();
  final peopleController = TextEditingController();
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
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.back();
                Get.toNamed(MainScreen.id);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ))),
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
                          //  height:  50,
                          width: size.width * 1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: kPrimaryColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 18.0, bottom: 8.0),
                                child: Text(
                                  "Fill Out Details",
                                  style: GoogleFonts.laila(
                                      fontSize: 16.0,
                                      letterSpacing: 1.3,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        textController: peopleController,
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
                        padding: const EdgeInsets.only(top: 18.0),
                        child: CustomButton(
                            ontap: () async {
                              int amount = int.parse(widget.receivedMap['price']
                                  .toStringAsFixed(0));
                              int people = int.parse(peopleController.text);

                              KhaltiScope.of(context).pay(
                                config: PaymentConfig(
                                  amount: amount * 100 * people,
                                  productIdentity:
                                      widget.receivedMap['packageId'],
                                  productName:
                                      widget.receivedMap['packageName'],
                                ),
                                preferences: [
                                  PaymentPreference.khalti,
                                ],
                                onSuccess: (su) async {
                                  // Map<String, dynamic> data = PaymentSucessModel;

                                  await database.requestPackage(
                                      _pickedDate, //date
                                      int.parse(peopleController.text), //people
                                      //  '1235'//amount
                                      user!.uid.toString(), //uuid
                                      '${widget.receivedMap['packageId']}', //packageid
                                      '${widget.receivedMap['packageName']}',
                                      '${widget.receivedMap['imgUrl']}'
                                      //  '${widget.receivedMap['price']}'
                                      );
                                  //  database.addPayment(su);

                                  Get.back();
                                  getSnackBar(
                                      title: 'Successful',
                                      message:
                                          'Your request has been successfully placed',
                                      color: Colors.green.shade300);

                                  // print(su);
                                  const successsnackBar = SnackBar(
                                    content: Text('Payment Successful'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(successsnackBar);
                                },
                                onFailure: (fa) {
                                  const failedsnackBar = SnackBar(
                                    content: Text('Payment Failed'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(failedsnackBar);
                                },
                                onCancel: () {
                                  const cancelsnackBar = SnackBar(
                                    content: Text('Payment Cancelled'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(cancelsnackBar);
                                },
                              );
                            },
                            text: 'Submit',
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
                        '${widget.receivedMap['imgUrl']}',
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
                        '${widget.receivedMap['packageName']}',
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
                        '${widget.receivedMap['locationName']}',
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
                    '${widget.receivedMap['price']} /person',
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
                    children: [
                      Text(
                        '${widget.receivedMap['placeDescription']}',
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 112, 109, 109)),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 50.0),
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
