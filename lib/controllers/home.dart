import 'package:get/get.dart';
import 'package:singh/models/product.dart';

class HomeController extends GetxController{
  String? selectedVisitReasons;
  String? selectedBrand;
  String? selectedProduct;
  String? rsp;
  List<String> visitReasons = ['One', 'Two', 'Three', 'Four'];
  List<ProductModel> products = [];
  bool enableAddMoreButton = false;

  void reset(){
    enableAddMoreButton = false;
    rsp = null;
    selectedProduct = null;
    selectedVisitReasons = null;
    selectedBrand = null;
  }

  void checkEnableAddMoreButton() {
    print('${selectedProduct != null}..${selectedBrand != null}..${rsp != null}');
   if ( selectedProduct != null &&
    selectedBrand != null &&
    rsp != null
       && rsp!.length == 3
   ){
     enableAddMoreButton = true;
   }
   else{
     enableAddMoreButton = false;
   }
  }
}