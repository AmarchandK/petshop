import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ServerClient {
  static const int _timeout = 90;
  static final loger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 100,
      lineLength: 1000,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static String username = 'ck_d058f2ac46d290f9b8c8b9fbf10ce3a0fb7fc9ef';
  static String password = 'cs_c909011ecca0cc98a6c8688e8b25d51476df2db6';

  static Future<List> get(String url) async {
    String encode = base64Encode(utf8.encode('$username:$password'));
    String basicAuth = 'Basic $encode';
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
    };
    try {
      var response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: _timeout));
      return _response(response);
    } on SocketException {
      loger.e("Get request error SocketException");
      return [600, "No internet"];
    } catch (e) {
      loger.e("Get request error $e");
      return [600, e.toString()];
    }
  }

  /// Post request

  static Future<List> post(
    String url, {
    Map<String, dynamic>? data,
    bool post = true,
  }) async {
    String encode = base64Encode(utf8.encode('$username:$password'));
    String basicAuth = 'Basic $encode';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
    };
    try {
      var body = json.encode(data);
      var response = await http
          .post(Uri.parse(url), body: post ? body : null, headers: headers)
          .timeout(const Duration(seconds: _timeout));
      return _response(response);
    } on SocketException {
      loger.e("Post request error SocketException");
      return [600, "No internet"];
    } catch (e) {
      loger.e("Post request error $e");
      return [600, e.toString()];
    }
  }

  /// Put request

  static Future<List> put(
    String url, {
    required Map<String, dynamic> data,
  }) async {
    String encodeData = base64Encode(utf8.encode('$username:$password'));
    String basicAuth = 'Basic $encodeData';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
      "Accept": "application/json",
    };
    try {
      log("body is $data");
      String? body = json.encode(data);

      var response = await http
          .put(
            Uri.parse(url),
            body: body,
            headers: headers,
          )
          .timeout(
            const Duration(seconds: _timeout),
          );
      return _response(response);
    } on SocketException {
      loger.e("Put request error SocketException");
      return [600, "No internet"];
    } catch (e) {
      log("Error Found $e");
      return [600, e.toString()];
    }
  }

  /// Delete request

  static Future<List> delete(String url, {String? id}) async {
    String encode = base64Encode(utf8.encode('$username:$password'));
    String basicAuth = 'Basic $encode';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
      "Accept": "application/json",
    };
    try {
      var response = await http.delete(Uri.parse(url), headers: headers);
      return await _response(response);
    } on SocketException {
      loger.e("Delete request error SocketException");
      return [600, "No internet"];
    } catch (e) {
      loger.e("Delete request error $e");
      return [600, e.toString()];
    }
  }

  // ------------------- ERROR HANDLING ------------------- \\

  static Future<List> _response(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        return [
          response.statusCode,
          json.decode(utf8.decode(response.bodyBytes)),
        ];
      case 201:
        return [response.statusCode, jsonDecode(response.body)];
      case 400:
        loger.e("Bad request 400 ${response.body}");
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 401:
        loger.e("Unauthorized 401 ${response.body}");
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 403:
        loger.e("Forbidden 403 ${response.body}");
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 404:
        loger.e("Not found 404 ${response.body}");
        return [
          response.statusCode,
          "You're using unregistered application",
        ];
      case 500:
        loger.e("Internal server error 500 ${response.body}");
        return [response.statusCode, jsonDecode(response.body)["message"]];
      default:
        loger.e("Error ${response.statusCode} ${response.body}");
        return [response.statusCode, jsonDecode(response.body)["message"]];
    }
  }
}
