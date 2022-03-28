// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/components/buttons.dart';
import 'package:travelapp/components/customTextField.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/controllers/colorcontroller.dart';
import 'package:travelapp/controllers/textcontroller.dart';
import 'package:travelapp/controllers/usercontroller.dart';
import 'package:travelapp/screens/login.dart';
import 'package:travelapp/utils/storage.dart';
import 'package:travelapp/utils/utils.dart';
import 'package:travelapp/widgets/snackbar.dart';

class Profile extends StatelessWidget {
  static const id = '/profile';
  final userController = Get.put(UserController());
  final textController = Get.put(TextController());

  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final textController = Get.find<TextController>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: null,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                SizedBox(
                  height: size.height * 0.08, //only for user profile
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Container(
                    height: size.height * 0.6, //user profile
                    // height: size.height * 0.7, //pros profile
        
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
                              color: const Color.fromARGB(255, 255, 255, 255),
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
                              margin: EdgeInsets.only(top: size.height * 0.08),
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.002,
                                    ),
                                    Center(
                                      child: Obx(
                                        () {
                                          if (userController.user.isEmpty) {
                                            return Text(
                                              'username',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 21.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            );
                                          }
                                          return Text(
                                            user!.email.toString(),
                                            // userController.user[0].userName
                                            //     .toUpperCase(),
                                            style: GoogleFonts.montserrat(
                                              fontSize: 21.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
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
                                          padding: EdgeInsets.only(left: 20.0),
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
                                            padding: EdgeInsets.only(left: 16.0),
                                            child: Icon(
                                              Icons.person,
                                              size: 25.0,
                                              color: Colors.purpleAccent,
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 16.0),
                                              child: Obx(
                                                () {
                                                  if (userController.user.isEmpty) {
                                                    return Text(
                                                      'userName',
                                                      style: GoogleFonts.montserrat(
                                                        fontSize: 18.0,
                                                        color: Colors.black,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    );
                                                  }
                                                  return Text(
                                                    userController.user[0].name!,
                                                    style: GoogleFonts.montserrat(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                      // fontWeight: FontWeight.bold,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
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
                                            padding: EdgeInsets.only(left: 16.0),
                                            child: Icon(
                                              Icons.phone,
                                              size: 25.0,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 16.0),
                                              child: Obx(
                                                () {
                                                  if (userController.user.isEmpty) {
                                                    return Text(
                                                      'phone number',
                                                      style: GoogleFonts.montserrat(
                                                        fontSize: 18.0,
                                                        color: Colors.black,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    );
                                                  }
                                                  return Text(
                                                    '${userController.user[0].phoneNo}',
                                                    style: GoogleFonts.montserrat(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                      letterSpacing: 1.3,
                                                      // fontWeight: FontWeight.bold,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
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
                                            padding: EdgeInsets.only(left: 16.0),
                                            child: Icon(
                                              Icons.email,
                                              size: 25.0,
                                              color: Colors.orangeAccent,
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 16.0),
                                              child: Obx(
                                                () {
                                                  if (userController.user.isEmpty) {
                                                    return Text(
                                                      'email',
                                                      style: GoogleFonts.montserrat(
                                                        fontSize: 18.0,
                                                        color: Colors.black,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    );
                                                  }
                                                  return Text(
                                                    userController.user[0].email!,
                                                    style: GoogleFonts.montserrat(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                      // fontWeight: FontWeight.bold,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
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
                          child: Obx(
                            () {
                              if (userController.user.isEmpty) {
                                return const CircleAvatar(
                                  radius: 55.0,
                                  backgroundColor: kSecondaryColor,
                                  // backgroundImage:
                                  //     const AssetImage('images/person.png'),
                                );
                              }
        
                              return CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.teal,
                                backgroundImage: userController.user[0].profileUrl ==
                                        null
                                    ? const AssetImage('images/person.png')
                                    : Image.network(
                                        userController.user[0].profileUrl!,
                                        loadingBuilder: (context, child, progress) {
                                          if (progress == null) return child;
                                          return const CircularProgressIndicator(
                                            color: kSecondaryColor,
                                          );
                                        },
                                      ).image,
                              );
                            },
                            // child: CircleAvatar(
                            //   radius: 55.0,
                            //   backgroundColor: Colors.redAccent,
                            // ),
                          ),
                        ),
                        Positioned(
                          top: 110.0,
                          left: 100.0,
                          right: 35.0,
                          child: GetX<ColourController>(
                              init: ColourController(),
                              builder: (colourController) {
                                return CircleAvatar(
                                  radius: 12,
                                  backgroundColor: colourController.color,
                                  child: GestureDetector(
                                    child: const Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.black,
                                      size: 17,
                                    ),
                                    onTap: () async {
                                      colourController.changeColour(Colors.white);
                                      try {
                                        final pickedImage = ImagePicker();
                                        final pickedFile = await pickedImage
                                            .pickImage(source: ImageSource.gallery);
        
                                        File file = File(pickedFile!.path);
        
                                        if (file == null) {
                                          colourController
                                              .changeColour(Colors.white54);
                                          return;
                                        }
        
                                        colourController.changeColour(Colors.white54);
        
                                        // String fileName = file.files.single.name;
                                        // String path = file.files.single.path;
                                        bool uploaded = await storage.uploadImage();
        
                                        if (uploaded) {
                                          getSnackBar(
                                              title: 'SUCCESS!',
                                              message:
                                                  'Your Profile Picture was updated');
                                        } else {
                                          getSnackBar(
                                              title: 'ERROR!',
                                              message:
                                                  'Your Profile Picture could not be updated');
                                        }
                                      } catch (e) {
                                        print(e);
                                        colourController.changeColour(Colors.white54);
                                      }
                                    },
                                  ),
                                );
                              }),
                        ),
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => EditProfile()),
                            // );
                            showBottomSheet(
                              // isScrollControlled: true,
                              elevation: 4.0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(26.0),
                                  topRight: Radius.circular(26.0),
                                ),
                              ),
                              // backgroundColor: Color(0xFF0E0E0F),
                              backgroundColor: kTextfieldColor,
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 16.0),
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
                                        // height: size.height * 0.3,
                                        // width: screenWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 8.0),
                                                child: CustomTextField(
                                                  hintText: 'Username',
                                                  icon: Icons.person,
                                                  textController:
                                                      textController.nameController,
                                                  isNumber: false,
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              CustomTextField(
                                                hintText: 'Phone Number',
                                                icon: Icons.phone,
                                                textController:
                                                    textController.emailController,
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
                                            textController.emailController.clear();
                                            textController.emailController.clear();
                                            Get.back();
                                          },
                                          color: kPrimaryColor,
                                          height: 55.0,
                                          text: 'Cancel',
                                          width: 160.0,
                                        ),
                                        CustomButton(
                                          ontap: () {
                                            textController.emailController.clear();
                                            textController.emailController.clear();
                                            Get.back();
                                          },
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator(
                                    color: kPrimaryColor,
                                    backgroundColor: Colors.white,
                                  ),
                                ],
                              ),
                            );
                            Get.toNamed(LogInScreen.id);
                          },
                          text: 'Sign Out',
                          height: 55.0,
                          width: 160.0,
                          color: Colors.red.shade500),
                    ])
              ]),
            );
          }
        ));
  }
}
