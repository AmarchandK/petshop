import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../constant/colors_file.dart';
import '../../../constant/common_widget.dart';
import '../../../constant/responsive.dart';
import '../../../constant/routes.dart';
import '../../product/view/widget/product_item_widget.dart';
import '../../product_inner_view/view/product_inner_view.dart';
import '../controller/search_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final controller = Get.put(SearchScreenController());
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Common.scaffold<SearchScreenController>(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Common.textFormField(
          onTap: () {},
          prefixIcon: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          hintText: "Search here",
          controller: _searchController,
          keyboardType: TextInputType.text,
          obscureText: false,
          validator: (_) {
            return null;
          },
          onSaved: (_) {},
          onChanged: (val) {
            controller.searchProducts(query: val ?? "");
          },
          context: context,
          autoFocus: true,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<SearchScreenController>(
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
              : obj.products.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Icon(
                            Icons.search_off,
                            size: 100,
                          ),
                        ),
                        Common.text(
                          text: "Search for products",
                          fontSize: 18,
                        ),
                      ],
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
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        final data = controller.products[index];
                        return GestureDetector(
                          onTap: () {
                            Routes.push(
                              screen: ProductInnerView(
                                product: data,
                                isFavorite: false,
                              ),
                              action: (_) {},
                            );
                          },
                          child: ProductItemWidget(
                            product: data,
                            isFavorite: false,
                          ),
                        );
                      },
                    );
        },
      ),
    );
  }
}
