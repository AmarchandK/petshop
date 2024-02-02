import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import '../../../constant/colors_file.dart';
import '../../../constant/common_widget.dart';
import '../../../constant/const_string.dart';
import '../../address/view/address_view.dart';
import '../../orders/view/orders_view.dart';
import '../../points/view/points_view.dart';
import '../controller/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final controller = Get.put(ProfileController());
  String userName = "Pet Village";

  @override
  void initState() {
    super.initState();
    ConstString.getName().then((value) {
      setState(() {
        userName = value ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Common.scaffold<ProfileController>(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("My Account"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: Common.kPadding,
              child: CachedNetworkImage(
                imageUrl: ConstString.home1,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder: (context, imageProvider) => Container(
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.whiteColor,
                        radius: 42,
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary.withOpacity(.3),
                          radius: 40,
                          child: Center(
                            child: Common.text(
                              text: getInitials(userName).toUpperCase(),
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Hello,",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            userName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              indent: 20,
              endIndent: 20,
            ),
            // ListTile(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const DashBoardView(),
            //       ),
            //     );
            //   },
            //   title: const Text("Dashboard"),
            //   leading: const Icon(Icons.dashboard),
            // ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersView(),
                  ),
                );
              },
              title: const Text("My Orders"),
              leading: const Icon(IconlyLight.bag2),
            ),

            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddressView(),
                  ),
                );
              },
              title: const Text("Address"),
              leading: const Icon(IconlyLight.location),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PointsView(),
                  ),
                );
              },
              title: const Text("Points"),
              leading: const Icon(IconlyLight.activity),
            ),
            ListTile(
              onTap: () {},
              title: const Text("Return & Refund"),
              leading: const Icon(IconlyLight.ticket),
            ),
            ListTile(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const DownloadsView(),
                //   ),
                // );
              },
              title: const Text("Terms & Conditions"),
              leading: const Icon(IconlyLight.shieldDone),
            ),
            ListTile(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const AccountDetailsScreen(),
                //   ),
                // );
              },
              title: const Text("Privacy Policy"),
              leading: const Icon(IconlyLight.document),
            ),
            ListTile(
              onTap: () async {
                await ConstString.clearAll();
              },
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getInitials(String name) {
    final nameSplit = name.trim().split(' ');
    if (nameSplit.length >= 2) {
      final firstNameInitial = nameSplit[0][0];
      final lastNameInitial = nameSplit[1][0];
      return '$firstNameInitial$lastNameInitial';
    } else if (nameSplit.length == 1) {
      return nameSplit[0][0];
    } else {
      return '';
    }
  }
}
