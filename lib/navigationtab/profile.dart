// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/components/buttons.dart';
import 'package:travelapp/components/customTextField.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/controllers/textcontroller.dart';
import 'package:travelapp/controllers/usercontroller.dart';
import 'package:travelapp/model/database.dart';
import 'package:travelapp/model/usermodel.dart';
import 'package:travelapp/screens/login.dart';
import 'package:travelapp/utils/editprofile.dart';
import 'package:travelapp/utils/storage.dart';
import 'package:travelapp/utils/utils.dart';
import 'package:travelapp/widgets/snackbar.dart';

final textController = TextController();

class Profile extends StatefulWidget {
  static const id = '/profile';

  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;
  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      setState(() {
        if (image != null) {
          _image = File(image.path);
        } else {
          getSnackBar(
              title: 'Unable to pick image',
              color: Colors.blueGrey.shade400,
              message: 'No image Selected');
        }
      });

      // final temp = await saveimage(image.path);

    } on PlatformException catch (error) {
      print(error);
      getSnackBar(
          title: 'Unable to pick image',
          color: Colors.blueGrey.shade400,
          message: 'No image Selected');
    }
  }

  Future uploadProfileToCloud() async {
    try {
      await pickImageFromGallery();
      final storage = Storage();
      storage.image = _image;
      storage.uploadImage();
    } on PlatformException catch (e) {
      print(e);
      getSnackBar(
          title: 'Unable to upload image',
          color: Colors.red.shade400,
          message: 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: StreamBuilder<Stream>(
            // stream: usersCollection.doc(user?.uid).snapshots(),
            stream: database.getCurrentUserData().asStream(),
            builder: (ctx, streamSnapshot) {
              if (ConnectionState.waiting == streamSnapshot.connectionState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: SizedBox(
                          height: size.height * 0.6,
                          width: size.width,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  width: size.width,
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 20.0,
                                    left: 20.0,
                                    right: 20.0,
                                  ),
                                  margin: const EdgeInsets.only(top: 80),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, 2),
                                        blurRadius: 10.0,
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: size.height * 0.08),
                                    child: SingleChildScrollView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.002,
                                          ),
                                          Center(
                                              child: Text(
                                            userDetail.name.toString(),
                                            style: GoogleFonts.montserrat(
                                              fontSize: 21.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                          const SizedBox(
                                            width: 120,
                                            height: 20,
                                            child: Divider(
                                              color: Colors.blueGrey,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30.0, left: 20.0),
                                                child: Text(
                                                  'My Information:',
                                                  style: GoogleFonts.raleway(
                                                    fontSize: 20.0,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20.0),
                                                child: SizedBox(
                                                  width: 180,
                                                  child: Divider(
                                                    color: Colors.blueGrey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                              bottom: 8.0,
                                            ),
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 16.0),
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 25.0,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0),
                                                      child: Text(
                                                        userDetail.name
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                              bottom: 8.0,
                                            ),
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 16.0),
                                                  child: Icon(
                                                    Icons.phone,
                                                    size: 25.0,
                                                    color: Colors.teal,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0),
                                                      child: Text(
                                                        userDetail.phoneNo
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                          letterSpacing: 1.3,
                                                          // fontWeight: FontWeight.bold,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // ),
                                          SizedBox(
                                            height: size.height * 0.005,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                              bottom: 8.0,
                                            ),
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 16.0),
                                                  child: Icon(
                                                    Icons.email,
                                                    size: 25.0,
                                                    color: Colors.orangeAccent,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0),
                                                      child: Text(
                                                        userDetail.email
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                          // fontWeight: FontWeight.bold,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // ),
                                          SizedBox(
                                            height: size.height * 0.005,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                left: 45.0,
                                right: 45.0,
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundColor: kSecondaryColor,
                                  backgroundImage: userDetail.profileUrl
                                              .toString() ==
                                          null
                                      ? const NetworkImage(
                                          'https://th.bing.com/th/id/R.e133e625e233464efc722e3f58217179?rik=yFi2QEYkCcm0pw&pid=ImgRaw&r=0')
                                      // FileImage(_image!)
                                      : Image.network(
                                          userDetail.profileUrl.toString(),
                                          loadingBuilder:
                                              (context, child, progress) {
                                            if (progress == null) {
                                              return child;
                                            }
                                            return const CircularProgressIndicator(
                                              color: kPrimaryColor,
                                            );
                                          },
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return const Icon(Icons.flag);
                                          },
                                        ).image,
                                ),
                              ),
                              Positioned(
                                top: 110.0,
                                left: 100.0,
                                right: 35.0,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.tealAccent,
                                  child: GestureDetector(
                                    child: const Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.black,
                                      size: 17,
                                    ),
                                    onTap: () {
                                      uploadProfileToCloud();
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                                color: kSecondaryColor,
                                width: 160.0,
                                height: 55.0,
                                text: 'Edit Profile',
                                ontap: () {
                                  showBottomSheet(
                                    elevation: 4.0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(26.0),
                                        topRight: Radius.circular(26.0),
                                      ),
                                    ),
                                    backgroundColor: kTextfieldColor,
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0),
                                                child: Text(
                                                  'Edit Info',
                                                  style: GoogleFonts.shortStack(
                                                    color: Colors.black,
                                                    fontSize: 24.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 200,
                                            child: Divider(
                                              color: Colors.tealAccent,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: CustomTextField(
                                                        hintText: 'Username',
                                                        icon: Icons.person,
                                                        textController:
                                                            textController
                                                                .nameController,
                                                        isNumber: false,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    CustomTextField(
                                                      hintText: 'Phone Number',
                                                      icon: Icons.phone,
                                                      textController:
                                                          textController
                                                              .phoneController,
                                                      isNumber: false,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CustomButton(
                                                ontap: () {
                                                  textController.nameController
                                                      .clear();
                                                  textController.phoneController
                                                      .clear();
                                                  Get.back();
                                                },
                                                color: kPrimaryColor,
                                                height: 55.0,
                                                text: 'Cancel',
                                                width: 160.0,
                                              ),
                                              const CustomButton(
                                                ontap: editProfile,
                                                color: kPrimaryColor,
                                                height: 55.0,
                                                text: 'Save Changes',
                                                width: 160.0,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                            CustomButton(
                                ontap: () {
                                  userAuthentication.logOut();
                                  Get.dialog(
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        CircularProgressIndicator(
                                          color: kPrimaryColor,
                                          backgroundColor: Colors.white,
                                        ),
                                      ],
                                    ),
                                  );
                                  // Get.offAndToNamed(LogInScreen.id);
                                  Get.offNamedUntil(
                                      LogInScreen.id, (route) => true);
                                },
                                text: 'Sign Out',
                                height: 55.0,
                                width: 160.0,
                                color: Colors.red.shade500),
                          ])
                    ]),
              );
            }));
  }
}
