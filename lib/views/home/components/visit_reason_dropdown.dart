import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../controllers/home.dart';

class VisitReasonDropdown extends StatelessWidget {
  const VisitReasonDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Reason of Visit*',
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp
                  )),
              SizedBox(height: 2.h,),
              Container(
                width: 162.w,
                height: 36.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.w),
                    border: Border.all(color: const Color(0x0000001F))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(controller.selectedVisitReasons ?? 'Select',
                      style: TextStyle(fontSize: 14.sp,
                          color: controller.selectedVisitReasons == null ?
                          const Color(0xff707070) : null),),
                    DropdownButton<String>(
                      //value: dropdownValue,
                      onChanged: (String? newValue) {
                        controller.selectedVisitReasons = newValue;
                        controller.update();
                      },
                      icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xffFF6400)
                      ),
                      underline: const SizedBox(),
                      items: controller.visitReasons
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              )

            ],
          );
        });
  }}
