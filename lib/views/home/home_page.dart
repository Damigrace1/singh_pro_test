import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:singh/controllers/home.dart';
import 'package:singh/models/product_add.dart';

import '../../data/product.dart';
import '../../models/product.dart';
import 'components/blue_container.dart';
import 'components/new_product_entry.dart';
import 'components/product_details_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];
  TextEditingController rspController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    rspController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    HomeController h = Get.put(HomeController());
    List productsJson = testJson['nonDalmiaProducts'];
    h.products = productsJson
        .map((productJson) => ProductModel.fromJson(productJson))
        .toList();
  }

  List<ProductDetailsRow> productDetails = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<HomeController>(
      builder: (controller) {
        return ListView(
          children: [
            const BlueContainer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
              color: const Color(0xffF4F2FC),
              child: Column(
                children: [
                  ...productDetails,
                  buildNewProductEntry(controller,productDetails,rspController),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        if (controller.enableAddMoreButton) {
                          controller.enableAddMoreButton = false;
                          TextEditingController rspCont =
                              TextEditingController();
                          productDetails.add(ProductDetailsRow(
                            productAddModel: ProductAddModel(
                                rsp: controller.rsp,
                                index: productDetails.length + 1,
                                brandName: controller.selectedBrand,
                                productName: controller.selectedProduct,
                                controller: rspCont),
                          ));
                          setState(() {
                            controller.reset();
                            rspController.clear();
                            FocusScope.of(context).unfocus();
                          });
                        }
                      },
                      splashColor: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 13.h),
                        color: const Color(0xffF4F2FC),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 10.w,
                              backgroundColor: const Color(0xffFF6400).withOpacity(
                                  controller.enableAddMoreButton ? 1 : 0.2),
                              child: Icon(
                                Icons.add,
                                size: 18.w,
                                color: const Color(0xffF4F2FC),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              'ADD MORE',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xffFF6400).withOpacity(
                                      controller.enableAddMoreButton
                                          ? 1
                                          : 0.2)),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    ));
  }

}

