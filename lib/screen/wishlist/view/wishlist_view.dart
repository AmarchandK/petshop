import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:petvillage/screen/cart/controller/cart_controller.dart';
import 'package:petvillage/screen/product_inner_view/controller/product_inner_view_controller.dart';
import '../../../constant/colors_file.dart';
import '../../../constant/common_widget.dart';
import '../../home/controller/home_controller.dart';
import '../controller/wishlist_controller.dart';

class WishListView extends StatefulWidget {
  const WishListView({super.key});
  @override
  State<WishListView> createState() => _WishListViewState();
}

class _WishListViewState extends State<WishListView> {
  final controller = Get.put(WishlistController());
  final cartCt = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Common.scaffold<WishlistController>(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Favorite",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("favorite")
              .doc(Get.find<HomeController>().userId)
              .snapshots(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = controller.getData(snap: snap.data);
            return data.isEmpty
                ? const Center(
                    child: Text(
                      'No Items in Wishlist',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : GridView.builder(
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Stack(
                        children: [
                          Card(
                            elevation: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            item.image,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          maxLines: 3,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'AED ${item.price}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("cart")
                                                    .doc(Get.find<
                                                            HomeController>()
                                                        .userId)
                                                    .collection("items")
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  final cartData =
                                                      Get.find<CartController>()
                                                          .getCartItems(
                                                              snap: snapshot
                                                                  .data);
                                                  return IconButton(
                                                    onPressed: () {
                                                      if (cartData.any(
                                                          (element) =>
                                                              element.id ==
                                                              item.id)) {
                                                        ScaffoldMessenger.of(
                                                            context)
                                                          ..removeCurrentSnackBar()
                                                          ..showSnackBar(
                                                            const SnackBar(
                                                              backgroundColor:
                                                                  Colors.red,
                                                              content: Text(
                                                                'Already in Cart',
                                                              ),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          1),
                                                            ),
                                                          );
                                                        return;
                                                      }
                                                      Get.put(ProductInnerViewController())
                                                          .addToCart(
                                                        product: item,
                                                        quantity: 1,
                                                      );
                                                      ScaffoldMessenger.of(
                                                          context)
                                                        ..removeCurrentSnackBar()
                                                        ..showSnackBar(
                                                          const SnackBar(
                                                            backgroundColor:
                                                                Colors.green,
                                                            content: Text(
                                                              'Added to Cart',
                                                            ),
                                                            duration: Duration(
                                                                seconds: 1),
                                                          ),
                                                        );
                                                    },
                                                    icon: Icon(
                                                      cartData.any((element) =>
                                                              element.id ==
                                                              item.id)
                                                          ? IconlyBold
                                                              .tickSquare
                                                          : IconlyBold.plus,
                                                      color: Colors.green,
                                                      size: 40,
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              onPressed: () {
                                controller.removeItem(id: data[index].id);
                              },
                              icon: const Icon(
                                IconlyBold.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
          },
        ),
      ),
    );
  }
}
