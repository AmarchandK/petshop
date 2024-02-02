import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petvillage/screen/home/controller/home_controller.dart';
import 'package:petvillage/screen/product/controller/product_controller.dart';
import 'package:share_plus/share_plus.dart';
import '../../../constant/colors_file.dart';
import '../../../constant/common_widget.dart';
import '../../../constant/responsive.dart';
import '../../../constant/routes.dart';
import '../../cart/model/cart_item.dart';
import '../../cart/view/cart_view.dart';
import '../../home/model/product_model.dart';
import '../../product/view/widget/product_item_widget.dart';
import '../controller/product_inner_view_controller.dart';

// ignore: must_be_immutable
class ProductInnerView extends StatefulWidget {
  ProductInnerView({
    super.key,
    required this.product,
    required this.isFavorite,
  });
  final ProductElement product;
  bool isFavorite;
  @override
  State<ProductInnerView> createState() => _ProductInnerViewState();
}

class _ProductInnerViewState extends State<ProductInnerView> {
  final controller = Get.put(ProductInnerViewController());
  final reviewController = TextEditingController();
  String rating = "0.0";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getRelatedProducts(id: widget.product.relatedIds ?? []);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductInnerViewController>(
      builder: (obj) {
        return Common.scaffold<ProductInnerViewController>(
          isLoading: obj.isMainLoading,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Get.find<ProductController>().addToFavorite(
                    userId: Get.find<HomeController>().userId,
                    data: CartItemModel(
                      id: widget.product.id ?? 0,
                      image: widget.product.images?.first.src ?? "",
                      name: widget.product.title ?? "",
                      price: double.tryParse(
                            widget.product.salePrice ?? "",
                          ) ??
                          0,
                      quantity: widget.product.quantity,
                    ),
                  );
                  setState(() {
                    widget.isFavorite = !widget.isFavorite;
                  });
                },
                icon: Icon(
                  widget.isFavorite ? IconlyBold.heart : IconlyBold.heart,
                  color: widget.isFavorite ? Colors.red : Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {
                  Routes.push(
                    screen: const CartView(),
                    action: (_) {},
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: widget.product.images?.first.src ?? "",
                        height: 300,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: SpinKitCubeGrid(
                            color: AppColors.primary,
                            size: 50.0,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.hide_image,
                          color: AppColors.greyColor,
                          size: 70,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 10,
                    //   left: 30,
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 10,
                    //       vertical: 5,
                    //     ),
                    //     decoration: BoxDecoration(
                    //       color: Colors.red,
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     child: Center(
                    //       child: Common.text(
                    //         text: "- 20 %",
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 12,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Share.shareUri(
                                Uri.parse(widget.product.permalink ?? ""),
                              );
                            },
                            icon: CircleAvatar(
                              backgroundColor: AppColors.primary.withOpacity(
                                0.2,
                              ),
                              radius: 25,
                              child: const Icon(Icons.share),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Common.text(
                              text: widget.product.title ?? "",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 50),
                          Common.text(
                            text:
                                "${widget.product.salePrice == 0 || widget.product.salePrice == null ? widget.product.regularPrice : widget.product.salePrice} AED",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Common.text(
                        text: "Earn 44 points worth AED2.20",
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: Responsive.height * 2),
                      Common.text(
                        text: "Description",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 5),
                      AnimatedReadMoreText(
                        _parseHtmlContent(
                          widget.product.description ?? "Product Description",
                        ),
                        maxLines: 4,
                        readMoreText: 'Expand',
                        readLessText: 'Collapse',
                        textStyle: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.blackColor,
                        ),
                        buttonTextStyle: TextStyle(
                          fontSize: 14.0,
                          color: AppColors.primary,
                        ),
                        expandOnTextTap: true,
                      ),
                      SizedBox(height: Responsive.height * 2),
                      GetBuilder<ProductInnerViewController>(builder: (obj) {
                        return ExpansionPanelList(
                          expansionCallback: (int index, bool isExpanded) {
                            controller.expandListTile();
                          },
                          elevation: 0,
                          children: [
                            ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  onTap: () {
                                    controller.expandListTile();
                                  },
                                  title: Common.text(
                                    text: "Drop a review",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                );
                              },
                              body: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RatingBar.builder(
                                    initialRating: 0.0,
                                    minRating: 2,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    unratedColor: Colors.amber.withAlpha(100),
                                    maxRating: 5,
                                    itemCount: 5,
                                    itemSize: 40.0,
                                    itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      this.rating = rating.toString();
                                    },
                                    updateOnDrag: true,
                                  ),
                                  const SizedBox(height: 20),
                                  Common.textFormField(
                                    controller: reviewController,
                                    hintText: "Write your review",
                                    keyboardType: TextInputType.text,
                                    context: context,
                                    validator: (p0) => null,
                                    onSaved: (p0) {},
                                    onChanged: (p0) {},
                                    obscureText: false,
                                    maxLines: 6,
                                  ),
                                  SizedBox(height: Responsive.height * 2),
                                  Common.button(
                                    text: "Submit",
                                    onPressed: () {
                                      if (reviewController.text.isEmpty) {
                                        Common.snackBar(
                                          message: "Please enter review",
                                          title: "Review",
                                          backgroundColor: Colors.red,
                                        );
                                        return;
                                      }
                                      controller
                                          .addReviews(
                                        id: widget.product.id.toString(),
                                        review: reviewController.text,
                                        rating: rating,
                                      )
                                          .then((value) {
                                        if (value) {
                                          Common.snackBar(
                                            message: "Review added",
                                            title: "Review",
                                            backgroundColor: Colors.green,
                                          );
                                          rating = "0.0";
                                          reviewController.clear();
                                          controller.expandListTile();
                                        } else {
                                          Common.snackBar(
                                            message: "Failed to add review",
                                            title: "Review",
                                            backgroundColor: Colors.red,
                                          );
                                        }
                                      });
                                    },
                                    radius: 10,
                                  ),
                                ],
                              ),
                              isExpanded: controller.isExpandListTile,
                            ),
                          ],
                        );
                      }),
                      SizedBox(height: Responsive.height * 3),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Common.text(
                    text: "Related Items",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GetBuilder<ProductInnerViewController>(
                  builder: (obj) {
                    return obj.isLoading
                        ? SizedBox(
                            height: Responsive.height * 15,
                            child: Center(
                              child: SpinKitPulse(
                                color: AppColors.primary,
                                size: 50.0,
                              ),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: Common.kPadding.copyWith(
                              top: 20,
                              bottom: 20,
                              right: 8,
                              left: 8,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 300,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                            itemCount: controller.relatedItems.length,
                            itemBuilder: (context, index) {
                              final product = controller.relatedItems[index];
                              return GestureDetector(
                                onTap: () {
                                  Routes.push(
                                    screen: ProductInnerView(
                                      product: product,
                                      isFavorite: false,
                                    ),
                                    action: (_) {},
                                  );
                                },
                                child: ProductItemWidget(
                                  product: product,
                                  isFavorite: false,
                                ),
                              );
                            },
                          );
                  },
                ),
                SizedBox(height: Responsive.height * 10),
              ],
            ),
          ),
          bottomSheet: Container(
            height: Responsive.height * 8,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: widget.product.quantity == 0
                ? Center(
                    child: Common.button(
                      text: "Add to cart",
                      onPressed: () {
                        CartItemModel cartItemModel = CartItemModel(
                          image: widget.product.images?.first.src ?? "",
                          name: widget.product.title ?? "",
                          price: double.tryParse(
                                widget.product.salePrice == 0 ||
                                        widget.product.salePrice == null
                                    ? widget.product.regularPrice
                                    : widget.product.salePrice ?? "",
                              ) ??
                              0,
                          quantity: widget.product.quantity,
                          id: widget.product.id ?? 0,
                        );
                        controller.addToCart(
                          product: cartItemModel,
                          quantity: 1,
                        );
                        setState(() {
                          widget.product.quantity++;
                        });
                      },
                      radius: 10,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          CartItemModel cartItemModel = CartItemModel(
                            image: widget.product.images?.first.src ?? "",
                            name: widget.product.title ?? "",
                            price: double.tryParse(
                                  widget.product.salePrice ?? "",
                                ) ??
                                0,
                            quantity: widget.product.quantity,
                            id: widget.product.id ?? 0,
                          );
                          if (widget.product.quantity > 0) {
                            setState(() {
                              widget.product.quantity--;
                            });
                            if (widget.product.quantity == 0) {
                              controller.deleteCart(
                                productId: widget.product.id ?? 0,
                              );
                              return;
                            }
                            controller.addToCart(
                              product: cartItemModel,
                              quantity: -1,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 50),
                      Common.text(
                        text: widget.product.quantity.toString(),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 50),
                      IconButton(
                        onPressed: () {
                          CartItemModel cartItemModel = CartItemModel(
                            image: widget.product.images?.first.src ?? "",
                            name: widget.product.title ?? "",
                            price: double.tryParse(
                                  widget.product.salePrice ?? "",
                                ) ??
                                0,
                            quantity: widget.product.quantity,
                            id: widget.product.id ?? 0,
                          );
                          controller.addToCart(
                            product: cartItemModel,
                            quantity: 1,
                          );
                          setState(() {
                            widget.product.quantity++;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  String _parseHtmlContent(String htmlContent) {
    htmlContent = htmlContent.replaceAll("&nbsp;", " ");
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlContent.replaceAll(exp, '');
  }
}
