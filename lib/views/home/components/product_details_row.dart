
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:singh/models/product_add.dart';
import 'package:singh/views/home/components/product_popup.dart';

import '../../../models/product.dart';

class ProductDetailsRow extends StatefulWidget {
  ProductDetailsRow({
    super.key, this.productAddModel,
  });

  ProductAddModel? productAddModel;

  @override
  State<ProductDetailsRow> createState() => _ProductDetailsRowState();
}

class _ProductDetailsRowState extends State<ProductDetailsRow> {

  late final TextEditingController rspController;
  @override
  void initState() {
    // TODO: implement initState
    rspController = TextEditingController(text: widget.productAddModel?.rsp??'');
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Detail ${widget.productAddModel?.index.toString().padLeft(
              widget.productAddModel!.index.toString().length <= 2 ? 2 : 3,'0'
          )}',
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
                selectedValue:widget.productAddModel?.brandName,
                onSelected: (ProductModel? newValue) {
                  widget.productAddModel?.brandName = newValue?.brandName;
                  setState(() {

                  });
                }),
            ProductPopup(
              title: 'Select Product*',
              selectedValue: widget.productAddModel?.productName,
              onSelected: (ProductModel? newValue) {
                widget.productAddModel?.productName = newValue?.productName;
                setState(() {

                });
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
                      border: Border.all(color: const Color(0x0000001F))),
                  child: TextFormField(
                    controller: rspController,
                    onChanged: (v) {
                      if(v.length < 3){
                        widget.productAddModel?.rsp = v;
                        setState(() {

                        });
                      }
                      if (v.length == 3) {
                        widget.productAddModel?.rsp = v;
                        setState(() {

                        });
                      }
                      if (v.length > 3) {
                        widget.productAddModel?.rsp = v;
                      }

                    },
                    keyboardType: TextInputType.number,
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
        SizedBox(
          height: 12.h,
        ),
      ],
    );
  }
}