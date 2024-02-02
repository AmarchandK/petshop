import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petvillage/screen/cart/model/cart_item.dart';

import '../../home/controller/home_controller.dart';

class WishlistController extends GetxController {
  List<CartItemModel> getData({DocumentSnapshot<Map<String, dynamic>>? snap}) {
    List<CartItemModel> resultList = [];
    if (snap?.data() != null) {
      Map<String, dynamic> data = snap?.data() as Map<String, dynamic>;
      List<dynamic> items = data['items'] as List<dynamic>;
      for (var item in items) {
        CartItemModel cartItem = CartItemModel.fromJson(item);
        resultList.add(cartItem);
      }
    }
    return resultList;
  }

  Future<void> removeItem({required int id}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
          .instance
          .collection("favorite")
          .doc(Get.find<HomeController>().userId)
          .get();
      if (snap.data() != null) {
        Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
        List<dynamic> items = data['items'] as List<dynamic>;
        List<dynamic> newItems = [];
        for (var item in items) {
          CartItemModel cartItem = CartItemModel.fromJson(item);
          if (cartItem.id != id) {
            newItems.add(item);
          }
        }
        await FirebaseFirestore.instance
            .collection("favorite")
            .doc(Get.find<HomeController>().userId)
            .update({
          "items": newItems,
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
