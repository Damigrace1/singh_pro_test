import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:singh/controllers/home.dart';
import 'package:singh/models/product.dart';

class ProductPopup extends StatelessWidget {
  const ProductPopup(
      {super.key,
      required this.title,
      required this.selectedValue,
      this.onSelected});
  final String title;
  final String? selectedValue;
  final void Function(ProductModel?)? onSelected;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    color: const Color(0xff666666),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp)),
            SizedBox(
              height: 6.h,
            ),
            Container(
              height: 36.h,
              width: 124.w,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.w),
                  border: Border.all(color: const Color(0x0000001F))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      selectedValue ?? 'Select',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(

                          fontSize: 14.sp,
                          color: selectedValue == null
                              ? const Color(0xff707070)
                              : null),
                    ),
                  ),
                  PopupMenuButton<ProductModel>(
                    icon: const Icon(Icons.arrow_drop_down, color: Color(0xffFF6400)),
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context) {
                      return controller.products.map((product) =>
                          PopupMenuItem<ProductModel>(
                              onTap: (){
                                if(onSelected != null){
                                  onSelected!(product);
                                }
                                controller.checkEnableAddMoreButton();
                              },
                              child: Text(product.productName??'',
                              overflow: TextOverflow.ellipsis,))
                      ).toList();
                  },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
