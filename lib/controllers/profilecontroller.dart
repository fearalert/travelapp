import 'package:get/get.dart';
import 'package:travelapp/model/usermodel.dart';

class ProfileController extends GetxController {
  var profileData = RxList<UserModel>([]);

  List<UserModel> get profile => profileData;

  @override
  void onInit() {
    super.onInit();
    // (Database().userDataStream());
  }

  @override
  Future<void> onClose() async {
    super.onClose();
  }
}
