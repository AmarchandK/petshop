import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petvillage/screen/cart/view/cart_view.dart';
import 'package:petvillage/screen/home/view/home_view.dart';
import '../../../profile/view/profile_view.dart';
import '../../../wishlist/view/wishlist_view.dart';

class NavController extends GetxController {
  bool isLoading = false;

  void changeLoading({required bool value}) {
    isLoading = value;
    update();
  }

  final List<Widget> _pages = [
    const HomeView(),
    const WishListView(),
    const CartView(),
    const ProfileView(),
  ];

  List<Widget> get pages => _pages;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changePage(int index) {
    _currentIndex = index;
    update();
  }
}
