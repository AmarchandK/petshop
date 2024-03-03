import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petvillage/constant/common_widget.dart';
import 'package:petvillage/constant/const_string.dart';
import 'package:petvillage/constant/server_client.dart';
import 'package:petvillage/screen/home/controller/home_controller.dart';
import '../../home/model/address_model.dart';

class AddressController extends GetxController {
  bool isLoading = false;

  Future<void> updateAddress({
    required String type,
    required Ing address,
  }) async {
    try {
      log("called");
      isLoading = true;
      update();
      Map<String, dynamic> body = {
        "customer": {
          type: address.toJson(),
        }
      };
      String? userId = await ConstString.getId();
      String apiUrl = 'https://petvillagedubai.com/wc-api/v3/customers/$userId';
      List response = await ServerClient.put(apiUrl, data: body);
      if (response.first >= 200 && response.first < 300) {
        await Get.find<HomeController>().getAddress();
        Get.back();
        return;
      }
      Common.snackBar(
        title: "Something went wrong",
        message: "Couldn't update the details",
        backgroundColor: Colors.red,
      );
    } catch (e) {
      log("error is $e");
      Common.snackBar(
        title: "Something went wrong",
        message: "Couldn't update the details",
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}
