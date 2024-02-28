import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petvillage/constant/const_string.dart';
import 'package:petvillage/constant/server_client.dart';
import 'package:petvillage/screen/cart/view/placed_view.dart';
import 'package:petvillage/screen/home/controller/home_controller.dart';
import '../model/cart_item.dart';

class CartController extends GetxController {
  bool isCartLoading = false;
  List<CartItemModel> cartItems = [];
  double subTotalAmount = 0.0;
  RxInt selectedValue = 1.obs; 


   void updateSelectedValue(int value) {
    selectedValue.value = value;
  }
  List<CartItemModel> getCartItems({QuerySnapshot? snap}) {
    subTotalAmount = 0.0;
    cartItems.clear();
    if (snap != null) {
      for (var doc in snap.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        CartItemModel cartItem = CartItemModel(
          image: data['image'],
          name: data['name'],
          price: data['price'],
          quantity: data['quantity'],
          id: data['id'],
        );
        log('se $subTotalAmount');
        log('esfs ${cartItem.toJson()}');
        cartItems.add(cartItem);
        subTotalAmount += cartItem.price * cartItem.quantity;
        subTotalAmount = double.parse(subTotalAmount.toStringAsFixed(2));
      }
    }
    return cartItems;
  }

  Future<void> cartIncrement({
    required CartItemModel cartItem,
    required String id,
  }) async {
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(id)
        .collection('items')
        .doc(cartItem.id.toString())
        .update({'quantity': cartItem.quantity + 1});
          }

  Future<void> cartDecrement({
    required CartItemModel cartItem,
    required String id,
  }) async {
    if (cartItem.quantity == 1) {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(id)
          .collection('items')
          .doc(cartItem.id.toString())
          .delete();
              } else {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(id)
          .collection('items')
          .doc(cartItem.id.toString())
          .update({'quantity': cartItem.quantity - 1});
              }
  }

  Map<String, dynamic>? paymentInstance;

  void createPaymentIntent({
    required String price,
    required List<CartItemModel> cartItems,
  }) async {
    try {
      isCartLoading = true;
      update();
      Map<String, dynamic> body = {
        'amount': price,
        'currency': 'AED',
        'description': 'Oasis Community : Cleaning Service Payment',
      };
      String testKey =
          "sk_test_51N2roFBLjVXVMSq146By0NAlD8zv3VS9Tx0639m5ZNMbF2vAcXDg5Mt6ncrWgfgkZTJcQR1LtsyBOmoKTup0AdCl00zzHvHDuW";
      http.Response response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          "Authorization": "Bearer $testKey",
          "Content-Type": "application/x-www-form-urlencoded"
        },
      );
      paymentInstance = jsonDecode(response.body);
      if (paymentInstance?['status'] == 'requires_payment_method') {
        await stripeSheetOpen(cartItems: cartItems);
      }
    } catch (e) {
      log('Error creating PaymentIntent: ${e.toString()}');
    }
  }

  Future<void> stripeSheetOpen({required List<CartItemModel> cartItems}) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentInstance?['client_secret'],
          style: ThemeMode.light,
          intentConfiguration: IntentConfiguration(
            mode: IntentMode(
              currencyCode: 'AED',
              amount: paymentInstance?['amount'],
            ),
            paymentMethodTypes: [
              'card',
            ],
            confirmHandler: (method, suc) {
              log('method: $method');
              log('suc: $suc');
            },
          ),
          billingDetails: BillingDetails(
            phone: Get.find<HomeController>().address?.billing?.phone,
            name: Get.find<HomeController>().address?.billing?.firstName,
            address: Address(
              city: Get.find<HomeController>().address?.billing?.city,
              country: 'AE',
              line1: Get.find<HomeController>().address?.billing?.address1,
              line2: Get.find<HomeController>().address?.billing?.address2,
              postalCode: Get.find<HomeController>().address?.billing?.postcode,
              state: Get.find<HomeController>().address?.billing?.state,
            ),
          ),
          merchantDisplayName: 'Pet Village',
        ),
      );
      await Stripe.instance.presentPaymentSheet().then((value) {
        updateOrderToServer(cartItems: cartItems);
      }).onError((error, stackTrace) {
        isCartLoading = false;
        update();
        log('error: $error -----');
      });
    } catch (e) {
      log('Error: $e --');
    }
  }

  Future<void> updateOrderToServer({
    required List<CartItemModel> cartItems,
  }) async {
    try {
      final String userId = await ConstString.getId() ?? '';
      List<Map<String, dynamic>> lineItems = [];
      for (var element in cartItems) {
        lineItems.add({
          "product_id": element.id,
          "quantity": element.quantity,
        });
      }
      int amount = paymentInstance?['amount'] ~/ 100;
      Map<String, dynamic> data = {
        "payment_method": "stripe",
        "payment_method_title": "Credit / Debit Card (Stripe)",
        "set_paid": true,
        "customer_id": userId,
        "billing": Get.find<HomeController>().address?.billing?.toJson(),
        "shipping": Get.find<HomeController>().address?.shipping?.toJson(),
        "line_items": lineItems,
        "shipping_lines": [
          {
            "method_id": "flat_rate",
            "method_title": "Flat Rate",
            "total": "$amount",
          }
        ]
      };
      List response = await ServerClient.post(
        ConstString.addOrder,
        data: data,
      );
      if (response.first >= 200 && response.first < 300) {
        await clearCart();
        Get.to(() => const PlacedView());
      }
    } catch (e) {
      log('Error: $e --');
    } finally {
      isCartLoading = false;
      update();
    }
  }

  Future<void> clearCart() async {
    try {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(Get.find<HomeController>().userId)
          .collection('items')
          .get()
          .then((value) {
        for (var doc in value.docs) {
          doc.reference.delete();
        }
      });
    } catch (e) {
      log('Error: $e --');
    }
  }
}
