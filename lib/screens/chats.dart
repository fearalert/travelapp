

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter/services.dart';
import 'package:travelapp/authentication/userauthentication.dart';
import 'package:travelapp/model/database.dart';
import 'package:travelapp/navigationtab/homepage.dart';
import 'package:travelapp/navigationtab/mypackages.dart';
import 'package:travelapp/screens/welcome.dart';

import '../constants/constants.dart';
import 'homescreen.dart';


final _firestore = FirebaseFirestore.instance;
User? loggedInuser;
final focusNode = FocusNode();

class ChatScreen extends StatefulWidget {

 final String packageName;
  ChatScreen({Key? key, required this.packageName});
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
  final controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;
  var messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
   
  }

  

  Future<bool> onBackPress() {
  
      Navigator.pop(context);


    return Future.value(false);
  }

  @override


  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInuser = user;
        print(loggedInuser);
      }
    } catch (e) {
      print(e);
    }
  }

 

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:const  Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () {
            Get.back();
             Get.toNamed(MainScreen.id);
          },
        ),
       
        title: const Text('Messages', style: TextStyle(color: Colors.black87,),),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: onBackPress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(packageName: widget.packageName.toString()),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  
                  decoration: const BoxDecoration(
                      // border:  Border(
                      //     top:
                      //          BorderSide(color: Colors.blueGrey, width: 0.5)),
                      color: Colors.white),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  
                      Flexible(
                        child: TextField(
                          
                          textInputAction: TextInputAction.send,
                          keyboardType: TextInputType.multiline,
                          focusNode: focusNode,
                          onSubmitted: (value) {
                            controller.clear();
                            database.sendMessage(messageText, widget.packageName);
                          },
                          maxLines: null,
                          controller: controller,
                          onChanged: (value) {
                            messageText = value;
                          },
                      decoration: InputDecoration(
                           hintText: '    Type Something...',
                             hintStyle: TextStyle(color: Color.fromARGB(255, 31, 31, 32)),
                            fillColor: Color.fromARGB(255, 227, 219, 219),
                            filled: true,
                            
                            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 15.0),
                                                                                   
                        ),
                      ),
                      Material(
                        child:  Container(
                          margin:  const EdgeInsets.symmetric(horizontal: 8.0),
                          child:  IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              controller.clear();
                             database.sendMessage(messageText, widget.packageName);

                            },
                            color: Colors.blueGrey,
                          ),
                        ),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
               Container(),
            ],
          ),
        ),
      ),
    );
  }


}

String giveUsername(String email) {
  return email.replaceAll(new RegExp(r'@g(oogle)?mail\.com$'), '');
}

class MessagesStream extends StatelessWidget {
  final String packageName;
  const  MessagesStream({Key?key, required this.packageName});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages').doc(user!.uid.toString()).collection(packageName)
          .orderBy("time", descending: true)
          .snapshots()  ,
      builder: (context, snapshot) {
        // If we do not have data yet, show a progress indicator.
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      // if(snapshot.hasData){
      //   print(snapshot.data);
      // }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children:snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return  MessageBubble(
            sender: data['userName'],
            text: data['message'],
            timestamp: data['time'],
            isMe: loggedInuser!.uid == data['uid'],
          );
        }).toList(),
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.timestamp, this.isMe});
  final String? sender;
  final String? text;
  final Timestamp? timestamp;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp!.seconds * 1000);
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
         
          Material(
            borderRadius: isMe!
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  )
                : const  BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
            elevation: 5.0,
            color:
                isMe! ?  Color(0xff1F72F6): Colors.grey ,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment:
                    isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    '$text',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: isMe! ? Colors.white : Colors.black54,
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
          Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      "${DateFormat('h:mm a').format(dateTime)}",
                      style: TextStyle(
                        fontSize: 9.0,
                        color: isMe!
                            ? Colors.black87.withOpacity(0.5)
                            : Colors.black54.withOpacity(0.5),
                      ),
                    ),
                  ),
        ],
      ),
    );
  }
}
