import 'package:get/get.dart';
import 'package:travelapp/model/database.dart';
import 'package:travelapp/model/usermodel.dart';

class UserController extends GetxController {
  var userData = RxList<UserModel>([]);

  List<UserModel> get user => userData;

  @override
  void onInit() {
    super.onInit();
    database.getCurrentUserData();
  }
}
