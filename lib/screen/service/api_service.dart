import 'package:petvillage/constant/const_string.dart';
import 'package:petvillage/constant/server_client.dart';
import 'package:petvillage/screen/home/model/product_model.dart';

class HomeService {
  Future<Product?> getAllProductsByCategory({
    required String category,
    required int count,
  }) async {
    try {
      List response = await ServerClient.get(
        "${ConstString.products}$category&status=publish&page=$count",
      );
      if (response.first >= 200 && response.first < 300) {
        Product product = Product.fromJson(response.last);
        return product;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Product?> getRelatedItems({required List<int> id}) async {
    try {
      String ids = "";
      for (int i = 0; i < id.length; i++) {
        ids += "${id[i]},";
      }
      List response = await ServerClient.get(
        "${ConstString.relatedItems}$ids",
      );
      if (response.first >= 200 && response.first < 300) {
        Product product = Product.fromJson(response.last);
        return product;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> addReviews({required String url}) async {
    try {
      List response = await ServerClient.post(
        url,
        post: false,
      );
      if (response.first >= 200 && response.first < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
