import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petvillage/screen/home/model/address_model.dart';
import '../../../constant/const_string.dart';
import '../../nav/view/nav_view.dart';

class LoginService {
  static String apiUrl =
      'https://petvillagedubai.com/wp-json/jwt-auth/v1/token';
  static String apiUrlToFetchId =
      'https://petvillagedubai.com/wp-json/wc/v3/customers';
  static String username = 'ck_d058f2ac46d290f9b8c8b9fbf10ce3a0fb7fc9ef';
  static String password = 'cs_c909011ecca0cc98a6c8688e8b25d51476df2db6';

  static Future<void> login({required Map<String, dynamic> body}) async {
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
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        var userEmail = data['user_email'];
        await ConstString.setName(name: data['user_display_name']);
        await ConstString.setToken(token: data['token']);
        await ConstString.setEmail(email: userEmail);
        await fetchCustomerDetails(email: userEmail, isSwitch: true);
      } else {
        throw Exception('Failed to login with error ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login with error $e');
    }
  }

  static Future<Address?> fetchCustomerDetails({
    required String email,
    required bool isSwitch,
  }) async {
    String encode = base64Encode(utf8.encode('$username:$password'));
    String basicAuth = 'Basic $encode';

    try {
      http.Response response = await http.get(
        Uri.parse('$apiUrlToFetchId?email=$email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': basicAuth,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Address address = Address.fromJson(data[0]);
        await ConstString.setId(id: address.id.toString());
        if (address.id != null) {
          await ConstString.setLogin();
          if (isSwitch) {
            Get.offAll(() => const NavView());
          }
          return address;
        }
      } else {
        throw Exception('Failed to fetch customer details with error');
      }
    } catch (e) {
      throw Exception('Failed to fetch customer details with error $e');
    }
    return null;
  }
}
