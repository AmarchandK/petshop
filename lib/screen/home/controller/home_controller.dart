import 'package:get/get.dart';
import 'package:petvillage/screen/home/model/address_model.dart';
import 'package:petvillage/screen/login/service/login_service.dart';
import '../../../constant/const_string.dart';

class HomeController extends GetxController {
  String userId = "";
  Address? address;

  @override
  void onInit() {
    super.onInit();
    ConstString.getId().then((value) {
      userId = value ?? "";
    });
    getAddress();
  }

  Future<void> getAddress() async {
    String? email = await ConstString.getEmail();
    address = await LoginService.fetchCustomerDetails(
      email: email ?? "",
      isSwitch: false,
    );
    update();
  }
}
