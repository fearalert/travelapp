import 'package:get/get.dart';
import 'package:travelapp/model/usermodel.dart';

class ProfileController extends GetxController {
  var profileData = RxList<UserModel>([]);

  List<UserModel> get user => profileData;

  @override
  void onInit() {
    super.onInit();
    profileData.bindStream(UserModel().userDataStream());
  }

  @override
  void onClose() {
    super.onClose();
  }
}
