import 'dart:developer';
import 'package:get/get.dart';
import 'package:petvillage/constant/const_string.dart';
import 'package:petvillage/constant/server_client.dart';
import '../model/orders_model.dart';

class OrdersController extends GetxController {
  List<MyOrders> myOrders = [];
  bool isLoading = false;

  Future<void> getMyOrders() async {
    try {
      isLoading = true;
      update();
      String userId = await ConstString.getId() ?? '';
      List response = await ServerClient.get(ConstString.myOrder + userId);
      log("Response in order is $response and url is ${ConstString.myOrder + userId}");
      
      if (response.first >= 200 && response.first < 300) {
        myOrders.clear();
        for (var item in response.last) {
          myOrders.add(MyOrders.fromJson(item));
        }
        update();
        log("order list length is ${myOrders.length}");
      }
    } catch (e) {
      log("error in getMyOrders $e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
