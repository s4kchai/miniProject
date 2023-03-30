import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.green[200],
    ),
     
    );
  }
}
