
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:singh/views/home/components/product_details_row.dart';
import 'package:singh/views/home/components/product_popup.dart';

import '../../../controllers/home.dart';
import '../../../models/product.dart';

Column buildNewProductEntry(HomeController controller,
List<ProductDetailsRow> productDetails,
    TextEditingController rspController
) {
  return Column(
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
                controller
                    .checkEnableAddMoreButton();
                controller.update();
              }),
          ProductPopup(
            title: 'Select Product*',
            selectedValue: controller.selectedProduct,
            onSelected: (ProductModel? newValue) {
              controller.selectedProduct =
                  newValue?.productName;
              controller
                  .checkEnableAddMoreButton();
              controller.update();
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
                      controller
                          .checkEnableAddMoreButton();
                      controller.update();
                    }
                    if (v.length == 3) {
                      controller.rsp = v;
                      controller
                          .checkEnableAddMoreButton();
                      controller.update();
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
  );
}