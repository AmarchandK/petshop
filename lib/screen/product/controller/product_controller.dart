import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../cart/model/cart_item.dart';
import '../../home/model/product_model.dart';
import '../../service/api_service.dart';

class ProductController extends GetxController {
  bool isLoading = false;
  String query = "";
  var currentPage = 0;

  @override
  onInit() {
    super.onInit();
    query = Get.arguments ?? "";
  }

  List<ProductElement> products = [];
  List<ProductElement> relatedItems = [];

  Future<void> getProductsByCategory() async {
    currentPage = 0;
    isLoading = true;
    update();
    log("current page $currentPage");
    products.clear();
    Product? prod = await HomeService().getAllProductsByCategory(
      category: query,
      count: currentPage,
    );
    if (prod != null) {
      products.addAll(prod.products ?? []);
      currentPage = 1;
    }
    isLoading = false;
    update();
  }

  bool isAlreadyRunning = false;

  Future<void> loadMoreProducts() async {
    try {
      if (isAlreadyRunning == true) return;
      isAlreadyRunning = true;
      Product? prod = await HomeService().getAllProductsByCategory(
        category: query,
        count: currentPage,
      );
      if (prod != null) {
        if (currentPage == 1) products.clear();
        products.addAll(prod.products ?? []);
        currentPage += 1;
        isAlreadyRunning = false;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      update();
    }
  }

  Future<void> addToFavorite({
    required CartItemModel data,
    required String userId,
  }) async {
    final c = FirebaseFirestore.instance.collection("favorite").doc(userId);
    final doc = await c.get();
    if (doc.exists) {
      data.quantity = 0;
      final existingData = doc.data() as Map<String, dynamic>;
      final existingItems = existingData["items"] as List<dynamic>;
      final existingItem = existingItems.firstWhere(
        (element) => element["id"] == data.id,
        orElse: () => null,
      );
      if (existingItem == null) {
        existingItems.add(data.toJson());
        await c.update({
          "items": existingItems,
        });
      } else {
        existingItems.remove(existingItem);
        await c.update({
          "items": existingItems,
        });
      }
    } else {
      await c.set({
        "items": [data.toJson()],
      });
    }
  }
}
