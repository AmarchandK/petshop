import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constant/const_string.dart';
import '../../../constant/routes.dart';
import '../../checkout/nav/view/nav_view.dart';

class SignupService {
  static String apiUrl = 'https://petvillagedubai.com/wc-api/v3/customers';
  static String username = 'ck_d058f2ac46d290f9b8c8b9fbf10ce3a0fb7fc9ef';
  static String password = 'cs_c909011ecca0cc98a6c8688e8b25d51476df2db6';

  static Future<void> signup({required Map<String, dynamic> body}) async {
    String encode = base64Encode(utf8.encode('$username:$password'));
    String basicAuth = 'Basic $encode';
    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': basicAuth,
        },
        body: jsonEncode(body),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await ConstString.setEmail(email: data['customer']['email']);
        await ConstString.setId(id: data['customer']['id'].toString());
        await ConstString.setLogin();
        Routes.pushRemoveUntil(screen: const NavView());
      } else {
        log('Failed to Signup with error $data');
        Get.snackbar(
          "Failed to Signup",
          "${data["errors"][0]["message"]}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      throw Exception('Failed to Signup with error $e');
    }
  }
}
