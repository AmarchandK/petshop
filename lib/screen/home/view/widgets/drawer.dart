import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:petvillage/screen/product/view/product_view.dart';
import '../../../../../constant/colors_file.dart';
import '../../../../../constant/common_widget.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  DrawerState createState() => DrawerState();
}

class DrawerState extends State<MyDrawer> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  _onChangePage(int index) {
    _controller.jumpToPage(index);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.drawerBackGroundColor,
      child: PageView.builder(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 9,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return MainDrawer(
                onChangePage: (pageIndex) => _onChangePage(pageIndex),
              );
            case 1:
              return ShopDrawer(
                onChangePage: (pageIndex) => _onChangePage(pageIndex),
              );
            case 2:
              return BrandsDrawer(
                onChangePage: (pageIndex) => _onChangePage(pageIndex),
              );
            case 3:
              return DogsDrawer(
                onChangePage: (pageIndex) => _onChangePage(pageIndex),
              );
            case 4:
              return CatDrawer(
                onChangePage: (pageIndex) => _onChangePage(pageIndex),
              );
            case 5:
              return BirdDrawer(
                onChangePage: (pageIndex) => _onChangePage(pageIndex),
              );
            case 6:
              return PetsDrawer(
                onChangePage: (pageIndex) => _onChangePage(pageIndex),
              );
            case 7:
              return FishDrawer(
                onChangePage: (pageIndex) => _onChangePage(pageIndex),
              );
            default:
              return MainDrawer(
                onChangePage: (pageIndex) => _onChangePage(pageIndex),
              );
          }
        },
      ),
    );
  }
}

class MainDrawer extends StatelessWidget {
  final Function(int) onChangePage;

  const MainDrawer({super.key, required this.onChangePage});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Common.smallSizedBox(),
            Common.drawerListTileWithoutIcon(
              text: 'NEW ARRIVALS',
            ),
            Common.smallSizedBox(),
            Common.drawerListTile(
              text: 'SHOP',
              iconData: FontAwesomeIcons.shop,
              onTap: () {
                onChangePage(1);
              },
            ),
            Common.drawerListTile(
              text: 'DOG SUPPLIES',
              iconData: FontAwesomeIcons.dog,
              onTap: () {
                onChangePage(3);
              },
            ),
            Common.drawerListTile(
              text: 'CAT SUPPLIES',
              iconData: FontAwesomeIcons.cat,
              onTap: () {
                onChangePage(4);
              },
            ),
            Common.drawerListTile(
              text: 'BIRD SUPPLIES',
              iconData: FontAwesomeIcons.kiwiBird,
              onTap: () {
                onChangePage(5);
              },
            ),
            Common.drawerListTile(
              text: 'SMALL PETS',
              iconData: FontAwesomeIcons.locust,
              onTap: () {
                onChangePage(6);
              },
            ),
            Common.drawerListTile(
              text: 'AQUATIC',
              iconData: FontAwesomeIcons.fish,
              onTap: () {
                onChangePage(7);
              },
            ),
            Common.contactUsListTile(
              text: '+971 52 523 1454',
              iconData: Icons.phone,
              onPressed: () {},
            ),
            Common.contactUsListTile(
              text: 'Apricot Tower- Sheikh Zayed Bin Hamdan Al Nahyan Street',
              iconData: Icons.location_on_outlined,
              onPressed: () {},
            ),
            Common.contactUsListTile(
              text: 'info@petvillagedubai.com',
              iconData: Icons.mail_outlined,
              onPressed: () {},
            ),
            Common.contactUsListTile(
              text: 'Mon - Fri: 09:00 AM - 09:00 PM ',
              iconData: Icons.access_time_outlined,
              onPressed: () {},
            ),
            Common.contactUsListTile(
              text: 'Track Order',
              iconData: FontAwesomeIcons.truck,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class ShopDrawer extends StatelessWidget {
  final Function(int) onChangePage;

  const ShopDrawer({super.key, required this.onChangePage});

  @override
  Widget build(BuildContext context) {
    // Customize the content for Level 2
    return SafeArea(
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: TextButton.icon(
              onPressed: () {
                onChangePage(0);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              label: Common.drawerText('BACK'),
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                )),
          ),
          Common.drawerListTileWithoutIcon(
            text: 'BRANDS',
            onTap: () {
              onChangePage(2);
            },
          )
        ],
      ),
    );
  }
}

class BrandsDrawer extends StatelessWidget {
  final Function(int) onChangePage;

  const BrandsDrawer({super.key, required this.onChangePage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: TextButton.icon(
              onPressed: () {
                onChangePage(1);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              label: Common.drawerText('BACK'),
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                )),
          ),
          Common.drawerListTileWithoutIcon(
            text: 'ROYAL CANIN',
            onTap: () {
              Get.to(
                () => const ProductView(tittle: 'ROYAL CANIN'),
                arguments: 'royal canin',
              );
            },
          ),
          Common.drawerListTileWithoutIcon(
            text: 'KIT CAT',
            onTap: () {
              Get.to(
                () => const ProductView(tittle: 'KIT CAT'),
                arguments: 'kit cat',
              );
            },
          ),
          Common.drawerListTileWithoutIcon(
            text: 'TASTE OF WILD',
            onTap: () {
              Get.to(
                () => const ProductView(tittle: 'TASTE OF WILD'),
                arguments: 'taste of the wild',
              );
            },
          ),
          Common.drawerListTileWithoutIcon(
            text: 'APPLAWS',
            onTap: () {
              Get.to(
                () => const ProductView(tittle: 'APPLAWS'),
                arguments: 'applaws',
              );
            },
          ),
          Common.drawerListTileWithoutIcon(
            text: 'LINDO CAT',
            onTap: () {
              Get.to(
                () => const ProductView(tittle: 'LINDO CAT'),
                arguments: 'lindocat',
              );
            },
          ),
          Common.drawerListTileWithoutIcon(
            text: 'BEAPHAR',
            onTap: () {
              Get.to(
                () => const ProductView(tittle: 'BEAPHAR'),
                arguments: 'beaphar',
              );
            },
          ),
        ],
      ),
    );
  }
}

class DogsDrawer extends StatelessWidget {
  final Function(int) onChangePage;

  const DogsDrawer({super.key, required this.onChangePage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: TextButton.icon(
                onPressed: () {
                  onChangePage(0);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                label: Common.drawerText('BACK'),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            ),
            Common.drawerListTileWithoutIcon(
              text: 'DOG SUPPLIES',
              onTap: () async {
                Get.to(
                  () => const ProductView(tittle: 'DOG SUPPLIES'),
                  arguments: 'dog supplies',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'DRY DOG FOOD',
              onTap: () async {
                Get.to(
                  () => const ProductView(tittle: 'DRY DOG FOOD'),
                  arguments: 'dry dog food',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'WET DOG FOOD',
              onTap: () async {
                Get.to(
                  () => const ProductView(tittle: 'WET DOG FOOD'),
                  arguments: 'wet dog food',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'PUPPY FOOD',
              onTap: () async {
                Get.to(
                  () => const ProductView(tittle: 'PUPPY FOOD'),
                  arguments: 'puppy food',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'FOOD BOWL & FEEDER',
              onTap: () async {
                Get.to(
                  () => const ProductView(tittle: 'FOOD BOWL & FEEDER'),
                  arguments: 'food bowl feeder',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'DOG BOWLS & FEEDING',
              onTap: () {
                Get.to(
                  () => const ProductView(tittle: 'DOG BOWLS & FEEDING'),
                  arguments: 'dog bowls feeding',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'LEASHES & COLLARS',
              onTap: () {
                Get.to(
                  () => const ProductView(tittle: 'LEASHES & COLLARS'),
                  arguments: 'leashes collars',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'DOG BEDS',
              onTap: () {
                Get.to(
                  () => const ProductView(tittle: 'DOG BEDS'),
                  arguments: 'dog beds',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'DOG DIAPERS',
              onTap: () {
                Get.to(
                  () => const ProductView(tittle: 'DOG DIAPERS'),
                  arguments: 'dog diapers',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'HYGIENE & HEALTH CARE',
              onTap: () {
                Get.to(
                  () => const ProductView(tittle: 'HYGIENE & HEALTH CARE'),
                  arguments: 'hygiene health care',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'DOG PADS',
              onTap: () {
                Get.to(
                  () => const ProductView(tittle: 'DOG PADS'),
                  arguments: 'dog pads',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'DOG PERFUME',
              onTap: () {
                Get.to(
                  () => const ProductView(tittle: 'DOG PERFUME'),
                  arguments: 'dog perfume',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'DOG ACCESSORIES',
              onTap: () {
                Get.to(
                  () => const ProductView(tittle: 'DOG ACCESSORIES'),
                  arguments: 'dog accessories',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'DOG CARRIERS & TRAVELS',
              onTap: () {
                Get.to(
                  () => const ProductView(tittle: 'DOG CARRIERS & TRAVELS'),
                  arguments: 'dog carriers travels',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'DOG GROOMING & SUPPLIES',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'DOG GROOMING & SUPPLIES',
                  ),
                  arguments: 'dog grooming supplies',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'DOG HEALTH CARE',
              onTap: () {
                Get.to(
                  () => const ProductView(tittle: 'DOG HEALTH CARE'),
                  arguments: 'dog health care',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CatDrawer extends StatelessWidget {
  final Function(int) onChangePage;

  const CatDrawer({super.key, required this.onChangePage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: TextButton.icon(
                onPressed: () {
                  onChangePage(0);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                label: Common.drawerText('BACK'),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAT SUPPLIES',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAT SUPPLIES',
                  ),
                  arguments: 'cat supplies',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'DRY CAT FOOD',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'DRY CAT FOOD',
                  ),
                  arguments: 'dry cat food',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'WET CAT FOOD',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'WET CAT FOOD',
                  ),
                  arguments: 'wet cat food',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAT TREATS',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAT TREATS',
                  ),
                  arguments: 'cat treats',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'FOOD BOWL & FEEDER',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'FOOD BOWL & FEEDER',
                  ),
                  arguments: 'food bowl feeder',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAT BEDS & SUPPLIES',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAT BEDS & SUPPLIES',
                  ),
                  arguments: 'cat beds supplies',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAT ACCESSORIES',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAT ACCESSORIES',
                  ),
                  arguments: 'cat accessories',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAT BOWLS AND FEEDING',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAT BOWLS AND FEEDING',
                  ),
                  arguments: 'cat bowls feeding',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAT LITTER',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAT LITTER',
                  ),
                  arguments: 'cat litter',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAT CARRIERS AND TRAVEL',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAT CARRIERS AND TRAVEL',
                  ),
                  arguments: 'cat carriers travel',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAT WIPES',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAT WIPES',
                  ),
                  arguments: 'cat wipes',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAT TOYS',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAT TOYS',
                  ),
                  arguments: 'cat toys',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'LITTER BOXES',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'LITTER BOXES',
                  ),
                  arguments: 'litter boxes',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'HEALTH CARE',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'HEALTH CARE',
                  ),
                  arguments: 'health care',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAT PERFUMES',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAT PERFUMES',
                  ),
                  arguments: 'cat perfumes',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAT SCRATCHERS',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAT SCRATCHERS',
                  ),
                  arguments: 'cat scratchers',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAT GROOMING',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAT GROOMING',
                  ),
                  arguments: 'cat grooming',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAT HEALTH CARE',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAT HEALTH CARE',
                  ),
                  arguments: 'cat health care',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BirdDrawer extends StatelessWidget {
  final Function(int) onChangePage;

  const BirdDrawer({super.key, required this.onChangePage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: TextButton.icon(
                onPressed: () {
                  onChangePage(0);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                label: Common.drawerText('BACK'),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            ),
            Common.drawerListTileWithoutIcon(
              text: 'BIRD SUPPLIES',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'BIRD SUPPLIES',
                  ),
                  arguments: 'bird supplies',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'BIRD FOOD',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'BIRD FOOD',
                  ),
                  arguments: 'bird food',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'BIRD HEALTH CARE',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'BIRD HEALTH CARE',
                  ),
                  arguments: 'bird health care',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'BIRD ACCESSORIES',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'BIRD ACCESSORIES',
                  ),
                  arguments: 'bird accessories',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PetsDrawer extends StatelessWidget {
  final Function(int) onChangePage;

  const PetsDrawer({super.key, required this.onChangePage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: TextButton.icon(
                onPressed: () {
                  onChangePage(0);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                label: Common.drawerText('BACK'),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            ),
            Common.drawerListTileWithoutIcon(
              text: 'SMALL PETS',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'SMALL PETS',
                  ),
                  arguments: 'small pets',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'BEDDING',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'BEDDING',
                  ),
                  arguments: 'bedding',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CAGES',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CAGES',
                  ),
                  arguments: 'cages',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'CLEANING',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'CLEANING',
                  ),
                  arguments: 'cleaning',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FishDrawer extends StatelessWidget {
  final Function(int) onChangePage;

  const FishDrawer({super.key, required this.onChangePage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: TextButton.icon(
                onPressed: () {
                  onChangePage(0);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                label: Common.drawerText('BACK'),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            ),
            Common.drawerListTileWithoutIcon(
              text: 'AQUATIC',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'AQUATIC',
                  ),
                  arguments: 'aquatic',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'AQUARIUM',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'AQUARIUM',
                  ),
                  arguments: 'aquarium',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'FOOD',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'FOOD',
                  ),
                  arguments: 'food',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'ADDITIVES & CONDITIONERS',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'ADDITIVES & CONDITIONERS',
                  ),
                  arguments: 'additives conditioners',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'AQUA SCOPING & DECOR',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'AQUA SCOPING & DECOR',
                  ),
                  arguments: 'aqua scoping decor',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'EQUIPMENTS',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'EQUIPMENTS',
                  ),
                  arguments: 'equipments',
                );
              },
            ),
            Common.drawerListTileWithoutIcon(
              text: 'MEDICATIONS',
              onTap: () {
                Get.to(
                  () => const ProductView(
                    tittle: 'MEDICATIONS',
                  ),
                  arguments: 'medications',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
