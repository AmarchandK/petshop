import 'dart:developer';

import 'package:get/get.dart';

import '../../../constant/const_string.dart';
import '../../../constant/server_client.dart';
import '../../home/model/product_model.dart';

class SearchScreenController extends GetxController {
  bool isLoading = false;
  List<ProductElement> products = [];

  Future<void> searchProducts({required String query}) async {
    try {
      isLoading = true;
      update();
      List response =
          await ServerClient.get("${ConstString.searchProduct}$query");
      if (response.first >= 200 && response.first < 300) {
        products.clear();
        Product product = Product.fromJson(response.last);
        products.addAll(product.products ?? []);
      }
      if (query.isEmpty) {
        products.clear();
      }
    } catch (e) {
      log("error in getMyOrders $e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
