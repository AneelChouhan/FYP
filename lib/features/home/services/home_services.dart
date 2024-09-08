// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:smartfit/constants/utils.dart';
import 'package:smartfit/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/globals_variable.dart';
import '../../../main.dart';
import '../../../providers/user_provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('${uri}api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<Product> fetchDealofDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
      addedby: prefs.getString("id")==""?"admin":prefs.getString("id")
    );
    try {
      http.Response res =
          await http.get(Uri.parse('${uri}api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
