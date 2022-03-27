import 'package:flutter/material.dart';

import 'package:travelapp/navigationtab/homepage.dart';
import 'package:travelapp/navigationtab/mypackages.dart';
import 'package:travelapp/navigationtab/profile.dart';

class MainScreen extends StatefulWidget {
  static const id = '/mainScreen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    // FirebaseMessaging.onMessage.listen((message) {
    //   print(message.notification.title);
    // });

    super.initState();
    tabController = TabController(length: 3, vsync: this);
    // notificationHandler.onMessageHandler();
    // resolveToken();
  }

  // resolveToken() async {
  //   try {
  //     String token = await database.getMyToken();
  //     String deviceToken = await FirebaseMessaging.instance.getToken();

  //     if (token == null || token == '' || token != deviceToken) {
  //       // String token = await FirebaseMessaging.instance.getToken();
  //       database.saveToken(deviceToken);
  //       print(deviceToken);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  // final ServiceHandler serviceHandler = ServiceHandler();

  @override
  Widget build(BuildContext context) {
    // Get.put(TextController());
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        // dragStartBehavior: DragStartBehavior.start,
        controller: tabController,
        children: [
          const HomePage(),
          const MyPackages(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xffd17842),
        unselectedItemColor: const Color(0xff4d4f52),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.remove_from_queue), label: "Requests"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            tabController.index = _selectedIndex;
          });
        },
      ),
    );
  }
}
