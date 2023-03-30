import '../../../../models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cartcontroller extends GetxController {
  var _product = {}.obs;

  void addProduct(ProductModel product) {
    if (_product.containsKey(product)) {
      _product[product] + 1;
    } else {
      _product[product] = 1;
    }
  }
}
