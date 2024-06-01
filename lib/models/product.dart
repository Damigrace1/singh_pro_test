class ProductModel {
  String? productName;
  String? brandName;
  int? brandId;
  ProductModel({this.brandId, this.brandName, this.productName});
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        brandId: json['brandId'],
        brandName: json['brandName'],
        productName: json['productName']);
  }
}
