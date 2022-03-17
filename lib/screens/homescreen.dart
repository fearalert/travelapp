import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/navigationtab/homepage.dart';
import 'package:travelapp/navigationtab/mypackages.dart';
import 'package:travelapp/navigationtab/profile.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/mainscreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    // FirebaseMessaging.onMessage.listen((message) {
    //   print(message.notification.title);
    // });

    super.initState();
    tabController = TabController(length: 4, vsync: this);
    // notificationHandler.onMessageHandler();
    // resolveToken();
  }

  // resolveToken() async {
  //   try {
  //     String? token = await Database.getMyToken();
  //     String? deviceToken = await FirebaseMessaging.instance.getToken();

  //     if (token == null || token == '' || token != deviceToken) {
  //       // String token = await FirebaseMessaging.instance.getToken();
  //       Database.saveToken(deviceToken);
  //       print(deviceToken);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  // final ServiceHandler serviceHandler = ServiceHandler();

  @override
  Widget build(BuildContext context) {
    // Get.put(TextController());
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        dragStartBehavior: DragStartBehavior.start,
        controller: tabController,
        children: const [
          HomePage(),
          MyPackages(),
          MyPackages(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: kSecondaryColor,
        unselectedItemColor: kTextfieldColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.grey),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_mall_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            tabController!.index = _selectedIndex;
          });
        },
      ),
    );
  }
}
