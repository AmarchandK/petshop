import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../constant/const_string.dart';
import '../../cart/model/cart_item.dart';
import '../../home/model/product_model.dart';
import '../../service/api_service.dart';

class ProductInnerViewController extends GetxController {
  bool isExpandListTile = false;

  void expandListTile() {
    isExpandListTile = !isExpandListTile;
    update();
  }

  bool isLoading = false;
  List<ProductElement> relatedItems = [];

  Future<void> getRelatedProducts({required List<int> id}) async {
    relatedItems.clear();
    isLoading = true;
    update();
    Product? product = await HomeService().getRelatedItems(
      id: id,
    );
    if (product != null) {
      relatedItems.addAll(product.products ?? []);
    }
    isLoading = false;
    update();
  }

  bool isMainLoading = false;

  Future<bool> addReviews({
    required String id,
    required String review,
    required String rating,
  }) async {
    try {
      isMainLoading = true;
      update();
      String? email = await ConstString.getEmail();
      String? name = await ConstString.getName();
      String url = "${ConstString.reviews.replaceFirst("{---}", id)}$review";
      if (email != null && name != null) {
        url += "&name=$name,&email=$email&rating=$rating";
      }
      bool response = await HomeService().addReviews(url: url);
      return response;
    } catch (e) {
      log("Error in addReviews $e");
      return false;
    } finally {
      isMainLoading = false;
      update();
    }
  }

  bool isCartLoading = false;

  Future<void> addToCart({
    required CartItemModel product,
    required int quantity,
  }) async {
    try {
      isCartLoading = true;
      update();
      String userId = await ConstString.getId() ?? "";
      final cartCollection = FirebaseFirestore.instance.collection("cart");
      final userCartCollection = cartCollection.doc(userId).collection("items");
      final productDoc = userCartCollection.doc(product.id.toString());
      final existingData = await productDoc.get();
      if (existingData.exists) {
        int currentQuantity = existingData.data()?['quantity'] ?? 0;
        int newQuantity = currentQuantity + quantity;
        if (newQuantity <= 0) {
          await productDoc.delete();
        } else {
          await productDoc.update({
            'quantity': newQuantity,
            'price': product.price,
          });
        }
      } else {
        Map<String, dynamic> data = {
          "image": product.image,
          "name": product.name,
          "price": product.price,
          "quantity": quantity,
          "id": product.id,
        };
        await userCartCollection.doc(product.id.toString()).set(data);
      }
    } catch (e) {
      log("Error in addToCart $e");
    } finally {
      isCartLoading = false;
      update();
    }
  }

  Future<void> deleteCart({required int productId}) async {
    try {
      isCartLoading = true;
      update();
      String userId = await ConstString.getId() ?? "";
      final cartCollection = FirebaseFirestore.instance.collection("cart");
      final userCartCollection = cartCollection.doc(userId).collection("items");
      final productDoc = userCartCollection.doc(productId.toString());
      await productDoc.delete();
    } catch (e) {
      log("Error in deleteCart $e");
    } finally {
      isCartLoading = false;
      update();
    }
  }
}
