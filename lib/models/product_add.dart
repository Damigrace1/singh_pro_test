import 'package:flutter/cupertino.dart';

class ProductAddModel {
  int index;
  String? productName;
  String? brandName;
  String? rsp;
  TextEditingController controller;
  ProductAddModel({this.rsp, this.brandName, this.productName,
    required this.index,
  required this.controller});

}
