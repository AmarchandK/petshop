import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:petvillage/constant/colors_file.dart';
import 'package:petvillage/constant/common_widget.dart';
import 'package:petvillage/screen/search/view/search_view.dart';
import '../../../constant/const_string.dart';
import '../../../constant/responsive.dart';
import '../../product/view/product_view.dart';
import 'widgets/drawer.dart';
import '../controller/home_controller.dart';
import 'widgets/pets_category_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeController = Get.put(HomeController());
  final _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (obj) {
        return Common.scaffold<HomeController>(
          key: scaffoldKey,
          drawer: const MyDrawer(),
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            title: const Image(
              image: AssetImage(ConstString.petLogo),
              height: 60,
            ),
            centerTitle: false,
            actions: [
              // IconButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const NotificationView(),
              //       ),
              //     );
              //   },
              //   icon: const Icon(IconlyLight.notification),
              // ),
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openEndDrawer();
                },
                icon: const Icon(Icons.menu_open),
              ),
              SizedBox(width: Responsive.width * 3),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Common.textFormField(
                        readOnly: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchView(),
                            ),
                          );
                        },
                        prefixIcon: const Icon(IconlyLight.search),
                        hintText: "Search here",
                        controller: _searchController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        validator: (_) {
                          return null;
                        },
                        onSaved: (_) {},
                        onChanged: (val) {},
                        context: context,
                      ),
                      Common.smallSizedBox(),
                      Common.text(
                        text: "All Categories",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      Common.smallSizedBox(),
                      PetsCategoryWidget(controller: homeController),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const ProductView(tittle: 'CAT FOOD'),
                      arguments: 'cat supplies',
                    );
                  },
                  child: Stack(
                    children: [
                      const Image(
                        image: AssetImage(
                          'assets/image/cat.png',
                        ),
                      ),
                      Positioned(
                        bottom: Responsive.height * 20,
                        right: 20,
                        child: Common.button(
                          text: "shop",
                          onPressed: () {
                            Get.to(
                              () => const ProductView(tittle: 'CAT FOOD'),
                              arguments: 'cat supplies',
                            );
                          },
                          buttonColor: AppColors.whiteColor,
                          buttonWidth: Responsive.width * 25,
                          buttonHeight: Responsive.height * 5,
                          textColor: AppColors.primary,
                          elevation: 0,
                          radius: 20,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const ProductView(tittle: 'CAT TOYS'),
                      arguments: 'cat toys',
                    );
                  },
                  child: const Stack(
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/image/foodImage.png',
                        ),
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      Common.smallSizedBox(),
                      appInfoWidget(
                        icon: Icons.local_shipping,
                        title: "Free UAE Delivery",
                        subTitle: "On orders over AED 80",
                      ),
                      Common.extraSmallSizedBox(),
                      appInfoWidget(
                        icon: Icons.card_giftcard,
                        title: "Same Day Dispatch",
                        subTitle: "On orders over AED 80",
                      ),
                      Common.extraSmallSizedBox(),
                      appInfoWidget(
                        icon: Icons.support_agent,
                        title: "94 % Customer Satisfaction",
                        subTitle: "Satisfied customers",
                      ),
                      Common.extraSmallSizedBox(),
                      appInfoWidget(
                        icon: Icons.person,
                        title: "Sales line",
                        subTitle: "Satisfied customers",
                      ),
                      Common.smallSizedBox(),
                      SizedBox(
                        height: Responsive.height * 5,
                        child: Marquee(
                          text: '🤵‍♀️24/7 Support '
                              ' 💰Quality Products '
                              ' 🍀15% Cashback '
                              ' 📦Fast Shipping ',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 20.0,
                          velocity: 100.0,
                          pauseAfterRound: const Duration(seconds: 1),
                          showFadingOnlyWhenScrolling: true,
                          fadingEdgeStartFraction: 0.1,
                          fadingEdgeEndFraction: 0.1,
                          startPadding: 10.0,
                          accelerationDuration: const Duration(seconds: 1),
                          accelerationCurve: Curves.linear,
                          decelerationDuration:
                              const Duration(milliseconds: 500),
                          decelerationCurve: Curves.easeOut,
                        ),
                      ),
                      Common.extraSmallSizedBox(),
                      Text(
                        "BEST PET SHOP IN DUBAI, UAE",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Common.extraSmallSizedBox(),
                      Text(
                        '''Pet Village Dubai, is one of the leading best Pet multipurpose pet retailers in UAE since 2015, and Pet Village Dubai has been providing its customers with guaranteed high-quality world top brands pet products for many years. We have a variety of selections like Cat Supplies, Dog Supplies, Bird Supplies, Aquatic, etc… Our range of top-of-the-range products and superb customer service ensures that we continue to be a firm favorite with pets from all over the globe. we deliver to your doorstep.
                  ''',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Common.extraSmallSizedBox(),
                      Container(
                        color: AppColors.highlightColor,
                        child: Column(
                          children: [
                            highlightFeature(
                              iconData: FontAwesomeIcons.truck,
                              title: 'Fast Shipping',
                            ),
                            highlightFeature(
                              iconData: Icons.info,
                              title: '24/7 Products',
                            ),
                            highlightFeature(
                              iconData: FontAwesomeIcons.coins,
                              title: 'Original Products',
                            )
                          ],
                        ),
                      ),
                      Common.mediumSizedBox(),
                      featureText(
                        Icons.heart_broken,
                        '''If you're a pet owner in Dubai, finding a reliable and trustworthy pet shop is essential to ensure that your furry friend gets the best care and attention they deserve. petvillagedubai.com is the best pet shop in Dubai, offering a wide range of pet supplies, a diverse selection of pets, knowledgeable staff, and exceptional customer service.
                  ''',
                      ),
                      Common.divider(),
                      featureText(
                        FontAwesomeIcons.truck,
                        '''We offer high-quality pet food and treats, a variety of toys and accessories, and health and grooming products to keep your pet happy and healthy. We provide a fast delivery option.
                  ''',
                      ),
                      Common.extraSmallSizedBox(),
                      Row(
                        children: [
                          Text(
                            'Follow us at:',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textColor,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(FontAwesomeIcons.facebook)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(FontAwesomeIcons.instagram)),
                        ],
                      ),
                    ],
                  ),
                ),
                Common.mediumSizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget featureText(IconData iconData, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.highlightColor,
          radius: 25,
          child: Icon(
            iconData,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        SizedBox(width: Responsive.height * 2),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }

  ListTile highlightFeature({
    required IconData iconData,
    required String title,
  }) {
    return ListTile(
      leading: Icon(
        iconData,
        color: AppColors.iconColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.highlightsTextColor,
        ),
      ),
    );
  }

  Row appInfoWidget({
    required String title,
    required String subTitle,
    required IconData icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 30,
          color: AppColors.primary,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Common.text(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            Common.text(
              text: subTitle,
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }

  Stack homeImage({
    double? height,
    double? width,
    double? radius,
    required String image,
    String? text,
    BoxFit? fit,
    Color? borderColor,
    required void Function()? onPressed,
  }) {
    return Stack(
      children: [
        CachedNetworkImage(
          height: height,
          imageUrl: image,
          width: width ?? Responsive.width * 100,
          fit: fit ?? BoxFit.fitWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageBuilder: (context, imageProvider) => Container(
            height: height,
            width: width ?? Responsive.width * 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor ?? AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(radius ?? 0),
              image: DecorationImage(
                image: imageProvider,
                fit: fit ?? BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 35,
            left: 30,
          ),
          child: Common.text(
            text: text ?? "",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            fontFamily: GoogleFonts.aoboshiOne().fontFamily,
          ),
        ),
        Positioned(
          bottom: 15,
          left: 20,
          child: Common.button(
            text: "shop",
            onPressed: onPressed,
            buttonColor: AppColors.whiteColor,
            buttonWidth: Responsive.width * 25,
            buttonHeight: Responsive.height * 5,
            textColor: AppColors.primary,
            elevation: 0,
            radius: 20,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
