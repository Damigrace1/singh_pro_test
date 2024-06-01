import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:singh/controllers/home.dart';
import 'package:singh/models/product_add.dart';
import 'package:singh/views/home/components/product_popup.dart';
import 'package:singh/views/home/components/visit_reason_dropdown.dart';

import '../../data/product.dart';
import '../../models/product.dart';
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10.h),
              color: const Color(0xff2300C8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Visit Date: 28 Feb 2024',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Opp. Status: Conversion',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp),
                      ),
                    ],
                  ),
                  const VisitReasonDropdown()
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
              color: const Color(0xffF4F2FC),
              child: Column(
                children: [
                  ...productDetails,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Detail '
                        '${((productDetails.length) + 1).toString().padLeft(productDetails.length.toString().length <= 2 ? 2 : 3, '0')}',
                        style: TextStyle(
                            color: const Color(0xffFF6400),
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp),
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProductPopup(
                              title: 'Select Brand Used*',
                              selectedValue: controller.selectedBrand,
                              onSelected: (ProductModel? newValue) {
                                controller.selectedBrand =
                                    newValue?.productName;
                                Get.find<HomeController>()
                                    .checkEnableAddMoreButton();
                                setState(() {});
                              }),
                          ProductPopup(
                            title: 'Select Product*',
                            selectedValue: controller.selectedProduct,
                            onSelected: (ProductModel? newValue) {
                              controller.selectedProduct =
                                  newValue?.productName;
                              Get.find<HomeController>()
                                  .checkEnableAddMoreButton();
                              setState(() {});
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Enter RSP*',
                                  style: TextStyle(
                                      color: const Color(0xff666666),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp)),
                              SizedBox(
                                height: 6.h,
                              ),
                              Container(
                                height: 36.h,
                                width: 65.w,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.w),
                                    border:
                                        Border.all(color: const Color(0x0000001F))),
                                child: TextFormField(
                                  controller: rspController,
                                  onChanged: (v) {
                                    if (v.length < 3) {
                                      controller.rsp = v;
                                      Get.find<HomeController>()
                                          .checkEnableAddMoreButton();
                                      setState(() {});
                                    }
                                    if (v.length == 3) {
                                      controller.rsp = v;
                                      Get.find<HomeController>()
                                          .checkEnableAddMoreButton();
                                      setState(() {});
                                    }
                                    if (v.length > 3) {
                                      rspController.text = controller.rsp!;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                    hintText: '3 digit',

                                    border: InputBorder
                                        .none, // This removes the underline
                                    focusedBorder: InputBorder
                                        .none, // This removes the underline when focused
                                    enabledBorder: InputBorder.none,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
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
