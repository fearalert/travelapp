import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:travelapp/utils/utils.dart';

class Database {
  void addUserInfo({User? user, Map? userData}) {
    usersRefrence.child(user!.uid).set(userData);
  }

  Future<String> getMyToken() async {
    DataSnapshot snapshot = await usersRefrence
        .child(userAuthentication.userID)
        .child('token')
        .once();
    String token = snapshot.value;
    return token;
  }

  Future<bool?> checkAccount(User user) async {
    bool accountExists = false;
    // Query query = usersRefrence.orderByChild('uid').equalTo(user.uid);
    await usersRefrence.child(user.uid).once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        accountExists = true;
      } else {
        accountExists = false;
      }
    });
    return accountExists;
  }

  Future<bool> checkPhoneNumber(int phoneNo) async {
    print('here');
    bool isAlreadyUsed = true;
    print(phoneNo);
    Query query = usersRefrence.orderByChild('userPhoneNo').equalTo(phoneNo);
    await query.once().then(
      (DataSnapshot snapshot) {
        if (snapshot.value != null) {
          isAlreadyUsed = true;
        } else {
          isAlreadyUsed = false;
        }
      },
    );
    print(isAlreadyUsed);
    return isAlreadyUsed;
  }
}
